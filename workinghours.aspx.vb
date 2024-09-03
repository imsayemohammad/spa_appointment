Imports System.Data.SqlClient
Imports System.Globalization

Partial Class workinghours
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            If Not String.IsNullOrEmpty(System.Web.HttpContext.Current.Session.SessionID) Then
                Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By LogId DESC")

                Dim sessionid As String = System.Web.HttpContext.Current.Session.SessionID
                Dim dbsessionid As String = Utility.StringData("Select TOP 1 SessionId From UserLog_Data Where UserId =" & userid & "")


                hdnuserid.Value = CType(userid, String)
                txtsearchdate.Text = Utility.Dayformat(DateTime.Now).ToString()
                Dayhead()
                ddlStaff.DataBind()
                Getwhinfo()

                If sessionid = dbsessionid Then
                    hdnuserid.Value = CType(userid, String)
                    txtsearchdate.Text = Utility.Dayformat(DateTime.Now).ToString()
                    'Response.Write(userid)
                    'loaddata()
                Else
                    'Response.Redirect("/login")
                End If
            Else
                Response.Redirect("/login")
            End If
        End If
    End Sub


    Private Sub Dayhead()
        Dim expenddt As Date
        If txtsearchdate.Text <> "" Then
            Dim todate = txtsearchdate.Text
            expenddt = Date.ParseExact(todate, "MM/dd/yyyy", System.Globalization.DateTimeFormatInfo.InvariantInfo)
           Else
            Dim dt = Utility.Dayformat(DateTime.Now).ToString()
            expenddt = Date.ParseExact(dt, "MM/dd/yyyy", System.Globalization.DateTimeFormatInfo.InvariantInfo)
        End If


        Dim dayOfWeeks = CInt(expenddt.DayOfWeek)
        Dim startOfWeek = expenddt.AddDays(-1 * dayOfWeeks).ToString("ddd, dd MMM")
        Dim endOfWeek = expenddt.AddDays(7 - dayOfWeeks).AddSeconds(-1).ToString("ddd, dd MMM")

        Const sunday As DayOfWeek = DayOfWeek.Sunday
        Dim diffstartday = sunday - Now.DayOfWeek

        Label1.Text = startOfWeek
        HiddenField1.Value = expenddt.AddDays(-1 * dayOfWeeks).ToString("dddd, dd MMMM yyyy")

        Label2.Text = expenddt.AddDays(2 - dayOfWeeks).AddSeconds(-1).ToString("ddd, dd MMM")
        HiddenField2.Value = expenddt.AddDays(2 - dayOfWeeks).AddSeconds(-1).ToString("dddd, dd MMMM yyyy")

        Label3.Text = expenddt.AddDays(3 - dayOfWeeks).AddSeconds(-1).ToString("ddd, dd MMM")
        HiddenField3.Value = expenddt.AddDays(3 - dayOfWeeks).AddSeconds(-1).ToString("dddd, dd MMMM yyyy")

        Label4.Text = expenddt.AddDays(4 - dayOfWeeks).AddSeconds(-1).ToString("ddd, dd MMM")
        HiddenField4.Value = expenddt.AddDays(4 - dayOfWeeks).AddSeconds(-1).ToString("dddd, dd MMMM yyyy")

        Label5.Text = expenddt.AddDays(5 - dayOfWeeks).AddSeconds(-1).ToString("ddd, dd MMM")
        HiddenField5.Value = expenddt.AddDays(5 - dayOfWeeks).AddSeconds(-1).ToString("dddd, dd MMMM yyyy")

        Label6.Text = expenddt.AddDays(6 - dayOfWeeks).AddSeconds(-1).ToString("ddd, dd MMM")
        HiddenField6.Value = expenddt.AddDays(6 - dayOfWeeks).AddSeconds(-1).ToString("dddd, dd MMMM yyyy")

        Label7.Text = endOfWeek
        HiddenField7.Value = expenddt.AddDays(7 - dayOfWeeks).AddSeconds(-1).ToString("dddd, dd MMMM yyyy")


        'Label1.Text = DateTime.Now.AddDays(diffstartday).ToString("ddd, dd MMM")
        'HiddenField1.Value = DateTime.Now.AddDays(diffstartday).ToString("dddd, dd MMMM yyyy")
        'Label2.Text = DateTime.Now.AddDays(diffstartday + 1).ToString("ddd, dd MMM")
        'HiddenField2.Value = DateTime.Now.AddDays(diffstartday + 1).ToString("dddd, dd MMMM yyyy")
        'Label3.Text = DateTime.Now.AddDays(diffstartday + 2).ToString("ddd, dd MMM")
        'HiddenField3.Value = DateTime.Now.AddDays(diffstartday + 2).ToString("dddd, dd MMMM yyyy")
        'Label4.Text = DateTime.Now.AddDays(diffstartday + 3).ToString("ddd, dd MMM")
        'HiddenField4.Value = DateTime.Now.AddDays(diffstartday + 3).ToString("dddd, dd MMMM yyyy")
        'Label5.Text = DateTime.Now.AddDays(diffstartday + 4).ToString("ddd, dd MMM")
        'HiddenField5.Value = DateTime.Now.AddDays(diffstartday + 4).ToString("dddd, dd MMMM yyyy")
        'Label6.Text = DateTime.Now.AddDays(diffstartday + 5).ToString("ddd, dd MMM")
        'HiddenField6.Value = DateTime.Now.AddDays(diffstartday + 5).ToString("dddd, dd MMMM yyyy")
        'Label7.Text = DateTime.Now.AddDays(diffstartday + 6).ToString("ddd, dd MMM")
        'HiddenField7.Value = DateTime.Now.AddDays(diffstartday + 6).ToString("dddd, dd MMMM yyyy")

        'If Now.DayOfWeek + 3 > 5 Then
        '    Label1.Text = DateTime.Now.AddDays(5).ToString("ddd, dd MMM")
        'Else
        '    Label2.Text = DateTime.Now.AddDays(3).ToString("ddd, dd MMM")
        'End If
    End Sub


    Protected Function GetSundayData(ByVal closeddatesid As Integer) As String
        Dim m As String = ""
        Dim connection = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
        Dim count As Integer = Utility.IntegerData("SELECT Count(ClosedDatesId) countdata FROM ClosedDatesLocation Where ClosedDatesId=" & closeddatesid & "")
        Dim conn As New Data.SqlClient.SqlConnection(connection)
        conn.Open()

        Dim selectString = "Select l.LocationID, l.LocationName From ClosedDatesLocation cdl INNER JOIN Location l ON cdl.LocationID = l.LocationID Where ClosedDatesId=@ClosedDatesId"
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
        cmd.Parameters.Clear()
        cmd.Parameters.Add("ClosedDatesId", Data.SqlDbType.Int).Value = closeddatesid
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        While reader.Read()
            m += reader("LocationName").ToString()

            If count <> 0 Then
                If count > 1 Then
                    m += "<br /> "
                End If
            End If
        End While

        reader.Close()
        conn.Close()

        Return m
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Sub SaveData(ByVal whid As String, ByVal staffid As String, ByVal shiftstart As String, ByVal shiftend As String, ByVal day As String, ByVal repeats As String)

        Dim dayname = ""
        dayname = day.Substring(0, day.IndexOf(","))

        Dim dDate As DateTime = CDate(day)
        Dim dateformat As String = dDate.ToString("yyyy-MM-dd")

        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")

        If staffid <> "" And staffid <> "0" Then
            Dim selectString As String = ""
            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
            conn.Open()
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
            If Not String.IsNullOrEmpty(whid) Then
                selectString = "UPDATE [StaffWorkingHours] SET [StartTime] = @StartTime, [EndTime] = @EndTime, [Day] = @Day, [Repeats] = @Repeats, [UpdatedBy] = @ChangeBy, [UpdatedAt] = Getdate() WHERE [StaffWorkingHoursId] = @StaffWorkingHoursId AND [StaffID] = @StaffID"
                cmd.Parameters.Add("StaffWorkingHoursId", Data.SqlDbType.BigInt).Value = whid
            Else
                selectString = "INSERT INTO [StaffWorkingHours] ([StaffID], [StartTime], [EndTime], [Day], [Repeats], [CreatedBy], [CreatedAt]) VALUES (@StaffID, @StartTime, @EndTime, @Day, @Repeats, @ChangeBy, Getdate())"
            End If
            cmd.Parameters.Add("StaffID", Data.SqlDbType.BigInt).Value = staffid
            cmd.Parameters.Add("StartTime", Data.SqlDbType.DateTime).Value = dateformat + " " + shiftstart
            cmd.Parameters.Add("EndTime", Data.SqlDbType.DateTime).Value = dateformat + " " + shiftend
            cmd.Parameters.Add("Day", Data.SqlDbType.NVarChar).Value = dayname
            cmd.Parameters.Add("Repeats", Data.SqlDbType.NVarChar).Value = repeats
            cmd.Parameters.Add("ChangeBy", Data.SqlDbType.Int).Value = userID

            cmd.CommandText = selectString
            cmd.ExecuteNonQuery()

            conn.Close()
        End If
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Sub DeleteData(ByVal whid As String)

        If Not String.IsNullOrEmpty(whid) Then
            Dim selectString As String = ""
            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
            conn.Open()
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)

            selectString = "DELETE FROM [StaffWorkingHours] WHERE [StaffWorkingHoursId] = @StaffWorkingHoursId"
            cmd.CommandText = selectString
            cmd.Parameters.Add("StaffWorkingHoursId", Data.SqlDbType.BigInt).Value = whid
            cmd.ExecuteNonQuery()

            conn.Close()
        End If
    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Function GetData(ByVal whid As String) As Model
        Dim wh As New Model
        Using conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Using cmd As New SqlCommand()
                cmd.CommandText = "SELECT StaffWorkingHoursId, StaffID, Format(StartTime,'hh:mm') StartTime, Format(EndTime,'hh:mm') EndTime, Day, Repeats FROM [StaffWorkingHours] Where StaffWorkingHoursId=@StaffWorkingHoursId"
                cmd.Parameters.Clear()
                cmd.Parameters.Add("@StaffWorkingHoursId", Data.SqlDbType.BigInt).Value = whid
                cmd.Connection = conn
                conn.Open()
                Using reader As SqlDataReader = cmd.ExecuteReader()
                    While reader.Read()
                        wh.whid = reader("StaffWorkingHoursId").ToString()
                        wh.staffid = reader("StaffID").ToString()
                        wh.shiftstart = reader("StartTime").ToString()
                        wh.shiftend = reader("EndTime").ToString()
                        wh.day = reader("Day").ToString()
                        wh.repeats = reader("Repeats").ToString()
                    End While
                End Using
                conn.Close()
            End Using
            Return wh
        End Using
    End Function


    Public Sub Getwhinfo()

        Dim m As String = ""
        Dim i As Integer = 1
        Dim Csscls As String = ""

        Dim staff As Long = Convert.ToInt64(ddlStaff.SelectedValue)

        Dim cmd = New SqlCommand()
        Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString)
        con.Open()
        Dim sql = ""
        If Not String.IsNullOrEmpty(ddlStaff.SelectedValue) And ddlStaff.SelectedValue <> "0" Then
            sql = "SELECT StaffWorkingHoursId, s.StaffID, (FirstName + ' ' + LastName) Name, Format(StartTime,'hh:mm tt') StartTime, Format(EndTime,'hh:mm tt') EndTime, Format(StartTime,'MM/dd/yyyy') Headingdate, Day, Repeats FROM [StaffWorkingHours] swh Right Join Staff s On swh.StaffID = s.StaffID Where s.StaffID=@StaffID"

            With cmd
                .Connection = con
                .CommandText = sql
                .Parameters.Clear()
                .Parameters.Add("StaffID", Data.SqlDbType.BigInt).Value = staff
            End With

        Else
            sql = "SELECT StaffWorkingHoursId, s.StaffID, (FirstName + ' ' + LastName) Name, Format(StartTime,'hh:mm tt') StartTime, Format(EndTime,'hh:mm tt') EndTime, Format(StartTime,'MM/dd/yyyy') Headingdate, Day, Repeats FROM [StaffWorkingHours] swh Inner Join Staff s On swh.StaffID = s.StaffID"

            With cmd
                .Connection = con
                .CommandText = sql
                .Parameters.Clear()
            End With
        End If

        Dim ds As New Data.DataSet()
        Dim adapter = New SqlDataAdapter(cmd)
        adapter.Fill(ds)
        con.Close()
        Dim a As String = ""
        For Each row As Data.DataRow In ds.Tables(0).Rows

            Dim whid = row("StaffWorkingHoursId").ToString()
            Dim shedul = row("StartTime").ToString() + "-" + row("EndTime").ToString()

            m += "<tr>" &
