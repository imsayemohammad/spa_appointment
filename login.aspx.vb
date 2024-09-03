Imports System.Data.SqlClient

Partial Class login
    Inherits System.Web.UI.Page
    Protected Sub btnLogin_Click(sender As Object, e As System.EventArgs) Handles btnLogin.Click
        Dim userID As String = txtUserID.Text.Trim()
        Dim password As String = txtPassword.Text.Trim()
        If userID.Contains("'") Or String.IsNullOrEmpty(userID) Then
            lblMessage.Text = ""
            lblMessage.Text = "User ID or password Invalid"
            lblMessage.ForeColor = Drawing.Color.Red
            Exit Sub
        End If
        If password.Contains("'") Or String.IsNullOrEmpty(password) Then
            lblMessage.Text = ""
            lblMessage.Text = "User ID or password Invalid"
            lblMessage.ForeColor = Drawing.Color.Red
            Exit Sub
        End If

        Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("spaconnectionstring").ToString)
        conn.Open()
        Dim selectString = "select * from UserInfo where LoginId=@LoginId and Password=@password"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("LoginId", Data.SqlDbType.VarChar, 50)
        cmd.Parameters.Add("password", Data.SqlDbType.VarChar, 100)
        cmd.Parameters("LoginId").Value = txtUserID.Text
        cmd.Parameters("password").Value = txtPassword.Text

        Dim reader As SqlDataReader = cmd.ExecuteReader()
        If reader.HasRows Then
            reader.Read()

            If reader("status") = True Then
                InsertLog(reader("UserId").ToString())

                'If Request.Cookies("aUserID") Is Nothing Then
                '    Response.Cookies.Add(New HttpCookie("aUserID", reader("UserId").ToString()))
                'Else
                '    Response.Cookies("aUserID").Value = reader("UserId").ToString()
                'End If

                'If Request.Cookies("auserName") Is Nothing Then
                '    Response.Cookies.Add(New HttpCookie("auserName", txtUserID.Text))
                'Else
                '    Response.Cookies("auserName").Value = txtUserID.Text
                'End If

                'If Request.Cookies("aLoginId") Is Nothing Then
                '    Response.Cookies.Add(New HttpCookie("aLoginId", reader("LoginId").ToString()))
                'Else
                '    Response.Cookies("aLoginId").Value = reader("LoginId").ToString()
                'End If

                'If Request.Cookies("auserFullName") Is Nothing Then
                '    Response.Cookies.Add(New HttpCookie("auserFullName", reader("UserName").ToString()))
                'Else
                '    Response.Cookies("auserFullName").Value = reader("UserName").ToString()
                'End If

                'If Request.Cookies("aRole") Is Nothing Then
                '    Response.Cookies.Add(New HttpCookie("aRole", reader("Role").ToString()))
                'Else
                '    Response.Cookies("aRole").Value = reader("Role").ToString()
                'End If

                'If Request.Cookies("auserpass") Is Nothing Then
                '    Response.Cookies.Add(New HttpCookie("auserpass", New Encription().EncryptTripleDES(txtPassword.Text.Trim(), "*n3x@")))
                'Else
                '    Response.Cookies("auserpass").Value = New Encription().EncryptTripleDES(txtPassword.Text.Trim(), "*n3x@")
                'End If

                'If Not chkRemember.Checked Then
                '    Response.Cookies("auserName").Expires = DateTime.Now.AddDays(1)
                '    Response.Cookies("auserFullName").Expires = DateTime.Now.AddDays(1)
                '    Response.Cookies("aRole").Expires = DateTime.Now.AddDays(1)
                '    Response.Cookies("auserpass").Expires = DateTime.Now.AddDays(1)
                'End If
                conn.Close()

                ' Response.Redirect(Context.Items("domainName") & "dashboard")
                'Response.Redirect("Default.aspx")
                Response.Write("<script>window.top.location.href='" & Context.Items("domainName") & "Home" & "'</script>")
            Else
                lblMessage.Text = ""
                lblMessage.Text = "User ID or password Invalid"
                lblMessage.ForeColor = Drawing.Color.Red
            End If

        Else
            lblMessage.Text = ""
            lblMessage.Text = "User ID or password Invalid"
            lblMessage.ForeColor = Drawing.Color.Red
            conn.Close()
        End If

    End Sub

    Protected Function InsertLog(ByVal UserID As Integer) As Integer
        Dim M As Integer = 0
        Dim sqlString As String
        'Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("spaconnectionstring").ToString)
        Dim strConn = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
        Dim sqlConn As SqlConnection = New SqlConnection(strConn)
        sqlConn.Open()

        sqlString = "DELETE FROM [UserLog_Data] WHERE UserId=@UserId"
        Dim sqlcomm As SqlCommand = New SqlCommand()
        sqlcomm.CommandText = sqlString
        sqlcomm.Connection = sqlConn
        sqlcomm.CommandType = Data.CommandType.Text
        sqlcomm.Parameters.Add("UserId", Data.SqlDbType.Int).Value = UserID
        sqlcomm.CommandText = sqlString
        sqlcomm.ExecuteNonQuery()
        sqlcomm.Parameters.Clear()
        sqlcomm.Dispose()

        If UserID <> 0 Then
            sqlString = "INSERT INTO [UserLog_Data] (SessionId,UserId,LoginDate,Status,LastUpdate) VALUES (@SessionId,@UserId,getdate(),1,getdate())"
            sqlcomm.Parameters.Add("UserId", Data.SqlDbType.Int).Value = UserID
            sqlcomm.Parameters.Add("SessionId", Data.SqlDbType.NVarChar).Value = System.Web.HttpContext.Current.Session.SessionID
            sqlcomm.CommandText = sqlString
            sqlcomm.ExecuteScalar()
            sqlcomm.Parameters.Clear()
            sqlcomm.Dispose()
        End If

        sqlConn.Close()
        Return M
    End Function

End Class
