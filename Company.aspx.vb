
Imports System.Data
Imports System.Data.SqlClient

Partial Class Company
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        If Not IsPostBack Then
            LoadCurrency()
            LoadTimeZone()
            LoadTimeFormat()
            LoadDataToForm()
        End If





    End Sub

    Private Sub LoadTimeFormat()
        dropDownTimeFormatList.Items.Insert(0, New ListItem("24 hours", "24"))
        dropDownTimeFormatList.Items.Insert(0, New ListItem("12 hours", "12"))
    End Sub

    Private Sub LoadTimeZone()

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim ds = New DataSet()
        Dim myda = New SqlDataAdapter("SELECT TimeZoneId,CONCAT(Name,'(',Time,')') as Time FROM  [dbo].[CompanyTimeZone] ORDER BY Time", conn)

        myda.Fill(ds)


        dropDownTimeZoneList.DataValueField = "TimeZoneId"
        dropDownTimeZoneList.DataTextField = "Time"
        dropDownTimeZoneList.DataSource = ds
        dropDownTimeZoneList.DataBind()


    End Sub

    Private Sub LoadCurrency()


        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim ds = New DataSet()
        Dim myda = New SqlDataAdapter("SELECT 0 as CurrID,' Select Currency ' as CurrName FROM Currencies UNION SELECT CurrID,CurType as CurrName FROM Currencies", conn)

        myda.Fill(ds)





        dropDownCurrencyList.DataValueField = "CurrID"
        dropDownCurrencyList.DataTextField = "CurrName"
        dropDownCurrencyList.DataSource = ds
        dropDownCurrencyList.DataBind()



    End Sub


    Private Sub LoadDataToForm()

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        Dim literalString As String

        conn.Open()

        Dim selectString = "SELECT * FROM  CompanySetting  WHERE SettingID=1"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        Dim currency = 0

        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()



        While reader.Read()
            CompanyBusinessName.Text = reader("ComanyName").ToString()
            CompanyDescription.Text = reader("Description").ToString()
            CompanyAddress.Text = reader("Address").ToString()
            CompanyWebsite.Text = reader("Website").ToString()



        End While

        reader.Close()
        conn.Close()


    End Sub





    <System.Web.Services.WebMethod()>
    Public Shared Function GetData() As Company

        Dim company = New Company()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "SELECT * FROM  CompanySetting  WHERE SettingID=1"

        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)


        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()



        While reader.Read()
            company.Currency = reader("BaseCurrency").ToString()
            company.TimeZone = reader("TimeZone").ToString()
            company.TimeFormat=reader("TimeFormat").ToString()
        End While

        reader.Close()
        conn.Close()

        Return company

    End Function



    Class Company
        Public Property Currency() As String
        Public Property TimeZone() As String
        Public Property TimeFormat() As String
    End Class









    Protected Sub btnsubmit_Click(sender As Object, e As EventArgs) Handles btnsubmit.Click



        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim M As String = ""

        ''CompanyBusinessName, CompanyDescription, CompanyAddress, CompanyWebsite, CompanyPhoneNumber,CompnayTimeZone,CompanyTimeFormat,CompnayCounty,CompanyCurrncy
        ''SettingID	ComanyName	LogoLink	Description	Address	Website	Phone1	Phone2	BusinessType	TimeZone	TimeFormat	EmailCare	EmailInfo	RegardsNote	BaseCurrency	BaseCountry	BaseLanguage	BgImage	VATApplicable	CreateBy	CreateDate	UpdatedBy	UpdatedDate	Status

        Dim selectString = "Update  CompanySetting SET ComanyName=@ComanyName,Address=@Address,Description=@Description,Website=@Website, BusinessType=@BusinessType,TimeZone=@TimeZone,TimeFormat=@TimeFormat,BaseCurrency=@BaseCurrency,BaseCountry=@BaseCountry,UpdatedDate=GETDATE() WHERE SettingID=1"


        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)

        cmd.Parameters.Add("ComanyName", Data.SqlDbType.NVarChar).Value = CompanyBusinessName.Text
        cmd.Parameters.Add("Description", Data.SqlDbType.NVarChar).Value = CompanyDescription.Text
        cmd.Parameters.Add("Website", Data.SqlDbType.NVarChar).Value = CompanyWebsite.Text
        cmd.Parameters.Add("Address", Data.SqlDbType.NVarChar).Value = CompanyAddress.Text
        cmd.Parameters.Add("BusinessType", Data.SqlDbType.NVarChar).Value = " "
        cmd.Parameters.Add("TimeFormat", Data.SqlDbType.NVarChar).Value = dropDownTimeFormatList.SelectedItem.Value
        cmd.Parameters.Add("BaseCurrency", Data.SqlDbType.Int).Value = dropDownCurrencyList.SelectedItem.Value
        cmd.Parameters.Add("BaseCountry", Data.SqlDbType.Int).Value = 1
        cmd.Parameters.Add("TimeZone", Data.SqlDbType.NVarChar).Value = dropDownTimeZoneList.SelectedItem.Value


        cmd.CommandText = selectString

        M = cmd.ExecuteNonQuery

        conn.Close()


    End Sub
End Class
