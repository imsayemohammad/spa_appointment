Imports Microsoft.VisualBasic
Imports System
Imports System.Drawing.Imaging
Imports System.Data.SqlClient
Imports System.IO
Imports System.Net
Imports System.Net.Mail

Public Class Utility
    Public Shared Function GetUserIP(Request As HttpRequest) As String
        Dim ipList As String = Request.ServerVariables("HTTP_X_FORWARDED_FOR")

        If Not String.IsNullOrEmpty(ipList) Then
            Return ipList.Split(","c)(0)
        End If

        Return Request.ServerVariables("REMOTE_ADDR")
    End Function









    Public Shared Function AddImageFromURL(ByVal imageURL As String, ByVal prefix As String, ByVal Server As System.Web.HttpServerUtility) As String

        Dim c As String, filename As String
        c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & Date.Now.Millisecond & ".jpg"
        filename = "Content/" & prefix & c

        WriteBytesToFile(Server.MapPath("../" & filename), GetBytesFromUrl(imageURL))

        Return filename

    End Function

    Public Shared Function AddImageFromURL(ByVal imageURL As String, ByVal prefix As String) As String

        Dim c As String, filename As String
        c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & Date.Now.Millisecond & ".jpg"
        filename = "Content/" & prefix & c

        WriteBytesToFile(HttpContext.Current.Server.MapPath("../" & filename), GetBytesFromUrl(imageURL))

        Return filename

    End Function

    Public Shared Sub RblAdd(ByVal ob As RadioButtonList, ByVal sql As String)
        Dim List As List(Of String) = New List(Of String)()
        Try
            Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("spaconnectionstring").ToString)
            con.Open()
            Dim cmd As SqlCommand = New SqlCommand(sql, con)
            Dim rd As SqlDataReader = cmd.ExecuteReader()
            List.Clear()
            While rd.Read()
                List.Add(rd(0).ToString())
            End While

            rd.Close()
            ob.Items.Clear()
            ob.Text = ""
            For i As Integer = 0 To List.Count - 1
                ob.Items.Add(List(i).ToString())
            Next
        Catch
        End Try
    End Sub



    Public Shared Function GetCurrencySymbol() As String

        Try
            Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("spaconnectionstring").ToString)
            Dim sql As String = "SELECT c.symbol FROM CompanySetting cs inner join Currencies c on    cs.BaseCurrency =c.CurrID"
            Dim symbol As String

            con.Open()

            Dim cmd As SqlCommand = New SqlCommand(sql, con)
            Dim rd As SqlDataReader = cmd.ExecuteReader()

            While rd.Read()
                symbol = rd("symbol").ToString()

            End While

            rd.Close()
            con.Close()

            Return symbol
        Catch

        End Try




    End Function


    Public Shared Sub listAdd(ByVal ob As ListBox, ByVal sql As String)
        Dim List As List(Of String) = New List(Of String)()
        Try
            Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("spaconnectionstring").ToString)
            con.Open()
            Dim cmd As SqlCommand = New SqlCommand(sql, con)
            Dim rd As SqlDataReader = cmd.ExecuteReader()
            List.Clear()
            While rd.Read()
                List.Add(rd(0).ToString())
            End While

            rd.Close()
            ob.Items.Clear()
            ob.Text = ""
            For i As Integer = 0 To List.Count - 1
                ob.Items.Add(List(i).ToString())
            Next
        Catch
        End Try
    End Sub

    Public Shared Sub txtAdd(ByVal sql As String, ByVal txtadd As TextBox)
        Try
            Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("spaconnectionstring").ToString)
            con.Open()
            Dim cmd As SqlCommand = New SqlCommand(sql, con)
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            If reader.Read() Then
                txtadd.Text = reader(0).ToString()
            End If

            con.Close()
            reader.Close()
        Catch
        End Try
    End Sub

    Public Shared Sub lblAdd(ByVal sql As String, ByVal lblAdd As Label)
        Try
            Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("spaconnectionstring").ToString)
            con.Open()
            Dim cmd As SqlCommand = New SqlCommand(sql, con)
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            If reader.Read() Then
                lblAdd.Text = reader(0).ToString()
            End If

            con.Close()
            reader.Close()
        Catch
        End Try
    End Sub

    Public Shared Function IntegerData(ByVal sql As String) As Integer
        Dim data As Integer = 0
        Try
            Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("spaconnectionstring").ToString)
            con.Open()
            Dim cmd As SqlCommand = New SqlCommand(sql, con)
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            If reader.Read() Then
                data = CType(reader(0).ToString(), Integer)
            End If

            con.Close()
            reader.Close()
        Catch
        End Try

        Return data
    End Function

    Public Shared Function StringData(ByVal sql As String) As String
        Dim data As String = ""
        Try
            Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("spaconnectionstring").ToString)
            con.Open()
            Dim cmd As SqlCommand = New SqlCommand(sql, con)
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            If reader.Read() Then
                data = reader(0).ToString()
            End If

            con.Close()
            reader.Close()
        Catch
        End Try

        Return data
    End Function

    Public Shared Sub hdnAdd(ByVal sql As String, ByVal hdnAdd As HiddenField)
        Try
            Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("spaconnectionstring").ToString)
            con.Open()
            Dim cmd As SqlCommand = New SqlCommand(sql, con)
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            If reader.Read() Then
                hdnAdd.Value = reader(0).ToString()
            End If
            con.Close()
            reader.Close()
        Catch
        End Try
    End Sub

    Public Shared Sub ltlAdd(ByVal sql As String, ByVal ltlAdd As Literal)
        Try
            Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("spaconnectionstring").ToString)
            con.Open()
            Dim cmd As SqlCommand = New SqlCommand(sql, con)
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            If reader.Read() Then
                ltlAdd.Text = reader(0).ToString()
            End If
            con.Close()
            reader.Close()
        Catch
        End Try
    End Sub

    Public Shared Function Dayformat(ByVal dt As DateTime) As String
        Dim mydate As String = dt.ToString("MM/dd/yyyy")
        Return mydate
    End Function

    Public Shared Function Dayformat1(ByVal dt As DateTime) As String
        Dim mydate As String = dt.ToString("dd/MM/yyyy")
        Return mydate
    End Function

    Public Shared Function GetDimentionSetting(ByVal moduleName As String, ByVal category As String, ByRef smallImageWidth As String, ByRef smallImageHeight As String, ByRef bigImageWidth As String, ByRef bigImageHeight As String, ByRef videoWidth As String, ByRef videoHeight As String) As String()
        Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()
        Dim selectString = "SELECT        DimentionID, ModuleName, Category, SmallImageWidth, SmallImageHeight, BigImageWidth, BigImageHeight, VideoWidth, VideoHeight  FROM   Settings_Dimention  where ModuleName=@ModuleName and Category=@Category  "
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("ModuleName", Data.SqlDbType.NVarChar, 100).Value = moduleName
        cmd.Parameters.Add("Category", Data.SqlDbType.NVarChar, 400, "Category").Value = category

        Dim reader As SqlDataReader = cmd.ExecuteReader()
        If reader.HasRows Then
            reader.Read()
            smallImageWidth = reader("smallImageWidth") & ""
            smallImageHeight = reader("smallImageHeight") & ""
            bigImageWidth = reader("bigImageWidth") & ""
            bigImageHeight = reader("bigImageHeight") & ""
            videoWidth = reader("videoWidth") & ""
            videoHeight = reader("videoHeight") & ""
        End If
        conn.Close()

    End Function


    Public Shared Function UploadFile(ByVal FileField As FileUpload, ByVal prefix As String) As String
        Dim domainName As String
        domainName = ConfigurationManager.AppSettings("RedirectUrl").ToString
        Dim c As String, filename As String = ""
        If FileField.PostedFile.ContentType.Contains("vnd.openxmlformats-officedocument.wordprocessingml.document") Then

            c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".docx"
            filename = "Content/" & prefix & c

            FileField.PostedFile.SaveAs(System.AppDomain.CurrentDomain.BaseDirectory() & "Admin/" & filename)

        ElseIf FileField.PostedFile.ContentType.Contains("msword") Then
            c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".doc"
            filename = "Content/" & prefix & c

            FileField.PostedFile.SaveAs(System.AppDomain.CurrentDomain.BaseDirectory() & "Admin/" & filename)

        ElseIf FileField.PostedFile.ContentType.Contains("pdf") Then
            c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".pdf"
            filename = "Content/" & prefix & c

            FileField.PostedFile.SaveAs(System.AppDomain.CurrentDomain.BaseDirectory() & "Admin/" & filename)

        Else
            Throw New Exception("Please select correct File format")
            Exit Function

        End If


        Return filename

    End Function



    Public Shared Function UploadFile(ByVal FileField As FileUpload, ByVal prefix As String, ByVal lang As String) As String
        Dim c As String, filename As String
        Try
            c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & FileField.FileName.Substring(FileField.FileName.LastIndexOf(".")) '".jpg"
        Catch ex As Exception
            c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".pdf"
        End Try

        filename = "Content/" & prefix & c


        If FileField.FileName <> "" Then
            FileField.PostedFile.SaveAs(System.AppDomain.CurrentDomain.BaseDirectory() & lang & "/Admin/" & filename)

        End If
        Return filename

    End Function
    Public Shared Function UploadFile(ByVal FileField As FileUpload, ByVal prefix As String, ByVal Server As System.Web.HttpServerUtility, ByVal lang As String) As String
        Dim c As String, filename As String
        Try
            c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & FileField.FileName.Substring(FileField.FileName.LastIndexOf(".")) '".jpg"
        Catch ex As Exception
            c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".pdf"
        End Try

        filename = "Content/" & prefix & c


        If FileField.FileName <> "" Then
            FileField.PostedFile.SaveAs(System.AppDomain.CurrentDomain.BaseDirectory() & lang & "/Admin/" & filename)

        End If
        Return filename

    End Function

    Public Shared Function AddImage(ByVal FileField As FileUpload, ByVal prefix As String) As String
        Dim c As String, filename As String
        c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".jpg"
        filename = "Content/" & prefix & c
        'Dim filename1 As String = "Content/T_" & prefix & c
        If FileField.FileName <> "" Then

            If Mid(FileField.PostedFile.ContentType, 1, 5) <> "image" Then
                Throw New Exception("Please select correct image")
                Exit Function
            End If
            FileField.PostedFile.SaveAs(System.AppDomain.CurrentDomain.BaseDirectory() & "Admin/" & filename)
            'FileField.PostedFile.SaveAs(System.AppDomain.CurrentDomain.BaseDirectory() & "Admin/" & filename1)
        End If
        Return filename

    End Function

    Public Shared Function AddImage(ByVal FileField As FileUpload, ByVal prefix As String, ByVal Server As System.Web.HttpServerUtility) As String
        Dim c As String, filename As String
        c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".jpg"
        filename = "Content/" & prefix & c
        'Dim filename1 As String = "Content/T_" & prefix & c
        If FileField.FileName <> "" Then

            If Mid(FileField.PostedFile.ContentType, 1, 5) <> "image" Then
                Throw New Exception("Please select correct image")
                Exit Function
            End If
            FileField.PostedFile.SaveAs(System.AppDomain.CurrentDomain.BaseDirectory() & "Admin/" & filename)
            'FileField.PostedFile.SaveAs(System.AppDomain.CurrentDomain.BaseDirectory() & "Admin/" & filename1)
        End If
        Return filename

    End Function

    Public Shared Function AddImage(ByVal FileField As FileUpload, ByVal prefix As String, ByVal Server As System.Web.HttpServerUtility, ByVal lang As String) As String
        Dim c As String, filename As String
        c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".jpg"
        filename = "Content/" & prefix & c
        'Dim filename1 As String = "Content/T_" & prefix & c
        If FileField.FileName <> "" Then

            If Mid(FileField.PostedFile.ContentType, 1, 5) <> "image" Then
                Throw New Exception("Please select correct image")
                Exit Function
            End If
            FileField.PostedFile.SaveAs(System.AppDomain.CurrentDomain.BaseDirectory() & lang & "/Admin/" & filename)
            'FileField.PostedFile.SaveAs(System.AppDomain.CurrentDomain.BaseDirectory() & lang & "/Admin/" & filename1)
        End If
        Return filename

    End Function

    ''' <summary>
    ''' The thumbnail image will contain "T_" as prefix of the full image
    ''' if FileField contains file name, this medhod will always return the thumbnail image location on server. 
    ''' So to get the original image location on server, remove prefix "T_"
    ''' </summary>
    ''' <param name="FileField">FileField contains upload file</param>
    ''' <param name="prefix">A prefix to Groupify the image </param>
    ''' <param name="width">Thumbnail Width</param>
    ''' <param name="Server">System.Web.HttpServerUtility object to get the location of the server </param>
    ''' <returns>if FileField contains file name, this medhod will always return the thumbnail image location</returns>
    ''' <remarks></remarks>


    Public Shared Function AddImage(ByVal FileField As FileUpload, ByVal prefix As String, ByVal width As Integer, ByVal Server As System.Web.HttpServerUtility) As String
        Dim c As String, filename As String
        c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".jpg"
        filename = "Content/" & prefix & c

        Dim fullSizeImg As System.Drawing.Image
        Dim w, h As Integer
        Dim thumbNailImg As System.Drawing.Image

        If FileField.FileName <> "" Then

            If Mid(FileField.PostedFile.ContentType, 1, 5) <> "image" Then
                Throw New Exception("Please select correct image")
                Exit Function
            End If
            FileField.PostedFile.SaveAs(System.AppDomain.CurrentDomain.BaseDirectory() & "Admin/" & filename)


            'Resiging Small Image

            fullSizeImg = System.Drawing.Image.FromFile(Server.MapPath(filename))

            w = fullSizeImg.Width
            h = fullSizeImg.Height

            If fullSizeImg.Width > width Or fullSizeImg.Width < width Then
                'Finding ration
                w = width
                h = (w * fullSizeImg.Height) / fullSizeImg.Width
            End If

            'Image Quality
            Dim codecs() As ImageCodecInfo = ImageCodecInfo.GetImageEncoders()
            'find the encoder with the image/jpeg mime-type
            Dim ici As ImageCodecInfo = Nothing
            Dim codec As ImageCodecInfo
            For Each codec In codecs
                If (codec.MimeType = "image/jpeg") Then
                    ici = codec
                End If
            Next
            Dim ep As EncoderParameters = New EncoderParameters
            ep.Param(0) = New EncoderParameter(Encoder.Quality, CType(100, Long))
            'ici, ep
            '.......................

            thumbNailImg = fullSizeImg.GetThumbnailImage(w, h, Nothing, IntPtr.Zero)
            filename = "Content/T_" & prefix & c
            thumbNailImg.Save(Server.MapPath(filename), ici, ep)

        End If
        Return filename

    End Function

    Public Shared Function AddImage(ByVal FileField As FileUpload, ByVal prefix As String, ByVal width As Integer, ByVal Server As System.Web.HttpServerUtility, ByVal lang As String) As String
        Dim c As String, filename As String
        c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".jpg"
        filename = "Content/" & prefix & c

        Dim fullSizeImg As System.Drawing.Image
        Dim w, h As Integer
        Dim thumbNailImg As System.Drawing.Image

        If FileField.FileName <> "" Then

            If Mid(FileField.PostedFile.ContentType, 1, 5) <> "image" Then
                Throw New Exception("Please select correct image")
                Exit Function
            End If
            FileField.PostedFile.SaveAs(System.AppDomain.CurrentDomain.BaseDirectory() & lang & "/Admin/" & filename)


            'Resiging Small Image

            fullSizeImg = System.Drawing.Image.FromFile(Server.MapPath(filename))

            w = fullSizeImg.Width
            h = fullSizeImg.Height

            If fullSizeImg.Width > width Or fullSizeImg.Width < width Then
                'Finding ration
                w = width
                h = (w * fullSizeImg.Height) / fullSizeImg.Width
            End If

            'Image Quality
            Dim codecs() As ImageCodecInfo = ImageCodecInfo.GetImageEncoders()
            'find the encoder with the image/jpeg mime-type
            Dim ici As ImageCodecInfo = Nothing
            Dim codec As ImageCodecInfo
            For Each codec In codecs
                If (codec.MimeType = "image/jpeg") Then
                    ici = codec
                End If
            Next
            Dim ep As EncoderParameters = New EncoderParameters
            ep.Param(0) = New EncoderParameter(Encoder.Quality, CType(100, Long))
            'ici, ep
            '.......................

            thumbNailImg = fullSizeImg.GetThumbnailImage(w, h, Nothing, IntPtr.Zero)
            filename = "Content/T_" & prefix & c
            thumbNailImg.Save(Server.MapPath(filename), ici, ep)

        End If
        Return filename

    End Function

    Public Shared Function AddImage(ByVal FileField As FileUpload, ByVal prefix As String, ByVal width As Integer, ByVal height As Integer, ByVal Server As System.Web.HttpServerUtility) As String
        Dim c As String, filename As String
        c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".jpg"
        filename = "Content/" & prefix & c

        Dim fullSizeImg As System.Drawing.Image
        Dim w, h As Integer
        Dim thumbNailImg As System.Drawing.Image

        If FileField.FileName <> "" Then

            If Mid(FileField.PostedFile.ContentType, 1, 5) <> "image" Then
                Throw New Exception("Please select correct image")
                Exit Function
            End If
            FileField.PostedFile.SaveAs(System.AppDomain.CurrentDomain.BaseDirectory() & "Admin/" & filename)


            'Resiging Small Image

            fullSizeImg = System.Drawing.Image.FromFile(Server.MapPath(filename))

            w = fullSizeImg.Width
            h = fullSizeImg.Height

            If fullSizeImg.Width > width Or fullSizeImg.Width < width Then
                'Finding ration
                w = width

            End If
            If fullSizeImg.Height > height Or fullSizeImg.Height < height Then
                'Finding ration
                h = height
            End If
            'Image Quality
            Dim codecs() As ImageCodecInfo = ImageCodecInfo.GetImageEncoders()
            'find the encoder with the image/jpeg mime-type
            Dim ici As ImageCodecInfo = Nothing
            Dim codec As ImageCodecInfo
            For Each codec In codecs
                If (codec.MimeType = "image/jpeg") Then
                    ici = codec
                End If
            Next
            Dim ep As EncoderParameters = New EncoderParameters
            ep.Param(0) = New EncoderParameter(Encoder.Quality, CType(100, Long))
            'ici, ep
            '.......................

            thumbNailImg = fullSizeImg.GetThumbnailImage(w, h, Nothing, IntPtr.Zero)
            filename = "Content/T_" & prefix & c
            thumbNailImg.Save(Server.MapPath(filename), ici, ep)

        End If
        Return filename

    End Function

    Public Shared Function AddImage(ByVal FileField As FileUpload, ByVal prefix As String, ByVal width As Integer, ByVal height As Integer, ByVal Server As System.Web.HttpServerUtility, ByVal lang As String) As String
        Dim c As String, filename As String
        c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".jpg"
        filename = "Content/" & prefix & c

        Dim fullSizeImg As System.Drawing.Image
        Dim w, h As Integer
        Dim thumbNailImg As System.Drawing.Image

        If FileField.FileName <> "" Then

            If Mid(FileField.PostedFile.ContentType, 1, 5) <> "image" Then
                Throw New Exception("Please select correct image")
                Exit Function
            End If
            FileField.PostedFile.SaveAs(System.AppDomain.CurrentDomain.BaseDirectory() & lang & "/Admin/" & filename)


            'Resiging Small Image

            fullSizeImg = System.Drawing.Image.FromFile(Server.MapPath(filename))

            w = fullSizeImg.Width
            h = fullSizeImg.Height

            If fullSizeImg.Width > width Or fullSizeImg.Width < width Then
                'Finding ration
                w = width

            End If
            If fullSizeImg.Height > height Or fullSizeImg.Height < height Then
                'Finding ration
                h = height
            End If
            'Image Quality
            Dim codecs() As ImageCodecInfo = ImageCodecInfo.GetImageEncoders()
            'find the encoder with the image/jpeg mime-type
            Dim ici As ImageCodecInfo = Nothing
            Dim codec As ImageCodecInfo
            For Each codec In codecs
                If (codec.MimeType = "image/jpeg") Then
                    ici = codec
                End If
            Next
            Dim ep As EncoderParameters = New EncoderParameters
            ep.Param(0) = New EncoderParameter(Encoder.Quality, CType(100, Long))
            'ici, ep
            '.......................

            thumbNailImg = fullSizeImg.GetThumbnailImage(w, h, Nothing, IntPtr.Zero)
            filename = "Content/T_" & prefix & c
            thumbNailImg.Save(Server.MapPath(filename), ici, ep)

        End If
        Return filename

    End Function




    Public Shared Function AddImageFromURL(ByVal imageURL As String, ByVal prefix As String, ByVal width As Integer, ByVal Server As System.Web.HttpServerUtility) As String

        Dim c As String, filename As String
        c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & Date.Now.Millisecond & ".jpg"
        filename = "Content/" & prefix & c

        WriteBytesToFile(Server.MapPath(filename), GetBytesFromUrl(imageURL))


        Dim fullSizeImg As System.Drawing.Image
        Dim w, h As Integer
        Dim thumbNailImg As System.Drawing.Image


        'Resiging Small Image
        Try
            fullSizeImg = System.Drawing.Image.FromFile(Server.MapPath(filename))

            w = fullSizeImg.Width
            h = fullSizeImg.Height

            If fullSizeImg.Width > width Or fullSizeImg.Width < width Then
                'Finding ration
                w = width
                h = (w * fullSizeImg.Height) / fullSizeImg.Width
            End If

            'Image Quality
            Dim codecs() As ImageCodecInfo = ImageCodecInfo.GetImageEncoders()
            'find the encoder with the image/jpeg mime-type
            Dim ici As ImageCodecInfo = Nothing
            Dim codec As ImageCodecInfo
            For Each codec In codecs
                If (codec.MimeType = "image/jpeg") Then
                    ici = codec
                End If
            Next
            Dim ep As EncoderParameters = New EncoderParameters
            ep.Param(0) = New EncoderParameter(Encoder.Quality, CType(100, Long))
            'ici, ep
            '.......................

            thumbNailImg = fullSizeImg.GetThumbnailImage(w, h, Nothing, IntPtr.Zero)
            filename = "Content/T_" & prefix & c
            thumbNailImg.Save(Server.MapPath(filename), ici, ep)
            thumbNailImg = Nothing
            ep = Nothing
            fullSizeImg = Nothing

        Catch ex As Exception

        End Try


        Return filename

    End Function

    Private Shared Function GetBytesFromUrl(url As String) As Byte()
        Dim b As Byte()
        Dim myReq As HttpWebRequest = DirectCast(WebRequest.Create(url), HttpWebRequest)
        Dim myResp As WebResponse = myReq.GetResponse()

        Dim stream As Stream = myResp.GetResponseStream()
        'int i;
        Using br As New BinaryReader(stream)
            'Dim i As Long = (stream.Length)
            b = br.ReadBytes(500000)
            br.Close()
        End Using
        myResp.Close()
        Return b
    End Function



    Private Shared Sub WriteBytesToFile(fileName As String, content As Byte())
        Dim fs As New FileStream(fileName, FileMode.Create)
        Dim w As New BinaryWriter(fs)
        Try
            w.Write(content)
        Finally
            fs.Close()
            w.Close()
        End Try

    End Sub

    Public Shared Function GetSmallDetails(ByVal smallDetails As String) As String
        Dim retVal As String = ""
        retVal = If(smallDetails.Length > 150, Mid(smallDetails, 1, 147) & "...", smallDetails)
        Return retVal
    End Function
    Public Shared Function GetAdSmallDetails(ByVal smallDetails As String) As String
        Dim retVal As String = ""
        retVal = If(smallDetails.Length > 75, Mid(smallDetails, 1, 72) & "...", smallDetails)
        Return retVal
    End Function

    '    Public Shared Sub SendMail(ByVal FromName As String, ByVal FromEmail As String, ByVal ReceiverEmail As String, ByVal CC As String, ByVal BCC As String, ByVal subj As String, ByVal Mssg As String)

    '        ''#################Sending Email##########################
    '        ''Create instance of main mail message class.

    '        Dim mailMessage As System.Net.Mail.MailMessage = New System.Net.Mail.MailMessage()

    '        mailMessage.From = New System.Net.Mail.MailAddress(FromEmail, FromName)
    '        mailMessage.To.Add(New System.Net.Mail.MailAddress(ReceiverEmail))
    '        If BCC <> "" Then
    '            mailMessage.Bcc.Add(New System.Net.Mail.MailAddress(BCC))
    '        End If
    '        If CC <> "" Then
    '            mailMessage.CC.Add(New System.Net.Mail.MailAddress(CC))
    '        End If

    '        ''Set additional options
    '        mailMessage.Priority = System.Net.Mail.MailPriority.Normal
    '        ''Text/HTMLs
    '        mailMessage.IsBodyHtml = True

    '        ''Set the subjet and body text
    '        mailMessage.Subject = subj
    '        mailMessage.Body = Mssg


    '        ''Create an instance of the SmtpClient class for sending the email
    '        Dim smtpClient As New System.Net.Mail.SmtpClient()
    '        'smtpClient.Host = "127.0.0.1"
    '        'smtpClient.Port = 25
    '        smtpClient.Host = "mail.remyrue.com" '"auth.smtp.1and1.co.uk"
    '        smtpClient.Port = 25
    '        smtpClient.Credentials = New NetworkCredential("noreply@remyrue.com", "subscribe")
    '        smtpClient.EnableSsl = False
    '        smtpClient.UseDefaultCredentials = False

    '        'ServicePointManager.ServerCertificateValidationCallback =
    '        '    Function(s As Object, certificate As System.Security.Cryptography.X509Certificates.X509Certificate, chain As System.Security.Cryptography.X509Certificates.X509Chain, sslPolicyErrors As Net.Security.SslPolicyErrors) True

    '        Try
    '            smtpClient.Send(mailMessage)
    '            'Response.Write("Email Send")
    '        Catch smtpExc As System.Net.Mail.SmtpException
    '            GoTo B
    '        Catch ex As Exception

    '            GoTo B
    '        End Try
    'B:
    '    End Sub

    Public Shared Function SendEmail(fromAddress As String, toAddress As String, cc As String, bcc As String, subject As String, body As String, attachment As String) As Boolean
        Dim smtpClient As New Mail.SmtpClient()
        Dim message As New MailMessage()
        Try
            Dim from As New MailAddress("" & fromAddress & "")
            message.From = from
            message.To.Add("" & toAddress & "")
            If cc <> "" Then
                message.CC.Add("" & cc & "")
            End If
            If bcc <> "" Then
                message.Bcc.Add("" & bcc & "")
            End If
            If attachment <> "" Then
                Dim Mailattachment As New Net.Mail.Attachment(attachment)
                message.Attachments.Add(Mailattachment)
            End If
            message.IsBodyHtml = True
            message.Subject = subject
            message.Body = body

            smtpClient.Host = "127.0.0.1"
            smtpClient.Port = 25

            smtpClient.Send(message)
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function

    '    Public Shared Function SendMailAmazon(fromAddress As String, ByVal ToEmail As String, ByVal CC As String, subJ As String, body As String) As String
    '        Dim A As String

    '        Dim myMail As New MailMessage()
    '        '  myMail.From = New MailAddress("noreply@royex.com", "demo.royex.net")
    '        ' myMail.From = New MailAddress("noreply@branoo.com", "Demo.royex.com")
    '        'myMail.From = New MailAddress("noreplytest@royex.com", "Demo.royex.com")
    '        'myMail.From = New MailAddress("info@machinebazer.com", "MachineBazer.com")

    '        myMail.From = New MailAddress("sayem@royex.net", "dsss.com")
    '        myMail.To.Add(New MailAddress(ToEmail))
    '        myMail.To.Add(New MailAddress(CC))
    '        myMail.Subject = subJ
    '        myMail.Priority = MailPriority.Normal

    '        myMail.IsBodyHtml = True
    '        myMail.Body = body   ' Replacing Email 


    '        Dim username As [String] = "AKIAIH7JXPGEMTVN5RJQ"
    '        ' Replace with your SMTP username.
    '        Dim password As [String] = "AreL48x9y1rMT8UTE42BLpMCuxfTCRbQWKevJf07Ybil"
    '        ' Replace with your SMTP password.
    '        Dim host As [String] = "email-smtp.us-west-2.amazonaws.com"
    '        Dim port As Integer = 25

    '        Using client = New System.Net.Mail.SmtpClient(host, port)
    '            client.Credentials = New System.Net.NetworkCredential(username, password)
    '            client.EnableSsl = True


    '            ' Replace with the sender address.
    '            ' Replace with the recipient address.

    '            Try

    '                client.Send(myMail)
    '                A = 1
    '            Catch smtpExc As System.Net.Mail.SmtpException
    '                A = smtpExc.Message
    '                GoTo B
    '            Catch ex As Exception
    '                A = ex.Message
    '                GoTo B
    '            End Try
    'B:
    '        End Using

    '        Return A

    '    End Function
    Public Shared Function SendMailAmazon(fromAddress As String, ByVal ToEmail As String, ByVal CC As String, ByVal BC As String, subJ As String, body As String) As String
        Dim A As String

        Dim myMail As New MailMessage()
        '  myMail.From = New MailAddress("noreply@royex.com", "demo.royex.net")

        myMail.From = New MailAddress("sayem@royex.net", "dsss.com")
        myMail.To.Add(New MailAddress(ToEmail))
        If CC <> "" Then
            myMail.To.Add(New MailAddress(CC))
        End If
        If BC <> "" Then
            myMail.To.Add(New MailAddress(BC))
        End If


        myMail.Subject = subJ
        myMail.Priority = MailPriority.Normal

        myMail.IsBodyHtml = True
        myMail.Body = body   ' Replacing Email 


        Dim username As [String] = "AKIAJOPTDCYJF3ZWKYMA"
        ' Replace with your SMTP username.
        Dim password As [String] = "AvmDvfJe3KnWivjFZVS4twhRVyay1CkhhfcMQEeqLgg5"
        ' Replace with your SMTP password.
        Dim host As [String] = "email-smtp.us-west-2.amazonaws.com"
        Dim port As Integer = 25

        Using client = New System.Net.Mail.SmtpClient(host, port)
            client.Credentials = New System.Net.NetworkCredential(username, password)
            client.EnableSsl = True
            ' Replace with the sender address.
            ' Replace with the recipient address.
            Try
                client.Send(myMail)
                A = 1
            Catch smtpExc As System.Net.Mail.SmtpException
                A = smtpExc.Message
                GoTo B
            Catch ex As Exception
                A = ex.Message
                GoTo B
            End Try
B:
        End Using

        Return A

    End Function

    Public Shared Function EncodeTitle(ByVal title As String, Optional ByVal delimiter As String = "-") As String

        Dim regTitle = New Regex("(\w+)(\W+)?", RegexOptions.IgnoreCase)
        Dim newTitle = Regex.Replace(regTitle.Replace(title, "$1-"), "[^\u0000-\u007F]+", "_").TrimEnd(New Char() {delimiter.Substring(0, 1)}).ToLower()
        Return newTitle
        'Return title.Trim().Replace(" ", delimiter).Replace("""", "").Replace("'", "").Replace("�", "").Replace("�", "").Replace("@", "-at-").Replace("&", "-").Replace("(", "-").Replace(")", "-").Replace(",", "").Replace("%", "").Replace("'", "").Replace("?", "").Replace(".", "").Replace("---", "-").ToLower().Replace("--", "-").ToLower()
    End Function

    Public Shared Function DecodeTitle(ByVal encodedTitle As String, ByVal delimiter As String) As String
        Return encodedTitle.Trim().Replace(delimiter, " ")
    End Function
    ''' <summary>
    ''' This is a simple curcular pager. If you are at first page and press on prev, 
    ''' it will take you to the last page and vice verca. The current pager is generally 
    ''' get the middle position except it's nearer to the boundary which is determined 
    ''' by a number= Math.Floor(totalPageNumToShow/2)
    ''' </summary>
    ''' <param name="presentPageNum">present Page Number</param>
    ''' <param name="totalNumOfPage ">total Num Of Page  </param>
    ''' <param name="totalPageNumToShow">Give odd number of pages except 1 to get best paging</param>
    ''' <param name="urlToNavigateWithQStr">example of this variable: example.aspx?page=</param>
    ''' <returns>It will return pager string</returns>
    ''' <remarks>If you get any bug, please tell me</remarks>
    Public Shared Function GetPager1(ByVal presentPageNum As Integer, ByVal totalNumOfPage As Integer, ByVal totalPageNumToShow As Integer, ByVal urlToNavigateWithQStr As String, ByVal conditionclause As String) As String
        Dim i As Integer
        Dim loopStartNum, loopEndNum, presentNum, maxShownNum As Integer
        Dim pagerString As String = ""
        presentNum = presentPageNum
        maxShownNum = totalPageNumToShow
        Dim middleFactor As Integer = maxShownNum / 2
        pagerString = "<div class=""""> <ul class=""pagination"">"
        If totalNumOfPage <= totalPageNumToShow Then
            loopStartNum = 1
            loopEndNum = totalNumOfPage
            'pagerString = pagerString & "<div><a href=""" & urlToNavigateWithQStr & "1"">First</a></div>"
            pagerString = pagerString & "<li><a href=""" & urlToNavigateWithQStr & If(presentNum <= 1, totalNumOfPage, (presentNum - 1)) & conditionclause & """>Previous</a></li>"
            For i = loopStartNum To loopEndNum
                If (i = presentNum) Then
                    pagerString = pagerString & "<li class=""active""><a href=""javascript:;"">" & i & "</a></li>"
                Else
                    pagerString = pagerString & "<li><a href=""" & urlToNavigateWithQStr & i & conditionclause & """>" & i & "</a></li>"
                End If
            Next
            pagerString = pagerString & "<li><a href=""" & urlToNavigateWithQStr & If(presentNum = totalNumOfPage, 1, (presentNum + 1)) & conditionclause & """>Next</a></li>"
            ' pagerString = pagerString & "<div><a href=""" & urlToNavigateWithQStr & totalNumOfPage & """>Last</a></div>"
        Else
            loopStartNum = If(presentNum <= (middleFactor + 1), 1, If(presentNum + middleFactor >= totalNumOfPage, totalNumOfPage - (maxShownNum - 1), presentNum - middleFactor))
            loopEndNum = If(presentNum <= (middleFactor + 1), maxShownNum, If(presentNum + middleFactor >= totalNumOfPage, totalNumOfPage, presentNum + middleFactor))
            loopEndNum = If(loopEndNum > totalNumOfPage, totalNumOfPage, loopEndNum)
            'pagerString = pagerString & "<div><a href=""" & urlToNavigateWithQStr & "1"">First</a></div>"
            pagerString = pagerString & "<li><a href=""" & urlToNavigateWithQStr & If(presentNum = 1, totalNumOfPage, (presentNum - 1)) & conditionclause & """>Previous</a></li>"
            For i = loopStartNum To loopEndNum
                If (i = presentNum) Then
                    pagerString = pagerString & "<li class=""active""><a href=""javascript:;"">" & i & "</a></li>"
                Else
                    pagerString = pagerString & "<li><a href=""" & urlToNavigateWithQStr & i & conditionclause & """>" & i & "</a></li>"
                End If
            Next
            pagerString = pagerString & "<li><a href=""" & urlToNavigateWithQStr & If(presentNum = totalNumOfPage, 1, (presentNum + 1)) & conditionclause & """>Next</a></li>"
            'pagerString = pagerString & "<div><a href=""" & urlToNavigateWithQStr & totalNumOfPage & """>Last</a></div>"
        End If

        pagerString = pagerString & "</ul></div>"
        Return pagerString
    End Function


    Public Shared Function GetPager(ByVal presentPageNum As Integer, ByVal totalNumOfPage As Integer, ByVal totalPageNumToShow As Integer, ByVal urlToNavigateWithQStr As String, ByVal conditionclause As String) As String
        Dim i As Integer
        Dim loopStartNum, loopEndNum, presentNum, maxShownNum As Integer
        Dim pagerString As String = ""
        presentNum = presentPageNum
        maxShownNum = totalPageNumToShow
        Dim middleFactor As Integer = maxShownNum / 2
        pagerString = "<nav aria-label=""Page navigation example"" class=""m-t-40""> <ul class=""pagination"">"
        If totalNumOfPage <= totalPageNumToShow Then
            loopStartNum = 1
            loopEndNum = totalNumOfPage
            pagerString = pagerString & "<li class=""page-item""><a class=""page-link"" href=""" & urlToNavigateWithQStr & If(presentNum <= 1, totalNumOfPage, (presentNum - 1)) & conditionclause & """>Previous</a></li>"
            For i = loopStartNum To loopEndNum
                If (i = presentNum) Then
                    pagerString = pagerString & "<li class=""page-item active""><a class=""page-link"" href=""javascript:;"">" & i & "</a></li>"
                Else
                    pagerString = pagerString & "<li class=""page-item""><a class=""page-link"" href=""" & urlToNavigateWithQStr & i & conditionclause & """>" & i & "</a></li>"
                End If
            Next
            pagerString = pagerString & "<li class=""page-item""><a class=""page-link"" href=""" & urlToNavigateWithQStr & If(presentNum = totalNumOfPage, 1, (presentNum + 1)) & conditionclause & """>Next</a></li>"
        Else
            loopStartNum = If(presentNum <= (middleFactor + 1), 1, If(presentNum + middleFactor >= totalNumOfPage, totalNumOfPage - (maxShownNum - 1), presentNum - middleFactor))
            loopEndNum = If(presentNum <= (middleFactor + 1), maxShownNum, If(presentNum + middleFactor >= totalNumOfPage, totalNumOfPage, presentNum + middleFactor))
            loopEndNum = If(loopEndNum > totalNumOfPage, totalNumOfPage, loopEndNum)
            pagerString = pagerString & "<li class=""page-item""><a class=""page-link"" href=""" & urlToNavigateWithQStr & If(presentNum = 1, totalNumOfPage, (presentNum - 1)) & conditionclause & """>Previous</a></li>"
            For i = loopStartNum To loopEndNum
                If (i = presentNum) Then
                    pagerString = pagerString & "<li class=""page-item active""><a class=""page-link"" href=""javascript:;"">" & i & "</a></li>"
                Else
                    pagerString = pagerString & "<li class=""page-item""><a class=""page-link"" href=""" & urlToNavigateWithQStr & i & conditionclause & """>" & i & "</a></li>"
                End If
            Next
            pagerString = pagerString & "<li class=""page-item""><a class=""page-link"" href=""" & urlToNavigateWithQStr & If(presentNum = totalNumOfPage, 1, (presentNum + 1)) & conditionclause & """>Next</a></li>"
        End If

        pagerString = pagerString & "</ul></nav>"
        Return pagerString
    End Function


    Public Shared Sub DownloadCSV(ByVal filename As String, ByVal table As Data.DataTable, ByVal Response As System.Web.HttpResponse)

        Dim i As Integer
        Dim sb As New System.Text.StringBuilder
        For i = 0 To table.Columns.Count - 1
            If i < (table.Columns.Count - 1) Then
                sb.Append(Chr(34) & table.Columns(i).ColumnName & Chr(34) & ",")
            Else
                sb.Append(Chr(34) & table.Columns(i).ColumnName & Chr(34) & vbCrLf)
            End If
        Next
        For Each row As Data.DataRow In table.Rows
            For i = 0 To table.Columns.Count - 1
                If i < (table.Columns.Count - 1) Then
                    sb.Append(Chr(34) & row(i).ToString.Replace("""", """""") & Chr(34) & ",")
                Else
                    sb.Append(Chr(34) & row(i).ToString.Replace("""", """""") & Chr(34) & vbCrLf)
                End If
            Next
        Next


        'Download CSV
        Response.ContentType = "Application/x-msexcel"
        Response.AddHeader("content-disposition", "attachment; filename=""" & filename & """")
        'Write the file directly to the HTTP output stream. 
        Response.Write(sb.ToString)
        Response.End()
    End Sub

    Public Shared Sub DownloadCSV(ByVal filename As String, ByVal SelectCommand As String, ByVal Response As System.Web.HttpResponse)
        'Use a string variable to hold the ConnectionString property.
        Dim cn As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        'Open the connection.
        cn.Open()
        'Set the appropriate ContentType. 
        Dim ss As String = SelectCommand
        Dim myCommand As New SqlCommand(ss, cn)
        'myCommand.Connection.Open()
        Dim myReader As Data.SqlClient.SqlDataReader = myCommand.ExecuteReader()

        Dim i As Integer
        Dim sb As New System.Text.StringBuilder
        For i = 0 To myReader.FieldCount - 1
            If i < (myReader.FieldCount - 1) Then
                sb.Append(Chr(34) & myReader.GetName(i) & Chr(34) & ",")
            Else
                sb.Append(Chr(34) & myReader.GetName(i) & Chr(34) & vbCrLf)
            End If
        Next
        While myReader.Read()
            For i = 0 To myReader.FieldCount - 1
                If i < (myReader.FieldCount - 1) Then
                    sb.Append(Chr(34) & myReader.GetValue(i).ToString.Replace("""", """""") & Chr(34) & ",")
                Else
                    sb.Append(Chr(34) & myReader.GetValue(i).ToString.Replace("""", """""") & Chr(34) & vbCrLf)
                End If
            Next
        End While
        myReader.Close()
        cn.Close()

        'Download CSV
        Response.ContentType = "Application/x-msexcel"
        Response.AddHeader("content-disposition", "attachment; filename=""" & filename & """")
        'for multilingual characterset
        Response.Charset = Encoding.UTF8.WebName
        Response.ContentEncoding = Encoding.UTF8
        Response.BinaryWrite(Encoding.UTF8.GetPreamble)

        'Write the file directly to the HTTP output stream. 
        Response.Write(sb.ToString)
        Response.End()
    End Sub



    Public Shared Sub SEO(ByVal Page_ As Page, ByVal title As String, ByVal keywords As String, ByVal description As String, ByVal Generator As String, ByVal ynRobot As Boolean)
        'META HEAD

        'Page Header
        Page_.Header.Title = title ' & " : dubainightplanner.com"


        'Keyword
        Dim metaKey As New HtmlMeta
        metaKey.Name = "keywords"
        metaKey.Content = keywords
        Page_.Header.Controls.Add(metaKey)

        'Description
        Dim metaDes As New HtmlMeta
        metaDes.Name = "description"
        metaDes.Content = description
        Page_.Header.Controls.Add(metaDes)

        'Generator
        Dim metaGen As New HtmlMeta
        metaGen.Name = "generator"
        metaGen.Content = Generator '"DNP 1.1"
        Page_.Header.Controls.Add(metaGen)


        'Robots
        Dim metaRob As New HtmlMeta
        If ynRobot Then
            metaRob.Name = "robots"
            metaRob.Content = "index,follow"
        Else
            metaRob.Name = "norobots"
            metaRob.Content = "noindex,nofollow"
        End If

        Page_.Header.Controls.Add(metaRob)


    End Sub

    Public Shared Function SEOFromDB(ByVal Page_ As Page, SEOID As String, ByVal Request As System.Web.HttpRequest) As String
        Dim recordID As String = "0"
        Dim title, keywords, description, focuskeyword As String
        Dim isRobot As Boolean = False
        title = ""
        keywords = ""
        description = ""
        focuskeyword = ""
        Dim Generator As String = "NEXA v 1.1"


        Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()
        Dim selectString = "SELECT [SEOID] ,[SEOTitle] ,[SEODescription] ,[SEOKeyWord] ,[SEORobot] ,[FocusKeyword],[PageType] ,[PageID]   FROM [dbo].[SEO]  where SEOID=@SEOID "
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("SEOID", Data.SqlDbType.Int).Value = SEOID

        Dim reader As SqlDataReader = cmd.ExecuteReader()
        If reader.HasRows Then
            reader.Read()
            title = reader("SEOTitle") & ""
            keywords = reader("SEOKeyWord") & ""
            focuskeyword = reader("FocusKeyword").ToString()
            description = reader("SEODescription") & ""
            Boolean.TryParse(reader("SEORobot") & "", isRobot)
            recordID = reader("SEOID") & ""
        End If
        conn.Close()

        'META HEAD
        'Page Header
        Page_.Header.Title = title
        If focuskeyword <> "" Then
            Page_.Header.Title = focuskeyword & " | " & Page_.Header.Title
        Else
            Page_.Header.Title = title & " | " & Page_.Header.Title
        End If

        'Keyword
        Dim metaKey As New HtmlMeta
        metaKey.Name = "keywords"
        metaKey.Content = keywords
        Page_.Header.Controls.Add(metaKey)

        'Description
        Dim metaDes As New HtmlMeta
        metaDes.Name = "description"
        metaDes.Content = description
        Page_.Header.Controls.Add(metaDes)

        'Generator
        Dim metaGen As New HtmlMeta
        metaGen.Name = "generator"
        metaGen.Content = Generator '"DNP 1.1"
        Page_.Header.Controls.Add(metaGen)


        'Robots
        Dim metaRob As New HtmlMeta
        If isRobot Then
            metaRob.Name = "robots"
            metaRob.Content = "index,follow"
        Else
            metaRob.Name = "robots"
            metaRob.Content = "noindex,nofollow"
        End If

        Page_.Header.Controls.Add(metaRob)

        Dim retVal As String = ""
        If isLoggedIn(Request) Then
            retVal = "<p style=""clear:both; padding-top:10px""><a target=""_blank"" href='Admin/A-SEO/SEOEdit.aspx?SEOID=" + recordID + "','TEXTEDITOR','scrollbars=yes,resizable=yes,width=850,height=700'>" &
            "<img border=""0"" src=""Admin/assets/images/icons/SEO.jpg"" width=""47""/></a><p>"
        End If


        Return retVal 'recordID
    End Function

    Public Shared Function SEOFromDB(ByVal Page_ As Page, pageType As String, pageID As String, ByVal Request As System.Web.HttpRequest) As String

        Dim domainName As String
        domainName = ConfigurationManager.AppSettings("RedirectUrl").ToString
        Dim recordID As String = "0"
        Dim title, keywords, description, focuskeyword As String
        Dim isRobot As Boolean = False
        title = ""
        focuskeyword = ""
        keywords = ""
        description = ""
        Dim Generator As String = "NEXA v 1.1"


        Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()
        Dim selectString = "SELECT [SEOID] ,[SEOTitle] ,[SEODescription] ,[SEOKeyWord] ,[SEORobot] ,[FocusKeyword], [PageType] ,[PageID]  FROM [dbo].[SEO]  where   PageType=@PageType and  pageID=@pageID "
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        'cmd.Parameters.Add("Lang", Data.SqlDbType.VarChar, 10).Value = lang
        cmd.Parameters.Add("PageType", Data.SqlDbType.VarChar, 50).Value = pageType
        cmd.Parameters.Add("pageID", Data.SqlDbType.VarChar, 50).Value = pageID

        Dim reader As SqlDataReader = cmd.ExecuteReader()
        If reader.HasRows Then
            reader.Read()
            title = reader("SEOTitle") & ""
            focuskeyword = reader("FocusKeyword").ToString()
            keywords = reader("SEOKeyWord") & ""
            description = reader("SEODescription") & ""
            Boolean.TryParse(reader("SEORobot") & "", isRobot)
            recordID = reader("SEOID") & ""
        End If
        conn.Close()

        'META HEAD
        'Page Header
        If focuskeyword <> "" Then
            Page_.Header.Title = focuskeyword & " | " & Page_.Header.Title
        Else
            Page_.Header.Title = title & " | " & Page_.Header.Title
        End If


        'Keyword
        Dim metaKey As New HtmlMeta
        metaKey.Name = "keywords"
        metaKey.Content = keywords
        Page_.Header.Controls.Add(metaKey)

        'Description
        Dim metaDes As New HtmlMeta
        metaDes.Name = "description"
        metaDes.Content = description
        Page_.Header.Controls.Add(metaDes)

        'Generator
        Dim metaGen As New HtmlMeta
        metaGen.Name = "generator"
        metaGen.Content = Generator '"DNP 1.1"
        Page_.Header.Controls.Add(metaGen)


        'Robots
        Dim metaRob As New HtmlMeta
        If isRobot Then
            metaRob.Name = "robots"
            metaRob.Content = "index,follow"
        Else
            metaRob.Name = "robots"
            metaRob.Content = "noindex,nofollow"
        End If

        Page_.Header.Controls.Add(metaRob)

        Dim retVal As String = ""
        If isLoggedIn(Request) Then
            retVal = "<p style=""clear:both; padding-top:10px""><a target=""_blank"" href='" & domainName & "Admin/A-SEO/SEOEdit.aspx?SEOID=" + recordID + "','TEXTEDITOR','scrollbars=yes,resizable=yes,width=850,height=700' class='cms fancybox.iframe'>" &
            "<img class=""AdminEditBtn"" src=""" & domainName & "Admin/assets/images/icons/SEO.png"" /></a><p>"
        End If


        Return retVal 'recordID
    End Function


    ''' <summary>
    ''' Compiled regular expression for performance.
    ''' </summary>
    Shared _htmlRegex As New Regex("<[^>]*>", RegexOptions.Compiled)
    Shared _htmlRegex1 As New Regex("<[^>]*>", RegexOptions.Compiled)
    ''' <summary>
    ''' Remove HTML from string with compiled Regex.
    ''' </summary>
    Public Shared Function StripTagsRegexCompiled(source As String) As String

        source = Regex.Replace(source, "<script.*?</script>", "", RegexOptions.Singleline Or RegexOptions.IgnoreCase)
        source = Regex.Replace(source, "<style.*?</style>", "", RegexOptions.Singleline Or RegexOptions.IgnoreCase)
        source = Regex.Replace(source, "<xml.*?</xml>", "", RegexOptions.Singleline Or RegexOptions.IgnoreCase)
        source = _htmlRegex.Replace(source, String.Empty)
        Return source.Trim()
    End Function

    Public Shared Function showEditButton(ByVal Request As System.Web.HttpRequest, ByVal adminUrl As String) As String
        Dim domainName As String
        domainName = ConfigurationManager.AppSettings("RedirectUrl").ToString
        Dim str As String = ""
        If isLoggedIn(Request) Then
            str += "<a target=""_blank"" href='" + domainName + adminUrl + "','TEXTEDITOR','scrollbars=yes,resizable=yes,width=850,height=700' class='cms fancybox.iframe' >"
            str += "<img style=""width:47px !important;"" border=""0"" src=""" & domainName & "Admin/assets/images/Icons/EditeMode.png""/></a>"
        End If

        Return str
    End Function
    Public Shared Function showAddButton(ByVal Request As System.Web.HttpRequest, ByVal adminUrl As String) As String
        Dim domainName As String
        domainName = ConfigurationManager.AppSettings("RedirectUrl").ToString
        Dim str As String = ""
        If isLoggedIn(Request) Then
            str += "<a target=""_blank"" href='" + domainName + adminUrl + "','TEXTEDITOR','scrollbars=yes,resizable=yes,width=850,height=700' class='cms fancybox.iframe'>"
            str += "<img border=""0"" src=""" & domainName & "Admin/assets/images/Icons/Add.png"" width=""47""/></a>"
        End If
        Return str
    End Function

    Public Shared Function isLoggedIn(ByVal Request As System.Web.HttpRequest) As Boolean
        If Request.Cookies("auserName") Is Nothing Then
            Return False
        End If
        If Request.Cookies("auserFullName") Is Nothing Then
            Return False
        End If
        If Request.Cookies("auserpass") Is Nothing Then
            Return False
        End If
        If Request.Cookies("auserName").Value.Trim() = "" Then
            Return False
        End If
        If Request.Cookies("auserFullName").Value.Trim() = "" Then
            Return False
        End If
        If Request.Cookies("auserpass").Value.Trim() = "" Then
            Return False
        End If
        If Request.Cookies("aUserID") Is Nothing Then
            Return False
        End If

        Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()
        Dim selectString = "select * from AdminPanelLogin where UN_1=@userID and PS_1=@password "
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("userID", Data.SqlDbType.VarChar, 50)
        cmd.Parameters.Add("password", Data.SqlDbType.VarChar, 100)
        cmd.Parameters("userID").Value = Request.Cookies("auserName").Value
        cmd.Parameters("password").Value = New Encription().DecryptTripleDES(Request.Cookies("auserpass").Value, "*n3x@")

        Dim reader As SqlDataReader = cmd.ExecuteReader()
        If reader.HasRows Then
            conn.Close()
            Return True
        End If
        conn.Close()


        Return False
    End Function

    'Public Shared Function EditModeBanner(ByVal Request As System.Web.HttpRequest) As String
    '    Dim retValue = New StringBuilder()

    '    '"            <div id=""pagetp_icon"">" & _
    '    '   "                <a target=""_blank"" onclick=""MM_openBrWindow('Admin/ContactsAll.aspx','TEXTEDITOR','scrollbars=yes,resizable=yes,width=800,height=600')"">" & _
    '    '   "                    <img border=""0"" src=""login/Assets/images/pagetp_report.jpg"" alt=""""/></a>" & _
    '    '   "            </div>" & _
    '    If isLoggedIn(Request) Then
    '        retValue.Append("<link href=""login/assets/css/style_sheet_header.css"" rel=""stylesheet"" type=""text/css"" />")
    '        retValue.Append("<div id=""outer"">")
    '        retValue.Append("    <div id=""top_strip"">")
    '        retValue.Append("        <div id=""tpstrip_lft"">")
    '        retValue.Append("            <img src=""login/Assets/images/pagetop_striplogo.jpg""/></div>")
    '        retValue.Append("        <div id=""tpstrip_rght"">")
    '        retValue.Append("            <div class=""pgtop_txt"" id=""pagetp_txt"">")
    '        retValue.Append("                <a href=""Login/LogOut.aspx"" style=""color: #FFFFFF"">Log out</a></div>")
    '        retValue.Append("            <div id=""pagetp_lgout"">")
    '        retValue.Append("                <img src=""login/Assets/images/pagetp_logout.jpg""/></div>")
    '        retValue.Append("            <div class=""pgtop_txt"" id=""pagetp_txt"">")
    '        retValue.Append("                <a target=""_blank"" style=""color: #FFFFFF"" href=""Admin/default.aspx"" target=""_blank""> ")
    '        retValue.Append("                Admin Panel</a></div>")
    '        retValue.Append("        </div>")
    '        retValue.Append("    </div>")
    '        retValue.Append("</div>")
    '    End If
    '    Return retValue.ToString()
    'End Function

    Public Shared Sub DounloadImage(ByVal Response As HttpResponse, ByVal Server As System.Web.HttpServerUtility, imageURL As String)

        Dim filename As String = Server.MapPath(imageURL)
        Dim fileInfo As New System.IO.FileInfo(filename)

        If fileInfo.Exists Then
            Response.Clear()
            Response.AddHeader("Content-Disposition", "inline;attachment; filename=" & fileInfo.Name)
            Response.AddHeader("Content-Length", fileInfo.Length.ToString())
            Response.ContentType = "image/jpeg"
            Response.Flush()
            Response.WriteFile(filename)
            Response.[End]()
            ' File Not Found

            'Response.ContentType = "Application/x-msexcel"
            'Response.AddHeader("content-disposition", "attachment; filename=""" & filename & """")
            ''Write the file directly to the HTTP output stream. 
            'Response.Write(sb.ToString)
            'Response.End()
        Else
        End If
    End Sub
    Public Shared Function FormatString(ByVal str As String) As String
        Dim retstr As String = ""
        If str <> "" Then
            Dim titlearray As String()
            titlearray = str.Split(" ")
            If titlearray.Length > 1 Then
                Dim middle As Integer = Math.Ceiling(titlearray.Length / 2)
                Dim firstpart As String = ""
                For i As Integer = 0 To middle - 1
                    firstpart += titlearray(i) & " "
                Next
                Dim secondpart As String = ""
                For i As Integer = middle To titlearray.Length - 1
                    secondpart += titlearray(i) & " "
                Next
                retstr = firstpart & "<span>" & secondpart & "</span>"
            Else
                retstr = str
            End If
        End If
        Return retstr
    End Function
End Class
