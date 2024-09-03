
Imports System.Data
Imports System.Data.SqlClient

Partial Class BrandList
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")

        If userID = 0 Then
            Response.Redirect("/login")
        End If
        LoadCountry()

    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function GetCountryById(ByVal CountryId As String) As Country
        Dim country = New Country()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "SELECT  top 1 * FROM Countries Where CountryID=@s"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = CountryId

        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()

        'CountryID,CountryName,MobileCode

        While reader.Read()
            country.CountryID = reader("CountryID").ToString()
            country.CountryName = reader("CountryName").ToString()
            country.ArCountryName = reader("ArCountryName").ToString()
            country.MobileCode = reader("MobileCode").ToString()
            'country.CountryFlag = System.AppDomain.CurrentDomain.BaseDirectory() & reader("CountryFlagImg").ToString()
            country.CountryFlag = reader("CountryFlagImg").ToString()
        End While

        reader.Close()
        conn.Close()

        Return country

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteCountryById(ByVal CountryId As String)

        Dim M As Integer
        Dim country = New Country()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "DELETE Countries Where CountryID=@s"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = CountryId

        M = cmd.ExecuteNonQuery()
        'CountryID,CountryName,MobileCode
        conn.Close()

        Return M
    End Function

    Public Sub LoadCountry()

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim query As String
        If String.IsNullOrEmpty(txtSearch.Text) Then
            query = "SELECT CountryID,CountryName,MobileCode, CountryFlagImg  FROM Countries"
        Else
            query = "SELECT CountryID,CountryName, MobileCode, CountryFlagImg  FROM Countries Where CountryName  like '%" + txtSearch.Text + "%' "
        End If

        Dim da As SqlDataAdapter = New SqlDataAdapter(query, conn)
        Dim table As DataTable = New DataTable()

        da.Fill(table)

        lstBrand.DataSource = table
        lstBrand.DataBind()

    End Sub

    Public Class Country
        Public Property CountryID() As String
        Public Property CountryName() As String
        Public Property ArCountryName() As String

        
        Public Property MobileCode() As String
        Public Property CountryFlag() As String

    End Class



    Protected Sub SaveCountryData(sender As Object, e As EventArgs) Handles btnsave.Click

        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")

        If Not String.IsNullOrEmpty(txtCountryName.Text) And Not String.IsNullOrEmpty(txtCountryCode.Text) Then

            If fuImageFile.FileName <> "" Then
                Dim ext = System.IO.Path.GetExtension(fuImageFile.PostedFile.FileName).ToLower()
                If fuImageFile.PostedFile.ContentType.Contains("image") Then
                    hdnImageUrl.Value = FileUpload(fuImageFile, txtCountryName.Text, Server)
                    lblmsg.Text = ""
                Else
                    lblmsg.Text = ""
                    lblmsg.Text = "Uploaded file type is not supported. Please, upload only image file."
                    Exit Sub
                End If

            End If


            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
            conn.Open()
            Dim M As String = ""
            Dim selectString = ""
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
            'CountryID,CountryName,MobileCode
            If Not String.IsNullOrEmpty(hidCountryID.Value) Then


                If Not String.IsNullOrEmpty(hdnImageUrl.Value) Then
                    selectString = "UPDATE Countries SET ArCountryName=@ArCountryName,CountryName=@CountryName,MobileCode=@MobileCode,CountryFlagImg=@CountryFlag,UpdatedBy=@CreateBy,UpdatedDate=GETDATE() Where CountryID=@CountryID"

                    cmd.Parameters.Add("CountryFlag", Data.SqlDbType.NVarChar).Value = hdnImageUrl.Value

                Else
                    selectString = "UPDATE Countries SET  ArCountryName=@ArCountryName, CountryName=@CountryName,MobileCode=@MobileCode,UpdatedBy=@CreateBy,UpdatedDate=GETDATE() Where CountryID=@CountryID"

                End If

                cmd.Parameters.Add("CountryID", Data.SqlDbType.Int).Value = hidCountryID.Value


            Else
                If Not String.IsNullOrEmpty(hdnImageUrl.Value) Then
                    selectString = "INSERT INTO [Countries] (CountryName,MobileCode,CountryFlagImg,CreateDate,CreateBy,ArCountryName) VALUES (@CountryName,@MobileCode,@CountryFlag,GETDATE(),@CreateBy,@ArCountryName)"
                    cmd.Parameters.Add("CountryFlag", Data.SqlDbType.NVarChar).Value = hdnImageUrl.Value
                Else
                    selectString = "INSERT INTO [Countries] (CountryName,MobileCode,CreateDate,CreateBy,ArCountryName) VALUES (@CountryName,@MobileCode,GETDATE(),@CreateBy,@ArCountryName)"
                End If


            End If

            cmd.Parameters.Add("CountryName", Data.SqlDbType.NVarChar).Value = txtCountryName.Text
            cmd.Parameters.Add("MobileCode", Data.SqlDbType.NVarChar).Value = txtCountryCode.Text
            cmd.Parameters.Add("ArCountryName", Data.SqlDbType.NVarChar).Value = txtArCountryName.Text
            


            cmd.Parameters.Add("CreateBy", Data.SqlDbType.Int).Value = userID

            cmd.CommandText = selectString

            M = cmd.ExecuteNonQuery

            If M > 0 Then
                LoadCountry()
            End If
            conn.Close()
        End If
    End Sub









    Public Shared Function FileUpload(ByVal FileField As FileUpload, ByVal prefix As String, ByVal Server As System.Web.HttpServerUtility) As String
        Dim domainName As String
        domainName = ConfigurationManager.AppSettings("RedirectUrl").ToString
        Dim c As String, filename As String = ""
        If FileField.PostedFile.ContentType.Contains("jpg") Then
            c = "_" & Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".jpg"
            filename = "ContentImage/Country/" & prefix & c

        ElseIf FileField.PostedFile.ContentType.Contains("jpeg") Then
            c = "_" & Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".jpeg"
            filename = "ContentImage/Country/" & prefix & c

        ElseIf FileField.PostedFile.ContentType.Contains("png") Then
            c = "_" & Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".png"
            filename = "ContentImage/Country/" & prefix & c

            'Else
            '    Throw New Exception("Please select correct File format")
            '    Exit Function
        End If

        If FileField.FileName <> "" Then
            FileField.PostedFile.SaveAs(System.AppDomain.CurrentDomain.BaseDirectory() & filename)
        End If

        Return filename

    End Function

End Class
