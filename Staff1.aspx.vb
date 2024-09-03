
Imports System.Data.SqlClient

Partial Class Staff1
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If Not String.IsNullOrEmpty(System.Web.HttpContext.Current.Session.SessionID) Then
                Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By LogId DESC")

                Dim sessionid As String = System.Web.HttpContext.Current.Session.SessionID
                Dim dbsessionid As String = Utility.StringData("Select TOP 1 SessionId From UserLog_Data Where UserId =" & userid & "")

                If sessionid = dbsessionid Then
                    'hdnuserid.Value = CType(userid, String)
                    'Response.Write(userid)
                    'Response.Write(sessionid)
                    'Response.Write(dbsessionid)
                Else
                    Response.Redirect("/login")
                End If
            Else
                Response.Redirect("/login")
            End If
        End If
    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Sub SaveData(ByVal staffid As String, ByVal FirstName As String, ByVal LastName As String, ByVal Phone As String, ByVal Email As String, ByVal Notes As String, ByVal StartDate As String, ByVal EndDate As String, ByVal Permission As String)
        'Dim userID As Integer = CType(HttpContext.Current.Request.Cookies("aUserID").Value.ToString(), Integer)
        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")

        If Not String.IsNullOrEmpty(FirstName) Then
            Dim selectString As String = ""
            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
            conn.Open()
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
            If Not String.IsNullOrEmpty(staffid) Then
                selectString = "UPDATE [Staff] SET [FirstName] = @FirstName, [LastName] = @LastName, [Phone1] = @Phone1, [Email] = @Email, [Notes] = @Notes, [StartDate] = @StartDate, [EndDate] = @EndDate, [UserPermission] = @UserPermission, [UpdatedBy] = @ChangeBy, [UpdatedDate] = Getdate() WHERE [StaffID] = @StaffID"
                cmd.Parameters.Add("StaffID", Data.SqlDbType.Int).Value = staffid
            Else
                selectString = "INSERT INTO [Staff] ([FirstName], [LastName], [Phone1], [Email], [Notes], [StartDate], [EndDate], [UserPermission], [CreateBy], [CreateDate]) VALUES (@FirstName, @LastName, @Phone1, @Email, @Notes, @StartDate, @EndDate, @UserPermission, @ChangeBy, Getdate())"
            End If

            cmd.Parameters.Add("FirstName", Data.SqlDbType.NVarChar).Value = FirstName
            cmd.Parameters.Add("LastName", Data.SqlDbType.NVarChar).Value = LastName
            cmd.Parameters.Add("Phone1", Data.SqlDbType.NVarChar).Value = Phone
            cmd.Parameters.Add("Email", Data.SqlDbType.NVarChar).Value = Email
            cmd.Parameters.Add("Notes", Data.SqlDbType.NVarChar).Value = Notes
            cmd.Parameters.Add("StartDate", Data.SqlDbType.DateTime).Value = StartDate
            cmd.Parameters.Add("EndDate", Data.SqlDbType.DateTime).Value = EndDate
            cmd.Parameters.Add("UserPermission", Data.SqlDbType.NVarChar).Value = Permission
            cmd.Parameters.Add("ChangeBy", Data.SqlDbType.Int).Value = userID

            cmd.CommandText = selectString
            cmd.ExecuteNonQuery()

            conn.Close()
        End If
    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Function StaffByStaffId(ByVal StaffId As String) As StaffModel
        Dim staff As New StaffModel
        Using conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Using cmd As New SqlCommand()
                cmd.CommandText = "SELECT * FROM [Staff] Where StaffID=@StaffID"
                cmd.Parameters.Clear()
                cmd.Parameters.Add("@StaffID", Data.SqlDbType.Int).Value = StaffId
                cmd.Connection = conn
                conn.Open()
                Using reader As SqlDataReader = cmd.ExecuteReader()
                    While reader.Read()
                        Dim strtdate = CDate(reader("StartDate"))
                        Dim enddate = CDate(reader("EndDate"))
                        staff.StaffId = reader("StaffID").ToString()
                        staff.FirstName = reader("FirstName").ToString()
                        staff.LastName = reader("LastName").ToString()
                        staff.Phone = reader("Phone1").ToString()
                        staff.Email = reader("Email").ToString()
                        staff.Notes = reader("Notes").ToString()
                        staff.StartDate = Utility.Dayformat(strtdate).ToString()
                        staff.EndDate = Utility.Dayformat(enddate).ToString()
                        staff.Permission = reader("UserPermission").ToString()
                    End While
                End Using
                conn.Close()
            End Using
            Return staff
        End Using
    End Function

    'Protected Sub btnsave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnsave.Click
    '    Dim intInsertUpdate As Integer

    '    If Request.QueryString("staffid") <> "" Then
    '        intInsertUpdate = sdsstaff.Update

    '        If intInsertUpdate = 1 Then
    '            Response.Redirect("/staff", False)
    '        End If
    '    Else
    '        intInsertUpdate = sdsstaff.Insert

    '        If intInsertUpdate = 1 Then
    '            Response.Redirect("/staff", False)
    '            lblmsg.Text = "Operation Done"
    '            lblmsg.Visible = True
    '        End If
    '    End If
    'End Sub
    
End Class
