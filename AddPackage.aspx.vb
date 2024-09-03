Imports System.Data
Imports System.Data.SqlClient
Imports System.Dynamic

Partial Class AddPackage
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            'If Not IsPostBack Then
            If Not String.IsNullOrEmpty(System.Web.HttpContext.Current.Session.SessionID) Then
                Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By LogId DESC")
                txtPrice.Attributes.Add("readonly", "readonly")
                Dim sessionid As String = System.Web.HttpContext.Current.Session.SessionID
                Dim dbsessionid As String = Utility.StringData("Select TOP 1 SessionId From UserLog_Data Where UserId =" & userid & "")
                LoadControl()
                If Request.QueryString("serviceId") <> "" Then
                    GetData()
                    btndelete.Visible = True
                    btnsave.Text = "Update"
                Else
                    btndelete.Visible = False
                    btnsave.Text = "Save"
                End If

                If sessionid = dbsessionid Then
                    'hdnuserid.Value = CType(userid, String)
                    LoadControl()
                    If Request.QueryString("serviceId") <> "" Then
                        GetData()
                    End If
                Else
                    Response.Redirect("/login")
                End If
            Else
                Response.Redirect("/login")
            End If

            'LoadControl()
            'If Request.QueryString("serviceId") <> "" Then
            '    GetServiceData()
            '    GetServicePackageData()
            '    GetServicePackageItemsData()
            'End If

        End If
    End Sub


    Protected Sub btnsave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnsave.Click
        'If btnsave.Text = "Update" Then
        '    Session("UPDATE") = "afterchange"
        'Else
        '    Session("UPDATE") = ""
        'End If

        SaveData()
    End Sub
    Public Sub GetData()
        If Request.QueryString("serviceId") <> "" Then
            GetServiceData()
            'Dim amount As String = Utility.StringData("Select PackagePrice From [dbo].[Services] Where ServiceId=" & Request.QueryString("serviceId") & "")
            'If amount <> txtPrice.Text Then
            'Else

            'If Session("UPDATE") = "" Then
            GetServicePackageData()
            GetServicePackageItemsData()
            'End If

            'End If

        End If
    End Sub

    Public Sub SaveData()
        Try
            Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")
            Dim serviceid = Request.QueryString("serviceid")

            Dim con As String
            Dim sData As String = "0"
            Dim sDataNew As String = "0"
            Dim nServiceId As Integer = 0
            Dim nServicePackageId As Integer = 0

            Dim bSuccess As Boolean = False
            con = ConfigurationManager.ConnectionStrings("ConnectionString").ToString
            Dim cn As SqlConnection = New SqlConnection(con)
            cn.Open()

            Dim insertSQL As String = ""
            Dim updateSQL As String = ""
            Dim nNewServiceId As Integer = 0
            Dim nNewServicePackageId As Integer = 0

            If Not String.IsNullOrEmpty(txtTitle.Text) And ddlGroup.SelectedValue <> "0" Then
                Try
                    If Not String.IsNullOrEmpty(serviceid) Then
                        updateSQL = "update Services Set Title = @Title, ArTitle = @ArTitle, ParentId = @ParentId, UpdatedBy = @UpdatedBy,  UpdatedAt = @UpdatedAt, PackagePrice = @PackagePrice   where ServiceId = @ServiceId "

                        Dim cmd2 As SqlCommand = New SqlCommand(updateSQL, cn)
                        cmd2.Parameters.Add("Title", SqlDbType.NVarChar).Value = txtTitle.Text
                        cmd2.Parameters.Add("ArTitle", SqlDbType.NVarChar).Value = txtArTitle.Text
                        cmd2.Parameters.Add("ParentId", Data.SqlDbType.BigInt).Value = If(ddlGroup.SelectedValue <> "", CInt(ddlGroup.SelectedValue), 0)
                        cmd2.Parameters.Add("UpdatedBy", SqlDbType.Int).Value = userID
                        cmd2.Parameters.Add("UpdatedAt", SqlDbType.DateTime).Value = DateTime.Now
                        cmd2.Parameters.Add("PackagePrice", Data.SqlDbType.Float).Value = If(txtPrice.Text <> "", CDec(txtPrice.Text), 0)
                        cmd2.Parameters.Add("ServiceId", SqlDbType.BigInt).Value = serviceid


                        cmd2.ExecuteNonQuery()
                        nServiceId = CInt(serviceid)
                        hdnPackageid.Value = nServiceId

                    Else

                        insertSQL = "INSERT into Services(Title, ArTitle, IsServiceGroup, Status, CreatedBy, CreatedAt, ParentId, RequiredMins, Tax, IsEnableCommission, IsPackage, PackagePrice)  values(@Title, @ArTitle, @IsServiceGroup, @Status, @CreatedBy, @CreatedAt, @ParentId, @RequiredMins, @Tax, @IsEnableCommission, @IsPackage, @PackagePrice)  SET @ServiceId = SCOPE_IDENTITY() "
                        Dim cmd2 As SqlCommand = New SqlCommand(insertSQL, cn)
                        cmd2.Parameters.Add("@ServiceId", Data.SqlDbType.Int).Direction = ParameterDirection.Output
                        cmd2.Parameters.Add("Title", SqlDbType.NVarChar).Value = txtTitle.Text
                        cmd2.Parameters.Add("ArTitle", SqlDbType.NVarChar).Value = txtArTitle.Text
                        cmd2.Parameters.Add("IsServiceGroup", SqlDbType.Bit).Value = False
                        cmd2.Parameters.Add("Status", SqlDbType.Bit).Value = True
                        cmd2.Parameters.Add("CreatedBy", SqlDbType.Int).Value = userID
                        cmd2.Parameters.Add("CreatedAt", SqlDbType.DateTime).Value = DateTime.Now
                        cmd2.Parameters.Add("ParentId", Data.SqlDbType.BigInt).Value = If(ddlGroup.SelectedValue <> "", CInt(ddlGroup.SelectedValue), 0)
                        cmd2.Parameters.Add("RequiredMins", SqlDbType.Int).Value = 0
                        cmd2.Parameters.Add("Tax", SqlDbType.Float).Value = 0
                        cmd2.Parameters.Add("IsEnableCommission", Data.SqlDbType.Bit).Value = False
                        cmd2.Parameters.Add("IsPackage", Data.SqlDbType.Bit).Value = True
                        cmd2.Parameters.Add("PackagePrice", Data.SqlDbType.Float).Value = If(txtPrice.Text <> "", CDec(txtPrice.Text), 0)

                        cmd2.ExecuteScalar()

                        nNewServiceId = CInt(cmd2.Parameters("@ServiceId").Value)

                        nServiceId = nNewServiceId

                        hdnPackageid.Value = ""
                        hdnPackageid.Value = nServiceId

                    End If
                Catch ex As Exception
                    MsgBox(ex.InnerException)
                End Try
            End If

            If nServiceId > 0 Then

                Try
                    Dim sqlString As String
                    Dim strConn = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                    Dim sqlConn As SqlConnection = New SqlConnection(strConn)
                    sqlConn.Open()
                    sqlString = "delete FROM ServicePackage where ServiceId = @ServiceId"
                    Dim sqlcomm As SqlCommand = New SqlCommand()
                    sqlcomm.CommandText = sqlString
                    sqlcomm.Connection = sqlConn
                    sqlcomm.CommandType = Data.CommandType.Text
                    sqlcomm.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = nServiceId
                    sqlcomm.ExecuteNonQuery()
                    sqlcomm.Parameters.Clear()
                    sqlcomm.Dispose()

                    sqlString = "insert into [ServicePackage] (ServiceId,AreaId, StartDate, EndDate, Status, IsBookFromWebsite, CreatedBy, CreatedAt) Values(@ServiceId, @AreaId, @StartDate, @EndDate, @Status, @IsBookFromWebsite, @CreatedBy, Getdate())  SET @ServicePackageId = SCOPE_IDENTITY() "
                    sqlcomm.CommandText = sqlString
                    sqlcomm.Connection = sqlConn
                    sqlcomm.CommandType = Data.CommandType.Text
                    sqlcomm.Parameters.Add("@ServicePackageId", Data.SqlDbType.Int).Direction = ParameterDirection.Output
                    sqlcomm.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = nServiceId
                    sqlcomm.Parameters.Add("AreaId", Data.SqlDbType.BigInt).Value = If(ddlLocation.SelectedValue <> "", CInt(ddlLocation.SelectedValue), 0)
                    sqlcomm.Parameters.Add("StartDate", Data.SqlDbType.DateTime).Value = If(txtstartDT.Text <> "", CDate(txtstartDT.Text), DateTime.Now)
                    sqlcomm.Parameters.Add("EndDate", Data.SqlDbType.DateTime).Value = If(txtEndDT.Text <> "", CDate(txtEndDT.Text), DateTime.Now)
                    sqlcomm.Parameters.Add("Status", Data.SqlDbType.NVarChar).Value = If(ddlStatus.SelectedValue <> "", ddlStatus.SelectedValue, "0")
                    sqlcomm.Parameters.Add("IsBookFromWebsite", Data.SqlDbType.NVarChar).Value = If(ddlBook.SelectedValue <> "", ddlBook.SelectedValue, "0")

                    sqlcomm.Parameters.Add("CreatedBy", Data.SqlDbType.Int).Value = userID
                    'sqlcomm.ExecuteNonQuery()

                    sqlcomm.ExecuteScalar()
                    nNewServicePackageId = CInt(sqlcomm.Parameters("@ServicePackageId").Value)
                    sqlcomm.Parameters.Clear()

                    sqlcomm.Dispose()
                    nServicePackageId = nNewServicePackageId

                    hdnServicPackageid.Value = ""
                    hdnServicPackageid.Value = nServicePackageId

                    sqlConn.Close()
                Catch ex As Exception
                    MsgBox(ex.InnerException)
                End Try

                Try

                    Dim listProduct As New List(Of ServiceItemModel)()

                    If gvSkuPrice.Rows.Count > 0 Then
                        For Each row As GridViewRow In gvSkuPrice.Rows
                            Dim item = New ServiceItemModel()

                            Dim txtQty As TextBox = CType(row.FindControl("posku"), TextBox)
                            Dim ItemValue As TextBox = CType(row.FindControl("txtTotal"), TextBox)
                            Dim txtDescription As TextBox = CType(row.FindControl("txtDescription"), TextBox)
                            Dim txtSalesPrice As TextBox = CType(row.FindControl("txtSalesPrice"), TextBox)

                            item.PricePerItem = Convert.ToDecimal(txtSalesPrice.Text)

                            item.ShortDescription = txtDescription.Text
                            item.Qty = Convert.ToDecimal(txtQty.Text)

                            Dim itemTotal As Decimal = Convert.ToDecimal(txtSalesPrice.Text) * CDec(item.Qty)
                            item.ItemTotal = itemTotal

                            Dim uID As HiddenField = CType(row.FindControl("hdServiceId"), HiddenField)
                            Dim hdServiceid As Integer = 0
                            Dim ddlService As DropDownList = CType(row.FindControl("ddlGroup"), DropDownList)
                            hdServiceid = CInt(ddlService.SelectedValue)
                            'Dim ServicePackageId As Integer = Utility.IntegerData("Select TOP(1) ServicePackageId From [dbo].[ServicePackage] Where ServiceId = " & hdServiceid & " Order By ServicePackageId DESC")
                            uID.Value = hdServiceid
                            item.ServiceId = hdServiceid

                            listProduct.Add(item)

                        Next
                    End If

                    If Not listProduct Is Nothing Then
                        Dim sqlString As String
                        Dim strConn = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                        Dim sqlConn As SqlConnection = New SqlConnection(strConn)
                        sqlConn.Open()
                        sqlString = "delete FROM ServicePackageItems where PackageId = @PackageId"
                        Dim sqlcomm As SqlCommand = New SqlCommand()
                        sqlcomm.CommandText = sqlString
                        sqlcomm.Connection = sqlConn
                        sqlcomm.CommandType = Data.CommandType.Text
                        sqlcomm.Parameters.Add("PackageId", Data.SqlDbType.BigInt).Value = nServicePackageId
                        sqlcomm.ExecuteNonQuery()
                        sqlcomm.Parameters.Clear()
                        sqlcomm.Dispose()

                        If listProduct.Count > 0 Then
                            For Each item As ServiceItemModel In listProduct
                                If Not String.IsNullOrEmpty(item.ServiceId) Then
                                    Try
                                        sqlString = "insert into [ServicePackageItems] (PackageId, ServiceId,ShortDescription, PricePerItem, Qty, CreatedBy, CreatedAt) Values(@PackageId, @ServiceId, @ShortDescription, @PricePerItem, @Qty, @CreatedBy, Getdate())"
                                        sqlcomm.CommandText = sqlString
                                        sqlcomm.Connection = sqlConn
                                        sqlcomm.CommandType = Data.CommandType.Text
                                        sqlcomm.Parameters.Add("PackageId", Data.SqlDbType.BigInt).Value = nServicePackageId
                                        sqlcomm.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = item.ServiceId
                                        sqlcomm.Parameters.Add("ShortDescription", Data.SqlDbType.NVarChar).Value = item.ShortDescription
                                        sqlcomm.Parameters.Add("PricePerItem", Data.SqlDbType.Float).Value = item.PricePerItem
                                        sqlcomm.Parameters.Add("Qty", Data.SqlDbType.Int).Value = item.Qty
                                        sqlcomm.Parameters.Add("CreatedBy", Data.SqlDbType.Int).Value = userID
                                        sqlcomm.ExecuteNonQuery()
                                        sqlcomm.Parameters.Clear()
                                        sqlcomm.Dispose()

                                    Catch ex As Exception

                                    End Try
                                End If
                            Next
                        End If

                        sqlConn.Close()

                    End If


                Catch ex As Exception

                End Try

                Try
                    Dim sqlString As String
                    Dim strConn = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                    Dim sqlConn As SqlConnection = New SqlConnection(strConn)
                    sqlConn.Open()
                    sqlString = "delete FROM ServiceRates where ServiceId = @ServiceId"
                    Dim sqlcomm As SqlCommand = New SqlCommand()
                    sqlcomm.CommandText = sqlString
                    sqlcomm.Connection = sqlConn
                    sqlcomm.CommandType = Data.CommandType.Text
                    sqlcomm.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = nServiceId
                    sqlcomm.ExecuteNonQuery()
                    sqlcomm.Parameters.Clear()
                    sqlcomm.Dispose()

                    sqlString = "insert into [ServiceRates] (ServiceId,RetailPrice, SpecialPrice, CreatedBy, CreatedAt) Values(@ServiceId,@RetailPrice, @SpecialPrice, @CreatedBy, Getdate())"
                    sqlcomm.CommandText = sqlString
                    sqlcomm.Connection = sqlConn
                    sqlcomm.CommandType = Data.CommandType.Text
                    sqlcomm.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = nServiceId
                    sqlcomm.Parameters.Add("RetailPrice", Data.SqlDbType.Float).Value = If(txtPrice.Text <> "", CDec(txtPrice.Text), 0)
                    sqlcomm.Parameters.Add("SpecialPrice", Data.SqlDbType.Float).Value = If(txtPrice.Text <> "", CDec(txtPrice.Text), 0)
                    sqlcomm.Parameters.Add("CreatedBy", Data.SqlDbType.Int).Value = userID
                    sqlcomm.ExecuteNonQuery()
                    sqlcomm.Parameters.Clear()
                    sqlcomm.Dispose()

                    sqlConn.Close()
                Catch ex As Exception
                    MsgBox(ex.InnerException)
                End Try

                If ddlLocation.SelectedValue <> "" And ddlLocation.SelectedValue <> "0" Then
                    Try
                        Dim sqlString As String
                        Dim strConn = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                        Dim sqlConn As SqlConnection = New SqlConnection(strConn)
                        sqlConn.Open()
                        sqlString = "delete FROM ServiceLocations where ServiceId = @ServiceId"
                        Dim sqlcomm As SqlCommand = New SqlCommand()
                        sqlcomm.CommandText = sqlString
                        sqlcomm.Connection = sqlConn
                        sqlcomm.CommandType = Data.CommandType.Text
                        sqlcomm.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = nServiceId
                        sqlcomm.ExecuteNonQuery()
                        sqlcomm.Parameters.Clear()
                        sqlcomm.Dispose()

                        sqlString = "insert into [ServiceLocations] (ServiceId,AreaId, CreatedBy, CreatedAt) Values(@ServiceId,@AreaId, @CreatedBy, Getdate())"
                        sqlcomm.CommandText = sqlString
                        sqlcomm.Connection = sqlConn
                        sqlcomm.CommandType = Data.CommandType.Text
                        sqlcomm.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = nServiceId
                        sqlcomm.Parameters.Add("AreaId", Data.SqlDbType.BigInt).Value = If(ddlLocation.SelectedValue <> "", CInt(ddlGroup.SelectedValue), 0)
                        sqlcomm.Parameters.Add("CreatedBy", Data.SqlDbType.Int).Value = userID
                        sqlcomm.ExecuteNonQuery()
                        sqlcomm.Parameters.Clear()
                        sqlcomm.Dispose()


                        sqlConn.Close()
                    Catch ex As Exception

                    End Try

                End If

            End If


            cn.Close()

            ClientScript.RegisterStartupScript(Me.GetType, "Load", "<script type='text/javascript'>window.parent.location.href = '/packages'; </script>")

        Catch ex As Exception

        End Try

    End Sub

    Public Sub GetServiceData()
        Dim serviceid = 0
        If Request.QueryString("serviceid") <> "" Then
            serviceid = CInt(Request.QueryString("serviceid"))

            If serviceid > 0 Then

                Using conn As New SqlConnection()
                    conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                    Using cmd As New SqlCommand()
                        cmd.CommandText = "SELECT * FROM [Services] Where ServiceId=@ServiceId"
                        cmd.Parameters.Clear()
                        cmd.Parameters.Add("@ServiceId", Data.SqlDbType.Int).Value = serviceid
                        cmd.Connection = conn
                        conn.Open()
                        Using reader As SqlDataReader = cmd.ExecuteReader()
                            If reader.HasRows Then
                                While reader.Read()
                                    hdnPackageid.Value = reader("ServiceId").ToString()
                                    txtTitle.Text = If(reader("Title") Is DBNull.Value, "", reader("Title").ToString())
                                    txtArTitle.Text = If(reader("ArTitle") Is DBNull.Value, "", reader("ArTitle").ToString())
                                    txtPrice.Text = If(reader("PackagePrice") Is DBNull.Value, "", reader("PackagePrice").ToString())
                                    ddlGroup.SelectedValue = If(reader("ParentId") Is DBNull.Value, "0", reader("ParentId").ToString())
                                End While
                            End If

                            reader.Close()
                        End Using
                        conn.Close()
                    End Using
                End Using

            End If



        End If
    End Sub

    Public Sub GetServicePackageData()
        Dim serviceid = 0
        If Request.QueryString("serviceid") <> "" Then
            serviceid = CInt(Request.QueryString("serviceid"))

            If serviceid > 0 Then

                Using conn As New SqlConnection()
                    conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                    Using cmd As New SqlCommand()
                        cmd.CommandText = "SELECT * FROM [ServicePackage] Where ServiceId=@ServiceId"
                        cmd.Parameters.Clear()
                        cmd.Parameters.Add("@ServiceId", Data.SqlDbType.Int).Value = serviceid
                        cmd.Connection = conn
                        conn.Open()
                        Using reader As SqlDataReader = cmd.ExecuteReader()
                            If reader.HasRows Then
                                While reader.Read()
                                    hdnServicPackageid.Value = reader("ServicePackageId").ToString()
                                    ddlLocation.SelectedValue = If(reader("AreaId") Is DBNull.Value, "0", reader("AreaId").ToString())
                                    ddlBook.SelectedValue = If(reader("IsBookFromWebsite") Is DBNull.Value, "0", reader("IsBookFromWebsite").ToString())
                                    ddlStatus.SelectedValue = If(reader("Status") Is DBNull.Value, "0", reader("Status").ToString())

                                    Dim strtdate = If(reader("StartDate") Is DBNull.Value, DateTime.Now, CDate(reader("StartDate")))
                                    Dim enddate = If(reader("EndDate") Is DBNull.Value, DateTime.Now, CDate(reader("EndDate")))
                                    txtstartDT.Text = Utility.Dayformat(strtdate).ToString()
                                    txtEndDT.Text = Utility.Dayformat(enddate).ToString()
                                End While
                            End If

                            reader.Close()
                        End Using
                        conn.Close()
                    End Using
                End Using
            End If
        End If
    End Sub

    Public Sub GetServicePackageItemsData()
        Dim serviceid = 0
        Dim servicepackageid = 0
        Dim listProduct As New List(Of ServiceItemModel)()
        gvSkuPrice.DataSource = Nothing
        gvSkuPrice.DataBind()

        If Request.QueryString("serviceid") <> "" Then
            'serviceid = CInt(Request.QueryString("serviceid"))
            servicepackageid = If(hdnServicPackageid.Value <> "", CInt(hdnServicPackageid.Value), 0)
            If servicepackageid > 0 Then

                Using conn As New SqlConnection()
                    conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                    Using cmd As New SqlCommand()
                        cmd.CommandText = "SELECT * FROM [ServicePackageItems] Where PackageId=@PackageId"
                        cmd.Parameters.Clear()
                        cmd.Parameters.Add("@PackageId", Data.SqlDbType.Int).Value = servicepackageid
                        cmd.Connection = conn
                        conn.Open()
                        Using reader As SqlDataReader = cmd.ExecuteReader()
                            If reader.HasRows Then
                                While reader.Read()

                                    Dim item = New ServiceItemModel()

                                    item.PricePerItem = If(reader("PricePerItem") Is DBNull.Value, 0, CDec(reader("PricePerItem")))

                                    item.ShortDescription = If(reader("ShortDescription") Is DBNull.Value, "", reader("ShortDescription").ToString())
                                    item.Qty = If(reader("Qty") Is DBNull.Value, 0, CDec(reader("Qty")))

                                    Dim itemTotal As Decimal = Convert.ToDecimal(item.PricePerItem) * CDec(item.Qty)
                                    item.ItemTotal = itemTotal
                                    item.ServiceId = If(reader("ServiceId") Is DBNull.Value, "0", reader("ServiceId"))

                                    listProduct.Add(item)

                                End While
                            End If

                            reader.Close()
                        End Using
                        conn.Close()
                    End Using
                End Using

            End If

            Dim dt As List(Of ServiceItemModel) = listProduct
            If Not dt Is Nothing Then
                If dt.Count > 0 Then
                    Dim totalShow As Decimal = 0

                    For Each dd As ServiceItemModel In dt
                        totalShow += Convert.ToDecimal(dd.ItemTotal)
                    Next

                    txtPrice.Text = totalShow.ToString("F")

                    gvSkuPrice.DataSource = dt
                    gvSkuPrice.DataBind()
                End If



            End If

        End If
    End Sub

    Private Sub LoadControl()

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Try
            Dim selectString = "SELECT * FROM Areas "
            Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
            ddlLocation.Items.Clear()
            ddlLocation.Items.Add(New ListItem("None", "0"))
            Dim objReaderb As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
            If objReaderb.HasRows Then
                While objReaderb.Read()
                    ddlLocation.Items.Add(New ListItem(objReaderb("AreaName"), objReaderb("AreaId").ToString()))
                End While
            End If

            ddlLocation.SelectedValue = "0"
            objReaderb.Close()

        Catch ex As Exception

        End Try

        Try
            'Dim level = GetPackageLevel(Request.QueryString("serviceId"))
            'Dim selectString = "SELECT * FROM appointment.vw_Package_Lists Where  ServiceId !=" + Request.QueryString("serviceId") + "  AND ParentId!=" + Request.QueryString("serviceId") + " AND [Level]<3"
            Dim selectString = "select * from [dbo].[Services] Where IsPackage=1 And status = 1 And ParentId = 0"
            Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
            ddlGroup.Items.Clear()
            ddlGroup.Items.Add(New ListItem("Select Service Group", "0"))

            Dim objReaderb As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()

            If objReaderb.HasRows Then
                While objReaderb.Read()
                    ddlGroup.Items.Add(New ListItem(objReaderb("Title"), objReaderb("ServiceId").ToString()))
                End While
            End If

            ddlGroup.SelectedValue = "0"
            objReaderb.Close()

        Catch ex As Exception
            'Response.Write(ex)
        End Try
        conn.Close()

    End Sub

    Private Function GetPackageLevel(queryString As String) As Integer

        Dim level = 0
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Try
            Dim selectString = "SELECT * FROM appointment.vw_Package_Lists WHERE ServiceID=" + queryString
            Dim cmd As SqlCommand = New SqlCommand(selectString, conn)

            Dim objReaderb As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
            If objReaderb.HasRows Then
                While objReaderb.Read()
                    Integer.TryParse(objReaderb("Level").ToString(), level)
                End While
            End If
            objReaderb.Close()
        Catch ex As Exception
        End Try
        conn.Close()

        Return level
    End Function

    Protected Sub btndelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btndelete.Click
        If Request.QueryString("serviceid") <> "" Then
            DeleteData()
        End If

        ClientScript.RegisterStartupScript(Me.GetType, "Load", "<script type='text/javascript'>window.parent.location.href = '/packages'; </script>")

    End Sub

    Public Sub DeleteData()
        If Request.QueryString("serviceid") <> "" Then
            If Not String.IsNullOrEmpty(Request.QueryString("serviceid")) Then
                Dim sql As String = ""
                Dim sql1 As String = ""
                Dim sql2 As String = ""
                Dim sql4 As String = ""
                Dim selectString As String = ""
                Dim nServiceId As Integer = 0
                nServiceId = Request.QueryString("serviceid")
                Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
                conn.Open()

                sql = "DELETE FROM [ServicePackageItems] WHERE [PackageId] = @PackageId"
                Dim cmd1 As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(sql, conn)
                cmd1.CommandText = sql
                cmd1.Parameters.Add("PackageId", Data.SqlDbType.BigInt).Value = nServiceId
                cmd1.ExecuteNonQuery()

                sql1 = "DELETE FROM [ServicePackage] WHERE [ServiceId] = @ServiceId"
                Dim cmd2 As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(sql1, conn)
                cmd2.CommandText = sql1
                cmd2.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = nServiceId
                cmd2.ExecuteNonQuery()

                sql2 = "DELETE FROM [ServiceLocations] WHERE [ServiceId] = @ServiceId"
                Dim cmd3 As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(sql2, conn)
                cmd3.CommandText = sql2
                cmd3.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = nServiceId
                cmd3.ExecuteNonQuery()

                sql4 = "DELETE FROM [ServiceRates] WHERE [ServiceId] = @ServiceId"
                Dim cmd4 As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(sql4, conn)
                cmd4.CommandText = sql4
                cmd4.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = nServiceId
                cmd4.ExecuteNonQuery()

                Dim countItems As Integer = Utility.IntegerData("Select Count(PackageId) FROM [ServicePackageItems] WHERE [PackageId] = " & nServiceId.ToString() & "")
                Dim countservice As Integer = Utility.IntegerData("Select Count(ServiceId) FROM [ServicePackage] WHERE [ServiceId] = " & nServiceId.ToString() & "")
                Dim countlocation As Integer = Utility.IntegerData("Select Count(ServiceId) FROM [ServiceLocations] WHERE [ServiceId] = " & nServiceId.ToString() & "")
                Dim countRates As Integer = Utility.IntegerData("Select Count(ServiceId) FROM [ServiceRates] WHERE [ServiceId] = " & nServiceId.ToString() & "")

                If countservice = 0 And countItems = 0 Then
                    Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
                    selectString = "DELETE FROM [Services] Where ServiceId=@ServiceId And IsPackage = 1 "
                    cmd.CommandText = selectString
                    cmd.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = nServiceId
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

    Protected Sub gvSkuPrice_RowEditing(ByVal sender As Object, ByVal e As GridViewEditEventArgs)
        gvSkuPrice.EditIndex = e.NewEditIndex
        ' GetServicePackageItemsData()
    End Sub

    Protected Sub gvSkuPrice_RowCancelingEdit(ByVal sender As Object, ByVal e As GridViewCancelEditEventArgs)
        gvSkuPrice.EditIndex = -1
        ' GetServicePackageItemsData()
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        Try
            Dim message As String = ""
            If txtTitle.Text <> "" And txtstartDT.Text <> "" And txtEndDT.Text <> "" And ddlGroup.SelectedValue <> "0" Then
                Dim listProduct As New List(Of ServiceItemModel)()
                Dim listNewProduct As New List(Of ServiceItemModel)()

                Dim itemNew = New ServiceItemModel()
                itemNew.PricePerItem = 0
                itemNew.ShortDescription = ""
                itemNew.Qty = 0
                itemNew.ItemTotal = 0

                If gvSkuPrice.Rows.Count > 0 Then
                    For Each row As GridViewRow In gvSkuPrice.Rows
                        Dim item = New ServiceItemModel()

                        Dim txtQty As TextBox = CType(row.FindControl("posku"), TextBox)
                        Dim ItemValue As TextBox = CType(row.FindControl("txtTotal"), TextBox)
                        Dim txtDescription As TextBox = CType(row.FindControl("txtDescription"), TextBox)
                        Dim txtSalesPrice As TextBox = CType(row.FindControl("txtSalesPrice"), TextBox)

                        item.ShortDescription = txtDescription.Text
                        item.Qty = Convert.ToDecimal(txtQty.Text)

                        Dim itemTotal As Decimal = Convert.ToDecimal(txtSalesPrice.Text) * CDec(item.Qty)
                        item.ItemTotal = itemTotal

                        Dim uID As HiddenField = CType(row.FindControl("hdServiceId"), HiddenField)
                        Dim hdServiceid As Integer = 0
                        Dim ddlService As DropDownList = CType(row.FindControl("ddlGroup"), DropDownList)
                        hdServiceid = CInt(ddlService.SelectedValue)
                        uID.Value = hdServiceid
                        item.ServiceId = hdServiceid

                        Dim price As String = Utility.StringData("Select top 1 isnull(RetailPrice,0) RetailPrice FROM [ServiceRates] WHERE [ServiceId] = " & hdServiceid.ToString() & "")
                        If price <> "0" Then
                            txtSalesPrice.Text = price
                        End If
                        item.PricePerItem = Convert.ToDecimal(txtSalesPrice.Text)

                        listProduct.Add(item)

                    Next
                End If

                listProduct.Add(itemNew)


                Dim dt As List(Of ServiceItemModel) = listProduct

                If dt.Count > 0 Then
                    Dim totalShow As Decimal = 0

                    For Each dd As ServiceItemModel In dt
                        totalShow += Convert.ToDecimal(dd.ItemTotal)
                    Next

                    txtPrice.Text = totalShow.ToString("F")
                End If


                gvSkuPrice.DataSource = dt
                gvSkuPrice.DataBind()
            Else
                If txtTitle.Text = "" Then
                    message = "Title is Empty."
                ElseIf txtstartDT.Text = "" Then
                    message = "Please Select Start Date."
                ElseIf txtEndDT.Text = "" Then
                    message = "Please Select End Date."
                ElseIf ddlGroup.SelectedValue = "0" Then
                    message = "Please Select Parent Package."
                Else
                    message = "Something went wrong. Please Check the Form."
                End If

                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), Title, "alert('" + message + "');", True)
            End If

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub OnRowDeleting(ByVal sender As Object, ByVal e As GridViewDeleteEventArgs)
        Dim listProduct As New List(Of ServiceItemModel)()

        If gvSkuPrice.Rows.Count > 0 Then
            For Each row As GridViewRow In gvSkuPrice.Rows
                Dim item = New ServiceItemModel()

                Dim txtQty As TextBox = CType(row.FindControl("posku"), TextBox)
                Dim ItemValue As TextBox = CType(row.FindControl("txtTotal"), TextBox)
                Dim txtDescription As TextBox = CType(row.FindControl("txtDescription"), TextBox)
                Dim txtSalesPrice As TextBox = CType(row.FindControl("txtSalesPrice"), TextBox)

                item.PricePerItem = Convert.ToDecimal(txtSalesPrice.Text)
                item.ShortDescription = txtDescription.Text
                item.Qty = Convert.ToDecimal(txtQty.Text)

                Dim itemTotal As Decimal = Convert.ToDecimal(txtSalesPrice.Text) * CDec(item.Qty)
                item.ItemTotal = itemTotal

                Dim uID As HiddenField = CType(row.FindControl("hdServiceId"), HiddenField)
                Dim hdServiceid As Integer = 0
                Dim ddlService As DropDownList = CType(row.FindControl("ddlGroup"), DropDownList)
                hdServiceid = CInt(ddlService.SelectedValue)
                uID.Value = hdServiceid
                item.ServiceId = hdServiceid

                listProduct.Add(item)

            Next

            Dim index As Integer = Convert.ToInt32(e.RowIndex)
            Dim dt As List(Of ServiceItemModel) = listProduct
            dt.RemoveAt(index)

            If dt.Count > 0 Then
                Dim totalShow As Decimal = 0

                For Each dd As ServiceItemModel In dt
                    totalShow += Convert.ToDecimal(dd.ItemTotal)
                Next

                txtPrice.Text = totalShow.ToString("F")
            End If


            gvSkuPrice.DataSource = dt
            gvSkuPrice.DataBind()

        End If

    End Sub

    Protected Sub ddlGroup_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)

        Try

            Dim ddlService As DropDownList = CType(sender, DropDownList)
            Dim gvRow As GridViewRow = CType(ddlService.NamingContainer, GridViewRow)
            Dim txtSalesPrice As TextBox = CType(gvRow.FindControl("txtSalesPrice"), TextBox)
            Dim nServiceId As Integer = CInt(ddlService.SelectedValue)
            Dim price As String = Utility.StringData("Select top 1 isnull(RetailPrice,0) RetailPrice FROM [ServiceRates] WHERE [ServiceId] = " & nServiceId.ToString() & "")
            If price <> "0" Then
                txtSalesPrice.Text = price
            End If

        Catch ex As Exception

        End Try

    End Sub
    Protected Sub gvSkuPrice_RowUpdating(ByVal sender As Object, ByVal e As GridViewUpdateEventArgs)
        'Dim gvr As GridViewRow = gvSkuPrice.Rows(e.RowIndex)
        'Dim str As String = gvSkuPrice.DataKeys(gvr.RowIndex).Value.ToString()
        'Dim id As Integer = Convert.ToInt32(str)
        'Dim editName As String = (CType(gvSkuPrice.Rows(e.RowIndex).FindControl("txtEditName"), TextBox)).Text
        'Dim editMobile As String = (CType(gvSkuPrice.Rows(e.RowIndex).FindControl("txtEditMobile"), TextBox)).Text
        'Dim editAge As String = (CType(gvSkuPrice.Rows(e.RowIndex).FindControl("txtEditAge"), TextBox)).Text
        Try
            Dim txtSalesPrice As TextBox = CType(gvSkuPrice.Rows(e.RowIndex).FindControl("txtSalesPrice"), TextBox)
            Dim txtQty As TextBox = CType(gvSkuPrice.Rows(e.RowIndex).FindControl("posku"), TextBox)
            Dim ddlService As DropDownList = CType(gvSkuPrice.Rows(e.RowIndex).FindControl("ddlGroup"), DropDownList)
            Dim ItemValue As TextBox = CType(gvSkuPrice.Rows(e.RowIndex).FindControl("txtTotal"), TextBox)

            Dim nServiceId As Integer = CInt(ddlService.SelectedValue)
            Dim price As String = Utility.StringData("Select top 1 isnull(RetailPrice,0) RetailPrice FROM [ServiceRates] WHERE [ServiceId] = " & nServiceId.ToString() & "")
            If price <> "0" Then
                txtSalesPrice.Text = price
            End If

            Dim itemTotal As Decimal = Convert.ToDecimal(txtQty.Text) * CDec(txtSalesPrice.Text)
            ItemValue.Text = itemTotal

        Catch ex As Exception

        End Try

    End Sub
    Protected Sub gvSkuPrice_DataBound(ByVal sender As Object, ByVal e As EventArgs)
        For Each gvRow As GridViewRow In gvSkuPrice.Rows
            Dim ddlGroup As DropDownList = TryCast(gvRow.FindControl("ddlGroup"), DropDownList)
            Dim hdServiceId As HiddenField = TryCast(gvRow.FindControl("hdServiceId"), HiddenField)
            Dim txtSalesPrice As TextBox = CType(gvRow.FindControl("txtSalesPrice"), TextBox)
            Dim ItemValue As TextBox = CType(gvRow.FindControl("txtTotal"), TextBox)
            Dim txtQty As TextBox = CType(gvRow.FindControl("posku"), TextBox)

            If Not ddlGroup Is Nothing AndAlso Not hdServiceId Is Nothing Then
                ddlGroup.SelectedValue = hdServiceId.Value

                'Dim price As String = Utility.StringData("Select top 1 isnull(RetailPrice,0) RetailPrice FROM [ServiceRates] WHERE [ServiceId] = " & hdServiceId.Value.ToString() & "")
                'If price <> "0" Then
                '    txtSalesPrice.Text = price
                'End If
                'Dim itemTotal As Decimal = Convert.ToDecimal(txtQty.Text) * CDec(txtSalesPrice.Text)
                'ItemValue.Text = itemTotal

            End If
        Next
    End Sub
    Protected Sub gvSkuPrice_RowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs)
        If gvSkuPrice.EditIndex = e.Row.RowIndex AndAlso e.Row.RowType = DataControlRowType.DataRow Then

            Try
                Dim txtSalesPrice As TextBox = CType(e.Row.FindControl("txtSalesPrice"), TextBox)
                Dim ddlService As DropDownList = CType(e.Row.FindControl("ddlGroup"), DropDownList)
                Dim txtQty As TextBox = CType(e.Row.FindControl("posku"), TextBox)
                Dim ItemValue As TextBox = CType(e.Row.FindControl("txtTotal"), TextBox)

                Dim nServiceId As Integer = CInt(ddlService.SelectedValue)
                Dim price As String = Utility.StringData("Select top 1 isnull(RetailPrice,0) RetailPrice FROM [ServiceRates] WHERE [ServiceId] = " & nServiceId.ToString() & "")
                If price <> "0" Then
                    txtSalesPrice.Text = price
                End If
                Dim itemTotal As Decimal = Convert.ToDecimal(txtQty.Text) * CDec(txtSalesPrice.Text)
                ItemValue.Text = itemTotal

            Catch ex As Exception

            End Try
        End If
    End Sub
    Protected Sub gvSkuPrice_RowCreated(ByVal sender As Object, ByVal e As GridViewRowEventArgs)
        Dim tbSalesPrice As TextBox = CType(e.Row.FindControl("txtSalesPrice"), TextBox)
        Dim tb2 As TextBox = CType(e.Row.FindControl("posku"), TextBox)
        Dim i As Integer = e.Row.RowIndex
        Dim tbCostPrice As String = ""
        Dim tbQty As String = ""
        Dim tbRowTotal As String = ""
        Dim tbHDQtyPerCase As String = ""
        Dim tbtxtCASEQtyID As String = ""
        Dim tbTotalQtyPcs As String = ""
        Dim tbCurrentStock As String = ""

        tbCostPrice = String.Format("txtSalesPrice", e.Row.RowIndex)
        tbQty = String.Format("posku", e.Row.RowIndex)
        tbRowTotal = String.Format("txtTotal", e.Row.RowIndex)

        If i <= 6 Then

            tbCostPrice = String.Format("gvSkuPrice_ctl0{0}_txtSalesPrice", e.Row.RowIndex + 3)
            tbQty = String.Format("gvSkuPrice_ctl0{0}_posku", e.Row.RowIndex + 3)
            tbRowTotal = String.Format("gvSkuPrice_ctl0{0}_txtTotal", e.Row.RowIndex + 3)

        Else

            tbCostPrice = String.Format("gvSkuPrice_ctl{0}_txtSalesPrice", e.Row.RowIndex + 3)
            tbQty = String.Format("gvSkuPrice_ctl{0}_posku", e.Row.RowIndex + 3)
            tbRowTotal = String.Format("gvSkuPrice_ctl{0}_txtTotal", e.Row.RowIndex + 3)

        End If


        If Not tb2 Is Nothing Then
            tb2.Text = "1"
            tb2.Attributes.Add("onBlur", ("changeMe('" & (tbCostPrice & ("','" & (tbQty & ("','" & (tbRowTotal & "')")))))))
        End If

        If Not tbSalesPrice Is Nothing Then
            tbSalesPrice.Attributes.Add("onBlur", ("changeMe('" & (tbCostPrice & ("','" & (tbQty & ("','" & (tbRowTotal & "')")))))))
        End If


    End Sub


End Class
