Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing
Imports System.IO

Partial Class ServiceGroups_popup
    Inherits System.Web.UI.Page
    Dim userid As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If Request.QueryString("sgid") <> "" Then
                GetServiceGroupData()
            End If

            If Not String.IsNullOrEmpty(System.Web.HttpContext.Current.Session.SessionID) Then
                userid = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By LogId DESC")

                Dim sessionid As String = System.Web.HttpContext.Current.Session.SessionID
                Dim dbsessionid As String = Utility.StringData("Select TOP 1 SessionId From UserLog_Data Where UserId =" & userid & "")
                'GetServiceGroupData()
                If sessionid = dbsessionid Then
                    If Page.IsPostBack = False Then
                        GetServiceGroupData()
                    End If
                Else
                    Response.Redirect("/login")
                End If
            Else
                Response.Redirect("/login")
            End If
        End If

    End Sub


    Public Sub GetServiceGroupData()
        Dim serviceid = Request.QueryString("sgid")
        LoadparentControl()
        If Request.QueryString("sgid") <> "" Then
            btnsubmit.Text = "Update"
            Using conn As New SqlConnection()
                conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                Using cmd As New SqlCommand()
                    'cmd.CommandText = "Select * FROM Services where IsServiceGroup = 1 And status = 1 And IsPackage = 0 And ServiceId = @ServiceId"
                    cmd.CommandText = "Select * FROM Services where IsServiceGroup = 1 And status = 1 And ServiceId = @ServiceId"
                    cmd.Parameters.Clear()
                    cmd.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = serviceid
                    cmd.Connection = conn
                    conn.Open()
                    Using reader As SqlDataReader = cmd.ExecuteReader()
                        While reader.Read()
                            hdnserviceid.Value = If(reader("ServiceId") Is DBNull.Value, "", reader("ServiceId").ToString())
                            txtName.Text = If(reader("Title") Is DBNull.Value, "", reader("Title").ToString())
                            txtDetails.Text = If(reader("Description") Is DBNull.Value, "", reader("Description").ToString())
                            txtArName.Text = If(reader("ArTitle") Is DBNull.Value, "", reader("ArTitle").ToString())
                            txtArDetails.Text = If(reader("ArDescription") Is DBNull.Value, "", reader("ArDescription").ToString())
                            hdnparentid.Value = If(reader("ParentId") Is DBNull.Value, "", reader("ParentId").ToString())
                            If hdnparentid.Value <> "0" Then
                                ddlGroup.SelectedValue = If(reader("ParentId") Is DBNull.Value, "", reader("ParentId").ToString())
                                'Else
                                '    ddlGroup.SelectedValue = If(reader("ServiceId") Is DBNull.Value, "", reader("ServiceId").ToString())
                            End If
                            'group.Color = If(reader("Color") Is DBNull.Value, "", reader("Color").ToString())
                            If reader("IsPackage") = True Then
                                chkPackage.Checked = True
                            Else
                                chkPackage.Checked = False
                            End If

                            hficonUrl_active.Value = If(reader("SmallIconOne") Is DBNull.Value, "", reader("SmallIconOne").ToString())
                            hficonUrl.Value = If(reader("SmallIconTwo") Is DBNull.Value, "", reader("SmallIconTwo").ToString())
                            hfImageUrl.Value = If(reader("BigIconOne") Is DBNull.Value, "", reader("BigIconOne").ToString())
                            hfImageUrlMain.Value = If(reader("BigIconTwo") Is DBNull.Value, "", reader("BigIconTwo").ToString())

                            txtBigimWidth.Text = If(reader("BigIconWidth") Is DBNull.Value, "", reader("BigIconWidth").ToString())
                            txtBigimHeight.Text = If(reader("BigIconHeight") Is DBNull.Value, "", reader("BigIconHeight").ToString())

                            Dim color = If(reader("Color") Is DBNull.Value, "", reader("Color").ToString())

                            If color.Equals("pink") Then
                                radio_1.Checked = True
                            End If

                            If color.Equals("purple") Then
                                radio_2.Checked = True
                            End If

                            If color.Equals("indigo") Then
                                radio_3.Checked = True
                            End If

                            If color.Equals("blue") Then
                                radio_4.Checked = True
                            End If

                            If color.Equals("cyan") Then
                                radio_5.Checked = True
                            End If

                            If color.Equals("teal") Then
                                radio_6.Checked = True
                            End If

                            If color.Equals("green") Then
                                radio_7.Checked = True
                            End If

                            If color.Equals("lime") Then
                                radio_8.Checked = True
                            End If
                            If color.Equals("yellow") Then
                                radio_9.Checked = True
                            End If

                            If color.Equals("orange") Then
                                radio_10.Checked = True
                            End If

                        End While
                    End Using
                    conn.Close()
                End Using

            End Using

            btndelete.Visible = True
        Else
            btndelete.Visible = False
            btnsubmit.Text = "Save"
        End If


    End Sub

    Public Sub LoadparentControl()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim hdServiceid As Integer = hdServiceid
        conn.Open()
        Try

            Dim selectString = "Select * FROM Services where IsServiceGroup = 1 And status = 1 And ServiceId <> " & hdServiceid & " And ParentId = 0 order by Title asc "
            Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
            ddlGroup.Items.Clear()
            ddlGroup.Items.Add(New ListItem("Select Service Group", "0"))

            Dim objReaderb As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()

            If objReaderb.HasRows Then
                While objReaderb.Read()
                    ddlGroup.Items.Add(New ListItem(objReaderb("Title"), objReaderb("ServiceId").ToString()))
                    Dim selectChild = "Select * FROM Services where IsServiceGroup = 1 And status = 1 And ServiceId <> " & hdServiceid & "  And ParentId = " & objReaderb("ServiceId").ToString() & " order by Title asc "
                    Dim cmdChild As SqlCommand = New SqlCommand(selectChild, conn)
                    Dim objReaderChild As Data.SqlClient.SqlDataReader = cmdChild.ExecuteReader()

                    'If objReaderChild.HasRows Then
                    '    While objReaderChild.Read()
                    '        ddlGroup.Items.Add(New ListItem(objReaderb("Title") & "-->" & objReaderChild("Title"), objReaderChild("ServiceId").ToString()))
                    '        Dim selectChildChild = "Select * FROM Services where IsServiceGroup = 1 And status = 1  And ServiceId <> " & hdServiceid & "  And ParentId = " & objReaderChild("ServiceId").ToString() & " order by Title asc "
                    '        Dim cmdChildChild As SqlCommand = New SqlCommand(selectChildChild, conn)
                    '        Dim objReaderChildChild As Data.SqlClient.SqlDataReader = cmdChildChild.ExecuteReader()

                    '        If objReaderChildChild.HasRows Then
                    '            While objReaderChildChild.Read()
                    '                ddlGroup.Items.Add(New ListItem(objReaderb("Title") & "-->" & objReaderChild("Title") & "-->" & objReaderChildChild("Title"), objReaderChildChild("ServiceId").ToString()))
                    '            End While
                    '        End If
                    '    End While
                    'End If
                End While
            End If
            ddlGroup.SelectedValue = "0"
            objReaderb.Close()

        Catch ex As Exception

        End Try

        conn.Close()
    End Sub

    Protected Sub btnsubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnsubmit.Click
        If Request.QueryString("sgid") <> "" Then
            SaveData()
            ClientScript.RegisterStartupScript(Me.GetType, "Load", "<script type='text/javascript'>window.parent.location.href = '/servicegroups'; </script>")
        Else
            SaveData()
            ClientScript.RegisterStartupScript(Me.GetType, "Load", "<script type='text/javascript'>window.parent.location.href = '/servicegroups'; </script>")
            'lblmsg.Text = "Operation Done"
            'lblmsg.Visible = True
        End If

        'Dim jScript As String = "window.top.location.href = '/ClosedDates';"
        'ScriptManager.RegisterStartupScript(Me, Me.GetType, "forceParentLoad", jScript, True)
        'Response.Redirect("/ClosedDates")
    End Sub

    Private Sub SaveData()
        Try
            UploadImage()
            Dim color As String = ServiceGroupColor()
            Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")

            Dim selectString As String = ""
            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
            conn.Open()
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)

            Dim ParentId = ddlGroup.SelectedValue

            Dim bigiconwidth As Integer = 0
            Dim bigiconheight As Integer = 0
            Integer.TryParse(txtBigimWidth.Text, bigiconwidth)
            Integer.TryParse(txtBigimHeight.Text, bigiconheight)

            If Not String.IsNullOrEmpty(Request.QueryString("sgid")) Then
                selectString = "UPDATE [Services] SET [Title] = @Title, [Description] = @Description, [ArTitle] = @ArTitle, [ArDescription] = @ArDescription, [Color] = @Color, [ParentId] = @ParentId, [UpdatedBy] = @ChangedBy, [UpdatedAt] = Getdate(), [IsPackage] = @IsPackage, [SmallIconOne] =@SmallIconOne, [SmallIconTwo] =@SmallIconTwo, [BigIconOne] = @BigIconOne, [BigIconTwo] = @BigIconTwo, [BigIconWidth]=@BigIconWidth, [BigIconHeight]=@BigIconHeight where [ServiceId] = @ServiceId"
                cmd.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = Request.QueryString("sgid")
            Else
                selectString = "INSERT into Services(Title, Description, ArTitle, ArDescription, Color, IsServiceGroup, Status, CreatedBy, CreatedAt, ParentId, IsPackage, SmallIconOne, SmallIconTwo, BigIconOne, BigIconTwo, BigIconWidth, BigIconHeight)  values(@Title, @Description, @ArTitle, @ArDescription, @Color, @IsServiceGroup, @Status, @ChangedBy, Getdate(), @ParentId, @IsPackage, @SmallIconOne, @SmallIconTwo, @BigIconOne, @BigIconTwo, @BigIconWidth, @BigIconHeight)   SET @ServiceId = SCOPE_IDENTITY()"
                cmd.Parameters.Add("@ServiceId", Data.SqlDbType.Int).Direction = ParameterDirection.Output
                cmd.Parameters.Add("Status", Data.SqlDbType.Bit).Value = True
                cmd.Parameters.Add("IsServiceGroup", Data.SqlDbType.Bit).Value = True
            End If

            cmd.Parameters.Add("Title", Data.SqlDbType.NVarChar).Value = txtName.Text
            cmd.Parameters.Add("Description", Data.SqlDbType.NVarChar).Value = txtDetails.Text
            cmd.Parameters.Add("ArTitle", Data.SqlDbType.NVarChar).Value = txtArName.Text
            cmd.Parameters.Add("ArDescription", Data.SqlDbType.NVarChar).Value = txtArDetails.Text
            cmd.Parameters.Add("Color", Data.SqlDbType.NVarChar).Value = color
            cmd.Parameters.Add("ChangedBy", Data.SqlDbType.Int).Value = userID
            'cmd.Parameters.Add("CreatedAt", Data.SqlDbType.DateTime).Value = DateTime.Now
            cmd.Parameters.Add("ParentId", Data.SqlDbType.BigInt).Value = If(ParentId <> "", CInt(ParentId), 0)
            cmd.Parameters.Add("IsPackage", Data.SqlDbType.Bit).Value = If(chkPackage.Checked = True, 1, 0)

            cmd.Parameters.Add("SmallIconOne", Data.SqlDbType.NVarChar).Value = hficonUrl_active.Value
            cmd.Parameters.Add("SmallIconTwo", Data.SqlDbType.NVarChar).Value = hficonUrl.Value
            cmd.Parameters.Add("BigIconOne", Data.SqlDbType.NVarChar).Value = hfImageUrl.Value
            cmd.Parameters.Add("BigIconTwo", Data.SqlDbType.NVarChar).Value = hfImageUrlMain.Value
            cmd.Parameters.Add("BigIconWidth", Data.SqlDbType.Int).Value = bigiconwidth
            cmd.Parameters.Add("BigIconHeight", Data.SqlDbType.Int).Value = bigiconheight

            cmd.CommandText = selectString
            If String.IsNullOrEmpty(Request.QueryString("sgid")) Then
                cmd.ExecuteScalar()
                hdnScopeID.Value = ""
                hdnScopeID.Value = CType(cmd.Parameters("@ServiceId").Value, String)
            Else
                cmd.ExecuteNonQuery()
            End If

            conn.Close()

            If String.IsNullOrEmpty(Request.QueryString("sgid")) Then
                ServiceRate()
            End If

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Private Function ServiceGroupColor() As String
        Dim color As String = ""

        If radio_1.Checked Then
            color = "pink"
        End If

        If radio_2.Checked Then
            color = "purple"
        End If

        If radio_3.Checked Then
            color = "indigo"
        End If

        If radio_4.Checked Then
            color = "blue"
        End If

        If radio_5.Checked Then
            color = "cyan"
        End If
        If radio_6.Checked Then
            color = "teal"
        End If
        If radio_7.Checked Then
            color = "green"
        End If
        If radio_8.Checked Then
            color = "lime"
        End If
        If radio_9.Checked Then
            color = "yellow"
        End If

        If radio_10.Checked Then
            color = "orange"
        End If

        Return color
    End Function

    Private Sub ServiceRate()
        Try
            Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")

            Dim selectString As String = ""
            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
            conn.Open()
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
            If Not String.IsNullOrEmpty(hdnScopeID.Value) Then
                selectString = "INSERT into ServiceRates(ServiceId, RetailPrice, SpecialPrice, CreatedBy, CreatedAt)  values(@ServiceId, @RetailPrice, @SpecialPrice, @CreatedBy, Getdate()) "
            End If
            cmd.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = CInt(hdnScopeID.Value)
            cmd.Parameters.Add("RetailPrice", Data.SqlDbType.Float).Value = 0
            cmd.Parameters.Add("SpecialPrice", Data.SqlDbType.Float).Value = 0
            cmd.Parameters.Add("CreatedBy", Data.SqlDbType.Int).Value = userid
            cmd.CommandText = selectString
            cmd.ExecuteNonQuery()
            conn.Close()
        Catch ex As Exception

        End Try
    End Sub

    Public Sub UploadImage()

        If fuSmallImage_active.FileName <> "" Then
            If Mid(fuSmallImage_active.PostedFile.ContentType, 1, 5) <> "image" Then
                Throw New Exception("Please select correct image")
                Exit Sub
            End If

            Dim c As String, filename As String
            If fuSmallImage_active.PostedFile.ContentType.Contains("jpg") Then
                c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".jpg"
                filename = "Content/images/service-icons/icons/active/" & c

            ElseIf fuSmallImage_active.PostedFile.ContentType.Contains("jpeg") Then
                c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".jpeg"
                filename = "Content/images/service-icons/icons/active/" & c

            ElseIf fuSmallImage_active.PostedFile.ContentType.Contains("png") Then
                c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".png"
                filename = "Content/images/service-icons/icons/active/" & c

            Else
                c = ""
                filename = "Content/images/service-icons/icons/active/" & c
            End If

            If c <> "" Then
                fuSmallImage_active.PostedFile.SaveAs(System.AppDomain.CurrentDomain.BaseDirectory() & filename)
                hficonUrl_active.Value = filename
            End If

        End If

        If fuSmallImage.FileName <> "" Then
            If Mid(fuSmallImage.PostedFile.ContentType, 1, 5) <> "image" Then
                Throw New Exception("Please select correct image")
                Exit Sub
            End If

            Dim c As String, filename As String
            If fuSmallImage.PostedFile.ContentType.Contains("jpg") Then
                c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".jpg"
                filename = "Content/images/service-icons/icons/" & c

            ElseIf fuSmallImage.PostedFile.ContentType.Contains("jpeg") Then
                c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".jpeg"
                filename = "Content/images/service-icons/icons/" & c

            ElseIf fuSmallImage.PostedFile.ContentType.Contains("png") Then
                c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".png"
                filename = "Content/images/service-icons/icons/" & c

            Else
                c = ""
                filename = "Content/images/service-icons/icons/" & c

            End If

            If c <> "" Then
                fuSmallImage.PostedFile.SaveAs(System.AppDomain.CurrentDomain.BaseDirectory() & filename)
                hficonUrl.Value = filename
            End If
        End If


        If fuBigImage.FileName <> "" Then

            If Mid(fuBigImage.PostedFile.ContentType, 1, 5) <> "image" Then
                Throw New Exception("Please select correct image")
                Exit Sub
            End If

            Const destination = "Content/images/service-icons/home-images/"

            Dim c As String, filename As String
            If fuSmallImage.PostedFile.ContentType.Contains("jpg") Then
                c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".jpg"
                filename = "Content/images/service-icons/home-images/" & c

            ElseIf fuSmallImage.PostedFile.ContentType.Contains("jpeg") Then
                c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".jpeg"
                filename = "Content/images/service-icons/home-images/" & c

            ElseIf fuSmallImage.PostedFile.ContentType.Contains("png") Then
                c = Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay) & ".png"
                filename = "Content/images/service-icons/home-images/" & c
            Else
                c = ""
                filename = "Content/images/service-icons/home-images/" & c

            End If

            If c <> "" Then
                fuBigImage.PostedFile.SaveAs(System.AppDomain.CurrentDomain.BaseDirectory() & filename)
                hfImageUrlMain.Value = filename
            End If

            Dim OriginalBM As Bitmap = New Bitmap(Server.MapPath("~/" & filename))
            Dim height As Integer = CInt(txtBigimHeight.Text)
            Dim width As Integer = CInt(txtBigimWidth.Text)
            'BigImage
            Dim BigSize As Size = New Size(width, height)
            Dim ResizedBM1 As Bitmap = New Bitmap(OriginalBM, BigSize)
            Dim fileLarge As String = "Home-" & Mid(c, 2)
            ResizedBM1.Save(Context.Server.MapPath(destination + fileLarge))

            hfImageUrl.Value = destination & fileLarge
        End If
    End Sub

End Class