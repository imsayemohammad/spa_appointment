Imports System.Data
Imports System.Data.SqlClient
Partial Class Staff_popup
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If Request.QueryString("staffid") <> "" Then
                GetData()
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
        Dim staffid = Request.QueryString("staffid")

        If fuImageFile.FileName <> "" Then
            Dim ext = System.IO.Path.GetExtension(fuImageFile.PostedFile.FileName).ToLower()
            If fuImageFile.PostedFile.ContentType.Contains("image") Then
                hdnImageUrl.Value = FileUpload(fuImageFile, staffid, Server)
                lblmsg.Text = ""
            Else
                lblmsg.Text = ""
                lblmsg.Text = "Uploaded file type is not supported. Please, upload only image file."
                Exit Sub
            End If

        End If

        If Not String.IsNullOrEmpty(txtFirstName.Text) Then
            Dim selectString As String = ""
            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
            conn.Open()
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
            If Not String.IsNullOrEmpty(Request.QueryString("staffid")) Then
                selectString = "UPDATE [Staff] SET [FirstName] = @FirstName, [LastName] = @LastName, [Phone1] = @Phone1, [Email] = @Email, [Notes] = @Notes, [StartDate] = @StartDate, [EndDate] = @EndDate, [UserPermission] = @UserPermission, [AppBooking]=@AppBooking, [BigImage]=@BigImage, [SmallImage]=@SmallImage, [UpdatedBy] = @ChangeBy, [UpdatedDate] = Getdate() WHERE [StaffID] = @StaffID"
                cmd.Parameters.Add("StaffID", Data.SqlDbType.Int).Value = staffid
            Else
                selectString = "INSERT INTO [Staff] ([FirstName], [LastName], [Phone1], [Email], [Notes], [StartDate], [EndDate], [UserPermission], [AppBooking], [BigImage], [SmallImage], [CreateBy], [CreateDate]) VALUES (@FirstName, @LastName, @Phone1, @Email, @Notes, @StartDate, @EndDate, @UserPermission, @AppBooking, @BigImage, @SmallImage, @ChangeBy, Getdate())   SET @StaffId = SCOPE_IDENTITY() "
                cmd.Parameters.Add("@StaffId", Data.SqlDbType.Int).Direction = ParameterDirection.Output
            End If

            cmd.Parameters.Add("FirstName", Data.SqlDbType.NVarChar).Value = txtFirstName.Text
            cmd.Parameters.Add("LastName", Data.SqlDbType.NVarChar).Value = txtLastName.Text
            cmd.Parameters.Add("Phone1", Data.SqlDbType.NVarChar).Value = txtPhone.Text
            cmd.Parameters.Add("Email", Data.SqlDbType.NVarChar).Value = txtEmail.Text
            cmd.Parameters.Add("Notes", Data.SqlDbType.NVarChar).Value = txtNotes.Text
            cmd.Parameters.Add("StartDate", Data.SqlDbType.DateTime).Value = txtstartDT.Text
            cmd.Parameters.Add("EndDate", Data.SqlDbType.DateTime).Value = txtEndDT.Text
            cmd.Parameters.Add("UserPermission", Data.SqlDbType.NVarChar).Value = ddlPermission.SelectedValue
            cmd.Parameters.Add("AppBooking", Data.SqlDbType.Bit).Value = If(chkstatus.Checked = True, 1, 0)
            cmd.Parameters.Add("BigImage", Data.SqlDbType.NVarChar).Value = hdnImageUrl.Value
            cmd.Parameters.Add("SmallImage", Data.SqlDbType.NVarChar).Value = hdnImageUrl.Value
            cmd.Parameters.Add("ChangeBy", Data.SqlDbType.Int).Value = userID

            cmd.CommandText = selectString
            If String.IsNullOrEmpty(Request.QueryString("staffid")) Then
                cmd.ExecuteScalar()
                hdnStaffid.Value = ""
                hdnStaffid.Value = CType(cmd.Parameters("@StaffId").Value, String)
            Else
                cmd.ExecuteNonQuery()
            End If
            conn.Close()

            InsertLocation()
            InsertService()
            StaffCommission()
            'Response.Redirect("/staff")
            
            If Request.QueryString("page") = "staffinfo" Then
                If lblmsg.Text = "" Then
                    Dim pagelink = "/StaffInfo?staffid=" & Request.QueryString("staffid")
                    ClientScript.RegisterStartupScript(Me.GetType, "Load", "<script type='text/javascript'>top.location='/StaffInfo';parent.location='" & pagelink & "';</script>")
                End If
            Else
                If lblmsg.Text = "" Then
                    ClientScript.RegisterStartupScript(Me.GetType, "Load", "<script type='text/javascript'>window.parent.location.href = '/staff'; </script>")
                End If
            End If

        End If
    End Sub

    Private Sub StaffCommission()
        Try
            Dim sqlString As String
            Dim ProductCom As String = ""
            Dim VoucherCm As String = ""
            Dim ServiceCom As String = ""

            ProductCom = txtProductCommission.Text
            ServiceCom = txtServiceCommission.Text
            VoucherCm = txtVSCommission.Text

            Dim strConn = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")
            Dim sqlConn As SqlConnection = New SqlConnection(strConn)
            sqlConn.Open()
            sqlString = "delete FROM StaffCommission where StaffID = @StaffID"
            Dim sqlcomm As SqlCommand = New SqlCommand()
            sqlcomm.CommandText = sqlString
            sqlcomm.Connection = sqlConn
            sqlcomm.CommandType = Data.CommandType.Text
            If Request.QueryString("staffid") <> "" Then
                sqlcomm.Parameters.Add("StaffID", Data.SqlDbType.BigInt).Value = Request.QueryString("staffid")
            Else
                sqlcomm.Parameters.Add("StaffID", Data.SqlDbType.BigInt).Value = hdnStaffid.Value
            End If

            sqlcomm.ExecuteNonQuery()
            sqlcomm.Parameters.Clear()
            sqlcomm.Dispose()

            sqlString = "insert into [StaffCommission] (StaffID, ProductCommission, ServiceCommission, VoucherCommission, CreatedBy, CreatedAt) Values(@StaffID, @ProductCommission, @ServiceCommission, @VoucherCommission, @CreatedBy, Getdate())"
            sqlcomm.CommandText = sqlString
            sqlcomm.Connection = sqlConn
            sqlcomm.CommandType = Data.CommandType.Text
            If Request.QueryString("staffid") <> "" Then
                sqlcomm.Parameters.Add("StaffID", Data.SqlDbType.BigInt).Value = Request.QueryString("staffid")
            Else
                sqlcomm.Parameters.Add("StaffID", Data.SqlDbType.BigInt).Value = hdnStaffid.Value
            End If
            sqlcomm.Parameters.Add("ProductCommission", Data.SqlDbType.Float).Value = If(ProductCom <> "", CDec(ProductCom), 0)
            sqlcomm.Parameters.Add("ServiceCommission", Data.SqlDbType.Float).Value = If(ServiceCom <> "", CDec(ServiceCom), 0)
            sqlcomm.Parameters.Add("VoucherCommission", Data.SqlDbType.Float).Value = If(VoucherCm <> "", CDec(VoucherCm), 0)

            sqlcomm.Parameters.Add("CreatedBy", Data.SqlDbType.Int).Value = userid
            sqlcomm.ExecuteNonQuery()
            sqlcomm.Parameters.Clear()
            sqlcomm.Dispose()

            sqlConn.Close()
        Catch ex As Exception

        End Try
    End Sub

    Private Sub InsertLocation()
        Try
            Dim sqlString As String
            Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")
            Dim staffid = Request.QueryString("staffid")
            Dim strConn = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Dim sqlConn As SqlConnection = New SqlConnection(strConn)
            sqlConn.Open()
            sqlString = "delete from [StaffServiceLocations] Where StaffId=@StaffId"
            Dim sqlcomm As SqlCommand = New SqlCommand()
            sqlcomm.CommandText = sqlString
            sqlcomm.Connection = sqlConn
            sqlcomm.CommandType = Data.CommandType.Text
            If Request.QueryString("staffid") <> "" Then
                sqlcomm.Parameters.Add("StaffId", Data.SqlDbType.BigInt).Value = Request.QueryString("staffid")
            Else
                sqlcomm.Parameters.Add("StaffId", Data.SqlDbType.BigInt).Value = hdnStaffid.Value
            End If
            sqlcomm.ExecuteNonQuery()
            sqlcomm.Parameters.Clear()
            sqlcomm.Dispose()

            For i As Integer = 0 To ChkLocation.Items.Count - 1
                If ChkLocation.Items(i).Selected = True Then
                    sqlString = "insert into [StaffServiceLocations] (AreaId, StaffId, CreatedBy, CreatedAt) Values(@AreaId, @StaffId, @CreatedBy, Getdate())"
                    sqlcomm.CommandText = sqlString
                    sqlcomm.Connection = sqlConn
                    sqlcomm.CommandType = Data.CommandType.Text
                    sqlcomm.Parameters.Add("AreaId", Data.SqlDbType.BigInt).Value = ChkLocation.Items(i).Value
                    If Request.QueryString("staffid") <> "" Then
                        sqlcomm.Parameters.Add("StaffId", Data.SqlDbType.BigInt).Value = Request.QueryString("staffid")
                    Else
                        sqlcomm.Parameters.Add("StaffId", Data.SqlDbType.BigInt).Value = hdnStaffid.Value
                    End If
                    sqlcomm.Parameters.Add("CreatedBy", Data.SqlDbType.Int).Value = userid
                    sqlcomm.ExecuteNonQuery()
                    sqlcomm.Parameters.Clear()
                    sqlcomm.Dispose()
                End If
            Next
            sqlConn.Close()
        Catch ex As Exception

        End Try
    End Sub

    Private Sub InsertService()
        Try
            Dim sqlString As String
            Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")
            Dim staffid = Request.QueryString("staffid")
            Dim strConn = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Dim sqlConn As SqlConnection = New SqlConnection(strConn)
            sqlConn.Open()
            sqlString = "delete from [StaffServices] Where StaffId=@StaffId"
            Dim sqlcomm As SqlCommand = New SqlCommand()
            sqlcomm.CommandText = sqlString
            sqlcomm.Connection = sqlConn
            sqlcomm.CommandType = Data.CommandType.Text
            If Request.QueryString("staffid") <> "" Then
                sqlcomm.Parameters.Add("StaffId", Data.SqlDbType.BigInt).Value = Request.QueryString("staffid")
            Else
                sqlcomm.Parameters.Add("StaffId", Data.SqlDbType.BigInt).Value = hdnStaffid.Value
            End If
            sqlcomm.ExecuteNonQuery()
            sqlcomm.Parameters.Clear()
            sqlcomm.Dispose()

            For i As Integer = 0 To ChkService.Items.Count - 1
                If ChkService.Items(i).Selected = True Then
                    sqlString = "insert into [StaffServices] (ServiceId, StaffId, CreatedBy, CreatedAt) Values(@ServiceId, @StaffId, @CreatedBy, Getdate())"
                    sqlcomm.CommandText = sqlString
                    sqlcomm.Connection = sqlConn
                    sqlcomm.CommandType = Data.CommandType.Text
                    sqlcomm.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = ChkService.Items(i).Value
                    If Request.QueryString("staffid") <> "" Then
                        sqlcomm.Parameters.Add("StaffId", Data.SqlDbType.BigInt).Value = Request.QueryString("staffid")
                    Else
                        sqlcomm.Parameters.Add("StaffId", Data.SqlDbType.BigInt).Value = hdnStaffid.Value
                    End If
                    sqlcomm.Parameters.Add("CreatedBy", Data.SqlDbType.Int).Value = userid
                    sqlcomm.ExecuteNonQuery()
                    sqlcomm.Parameters.Clear()
                    sqlcomm.Dispose()
                End If
            Next
            sqlConn.Close()
        Catch ex As Exception

        End Try
    End Sub

    Public Sub GetData()
        Dim staffid = Request.QueryString("staffid")
        If staffid <> "" Then
            Using conn As New SqlConnection()
                conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                Using cmd As New SqlCommand()
                    cmd.CommandText = "SELECT * FROM [Staff] Where StaffID=@StaffID"
                    cmd.Parameters.Clear()
                    cmd.Parameters.Add("@StaffID", Data.SqlDbType.Int).Value = staffid
                    cmd.Connection = conn
                    conn.Open()
                    Using reader As SqlDataReader = cmd.ExecuteReader()
                        While reader.Read()
                            Dim strtdate = CDate(reader("StartDate"))
                            Dim enddate = CDate(reader("EndDate"))
                            hdnStaffid.Value = reader("StaffID").ToString()
                            txtFirstName.Text = reader("FirstName").ToString()
                            txtLastName.Text = reader("LastName").ToString()
                            txtPhone.Text = reader("Phone1").ToString()
                            txtEmail.Text = reader("Email").ToString()
                            txtNotes.Text = reader("Notes").ToString()
                            txtstartDT.Text = Utility.Dayformat(strtdate).ToString()
                            txtEndDT.Text = Utility.Dayformat(enddate).ToString()
                            ddlPermission.SelectedValue = reader("UserPermission").ToString()
                            chkstatus.Checked = CType(reader("AppBooking").ToString(), Boolean)
                            'If IsDBNull(reader("AppBooking")) <> False Then
                            '    chkstatus.Checked = reader("AppBooking").ToString()
                            'End If

                            If reader("BigImage").ToString() <> "" Then
                                hdnImageUrl.Value = reader("BigImage") & ""
                                imgSmallImage.Visible = True
                                imgSmallImage.ImageUrl = hdnImageUrl.Value
                                'imgSmallImage.ImageUrl = ConfigurationManager.AppSettings("ImageUrl") & hdnImageUrl.Value
                            Else
                                imgSmallImage.Visible = False
                            End If

                        End While
                        reader.Close()
                    End Using
                    conn.Close()
                End Using
            End Using
            LoadLocation()
            LoadService()
            LoadCommission()
        End If
    End Sub

    Private Sub LoadLocation()
        If Request.QueryString("staffid") <> "" Then
            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
            conn.Open()
            Dim selectString = "SELECT * FROM StaffServiceLocations where StaffId=@StaffId"
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
            cmd.Parameters.Add("StaffId", Data.SqlDbType.BigInt).Value = Request.QueryString("staffid")

            Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
            ChkLocation.DataBind()
            While reader.Read()

                For i As Integer = 0 To ChkLocation.Items.Count - 1
                    If ChkLocation.Items(i).Value = reader("AreaId").ToString() Then
                        ChkLocation.Items(i).Selected = True
                    End If
                Next

            End While
            reader.Close()
        End If
    End Sub

    Private Sub LoadService()
        If Request.QueryString("staffid") <> "" Then
            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
            conn.Open()
            Dim selectString = "SELECT * FROM StaffServices where StaffId=@StaffId"
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
            cmd.Parameters.Add("StaffId", Data.SqlDbType.BigInt).Value = Request.QueryString("staffid")

            Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
            ChkService.DataBind()
            While reader.Read()

                For i As Integer = 0 To ChkService.Items.Count - 1
                    If ChkService.Items(i).Value = reader("ServiceId").ToString() Then
                        ChkService.Items(i).Selected = True
                    End If
                Next

            End While
            reader.Close()
        End If
    End Sub

    Private Sub LoadCommission()
        If Request.QueryString("staffid") <> "" Then
            Using conn As New SqlConnection()
                conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                Using cmd As New SqlCommand()
                    cmd.CommandText = "SELECT * FROM StaffCommission where StaffID=@StaffId"
                    cmd.Parameters.Clear()
                    cmd.Parameters.Add("StaffId", Data.SqlDbType.BigInt).Value = Request.QueryString("staffid")
                    cmd.Connection = conn
                    conn.Open()
                    Using reader As SqlDataReader = cmd.ExecuteReader()
                        While reader.Read()
                            txtProductCommission.Text = reader("ProductCommission").ToString()
                            txtServiceCommission.Text = reader("ServiceCommission").ToString()
                            txtVSCommission.Text = reader("VoucherCommission").ToString()
                        End While
                        reader.Close()
                    End Using
                    conn.Close()
                End Using
            End Using

        End If
    End Sub

    Protected Sub btndelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btndelete.Click
        If Request.QueryString("staffid") <> "" Then
            DeleteData()
        End If

        ClientScript.RegisterStartupScript(Me.GetType, "Load", "<script type='text/javascript'>window.parent.location.href = '/staff'; </script>")

    End Sub

    Public Sub DeleteData()
        If Request.QueryString("staffid") <> "" Then
            If Not String.IsNullOrEmpty(Request.QueryString("staffid")) Then
                Dim sql As String = ""
                Dim sql1 As String = ""
                Dim sql2 As String = ""
                Dim selectString As String = ""
                Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
                conn.Open()

                Dim cmd1 As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(sql, conn)
                sql = "DELETE FROM [StaffServiceLocations] WHERE [StaffId] = @StaffId"
                cmd1.CommandText = sql
                cmd1.Parameters.Add("StaffId", Data.SqlDbType.BigInt).Value = Request.QueryString("staffid")
                cmd1.ExecuteNonQuery()

                Dim cmd2 As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(sql1, conn)
                sql1 = "DELETE FROM [StaffServices] WHERE [StaffId] = @StaffId"
                cmd2.CommandText = sql1
                cmd2.Parameters.Add("StaffId", Data.SqlDbType.BigInt).Value = Request.QueryString("staffid")
                cmd2.ExecuteNonQuery()

                Dim cmd3 As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(sql2, conn)
                sql2 = "DELETE FROM [StaffCommission] WHERE [StaffId] = @StaffId"
                cmd3.CommandText = sql2
                cmd3.Parameters.Add("StaffId", Data.SqlDbType.BigInt).Value = Request.QueryString("staffid")
                cmd3.ExecuteNonQuery()

                Dim countlocation As Integer = Utility.IntegerData("Select Count(StaffId) FROM [StaffServiceLocations] WHERE [StaffId] = " & Request.QueryString("staffid") & "")
                Dim countservice As Integer = Utility.IntegerData("Select Count(StaffId) FROM [StaffServices] WHERE [StaffId] = " & Request.QueryString("staffid") & "")
                Dim countcommission As Integer = Utility.IntegerData("Select Count(StaffId) FROM [StaffCommission] WHERE [StaffId] = " & Request.QueryString("staffid") & "")
                If countlocation = 0 And countservice = 0 And countcommission = 0 Then
                    Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
                    selectString = "DELETE FROM [Staff] Where StaffID=@StaffID"
                    cmd.CommandText = selectString
                    cmd.Parameters.Add("StaffID", Data.SqlDbType.BigInt).Value = Request.QueryString("staffid")
                    cmd.ExecuteNonQuery()
                    conn.Close()
                End If

            End If
        End If
    End Sub


    Public Shared Function FileUpload(ByVal FileField As FileUpload, ByVal prefix As String, ByVal Server As System.Web.HttpServerUtility) As String
        Dim domainName As String
        domainName = ConfigurationManager.AppSettings("RedirectUrl").ToString
        Dim c As String, filename As String = ""
        If FileField.PostedFile.ContentType.Contains("jpg") Then
            c = "_" & Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".jpg"
            filename = "ContentImage/" & prefix & c

        ElseIf FileField.PostedFile.ContentType.Contains("jpeg") Then
            c = "_" & Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".jpeg"
            filename = "ContentImage/" & prefix & c

        ElseIf FileField.PostedFile.ContentType.Contains("png") Then
            c = "_" & Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".png"
            filename = "ContentImage/" & prefix & c

            'Else
            '    Throw New Exception("Please select correct File format")
            '    Exit Function
        End If

        If FileField.FileName <> "" Then
            FileField.PostedFile.SaveAs(System.AppDomain.CurrentDomain.BaseDirectory() & filename)
        End If

        Return filename

    End Function

End Class
