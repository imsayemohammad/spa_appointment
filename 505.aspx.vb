Imports System.Data.SqlClient

Partial Class _505
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MSG = "<html><head><meta http-equiv=""Content-Language"" content=""en-us""><meta http-equiv=""Content-Type"" content=""text/html; charset=windows-1252""><title>Error</title></head><body><table border=""1"" width=""100%"" id=""table1"" style=""border-collapse: collapse"">	<tr>		<td width=""141""><font face=""Arial"" size=""2"">Time</font></td>		<td><font face=""Arial"" size=""2"">" & Now() & "</font></td>	</tr>	<tr>	<td width=""141""><font face=""Arial"" size=""2"">Error Page</font></td>		<td><font face=""Arial"" size=""2"">" & Request.QueryString().ToString & "</font></td>	</tr>	<tr>		<td width=""141""><font face=""Arial"" size=""2"">IP Address</font></td>		<td><font face=""Arial"" size=""2"">" & Request.ServerVariables("REMOTE_ADDR") & "</font></td>	</tr>	<tr>	<td width=""141""><font face=""Arial"" size=""2"">Browser Information</font></td>		<td><font face=""Arial"" size=""2"">" & Request.ServerVariables("HTTP_USER_AGENT") & "</font></td>	</tr>	<tr>		<td width=""141""><font face=""Arial"" size=""2"">Remote Host</font></td>		<td><font face=""Arial"" size=""2"">" & Request.ServerVariables("REMOTE_HOST") & "</font></td>	</tr>	<tr>		<td width=""141""><font face=""Arial"" size=""2"">Remote User</font></td>		<td><font face=""Arial"" size=""2"">" & Request.ServerVariables("REMOTE_USER") & "</font></td>	</tr></table></body></html>"

        Dim con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString())
        con.Open()

        Dim sql = "Insert Into AppError([MailBody],[MailDate]) values(@MailBody,getdate()) "

        Dim cmd = New SqlCommand(sql, con)

        cmd.Parameters.Add("MailBody", Data.SqlDbType.VarChar).Value = MSG

        cmd.ExecuteNonQuery()

        con.Close()


        'Dim mailMessage As System.Net.Mail.MailMessage = New System.Net.Mail.MailMessage()

        'mailMessage.From = New System.Net.Mail.MailAddress("noreply@yibto.com", "Error")
        'mailMessage.To.Add(New System.Net.Mail.MailAddress("sayem@royex.net"))
        ''mailMessage.To.Add(New System.Net.Mail.MailAddress("rajib@royex.net"))

        '''Set additional options
        'mailMessage.Priority = System.Net.Mail.MailPriority.Normal
        '''Text/HTMLs
        'mailMessage.IsBodyHtml = True

        '''Set the subjet and body text
        'mailMessage.Subject = "Error Details of yibto.com"
        'mailMessage.Body = MSG


        '''Create an instance of the SmtpClient class for sending the email
        'Dim smtpClient As New System.Net.Mail.SmtpClient()
        'smtpClient.Host = "127.0.0.1"
        'smtpClient.Port = 25

        'smtpClient.Send(mailMessage)
        'Try

        'Catch smtpExc As System.Net.Mail.SmtpException
        'Catch ex As Exception
        'End Try
    End Sub
End Class
