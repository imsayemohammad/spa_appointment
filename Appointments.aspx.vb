
Imports System.Data
Imports System.Data.SqlClient

Partial Class Appointments
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        If Not IsPostBack Then
            LoadLocation()
            LoadApoinment()
            LoadStaff()
        End If
    End Sub

    Private Sub LoadLocation()

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim ds = New DataSet()
        Dim myda = New SqlDataAdapter("SELECT 0 as AreaId,'All Location ' as AreaName FROM ClientLocation UNION  SELECT DISTINCT ClientLocationId as AreaId,City as AreaName FROM ClientLocation", conn)


        myda.Fill(ds)

        dropDownLocationList.DataSource = ds
        dropDownLocationList.DataValueField = "AreaId"
        dropDownLocationList.DataTextField = "AreaName"
        dropDownLocationList.DataBind()


    End Sub


    Private Sub LoadStaff()

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim ds = New DataSet()
        Dim myda = New SqlDataAdapter("SELECT 0 as StaffID,'All Stuff' as Name FROM Staff UNION SELECT StaffID,Concat(FirstName,' ',LastName) as Name FROM Staff", conn)

        myda.Fill(ds)

        dropDownStaffList.DataSource = ds
        dropDownStaffList.DataValueField = "StaffID"
        dropDownStaffList.DataTextField = "Name"
        dropDownStaffList.DataBind()


    End Sub


    Private Sub LoadApoinment()


        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim query As String
        query = "SELECT * FROM VW_Apointment"
        Dim da As SqlDataAdapter = New SqlDataAdapter(query, conn)
        Dim table As DataTable = New DataTable()



        da.Fill(table)
        lstApointment.DataSource = table
        lstApointment.DataBind()



    End Sub



End Class
