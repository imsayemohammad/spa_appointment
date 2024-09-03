
Imports System.Data
Imports System.Data.SqlClient
Partial Class Client_popup
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If Request.QueryString("page") = "calendar" Then
                btndelete.Visible = False
            Else
                btndelete.Visible = True
            End If
            If Request.QueryString("id") <> "" Then
                Dim clientid = Request.QueryString("id")
                GetData(clientid)
                btndelete.Visible = True
                btnsubmit.Text = "Update"
            Else
                btndelete.Visible = False
                btnsubmit.Text = "Save"
            End If

            'If Not String.IsNullOrEmpty(System.Web.HttpContext.Current.Session.SessionID) Then
            '    Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By LogId DESC")

            '    Dim sessionid As String = System.Web.HttpContext.Current.Session.SessionID
            '    Dim dbsessionid As String = Utility.StringData("Select TOP 1 SessionId From UserLog_Data Where UserId =" & userid & "")

            '    If sessionid = dbsessionid Then
            '        'hdnuserid.Value = CType(userid, String)
            '        'Response.Write(userid)
            '        'Response.Write(sessionid)
            '        'Response.Write(dbsessionid)
            '    Else
            '        'Response.Redirect("/login")
            '    End If
            'Else
            '    Response.Redirect("/login")
            'End If
        End If
    End Sub

    Protected Sub btnsubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnsubmit.Click
        SaveData()

        'Dim intInsertUpdate As Integer
        'If Request.QueryString("staffid") <> "" Then
        '    intInsertUpdate = sdsstaff.Update
        '    If intInsertUpdate = 1 Then
        '        Response.Redirect("/staff", False)
        '    End If
        'Else
        '    intInsertUpdate = sdsstaff.Insert
        '    If intInsertUpdate = 1 Then
        '        Response.Redirect("/staff", False)
        '        lblmsg.Text = "Operation Done"
        '        lblmsg.Visible = True
        '    End If
        'End If
    End Sub

    Public Sub SaveData()

        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")
        Dim clientid = Request.QueryString("id")
        If Not String.IsNullOrEmpty(txtFirstName.Text) And txtEmail.Text <> "" Then

            'Dim dob As Date = Date.ParseExact(txtdob.Text, "dd/MM/yyyy", System.Globalization.DateTimeFormatInfo.InvariantInfo)
            Dim selectString As String = ""
            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
            conn.Open()
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
            If Not String.IsNullOrEmpty(clientid) Then
                selectString = "UPDATE [Client] SET [FirstName] = @FirstName, [LastName] = @LastName, [DOB]=@DOB, [Gender]= @Gender, [Phone1] = @Phone1, [Phone2]=@Phone2, [Email] = @Email, [Notes] = @Notes, [Notification]= @Notification, [RefSource]= @RefSource, [Booking]=@Booking, [UpdatedBy] = @ChangeBy, [UpdatedDate] = Getdate() WHERE [ClientID] = @ClientID"
                cmd.Parameters.Add("ClientID", Data.SqlDbType.Int).Value = clientid
            Else
                selectString = "INSERT INTO [Client] ([FirstName], [LastName], [DOB], [Gender], [Phone1], [Phone2], [Email], [Notes], [Notification], [RefSource], [Booking], [CreateBy], [CreateDate]) VALUES (@FirstName, @LastName, @DOB, @Gender, @Phone1, @Phone2, @Email, @Notes, @Notification, @RefSource, @Booking, @ChangeBy, Getdate())  SET @ClientID = SCOPE_IDENTITY() "
                cmd.Parameters.Add("@ClientID", Data.SqlDbType.Int).Direction = ParameterDirection.Output
            End If

            cmd.Parameters.Add("FirstName", Data.SqlDbType.NVarChar).Value = txtFirstName.Text
            cmd.Parameters.Add("LastName", Data.SqlDbType.NVarChar).Value = txtLastName.Text
            cmd.Parameters.Add("DOB", Data.SqlDbType.DateTime).Value = CDate(If(txtdob.Text = "", "1900-01-01", txtdob.Text))
            cmd.Parameters.Add("Gender", Data.SqlDbType.NVarChar).Value = ddlgender.SelectedValue
            cmd.Parameters.Add("Phone1", Data.SqlDbType.NVarChar).Value = txtPhone.Text
            cmd.Parameters.Add("Phone2", Data.SqlDbType.NVarChar).Value = txtTelephone.Text
            cmd.Parameters.Add("Email", Data.SqlDbType.NVarChar).Value = txtEmail.Text
            cmd.Parameters.Add("Notes", Data.SqlDbType.NVarChar).Value = txtNotes.Text
            cmd.Parameters.Add("Notification", Data.SqlDbType.NVarChar).Value = ddlNotification.SelectedValue
            cmd.Parameters.Add("RefSource", Data.SqlDbType.NVarChar).Value = ddlrefsource.SelectedValue
            cmd.Parameters.Add("Booking", Data.SqlDbType.Bit).Value = If(chkbookings.Checked = True, 1, 0)
            cmd.Parameters.Add("ChangeBy", Data.SqlDbType.Int).Value = userID

            cmd.CommandText = selectString
            If Not String.IsNullOrEmpty(Request.QueryString("id")) Then
                cmd.ExecuteNonQuery()
            Else
                cmd.ExecuteScalar()
                hdnClientid.Value = ""
                hdnClientid.Value = CType(cmd.Parameters("@ClientID").Value, String)
            End If
            conn.Close()

            InsertClientLocation(clientid, userID)

            If Request.QueryString("page") = "calendar" Then
                If lblmsg.Text = "" Then
                    ClientScript.RegisterStartupScript(Me.GetType, "Load", "<script type='text/javascript'>top.location='calendar_popup.aspx';parent.location='/calendar';</script>")
                End If
            ElseIf Request.QueryString("page") = "clientinfo" Then
                If lblmsg.Text = "" Then
                    Dim pagelink = "/clientinfo?id=" & Request.QueryString("id")
                    ClientScript.RegisterStartupScript(Me.GetType, "Load", "<script type='text/javascript'>top.location='calendar_popup.aspx';parent.location='" & pagelink & "';</script>")
                End If
            Else
                If lblmsg.Text = "" Then
                    ClientScript.RegisterStartupScript(Me.GetType, "Load", "<script type='text/javascript'>window.parent.location.href = '/client'; </script>")
                End If
            End If


        End If
    End Sub

    Private Sub InsertClientLocation(ByVal clientid As String, ByVal userID As String)
        Dim selectString As String = ""
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim countaddresstp As Integer = Utility.IntegerData("Select Count(AddressType) From [dbo].[ClientLocation] Where AddressType Like '%" & txtaddresstp.Text & "%' AND (ClientID=" & clientid & " or ClientID=" & hdnClientid.Value & ")")

        conn.Open()
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
        If Not String.IsNullOrEmpty(clientid) And ddlAddress.SelectedValue <> "0" Or ddlAddress.SelectedValue <> "" Then
            lblmsg.Text = ""
            selectString = "UPDATE [ClientLocation] SET [AddressType] = @AddressType, [Address] = @Address, [City] = @City, [State]=@State, [ZipCode]= @ZipCode, [Suburb] = @Suburb, [Latitude] = @Latitude, [Longitude] = @Longitude, [UpdatedBy] = @ChangeBy, [UpdatedDate] = Getdate() WHERE ClientLocationID=@ClientLocationID AND [ClientID] = @ClientID"
            cmd.Parameters.Add("ClientLocationID", Data.SqlDbType.Int).Value = ddlAddress.SelectedValue
            cmd.Parameters.Add("ClientID", Data.SqlDbType.Int).Value = clientid
        Else
            If countaddresstp = 0 Then
                lblmsg.Text = ""
                selectString = "INSERT INTO [ClientLocation] ([ClientID], [AddressType], [Address], [City], [State], [ZipCode], [Suburb], [Latitude], [Longitude], [CreateBy], [CreateDate]) VALUES (@ClientID, @AddressType, @Address, @City, @State, @ZipCode, @Suburb, @Latitude, @Longitude, @ChangeBy, Getdate())"
                cmd.Parameters.Add("ClientID", Data.SqlDbType.BigInt).Value = hdnClientid.Value
            Else
                lblmsg.Text = ""
                lblmsg.Text = "Address Type Allready Exist."
                Exit Sub
            End If
        End If
        'selectString = "INSERT INTO [ClientLocation] ([ClientID], [AddressType], [Address], [City], [State], [ZipCode], [Suburb], [Latitude], [Longitude], [CreateBy], [CreateDate]) VALUES (@ClientID, @Address, @City, @State, @ZipCode, @Suburb, @Latitude, @Longitude, @ChangeBy, Getdate())"

        'cmd.Parameters.Add("ClientID", Data.SqlDbType.BigInt).Value = If(hdnClientid.Value <> "", hdnClientid.Value, clientid)
        cmd.Parameters.Add("AddressType", Data.SqlDbType.NVarChar).Value = txtaddresstp.Text
        cmd.Parameters.Add("Address", Data.SqlDbType.NVarChar).Value = txtaddress.Text
        cmd.Parameters.Add("City", Data.SqlDbType.NVarChar).Value = txtCity.Text
        cmd.Parameters.Add("State", Data.SqlDbType.NVarChar).Value = txtstate.Text
        cmd.Parameters.Add("ZipCode", Data.SqlDbType.NVarChar).Value = txtzipcode.Text
        cmd.Parameters.Add("Suburb", Data.SqlDbType.NVarChar).Value = txtsuburb.Text
        cmd.Parameters.Add("Latitude", Data.SqlDbType.NVarChar).Value = txtLatitude.Value
        cmd.Parameters.Add("Longitude", Data.SqlDbType.NVarChar).Value = txtLongitude.Value
        cmd.Parameters.Add("ChangeBy", Data.SqlDbType.Int).Value = userID

        cmd.CommandText = selectString
        cmd.ExecuteNonQuery()
        conn.Close()

    End Sub

    Public Sub GetData(ByVal clientid As String)
        If clientid <> "" Then
            Using conn As New SqlConnection()
                conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                Using cmd As New SqlCommand()
                    'cmd.CommandText = "SELECT * FROM Client C LEFT Join ClientLocation CL ON C.ClientID = CL.ClientID Where C.ClientID=@ClientID"

                    cmd.CommandText = "SELECT * FROM Client Where ClientID=@ClientID"
                    cmd.Parameters.Clear()
                    cmd.Parameters.Add("@ClientID", Data.SqlDbType.Int).Value = clientid
                    cmd.Connection = conn
                    conn.Open()
                    Using reader As SqlDataReader = cmd.ExecuteReader()
                        While reader.Read()
                            hdnClientid.Value = reader("ClientID").ToString()
                            txtFirstName.Text = reader("FirstName").ToString()
                            txtLastName.Text = reader("LastName").ToString()
                            txtdob.Text = If(reader("DOB") Is DBNull.Value, "", Utility.Dayformat(reader("DOB").ToString()).ToString())
                            If txtdob.Text = "01/01/1900" Then
                                txtdob.Text = ""
                            End If
                            ddlgender.SelectedValue = reader("Gender").ToString()
                            txtPhone.Text = reader("Phone1").ToString()
                            txtTelephone.Text = reader("Phone2").ToString()
                            txtEmail.Text = reader("Email").ToString()
                            txtNotes.Text = reader("Notes").ToString()
                            ddlNotification.SelectedValue = reader("Notification").ToString()
                            ddlrefsource.SelectedValue = reader("RefSource").ToString()
                            If (reader("Booking").ToString() = True) Then
                                chkbookings.Checked = True
                            Else
                                chkbookings.Checked = False
                            End If
                            'txtaddress.Text = reader("Address").ToString()
                            'txtCity.Text = reader("City").ToString()
                            'txtstate.Text = reader("State").ToString()
                            'txtzipcode.Text = reader("ZipCode").ToString()
                            'txtsuburb.Text = reader("Suburb").ToString()
                            'txtLatitude.Value = reader("Latitude").ToString()
                            'txtLongitude.Value = reader("Longitude").ToString()
                        End While
                    End Using
                    conn.Close()
                End Using
            End Using
        End If
    End Sub

    Public Sub GetLocationdata()
        If Request.QueryString("id") <> "" Then
            Using conn As New SqlConnection()
                conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                Using cmd As New SqlCommand()
                    cmd.CommandText = "SELECT * FROM ClientLocation Where ClientID=@ClientID And ClientLocationID=@ClientLocationID"
                    cmd.Parameters.Clear()
                    cmd.Parameters.Add("@ClientID", Data.SqlDbType.Int).Value = Request.QueryString("id")
                    cmd.Parameters.Add("ClientLocationID", Data.SqlDbType.Int).Value = ddlAddress.SelectedValue
                    cmd.Connection = conn
                    conn.Open()
                    Using reader As SqlDataReader = cmd.ExecuteReader()
                        While reader.Read()
                            hdnClientid.Value = reader("ClientID").ToString()
                            txtaddresstp.Text = reader("AddressType").ToString()
                            txtaddress.Text = reader("Address").ToString()
                            txtCity.Text = reader("City").ToString()
                            txtstate.Text = reader("State").ToString()
                            txtzipcode.Text = reader("ZipCode").ToString()
                            txtsuburb.Text = reader("Suburb").ToString()
                            txtLatitude.Value = reader("Latitude").ToString()
                            txtLongitude.Value = reader("Longitude").ToString()
                        End While
                    End Using
                    conn.Close()
                End Using
            End Using
        End If
    End Sub

    Protected Sub ddlAddress_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlAddress.SelectedIndexChanged
        If ddlAddress.SelectedValue <> "0" Then
            GetLocationdata()
        Else
            txtaddresstp.Text = ""
            txtaddress.Text = ""
            txtCity.Text = ""
            txtstate.Text = ""
            txtzipcode.Text = ""
            txtsuburb.Text = ""
            txtLatitude.Value = "25.1939565"
            txtLongitude.Value = "55.2316175000001"
        End If
        'Dim pagelink = "/Client_popup.aspx?id=" & Request.QueryString("id") & "#s-LOCATIONS"
        'ClientScript.RegisterStartupScript(Me.GetType, "Load", "<script type='text/javascript'>window.parent.location.href = '" & pagelink & "'; </script>")
    End Sub

    Protected Sub btnaddlocation_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnaddlocation.Click
        ddlAddress.SelectedIndex = -1
        txtaddresstp.Text = ""
        txtaddress.Text = ""
        txtCity.Text = ""
        txtstate.Text = ""
        txtzipcode.Text = ""
        txtsuburb.Text = ""
        txtLatitude.Value = "25.1939565"
        txtLongitude.Value = "55.2316175000001"
    End Sub


    Protected Sub btndelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btndelete.Click
        If Request.QueryString("id") <> "" Then
            DeleteData()
        End If

        ClientScript.RegisterStartupScript(Me.GetType, "Load", "<script type='text/javascript'>window.parent.location.href = '/client'; </script>")

    End Sub

    Public Sub DeleteData()
        If Request.QueryString("id") <> "" Then
            If Not String.IsNullOrEmpty(Request.QueryString("id")) Then
                Dim sql As String = ""
                Dim sql1 As String = ""
                Dim sql2 As String = ""
                Dim selectString As String = ""
                Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
                conn.Open()

                Dim cmd1 As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(sql, conn)
                sql = "DELETE FROM [ClientLocation] WHERE [ClientID] = @ClientID"
                cmd1.CommandText = sql
                cmd1.Parameters.Add("ClientID", Data.SqlDbType.BigInt).Value = Request.QueryString("id")
                cmd1.ExecuteNonQuery()

                Dim countlocation As Integer = Utility.IntegerData("Select Count(ClientID) FROM [ClientLocation] WHERE [ClientID] = " & Request.QueryString("id") & "")
                Dim countservice As Integer = Utility.IntegerData("Select Count(ClientID) FROM [ServiceRequestMasters] WHERE [ClientID] = " & Request.QueryString("id") & "")
                If countlocation = 0 And countservice = 0 Then
                    Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
                    selectString = "DELETE FROM [Client] WHERE [ClientID] = @ClientID"
                    cmd.CommandText = selectString
                    cmd.Parameters.Add("ClientID", Data.SqlDbType.BigInt).Value = Request.QueryString("id")
                    cmd.ExecuteNonQuery()
                    conn.Close()
                End If

            End If
        End If
    End Sub


End Class
