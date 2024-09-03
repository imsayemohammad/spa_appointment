Imports System.Data.SqlClient
Partial Class closeddates_popup
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            If Not String.IsNullOrEmpty(System.Web.HttpContext.Current.Session.SessionID) Then
                Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By LogId DESC")

                Dim sessionid As String = System.Web.HttpContext.Current.Session.SessionID
                Dim dbsessionid As String = Utility.StringData("Select TOP 1 SessionId From UserLog_Data Where UserId =" & userid & "")

                If sessionid = dbsessionid Then
                    If Request.QueryString("cdid") <> "" Then
                        GetData()
                    Else
                        btndelete.Visible = False
                        btnsave.Text = "Save"
                    End If

                    'hdnuserid.Value = CType(userid, String)
                    'Response.Write(userid)
                Else
                    'Response.Redirect("/login")
                End If
            Else
                Response.Redirect("/login")
            End If
        End If
    End Sub

    Protected Sub btnsave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnsave.Click
        Dim intInsertUpdate As Integer

        If Request.QueryString("cdid") <> "" Then
            intInsertUpdate = sdscloseddates.Update
            InserClosedDatesLocation()
            If intInsertUpdate = 1 Then
                ClientScript.RegisterStartupScript(Me.GetType, "Load", "<script type='text/javascript'>window.parent.location.href = '/ClosedDates'; </script>")
            End If
        Else
            intInsertUpdate = sdscloseddates.Insert
            InserClosedDatesLocation()
            If intInsertUpdate = 1 Then
                ClientScript.RegisterStartupScript(Me.GetType, "Load", "<script type='text/javascript'>window.parent.location.href = '/ClosedDates'; </script>")
                'lblmsg.Text = "Operation Done"
                'lblmsg.Visible = True
            End If
        End If

        'Dim jScript As String = "window.top.location.href = '/ClosedDates';"
        'ScriptManager.RegisterStartupScript(Me, Me.GetType, "forceParentLoad", jScript, True)
        'Response.Redirect("/ClosedDates")
    End Sub


    Protected Sub sdscloseddates_Inserted(ByVal sender As Object, ByVal e As SqlDataSourceStatusEventArgs) Handles sdscloseddates.Inserted
        If IsDBNull(e.Command.Parameters("@ScopeID").Value) = False Then
            hdnScopeID.Value = e.Command.Parameters("@ScopeID").Value
        End If
    End Sub

    Private Sub InserClosedDatesLocation()
        Try
            Dim sqlString As String
            Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")
            Dim strConn = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Dim sqlConn As SqlConnection = New SqlConnection(strConn)
            sqlConn.Open()
            sqlString = "delete from [ClosedDatesLocation] Where ClosedDatesId=@ClosedDatesId"
            Dim sqlcomm As SqlCommand = New SqlCommand()
            sqlcomm.CommandText = sqlString
            sqlcomm.Connection = sqlConn
            sqlcomm.CommandType = Data.CommandType.Text
            If Request.QueryString("cdid") <> "" Then
                sqlcomm.Parameters.Add("ClosedDatesId", Data.SqlDbType.BigInt).Value = Request.QueryString("cdid")
            Else
                sqlcomm.Parameters.Add("ClosedDatesId", Data.SqlDbType.BigInt).Value = hdnScopeID.Value
            End If
            sqlcomm.ExecuteNonQuery()
            sqlcomm.Parameters.Clear()
            sqlcomm.Dispose()

            For i As Integer = 0 To ChkLocation.Items.Count - 1
                If ChkLocation.Items(i).Selected = True Then
                    sqlString = "insert into [ClosedDatesLocation] (AreaId,ClosedDatesId, CreatedBy, CreatedAt) Values(@AreaId,@ClosedDatesId, @CreatedBy, Getdate())"
                    sqlcomm.CommandText = sqlString
                    sqlcomm.Connection = sqlConn
                    sqlcomm.CommandType = Data.CommandType.Text
                    sqlcomm.Parameters.Add("AreaId", Data.SqlDbType.Int).Value = ChkLocation.Items(i).Value
                    If Request.QueryString("cdid") <> "" Then
                        sqlcomm.Parameters.Add("ClosedDatesId", Data.SqlDbType.BigInt).Value = Request.QueryString("cdid")
                    Else
                        sqlcomm.Parameters.Add("ClosedDatesId", Data.SqlDbType.BigInt).Value = hdnScopeID.Value
                    End If
                    sqlcomm.Parameters.Add("CreatedBy", Data.SqlDbType.Int).Value = userid
                    sqlcomm.ExecuteNonQuery()
                    sqlcomm.Parameters.Clear()
                    sqlcomm.Dispose()
                End If
            Next
            sqlConn.Close()
        Catch ex As Exception

        End Try
    End Sub

    Public Sub GetData()
        Dim cdid = Request.QueryString("cdid")
        If cdid <> "" Then
            btnsave.Text = "Update"
            Using conn As New SqlConnection()
                conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                Using cmd As New SqlCommand()
                    cmd.CommandText = "SELECT * FROM ClosedDates cd LEFT JOIN ClosedDatesLocation cdl ON cd.ClosedDatesId = cdl.ClosedDatesId Where cd.ClosedDatesId=@ClosedDatesId"
                    cmd.Parameters.Clear()
                    cmd.Parameters.Add("@ClosedDatesId", Data.SqlDbType.BigInt).Value = cdid
                    cmd.Connection = conn
                    conn.Open()
                    Using reader As SqlDataReader = cmd.ExecuteReader()
                        While reader.Read()
                            hdncloseddateid.Value = reader("ClosedDatesId").ToString()
                            Dim strtdt = CDate(reader("StartDate"))
                            txtStartDate.Text = Utility.Dayformat(strtdt).ToString()

                            Dim enddt = CDate(reader("EndDate"))
                            txtEndDate.Text = Utility.Dayformat(enddt).ToString()
                            txtDescription.Text = reader("Description").ToString()

                        End While
                    End Using
                    conn.Close()
                End Using
            End Using
            btndelete.Visible = True
        Else
            btndelete.Visible = False
            btnsave.Text = "Save"
        End If

        LoadLocation()
    End Sub


    Private Sub LoadLocation()
        If Request.QueryString("cdid") <> "" Then
            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
            conn.Open()
            Dim selectString = "SELECT * FROM ClosedDatesLocation where ClosedDatesId=@ClosedDatesId"
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
            cmd.Parameters.Add("ClosedDatesId", Data.SqlDbType.BigInt).Value = Request.QueryString("cdid")

            Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
            ChkLocation.DataBind()
            While reader.Read()

                For i As Integer = 0 To ChkLocation.Items.Count - 1
                    If ChkLocation.Items(i).Value = reader("AreaId").ToString() Then
                        ChkLocation.Items(i).Selected = True
                    End If
                Next

            End While
            reader.Close()
        End If
    End Sub


    Protected Sub btndelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btndelete.Click
        If Request.QueryString("cdid") <> "" Then
            DeleteData()
        End If

        ClientScript.RegisterStartupScript(Me.GetType, "Load", "<script type='text/javascript'>window.parent.location.href = '/ClosedDates'; </script>")

    End Sub

    Public Sub DeleteData()
        If Request.QueryString("cdid") <> "" Then
            If Not String.IsNullOrEmpty(Request.QueryString("cdid")) Then
                Dim sql As String = ""
                Dim selectString As String = ""
                Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
                conn.Open()

                Dim cmd1 As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(sql, conn)
                sql = "DELETE FROM [ClosedDatesLocation] WHERE [ClosedDatesId] = @ClosedDatesId"
                cmd1.CommandText = sql
                cmd1.Parameters.Add("ClosedDatesId", Data.SqlDbType.BigInt).Value = Request.QueryString("cdid")
                cmd1.ExecuteNonQuery()

                Dim countid As Integer = Utility.IntegerData("Select Count(ClosedDatesId) FROM [ClosedDatesLocation] WHERE [ClosedDatesId] = " & Request.QueryString("cdid") & "")
                If countid = 0 Then
                    Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
                    selectString = "DELETE FROM [ClosedDates] WHERE [ClosedDatesId] = @ClosedDatesId"
                    cmd.CommandText = selectString
                    cmd.Parameters.Add("ClosedDatesId", Data.SqlDbType.BigInt).Value = Request.QueryString("cdid")
                    cmd.ExecuteNonQuery()
                    conn.Close()
                End If

            End If
        End If
    End Sub

End Class
