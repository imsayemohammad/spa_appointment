Imports System.Data.SqlClient
Partial Class StaffInfo
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If Not String.IsNullOrEmpty(System.Web.HttpContext.Current.Session.SessionID) Then

                If Request.QueryString("staffid") <> "" Then
                    Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By LogId DESC")
                    Utility.lblAdd("SELECT (FirstName + ' ' + LastName) Name  FROM [Staff] WHERE StaffID=" & Request.QueryString("staffid") & "", lblStaffname)
                    Utility.lblAdd("SELECT COUNT(ServiceRequestDetailId) totalservice FROM ServiceRequestDetails Where StaffID=" & Request.QueryString("staffid") & "", lbltotalappointment)

                    Dim sessionid As String = System.Web.HttpContext.Current.Session.SessionID
                    Dim dbsessionid As String = Utility.StringData("Select TOP 1 SessionId From UserLog_Data Where UserId =" & userid & "")
                    GetClientInfo()
                    'loaddata()
                    If sessionid = dbsessionid Then
                        'loaddata()
                    Else
                        'Response.Redirect("/login")
                    End If
                Else
                    Response.Redirect("/client")
                End If

            Else
                Response.Redirect("/login")
            End If
        End If
    End Sub


    Public Sub GetClientInfo()
        Dim m As String = ""
        Dim cmd = New SqlCommand()
        Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString)
        con.Open()
        Dim sql = "SELECT *,(FirstName + ' ' + LastName) Name, (Phone1 + ',<br/> ' + Phone2) Phones, CONVERT(VARCHAR(10), DOB, 101) dateofbirth, CONVERT(VARCHAR(10), StartDate, 101) AppStartDate, CONVERT(VARCHAR(10), EndDate, 101) AppEndDate  FROM [Staff] WHERE StaffID=@StaffID"
        With cmd
            .Connection = con
            .CommandText = sql
            .Parameters.Clear()
            .Parameters.Add("StaffID", Data.SqlDbType.BigInt).Value = Request.QueryString("staffid")
        End With

        Dim ds As New Data.DataSet()
        Dim adapter = New SqlDataAdapter(cmd)
        adapter.Fill(ds)
        con.Close()
        Dim a As String = ""
        For Each row As Data.DataRow In ds.Tables(0).Rows

            m += "<h5 class=""text-muted"">Name </h5>" &
"                                        <p class=""font-14"">" & row("Name").ToString() & "</p>" &
"                                        <hr/>" &
"                                        <h5 class=""text-muted"">Email address </h5>" &
"                                        <p class=""font-14"">" & row("Email").ToString() & "</p>" &
"                                        <hr/>" &
"                                        <h5 class=""text-muted"">Phone</h5>" &
"                                        <p class=""font-14"">" & If(row("Phone2").ToString() <> "", row("Phones").ToString(), row("Phone1").ToString()) & "</p>" &
"                                        <hr/>" &
"                                        <h5 class=""text-muted"">Location</h5>" &
"                                        <p class=""font-14"">" & Getstafflocation(row("StaffID").ToString()) & "</p>" &
"                                        <hr/>" &
"                                        <h5 class=""text-muted"">Employment Date </h5>" &
"                                        <p class=""font-14""> <strong class=""text-muted""> Start Date : </strong>" & row("AppStartDate").ToString() & "<br/>" &
"                                         <strong class=""text-muted""> End Date : </strong>" & row("AppEndDate").ToString() & "</p>" &
"                                        <hr/>" &
"                                        <h5 class=""text-muted"">Notes </h5>" &
"                                        <p class=""font-14"">" & row("Notes").ToString() & ". </p>"
            
        Next

        ltlclientinfo.Text = m

    End Sub


    Public Function Getstafflocation(ByVal staffid As Integer) As String

        Dim m As String = ""
        Dim cmd = New SqlCommand()
        Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString)
        con.Open()
        Dim sql = "SELECT AreaName From [dbo].[StaffServiceLocations] sl INNER JOIN Areas a ON a.AreaId = sl.AreaId Where StaffId=@StaffId"

        With cmd
            .Connection = con
            .CommandText = sql
            .Parameters.Clear()
            .Parameters.Add("StaffId", Data.SqlDbType.Int).Value = staffid
        End With

        Dim ds As New Data.DataSet()
        Dim adapter = New SqlDataAdapter(cmd)
        adapter.Fill(ds)
        con.Close()

        For Each row As Data.DataRow In ds.Tables(0).Rows

            m += "" & row("AreaName").ToString() & ", "
        Next


        'If m = "" Then
        '    m = "<tr<>td colspan=""5"">No Result Found</td></tr>"
        'End If
        Return m
    End Function

    Protected Function GetRating(ByVal serviceid As Integer) As String
        Dim m As String = ""
        Dim connection = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
        Dim conn As New Data.SqlClient.SqlConnection(connection)
        conn.Open()
        Dim selectString = "Select AVG(Rating) Rating From StaffRatings Where ServiceId=@ServiceId"
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
        cmd.Parameters.Clear()
        cmd.Parameters.Add("ServiceId", Data.SqlDbType.Int).Value = serviceid
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        While reader.Read()
            Dim rating = reader("Rating").ToString()
            m += rating.TrimEnd(New String({"0", "."}))
        End While

        reader.Close()
        conn.Close()

        Return m
    End Function

End Class
