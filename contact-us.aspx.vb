Imports System.Data.SqlClient

Partial Class contact_us
    Inherits System.Web.UI.Page

    Private Sub contact_us_Load(sender As Object, e As EventArgs) Handles Me.Load
        If IsPostBack = False Then

            Dim cmd = New SqlCommand()
            Dim con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString())
            con.Open()

            With cmd
                .Connection = con
                .CommandText = "Select Title,BigDetails from HTML where Htmlid=@Htmlid"
                .Parameters.Add("Htmlid", Data.SqlDbType.Int).Value = 23
            End With

            Dim ds As New Data.DataSet()
            Dim adapter = New SqlDataAdapter(cmd)
            adapter.Fill(ds)
            con.Close()

            For Each row As Data.DataRow In ds.Tables(0).Rows
                ltrlBigDetails.Text = row("BigDetails").ToString()
            Next
        End If

    End Sub

    Protected Sub btnregistert_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnregister.Click

        If sdsSave.Insert() > 0 Then

            'Admin Email format
            Dim Details As String = "<p><font face='Arial'>Registration Details:</font></p>"
            Details = Details + "<table border='0' width='100%' id='table1' cellspacing='3' cellpadding='3'>"
            Details = Details + "<tr><td width='101' bgcolor='#F3F3F3'><font face='Arial'>Name </font></td><td bgcolor='#F3F3F3'><font face='Arial'>" & txtName.Text & "</font></td></tr>"
            Details = Details + "<tr><td width='101' bgcolor='#F3F3F3'><font face='Arial'>Email </font></td><td bgcolor='#F3F3F3'><font face='Arial'>" & txtREmail.Text & "</font></td></tr>"
            Details = Details + "<tr><td width='101' bgcolor='#F3F3F3'><font face='Arial'>Phone </font></td><td bgcolor='#F3F3F3'><font face='Arial'>" & txtMobile.Text & "</font></td></tr>"
            Details = Details + "<tr><td width='101' bgcolor='#F3F3F3'><font face='Arial'>Address </font></td><td bgcolor='#F3F3F3'><font face='Arial'>" & txtAddress.Text & "</font></td></tr>"
            Details = Details + "<tr><td width='101' bgcolor='#F3F3F3'><font face='Arial'>Message </font></td><td bgcolor='#F3F3F3'><font face='Arial'>" & txtMessage.Text & "</font></td></tr>"
            Details = Details + "</table>"
            Details = Details + "<br /><a href=""http://" & Request.Url.Host & """>Yibto</a><br />http://" & Request.Url.Host

            'Loading emails from web.config
            Dim adminEmailFrom = ConfigurationManager.AppSettings("emailFrom").ToString
            Dim adminEmailFromName = ConfigurationManager.AppSettings("emailFromName").ToString
            Dim adminEmailTo = ConfigurationManager.AppSettings("emailTo").ToString
            Dim adminEmailCC = ConfigurationManager.AppSettings("emailCC").ToString
            Dim adminEmailBCC = ConfigurationManager.AppSettings("emailBCC").ToString


            'sending emails to admin
            Utility.SendMailAmazon(adminEmailFromName, adminEmailTo, adminEmailCC, adminEmailBCC, "Yibto: Contact", Details)

            Response.Redirect(Context.Items("domainName") & "thank-you/contact")

        End If

    End Sub

    Private Function RegistrationMessage(adminEmailFrom As String) As String
        Return "<!DOCTYPE html>" &
                "<html lang='en'>" &
                "  <head>" &
                "    <meta charset='utf-8'>" &
                "    <title>Thank you for Subsubcribing - Ajmal</title>" &
                "    <meta name='viewport' content='width=device-width, initial-scale=1.0'>" &
                "    <meta name='description' content=''>" &
                "    <meta name='author' content=''>   " &
                "  </head>" &
                "  <body style='margin:0px; padding:0px; background:#eee;'>" &
                "  <div style='font:14px/20px Arial, sans-serif; margin: 0; padding: 0px 0 20px; text-align: center; background-color: #ddd;'>" &
                "    <center>      " &
                "      <table border='0' cellpadding='0' cellspacing='0' height='100%' width='100%' style='background-color:#ddd;'>" &
                "        <tbody>" &
                "          <tr>" &
                "            <td align='center' valign='top'>              " &
                "              <table border='0' cellpadding='0' cellspacing='0' width='600' style='background-color:#fff; border-left:1px solid #ccc; border-right:1px solid #ccc;'>" &
                "                <tbody>                  " &
                "                  <tr>" &
                "                    <td align='center'>" &
                "                      <a href='http://" & Request.Url.Host & "'>" &
                "                        <img src='http://" & Request.Url.Host & "/images/logo.png' alt=''>" &
                "                      </a>" &
                "                    </td>" &
                "                  </tr>" &
                "                  <tr>" &
                "                    <td align='center' valign='top' style='padding:20px 0;'>" &
                "                      <table border='0' cellpadding='0' cellspacing='0' width='550' style='background:#f5f5f5; color:#000;'>" &
                "                        <tbody>" &
                "                          <tr><td>" &
                "                            <div style='padding:20px 10px;'>" &
                "                              <h3 style='font-family:arial; margin:5px 30px 15px; font-size:14px; text-align:center; font-weight:;'>Thank you for your Enquiry! " & "</h3>" &
                "                              <p style='font-family:arial; margin:0 30px 15px; font-size:14px; text-align:center;'>If you have any questions, queries or require any technical assistance with the site, please do not hesitate to contact us at <a href='mailto:Service@yibto.com'>Service@yibto.com</a>  </p>" &
                "                              <p style='font-family:arial; margin:0 30px 15px; font-size:14px; text-align:center;'>We look forward to seeing you at Yibto soon.</p>                                                            " &
                "                              <h2 style='font-family:arial; margin:0 30px 5px; font-size:14px; text-align:center;'><span style='font-size:10.5pt;text-align:center;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:black'>Kind Regards, <br />Yibto Team</span></h2>" &
                "                            </div>" &
                "                          </td></tr>" &
                "                        </tbody>" &
                "                      </table>" &
                "                    </td>" &
                "                  </tr>" &
               "                  <tr>" &
                "                    <td align='center' valign='top'>" &
                "                      <table border='0' cellpadding='0' cellspacing='0' width='550' style='color:#000; margin:5px 0;'>" &
                "                        <tbody>" &
                "                          <tr><td>" &
                "                            <div style='padding:0 10px;'>" &
                "                              " &
                "                              <h3 style='margin:0px 30px 15px; font-size:14px; text-align:center; font-weight:normal;'><a style='color:#000; text-decoration: none;  font-weight:bold;' href='" & Context.Items("domainName") & "'>" & Context.Items("domainName") & "</a></h3>" &
                "                            </div>" &
                "                          </td></tr>" &
                "                        </tbody>" &
                "                      </table>" &
                "                    </td>" &
                "                  </tr>" &
                "                  <tr>" &
                "                    <td align='center' valign='top'>" &
                "                      <p style='font-family:arial; text-align:center; font-size:11px; margin:5px 0 10px;'>To ensure your receive your emails, please add " & adminEmailFrom & " to your email address book.</p>" &
                "                    </td>" &
                "                  </tr>" &
                "                </tbody>" &
                "              </table>" &
                "            </td>" &
                "          </tr> " &
                "          <tr>" &
                "            <td align='center' valign='top' style='padding:10px 0;'>" &
                "              <p style='font-family:arial; font-size:11px; color:#999; padding:5px 20px; margin:0; text-align:center;'>This email cannot be replied. If you have any futher queries and question please <a href='mailto:service@tibto.com' style='color:#666; font-family:arial;'>Email Us</a></p>" &
                "            </td>" &
                "          </tr>" &
                "        </tbody>" &
                "      </table>" &
                "    </center>" &
                "  </div>" &
                "  </body>" &
                "</html>"
    End Function

End Class
