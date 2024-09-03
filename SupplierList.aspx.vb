
Imports System.Data
Imports System.Data.SqlClient
Imports Org.BouncyCastle.Math

Partial Class SupplierList
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")

        If userID = 0 Then

            Response.Redirect("/login")
        Else

            If Not IsPostBack Then
                LoadDropdownCountry()
            End If

            LoadSupplier()


        End If

    End Sub

    Public Sub LoadSupplier()

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim query As String

        If Not String.IsNullOrEmpty(txtSearch.Text) Then
            query = "SELECT * FROM Supplier Where SupplierName like '%" + txtSearch.Text + "%' "
        Else
            query = "SELECT * FROM Supplier"
        End If


        Dim da As SqlDataAdapter = New SqlDataAdapter(query, conn)
        Dim table As DataTable = New DataTable()

        da.Fill(table)
        lstSupplier.DataSource = table
        lstSupplier.DataBind()

    End Sub


    Private Sub LoadDropdownCountry()

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim ds = New DataSet()
        'SELECT 0 as CountryID,'--SELECT COUNTRY--' as CountryName FROM Countries UNION
        Dim myda = New SqlDataAdapter(" SELECT CountryID,CountryName FROM Countries", conn)

        myda.Fill(ds)
        dropDownCountryList.DataSource = ds
        dropDownCountryList.DataValueField = "CountryID"
        dropDownCountryList.DataTextField = "CountryName"
        dropDownCountryList.DataBind()
    End Sub








    Protected Sub SaveSupplierData(sender As Object, e As EventArgs) Handles btnsave.Click


        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")





        Dim selectString As String = ""
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)


        If Not String.IsNullOrEmpty(hdnSupplierid.Value) Then

            selectString = "UPDATE [Supplier] SET [SupplierName]=@SupplierName, [FirstName]=@FirstName, [LastName]=@LastName, [Phone1]=@Phone1, [Phone2]=@Phone2, [Email]=@Email, [WebSite]=@WebSite, [UpdatedBy]=@CreateBy,Street=@Street,City=@City,State=@State,ZipCode=@ZipCode,CountryID=@CountryID,Notes=@Notes,SameASPostal=@SameASPostal  Where SupplierID=@SupplierID"
            cmd.Parameters.Add("SupplierID", Data.SqlDbType.BigInt).Value = hdnSupplierid.Value
        Else
            selectString = "INSERT INTO [Supplier] ([SupplierName], [FirstName], [LastName], [Phone1], [Phone2], [Email], [WebSite], [CreateBy],Street,City,State,ZipCode,CountryID,Notes,SameASPostal) VALUES (@SupplierName, @FirstName, @LastName, @Phone1, @Phone2, @Email, @WebSite, @CreateBy,@Street,@City,@State,@ZipCode,@CountryID,@Notes,@SameASPostal)"
        End If

        cmd.Parameters.Add("SupplierName", Data.SqlDbType.NVarChar).Value = txtSupplierName.Text
        cmd.Parameters.Add("FirstName", Data.SqlDbType.NVarChar).Value = txtFirstName.Text
        cmd.Parameters.Add("LastName", Data.SqlDbType.NVarChar).Value = txtLasName.Text
        cmd.Parameters.Add("Phone1", Data.SqlDbType.NVarChar).Value = txtMobile.Text
        cmd.Parameters.Add("Phone2", Data.SqlDbType.NVarChar).Value = txtTelePhone.Text
        cmd.Parameters.Add("Email", Data.SqlDbType.NVarChar).Value = txtEmail.Text
        cmd.Parameters.Add("WebSite", Data.SqlDbType.NVarChar).Value = txtWebSite.Text
        cmd.Parameters.Add("Street", Data.SqlDbType.NVarChar).Value = txtStreet.Text
        cmd.Parameters.Add("City", Data.SqlDbType.NVarChar).Value = txtCity.Text
        cmd.Parameters.Add("State", Data.SqlDbType.NVarChar).Value = txtState.Text
        cmd.Parameters.Add("ZipCode", Data.SqlDbType.NVarChar).Value = txtZip.Text
        cmd.Parameters.Add("Notes", Data.SqlDbType.NVarChar).Value = txtSupplierDescription.Text

        cmd.Parameters.Add("CreateBy", Data.SqlDbType.Int).Value = userID
        cmd.Parameters.Add("CountryID", Data.SqlDbType.BigInt).Value = dropDownCountryList.SelectedItem.Value
        cmd.Parameters.Add("SameASPostal", Data.SqlDbType.Bit).Value = chkPostAddress.Checked
        'SameASPostal




        ' chkPostAddress

        cmd.CommandText = selectString
        cmd.ExecuteNonQuery()
        conn.Close()
        LoadSupplier()

    End Sub



    'SupplierBySupplierId   SupplierId



    <System.Web.Services.WebMethod()>
    Public Shared Function SupplierBySupplierId(ByVal SupplierId As String) As Supplier

        Dim supplier = New Supplier()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "SELECT  top 1 * FROM Supplier Where SupplierID=@s"

        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.BigInt).Value = SupplierId

        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()



        While reader.Read()

            supplier.SupplierName = reader("SupplierName").ToString()
            supplier.FirstName = reader("FirstName").ToString()
            supplier.LastName = reader("LastName").ToString()
            supplier.Phone1 = reader("Phone1").ToString()
            supplier.Phone2 = reader("Phone2").ToString()
            supplier.Email = reader("Email").ToString()
            supplier.WebSite = reader("WebSite").ToString()
            supplier.Street = reader("Street").ToString()
            supplier.City = reader("City").ToString()
            supplier.State = reader("State").ToString()
            supplier.ZipCode = reader("ZipCode").ToString()
            supplier.CountryID = reader("CountryID").ToString()
            supplier.Notes = reader("Notes").ToString()
            supplier.SupplierID = reader("SupplierID").ToString()
            supplier.SameASPostal = reader("SameASPostal").ToString()



        End While

        reader.Close()
        conn.Close()

        Return supplier

    End Function



End Class





Public Class Supplier


    Public Property SupplierID() As String
    Public Property SupplierName() As String
    Public Property FirstName() As String
    Public Property LastName() As String
    Public Property Phone1() As String
    Public Property Phone2() As String
    Public Property Email() As String
    Public Property WebSite() As String
    Public Property Street() As String
    Public Property City() As String
    Public Property State() As String
    Public Property ZipCode() As String
    Public Property CountryID() As String
    Public Property Notes() As String
    Public Property SameASPostal() As Boolean



End Class
