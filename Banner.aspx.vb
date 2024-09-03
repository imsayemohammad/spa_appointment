
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
    Public Shared Function GetBannerById(ByVal BannerId As String) As Banner


        Dim banner = New Banner()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "SELECT  top 1 * FROM Banners Where  BannerId=@s"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = BannerId

        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()

        'CountryID,CountryName,MobileCode

        While reader.Read()

            banner.hidBannerID = reader("BannerId").ToString()
            banner.txtBannerTitle = reader("BannerTitle").ToString()
            banner.txtArBannerTitle = reader("ArBannerTitle").ToString()
            banner.chkActiveBanner = reader("Status").ToString()
            banner.Image = reader("Image").ToString()
        End While

        reader.Close()
        conn.Close()

        Return banner

    End Function



    
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteBannerById(ByVal BannerId As String)

        Dim M As Integer
        Dim banner = New Banner()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "DELETE Banners Where BannerId=@s"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = BannerId

        M = cmd.ExecuteNonQuery()
        'CountryID,CountryName,MobileCode
        conn.Close()

        Return M
    End Function

    Public Sub LoadCountry()

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim query As String
        If String.IsNullOrEmpty(txtSearch.Text) Then
            query = "SELECT *  FROM Banners"
        Else
            query = "SELECT *  FROM Banners Where BannerTitle  like '%" + txtSearch.Text + "%' "
        End If

        Dim da As SqlDataAdapter = New SqlDataAdapter(query, conn)
        Dim table As DataTable = New DataTable()

        da.Fill(table)

        lstBanner.DataSource = table
        lstBanner.DataBind()

    End Sub

    Public Class Banner
        Public Property hidBannerID() As String
        Public Property txtBannerTitle() As String
        Public Property txtArBannerTitle() As String
        Public Property Image() As String
        Public Property chkActiveBanner() As Boolean

    End Class



    Protected Sub SaveCountryData(sender As Object, e As EventArgs) Handles btnsave.Click

        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")




        If Not String.IsNullOrEmpty(txtBannerTitle.Text) Then

            If fuImageFile.FileName <> "" Then
                Dim ext = System.IO.Path.GetExtension(fuImageFile.PostedFile.FileName).ToLower()
                If fuImageFile.PostedFile.ContentType.Contains("image") Then
                    hdnImageUrl.Value = FileUpload(fuImageFile, txtBannerTitle.Text, Server)
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
        

            If Not String.IsNullOrEmpty(hidBannerID.Value) Then


                If Not String.IsNullOrEmpty(hdnImageUrl.Value) Then
                    selectString = "UPDATE Banners SET  BannerType=@BannerType,Status=@Status,BannerTitle=@BannerTitle,ArBannerTitle=@ArBannerTitle,Image=@Image,UpdatedBy=@CreatedBy,UpdatedDate=GETDATE() Where  BannerId=@BannerId"

                    cmd.Parameters.Add("Image", Data.SqlDbType.NVarChar).Value = hdnImageUrl.Value





                Else
                    selectString = "UPDATE Banners SET  BannerType=@BannerType,Status=@Status,BannerTitle=@BannerTitle,ArBannerTitle=@ArBannerTitle,UpdatedBy=@CreatedBy,UpdatedDate=GETDATE() Where  BannerId=@BannerId"

                End If

                cmd.Parameters.Add("BannerId", Data.SqlDbType.BigInt).Value = hidBannerID.value


            Else
                If Not String.IsNullOrEmpty(hdnImageUrl.Value) Then
                    selectString = "INSERT INTO [Banners] (BannerType,ArBannerTitle,BannerTitle,Image,Status,CreatedBy,CreateDate) VALUES (@BannerType,@ArBannerTitle,@BannerTitle,@Image,@Status,@CreatedBy,GETDATE())"
                    cmd.Parameters.Add("Image", Data.SqlDbType.NVarChar).Value = hdnImageUrl.Value
                Else
                    selectString = "INSERT INTO [Banners] (BannerType,ArBannerTitle,BannerTitle,Status,CreatedBy,CreateDate) VALUES (@BannerType,@ArBannerTitle,@BannerTitle,@Status,@CreatedBy,GETDATE())"
                End If


            End If



            cmd.Parameters.Add("BannerType", Data.SqlDbType.NVarChar).Value = "Home"
            cmd.Parameters.Add("ArBannerTitle", Data.SqlDbType.NVarChar).Value = txtArBannerTitle.Text
            cmd.Parameters.Add("BannerTitle", Data.SqlDbType.NVarChar).Value = txtBannerTitle.Text
            cmd.Parameters.Add("Status", Data.SqlDbType.Bit).Value = chkActiveBanner.Checked



            cmd.Parameters.Add("CreatedBy", Data.SqlDbType.Int).Value = userID

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
            filename = "ContentImage/Banner/" & prefix & c

        ElseIf FileField.PostedFile.ContentType.Contains("jpeg") Then
            c = "_" & Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".jpeg"
            filename = "ContentImage/Banner/" & prefix & c

        ElseIf FileField.PostedFile.ContentType.Contains("png") Then
            c = "_" & Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".png"
            filename = "ContentImage/Banner/" & prefix & c

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
