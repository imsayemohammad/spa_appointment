
Imports System.Data
Imports System.Data.SqlClient

Partial Class BrandList
    Inherits System.Web.UI.Page



    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")

        If userID = 0 Then
            Response.Redirect("/login")
        Else
            LoadCurrency()
        End If




    End Sub



    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteCurrencyById(ByVal CurrencyId As String) 


        Dim currency = New Currency()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "DELETE Currencies Where CurrID=@s"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = CurrencyId

         cmd.ExecuteReader()
        
        conn.Close()   
    End Function





    <System.Web.Services.WebMethod()>
    Public Shared Function GetCurrencyById(ByVal CurrencyId As String) As Currency


        Dim currency = New Currency()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "SELECT  top 1 * FROM Currencies Where CurrID=@s"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = CurrencyId

        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()


        While reader.Read()                                       
            currency.hidCurrencyID = reader("CurrID").ToString()
            currency.txtCurrencyName = reader("CurrName").ToString()
            currency.txtExtraRate = reader("ExRate").ToString()
            currency.txtCurrencyType = reader("CurType").ToString()
            currency.txtCurrencyValue = reader("DecimalValue").ToString()
            currency.txtCurrencySymbol = reader("Symbol").ToString()
            currency.chkIsInternational = reader("IsInternational").ToString()
            currency.txtShortForm = reader("ShortForm").ToString()
        End While

        reader.Close()
        conn.Close()

        Return currency

    End Function


    Public Class Currency

        Public Property hidCurrencyID() As String
        Public Property txtCurrencyName() As String
        Public Property txtExtraRate() As String
        Public Property txtCurrencyType() As String
        Public Property txtCurrencyValue() As String
        Public Property txtCurrencySymbol() As String
        Public Property txtShortForm() As String


        Public Property chkIsInternational() As Boolean


    End Class






    Private Sub LoadCurrency()

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)


        Dim query As String

        If String.IsNullOrEmpty(txtSearch.Text) Then
            query = "SELECT * FROM Currencies"
        Else
            query = "SELECT * FROM Currencies Where CurrName  like '%" + txtSearch.Text + "%' "
        End If

        Dim da As SqlDataAdapter = New SqlDataAdapter(query, conn)
        Dim table As DataTable = New DataTable()

        da.Fill(table)

        lstCurrency.DataSource = table
        lstCurrency.DataBind()

    End Sub




    Protected Sub SaveSupplierData(sender As Object, e As EventArgs) Handles btnsave.Click

        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")


        If Not String.IsNullOrEmpty(txtCurrencyName.Text) Or Not String.IsNullOrEmpty(txtShortForm.Text) Or Not String.IsNullOrEmpty(txtExtraRate.Text) Or Not String.IsNullOrEmpty(txtCurrencyType.Text) Or Not String.IsNullOrEmpty(txtCurrencySymbol.Text) Or Not String.IsNullOrEmpty(txtCurrencyValue.Text) Or Not String.IsNullOrEmpty(txtCurrencyName.Text) Then

            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

            conn.Open()

            Dim M As String = ""
            Dim selectString = ""
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)

            If Not String.IsNullOrEmpty(hidCurrencyID.Value) Then
                selectString = "UPDATE Currencies SET CurrName=@CurrName,ShortForm=@ShortForm,ExRate=@ExRate,CurType=@CurType,IsInternational=@IsInternational,DecimalValue=@DecimalValue,Symbol=@Symbol,Status=@Status,UpdatedBy=@CreateBy,UpdatedDate=GETDATE() Where CurrID=@CurrID"
                cmd.Parameters.Add("CurrID", Data.SqlDbType.Int).Value = hidCurrencyID.Value
            Else
                selectString = "INSERT INTO [Currencies] (CurrName,ShortForm,ExRate,CurType,IsInternational,DecimalValue,Symbol,Status,CreateBy,CreateDate) VALUES (@CurrName,@ShortForm,@ExRate,@CurType,@IsInternational,@DecimalValue,@Symbol,@Status,@CreateBy,GETDATE())"
            End If


            cmd.Parameters.Add("CurrName", Data.SqlDbType.NVarChar).Value = txtCurrencyName.Text
            cmd.Parameters.Add("ShortForm", Data.SqlDbType.NVarChar).Value = txtShortForm.Text
            cmd.Parameters.Add("ExRate", Data.SqlDbType.Float).Value = txtExtraRate.Text
            cmd.Parameters.Add("CurType", Data.SqlDbType.NVarChar).Value = txtCurrencyType.Text
            cmd.Parameters.Add("DecimalValue", Data.SqlDbType.Int).Value = txtCurrencyValue.Text
            cmd.Parameters.Add("Symbol", Data.SqlDbType.NVarChar).Value = txtCurrencySymbol.Text
            cmd.Parameters.Add("IsInternational", Data.SqlDbType.Bit).Value = chkIsInternational.Checked
            cmd.Parameters.Add("Status", Data.SqlDbType.Bit).Value = 1




            cmd.Parameters.Add("CreateBy", Data.SqlDbType.Int).Value = userID


            cmd.CommandText = selectString

            M = cmd.ExecuteNonQuery

            If M > 0 Then
                LoadCurrency()
            End If


            conn.Close()

        End If


    End Sub










End Class
