
Imports System.Data.SqlClient

Partial Class ClientInfo
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If Not String.IsNullOrEmpty(System.Web.HttpContext.Current.Session.SessionID) Then

                If Request.QueryString("id") <> "" Then
                    Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By LogId DESC")
                    Utility.lblAdd("SELECT (FirstName + ' ' + LastName) Name  FROM [Client] WHERE ClientID=" & Request.QueryString("id") & "", lblclientname)
                    Utility.lblAdd("SELECT COUNT(ServiceRequestDetailId) totalservice FROM ServiceRequestDetails srd Inner Join ServiceRequestMasters srm ON srd.ServiceRequestMasterId = srm.ServiceRequestMasterId Where ClientId=" & Request.QueryString("id") & "", lbltotalappointment)
                    
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
        Dim sql = "SELECT *,(FirstName + ' ' + LastName) Name, (Phone1 + ',<br/> ' + Phone2) Phones, CONVERT(VARCHAR(10), DOB, 101) dateofbirth  FROM [Client] WHERE ClientID=@ClientID"
        With cmd
            .Connection = con
            .CommandText = sql
            .Parameters.Clear()
            .Parameters.Add("ClientID", Data.SqlDbType.BigInt).Value = Request.QueryString("id")
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
"                                        <h5 class=""text-muted"">Address</h5>" &
"                                        <p class=""font-14"">" & GetClientAddress(row("ClientID").ToString()) & "</p>" &
"                                        <hr/>" &
"                                        <h5 class=""text-muted"">Birthday </h5>" &
"                                        <p class=""font-14"">" & row("dateofbirth").ToString() & "</p>" &
"                                        <hr/>" &
"                                        <h5 class=""text-muted"">Notes </h5>" &
"                                        <p class=""font-14"">" & row("Notes").ToString() & ". </p>"

        Next

        ltlclientinfo.Text = m

    End Sub


    Public Function GetClientAddress(ByVal clientid As Integer) As String

        Dim m As String = ""
        Dim cmd = New SqlCommand()
        Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString)
        con.Open()
        Dim sql = "SELECT * FROM dbo.ClientLocation WHERE ClientID=@ClientID"

        With cmd
            .Connection = con
            .CommandText = sql
            .Parameters.Clear()
            .Parameters.Add("ClientID", Data.SqlDbType.Int).Value = clientid
        End With

        Dim ds As New Data.DataSet()
        Dim adapter = New SqlDataAdapter(cmd)
        adapter.Fill(ds)
        con.Close()

        For Each row As Data.DataRow In ds.Tables(0).Rows

            m += "<strong class=""text-muted"">" & row("AddressType").ToString() & ": </strong>" &
              " " & row("Address").ToString() & ", " & row("Street").ToString() & ", " & row("City").ToString() & " " &
              " , " & row("State").ToString() & ", " & row("ZipCode").ToString() & ".<br />"
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
        Dim selectString = "Select AVG(Rating) Rating From ClientRatings Where ServiceId=@ServiceId"
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