"                                                <td>" & row("Name").ToString() & "<br />" &
"                                                    <small>20h</small></td>" &
"                                                <td>" & Getworksdata(whid, shedul, HiddenField1.Value, row("Headingdate").ToString()) &
"                                                </td>" &
"                                                <td>" & Getworksdata(whid, shedul, HiddenField2.Value, row("Headingdate").ToString()) &
"                                                </td>" &
"                                                <td>" & Getworksdata(whid, shedul, HiddenField3.Value, row("Headingdate").ToString()) &
"                                                </td>" &
"                                                <td>" & Getworksdata(whid, shedul, HiddenField4.Value, row("Headingdate").ToString()) &
"                                                </td>" &
"                                                <td>" & Getworksdata(whid, shedul, HiddenField5.Value, row("Headingdate").ToString()) &
"                                                </td>" &
"                                                <td>" & Getworksdata(whid, shedul, HiddenField6.Value, row("Headingdate").ToString()) &
"                                                </td>" &
"                                                <td>" & Getworksdata(whid, shedul, HiddenField7.Value, row("Headingdate").ToString()) &
"                                                </td>" &
"                                            </tr>"


        Next

        ltlWHList.Text = m

    End Sub


    Public Function Getworksdata(ByVal whid As String, ByVal workstime As String, ByVal HiddenField As String, ByVal headdate As String) As String
        Dim m As String = ""

        Dim dDate As DateTime = CDate(HiddenField)
        Dim dateformat As String = dDate.ToString("MM/dd/yyyy")

        If headdate = dateformat Then
            If Not String.IsNullOrEmpty(workstime) Then
                m = "<a href=""#""  class=""assignedslot"" onclick=""openModalWithDate('" & HiddenField & "'); GetDataById(" & whid & ");""  data-toggle=""modal"" data-target=""#slotmodal"" >" &
    "               " & workstime & "" &
    "               </a>"
            Else
                m = " <a href=""#""  class=""addslot"" data-toggle=""modal"" data-target=""#slotmodal"" onclick=""openModalWithDate('" & HiddenField & "')"">" &
"               <i class=""mdi mdi-plus-circle-outline""></i>" &
"                  </a>"
            End If
        Else
            m = " <a href=""#""  class=""addslot"" data-toggle=""modal"" data-target=""#slotmodal"" onclick=""openModalWithDate('" & HiddenField & "')"">" &
"               <i class=""mdi mdi-plus-circle-outline""></i>" &
"                  </a>"
        End If


        Return m
    End Function

    Protected Sub btnsearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnsearch.Click
        Dayhead()
        Getwhinfo()
    End Sub

    Protected Sub ddlStaff_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlStaff.SelectedIndexChanged
        Dayhead()
        Getwhinfo()

        'ddlStaff.SelectedValue = ddlStaff.SelectedValue
    End Sub
End Class
