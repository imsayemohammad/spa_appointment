
Imports System.Data
Imports System.Data.SqlClient
Partial Class Team_popup
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If Not String.IsNullOrEmpty(Request.QueryString("teamId")) Then
              hdnTeamId.Value=Request.QueryString("teamId")
            End If

        End If
    End Sub



    Protected Sub SaveTeamData(sender As Object, e As EventArgs) Handles btnsave.Click

        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")
        Dim M As Integer

        If Not String.IsNullOrEmpty(txtStaffName.Text) Then

            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

            Dim selectString = ""
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)

            
                'conn.Open()
                'selectString = "UPDATE TeamMST SET TeamName=@TeamName,Description=@Description,UpdatedBy=@CreateBy,UpdatedDate=GETDATE() Where TeamID=@TeamID"
                'cmd.Parameters.Add("TeamID", Data.SqlDbType.BigInt).Value = Request.QueryString("id")

                'cmd.Parameters.Add("TeamName", Data.SqlDbType.NVarChar).Value = txtTeamName.Text
                'cmd.Parameters.Add("Description", Data.SqlDbType.NVarChar).Value = txtTeamDetails.Text
                'cmd.Parameters.Add("CreateBy", Data.SqlDbType.Int).Value = userID


                'cmd.CommandText = selectString
                'M = cmd.ExecuteNonQuery()

                'conn.Close()
            

                'TeamDetailsID
                'TeamID
                'StaffID
                'Description
                'Status
                'CreateBy
                'CreateDate
                'UpdatedBy
                'UpdatedDate

                conn.Open()
                selectString = "INSERT INTO [TeamDetails] (TeamID,StaffID,CreateDate,CreateBy,Status,Description) VALUES (@TeamID,@StaffID,GETDATE(),@CreateBy,@Status,@Description)"
                cmd.Parameters.Add("TeamID", Data.SqlDbType.BigInt).Value = hdnTeamId.Value
                cmd.Parameters.Add("StaffID", Data.SqlDbType.BigInt).Value = hdnStaffId.Value
                cmd.Parameters.Add("Description", Data.SqlDbType.NVarChar).Value = txtTeamMemberDetails.Text
                cmd.Parameters.Add("CreateBy", Data.SqlDbType.Int).Value = userID
                cmd.Parameters.Add("Status", Data.SqlDbType.Bit).Value = 1


                cmd.CommandText = selectString
                M = cmd.ExecuteNonQuery()

                conn.Close()


            End If


    

        '        Response.Redirect("/")

        If M > 0 Then

            ClientScript.RegisterStartupScript(Me.GetType, "Load", "<script type='text/javascript'>window.parent.location.href = '/Team_Memeber.aspx?id="+Request.QueryString("teamId")+"'; </script>")
        End If


    End Sub




    Public Sub LoadData(queryString As String)



        Dim M As Integer
        Dim totalNumberOfProducts As Integer = 0
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "SELECT * FROM TeamMST Where TeamID=@s"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)

        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = queryString

        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()

        While reader.Read()

        End While

        reader.Close()
        conn.Close()


    End Sub


    '
    <System.Web.Services.WebMethod()>
    Public Shared Function GetclientData(ByVal name As String) As String()
        Dim clientname As New List(Of String)()
        Using conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Using cmd As New SqlCommand()
                Dim str = "SELECT * FROM (SELECT StaffID,CONCAT(FirstName,' ',LastName) as FullName FROM Staff WHERE StaffID Not in (SELECT StaffID FROM TeamDetails WHERE Status=1) )RESULT WHERE FullName Like + '%' + @txtmassage +'%' "
                cmd.Parameters.Add("txtmassage", Data.SqlDbType.VarChar).Value = name

                cmd.CommandText = str


                cmd.Connection = conn
                conn.Open()
                Using sdr As SqlDataReader = cmd.ExecuteReader()
                    If sdr.HasRows = True Then
                        While sdr.Read()
                            clientname.Add(String.Format("{1}-{0}", sdr("StaffID"), sdr("FullName")))
                        End While
                    End If

                End Using
                conn.Close()
            End Using

            Return clientname.ToArray
        End Using
    End Function


End Class
