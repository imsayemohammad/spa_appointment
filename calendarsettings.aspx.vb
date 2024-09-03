
Imports System.Data.SqlClient

Partial Class calendarsettings
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If Not String.IsNullOrEmpty(System.Web.HttpContext.Current.Session.SessionID) Then
                Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By LogId DESC")

                Dim sessionid As String = System.Web.HttpContext.Current.Session.SessionID
                Dim dbsessionid As String = Utility.StringData("Select TOP 1 SessionId From UserLog_Data Where UserId =" & userid & "")
                
                If sessionid = dbsessionid Then
                    hdnuserid.Value = CType(userid, String)
                    GetData()
                Else
                    Response.Redirect("/login")
                End If
            Else
                Response.Redirect("/login")
            End If
        End If
    End Sub

    Public Sub GetData()
        Using conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Using cmd As New SqlCommand()
                cmd.CommandText = "SELECT * FROM [CalendarSetting]"
                'cmd.Parameters.Clear()
                'cmd.Parameters.Add("@ClosedDatesId", Data.SqlDbType.BigInt).Value = cdid
                cmd.Connection = conn
                conn.Open()
                Using reader As SqlDataReader = cmd.ExecuteReader()
                    While reader.Read()
                        hdncalendarsettingsid.Value = reader("CalendarSettingID").ToString()
                        ddlappcolor.SelectedValue = reader("AppointmentColor").ToString()
                        ddltimesinterval.SelectedValue = reader("TimeSlotInterval").ToString()
                        ddldefview.SelectedValue = reader("DefaultView").ToString()
                        ddlweekstart.SelectedValue = reader("WeekStartDay").ToString()
                    End While
                End Using
                conn.Close()
            End Using
        End Using
    End Sub


    Protected Sub btnsubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnsubmit.Click
        Dim intInsertUpdate As Integer

        If hdncalendarsettingsid.Value <> "" Then
            intInsertUpdate = sdscalendarsettings.Update
            If intInsertUpdate = 1 Then
                Response.Redirect("/calendarsettings", False)
            End If
        Else
            intInsertUpdate = sdscalendarsettings.Insert
            If intInsertUpdate = 1 Then
                Response.Redirect("/calendarsettings", False)
                'lblmsg.Text = "Operation Done"
                'lblmsg.Visible = True
            End If
        End If
    End Sub

End Class
