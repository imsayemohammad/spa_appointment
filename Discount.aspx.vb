
Imports System.Data
Imports System.Data.SqlClient

Partial Class BrandList
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")

        If userID = 0 Then
            Response.Redirect("/login")
        Else
            LoadDiscount()
        End If

    End Sub








    <System.Web.Services.WebMethod()>
    Public Shared Function GetDiscountById(ByVal DiscountID As String) As Discount



        Dim discount = New Discount()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "SELECT  top 1 * FROM Discount Where DiscountID=@s"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = DiscountID

        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()


        'CountryID,CountryName,MobileCode

        While reader.Read()


            discount.hidDiscountID = reader("DiscountID").ToString()
            discount.txtDiscountName = reader("DiscountName").ToString()
            discount.chkEnableForServiceSales = reader("AbleForServiceSales").ToString()
            discount.chkEnableForProductSales = reader("AbleForProductSales").ToString()
            discount.chkEnableForVoucherSales = reader("AbleForVoucherSales").ToString()

            discount.txtDiscountValue = reader("DiscountAmount").ToString()

            If reader("DiscountType").ToString().Trim().Equals("Percentage") Then
                discount.rbpercentage = True


                discount.rbBDTamount = False

            ElseIf reader("DiscountType").ToString().Trim().Equals("Amount") Then

                discount.rbpercentage = False
                discount.rbBDTamount = True
            End If
        End While

        reader.Close()
        conn.Close()




        Return discount

    End Function


    Public Class Discount



        Public Property hidDiscountID As String
        Public Property txtDiscountName As String
        Public Property txtDiscountValue As String
        Public Property chkEnableForServiceSales As Boolean
        Public Property chkEnableForProductSales As Boolean
        Public Property chkEnableForVoucherSales As Boolean
        Public Property rbpercentage As Boolean
        Public Property rbBDTamount As Boolean

    End Class





    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteDiscountById(ByVal DiscountID As String) As Discount

        Dim M As Integer

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "DELETE Discount Where DiscountID=@s"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = DiscountID

        M = cmd.ExecuteNonQuery()
        conn.Close()

       


    End Function







    Public Sub LoadDiscount()

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)


        Dim query As String




        If String.IsNullOrEmpty(txtSearch.Text) Then
            query = "SELECT *,convert(varchar,CreateDate,0) as CreateDateFrom  FROM Discount"
        Else
            query = "SELECT *,convert(varchar,CreateDate,0) as CreateDateFrom  FROM Discount Where DiscountName  like '%" + txtSearch.Text + "%' "
        End If




        Dim da As SqlDataAdapter = New SqlDataAdapter(query, conn)
        Dim table As DataTable = New DataTable()

        da.Fill(table)

        lstDiscount.DataSource = table
        lstDiscount.DataBind()


    End Sub





    Protected Sub SaveCountryData(sender As Object, e As EventArgs) Handles btnsave.Click

        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")

        Dim M As Integer



        Dim selectString As String = ""
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)


        If Not String.IsNullOrEmpty(hidDiscountID.Value) Then

            selectString = "UPDATE [Discount] SET DiscountName=@DiscountName,DiscountType=@DiscountType,DiscountAmount=@DiscountAmount,AbleForServiceSales=@AbleForServiceSales,AbleForProductSales=@AbleForProductSales,AbleForVoucherSales=@AbleForVoucherSales,Status=@Status,UpdatedBy=@CreateBy,UpdatedDate=GETDATE()  Where DiscountID=@DiscountID"
            cmd.Parameters.Add("DiscountID", Data.SqlDbType.BigInt).Value = hidDiscountID.Value
        Else
            selectString = "INSERT INTO [Discount] (DiscountName,DiscountType,DiscountAmount,AbleForServiceSales,AbleForProductSales,AbleForVoucherSales,Status,CreateDate,CreateBy) VALUES (@DiscountName,@DiscountType,@DiscountAmount,@AbleForServiceSales,@AbleForProductSales,@AbleForVoucherSales,@Status,GETDATE(),@CreateBy)"

        End If



        cmd.Parameters.Add("DiscountName", Data.SqlDbType.NVarChar).Value = txtDiscountName.Text

        If rbpercentage.Checked Then
            cmd.Parameters.Add("DiscountType", Data.SqlDbType.NVarChar).Value = "Percentage"
        ElseIf rbBDTamount.Checked Then
            cmd.Parameters.Add("DiscountType", Data.SqlDbType.NVarChar).Value = "Amount"
        End If


        cmd.Parameters.Add("DiscountAmount", Data.SqlDbType.Float).Value = txtDiscountValue.Text
        cmd.Parameters.Add("AbleForServiceSales", Data.SqlDbType.Bit).Value = chkEnableForServiceSales.Checked
        cmd.Parameters.Add("AbleForProductSales", Data.SqlDbType.Bit).Value = chkEnableForProductSales.Checked
        cmd.Parameters.Add("AbleForVoucherSales", Data.SqlDbType.Bit).Value = chkEnableForVoucherSales.Checked


        cmd.Parameters.Add("Status", Data.SqlDbType.Bit).Value = 1


        cmd.Parameters.Add("CreateBy", Data.SqlDbType.BigInt).Value = userID




        cmd.CommandText = selectString
        M = cmd.ExecuteNonQuery()
        conn.Close()
        If M > 0 Then
            LoadDiscount()
        End If




    End Sub










End Class
