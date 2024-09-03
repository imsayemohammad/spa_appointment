
Imports System.Activities.Statements
Imports System.Data
Imports System.Data.SqlClient

Partial Class AllServices
    Inherits System.Web.UI.Page
    Dim userid As Integer = 0
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'If Not String.IsNullOrEmpty(System.Web.HttpContext.Current.Session.SessionID) Then
        '    userid = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By LogId DESC")

        Dim sessionid As String = System.Web.HttpContext.Current.Session.SessionID
        Dim dbsessionid As String = Utility.StringData("Select TOP 1 SessionId From UserLog_Data Where UserId =" & userid & "")
        '    lvService

        '           Else 
        '            Response.Redirect("/login")
        '        End If

        If Not Page.IsPostBack Then
            LoadControl()
            LoadTableData()
            LoadServices()
        End If
    End Sub

    Private Sub LoadTableData()

    End Sub

    Private Sub LoadControl()

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Try
            'Dim selectString = "Select * FROM Services where IsServiceGroup = 1 And status = 1 And ParentId = 0 order by Title asc "
            Dim selectString = "Select * FROM Services where IsServiceGroup = 1 And status = 1 And ParentId <> 0 order by Title asc "
            Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
            ddlGroup.Items.Clear()
            ddlGroup.Items.Add(New ListItem("Select Service Group", "0"))

            Dim objReaderb As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()

            If objReaderb.HasRows Then
                While objReaderb.Read()
                    ddlGroup.Items.Add(New ListItem(objReaderb("Title"), objReaderb("ServiceId").ToString()))
                    Dim selectChild = "Select * FROM Services where IsServiceGroup = 1 And status = 1  And ParentId = " & objReaderb("ServiceId").ToString() & " order by Title asc "
                    Dim cmdChild As SqlCommand = New SqlCommand(selectChild, conn)
                    Dim objReaderChild As Data.SqlClient.SqlDataReader = cmdChild.ExecuteReader()

                    If objReaderChild.HasRows Then
                        While objReaderChild.Read()
                            ddlGroup.Items.Add(New ListItem(objReaderb("Title") & "-->" & objReaderChild("Title"), objReaderChild("ServiceId").ToString()))
                            Dim selectChildChild = "Select * FROM Services where IsServiceGroup = 1 And status = 1  And ParentId = " & objReaderChild("ServiceId").ToString() & " order by Title asc "
                            Dim cmdChildChild As SqlCommand = New SqlCommand(selectChildChild, conn)
                            Dim objReaderChildChild As Data.SqlClient.SqlDataReader = cmdChildChild.ExecuteReader()

                            'If objReaderChildChild.HasRows Then
                            '    While objReaderChildChild.Read()
                            '        ddlGroup.Items.Add(New ListItem(objReaderb("Title") & "-->" & objReaderChild("Title") & "-->" & objReaderChildChild("Title"), objReaderChildChild("ServiceId").ToString()))
                            '    End While
                            'End If
                        End While
                    End If
                End While
            End If
            objReaderb.Close()
            ddlGroup.SelectedValue = "0"
        Catch ex As Exception

        End Try

        'Try
        '    'Dim selectString = "SELECT * FROM VW_ServiceGroup  order by ServiceId"
        '    Dim selectString = "Select * FROM Services where IsServiceGroup = 1 And status = 1 And ParentId = 0 And IsPackage = 0  order by Title asc "
        '    Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        '    ddlGroup.Items.Clear()
        '    ddlGroup.Items.Add(New ListItem("Select Service Group", "0"))

        '    Dim objReaderb As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()

        '    If objReaderb.HasRows Then
        '        While objReaderb.Read()
        '            ddlGroup.Items.Add(New ListItem(objReaderb("Title"), objReaderb("ServiceId").ToString()))
        '            Dim selectChild = "Select * FROM Services where IsServiceGroup = 1 And status = 1 And IsPackage = 0 And ParentId = " & objReaderb("ServiceId").ToString() & " order by Title asc "
        '            Dim cmdChild As SqlCommand = New SqlCommand(selectChild, conn)
        '            Dim objReaderChild As Data.SqlClient.SqlDataReader = cmdChild.ExecuteReader()

        '            If objReaderChild.HasRows Then
        '                While objReaderChild.Read()
        '                    ddlGroup.Items.Add(New ListItem(objReaderChild("Title"), objReaderChild("ServiceId").ToString()))
        '                    Dim selectChildChild = "Select * FROM Services where IsServiceGroup = 1 And status = 1 And IsPackage = 0 And ParentId = " & objReaderChild("ServiceId").ToString() & " order by Title asc "
        '                    Dim cmdChildChild As SqlCommand = New SqlCommand(selectChildChild, conn)
        '                    Dim objReaderChildChild As Data.SqlClient.SqlDataReader = cmdChildChild.ExecuteReader()

        '                    If objReaderChildChild.HasRows Then
        '                        While objReaderChildChild.Read()
        '                            ddlGroup.Items.Add(New ListItem(objReaderChildChild("Title"), objReaderChildChild("ServiceId").ToString()))
        '                        End While
        '                    End If
        '                End While
        '            End If
        '        End While
        '    End If
        '    ddlGroup.SelectedValue = "0"
        '    objReaderb.Close()

        'Catch ex As Exception

        'End Try

        Try

            Dim selectString = "SELECT * FROM ServiceDuration "
            Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
            ddlServiceDuration.Items.Clear()
            ddlServiceDuration.Items.Add(New ListItem("None", "0"))

            ddlExtraDuration.Items.Clear()
            ddlExtraDuration.Items.Add(New ListItem("None", "0"))

            Dim objReaderb As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()

            If objReaderb.HasRows Then
                While objReaderb.Read()
                    ddlServiceDuration.Items.Add(New ListItem(objReaderb("Title"), objReaderb("Duration").ToString()))
                    ddlExtraDuration.Items.Add(New ListItem(objReaderb("Title"), objReaderb("Duration").ToString()))
                End While
            End If

            ddlServiceDuration.SelectedValue = "0"
            ddlExtraDuration.SelectedValue = "0"

            objReaderb.Close()


        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        conn.Close()

    End Sub
    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        Try
            If txtSearch.Text.Trim.Length > 0 Then
                LoadServices(txtSearch.Text.Trim)
            End If
        Catch ex As Exception

        End Try

    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Sub SaveData(ByVal ServiceId As String, ByVal Title As String, ByVal ParentId As String, ByVal PriceType As String, ByVal RetailPrice As String, ByVal SpecialPrice As String, ByVal EnableCommission As String, ByVal ServiceDuration As String, ByVal ExtraType As String, ByVal ExtraDuration As String, ByVal Gender As String, ByVal Tax As String, ByVal ProductCom As String, ByVal ServiceCom As String, ByVal VoucherCm As String, ByVal sLocationsId As String, ByVal ArTitle As String, ByVal hdnParentID As String)
        Try
            Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")

            Dim con As String
            Dim sData As String = "0"
            Dim sDataNew As String = "0"
            Dim nServiceId As Integer = 0

            Dim bSuccess As Boolean = False
            con = ConfigurationManager.ConnectionStrings("ConnectionString").ToString
            Dim cn As SqlConnection = New SqlConnection(con)
            cn.Open()

            Dim insertSQL As String = ""
            Dim updateSQL As String = ""
            Dim nNewServiceId As Integer = 0

            Try
                If Not String.IsNullOrEmpty(ServiceId) Then
                    updateSQL = "update Services Set Title = @Title, ArTitle =@ArTitle, ParentId = @ParentId, UpdatedBy = @UpdatedBy,  UpdatedAt = @UpdatedAt, RequiredMins = @RequiredMins, PriceType = @PriceType,  AvailableFor = @AvailableFor, Tax = @Tax, IsEnableCommission = @IsEnableCommission,  IsExtraTimeNeeded = @IsExtraTimeNeeded, ExtraMins = @ExtraMins  where ServiceId = @ServiceId "

                    Dim cmd2 As SqlCommand = New SqlCommand(updateSQL, cn)
                    cmd2.Parameters.Add("Title", SqlDbType.NVarChar).Value = Title
                    cmd2.Parameters.Add("ArTitle", SqlDbType.NVarChar).Value = ArTitle
                    Dim parent = 0
                    Integer.TryParse(hdnParentID, parent)
                    cmd2.Parameters.Add("ParentId", Data.SqlDbType.BigInt).Value = parent
                    cmd2.Parameters.Add("UpdatedBy", SqlDbType.Int).Value = userID
                    cmd2.Parameters.Add("UpdatedAt", SqlDbType.DateTime).Value = DateTime.Now

                    cmd2.Parameters.Add("RequiredMins", SqlDbType.Int).Value = If(ServiceDuration <> "", CInt(ServiceDuration), 0)
                    cmd2.Parameters.Add("PriceType", Data.SqlDbType.NVarChar).Value = PriceType
                    cmd2.Parameters.Add("AvailableFor", SqlDbType.NVarChar).Value = Gender
                    cmd2.Parameters.Add("Tax", SqlDbType.Float).Value = If(Tax <> "", CDec(Tax), 0)
                    cmd2.Parameters.Add("IsEnableCommission", Data.SqlDbType.Bit).Value = If(EnableCommission = "on", True, False)
                    cmd2.Parameters.Add("IsExtraTimeNeeded", SqlDbType.NVarChar).Value = ExtraType

                    cmd2.Parameters.Add("ExtraMins", SqlDbType.Int).Value = If(ExtraDuration <> "", CInt(ExtraDuration), 0)
                    cmd2.Parameters.Add("ServiceId", SqlDbType.BigInt).Value = ServiceId


                    cmd2.ExecuteNonQuery()
                    nServiceId = CInt(ServiceId)
                Else

                    insertSQL = "INSERT into Services(Title, ArTitle, IsServiceGroup, Status, CreatedBy, CreatedAt, ParentId, RequiredMins, PriceType, AvailableFor, Tax, IsEnableCommission, IsExtraTimeNeeded, ExtraMins)  values(@Title,  @ArTitle, @IsServiceGroup, @Status, @CreatedBy, @CreatedAt, @ParentId, @RequiredMins, @PriceType, @AvailableFor, @Tax, @IsEnableCommission, @IsExtraTimeNeeded, @ExtraMins)  SET @ServiceId = SCOPE_IDENTITY() "
                    Dim cmd2 As SqlCommand = New SqlCommand(insertSQL, cn)
                    cmd2.Parameters.Add("@ServiceId", Data.SqlDbType.Int).Direction = ParameterDirection.Output
                    cmd2.Parameters.Add("Title", SqlDbType.NVarChar).Value = Title
                    cmd2.Parameters.Add("ArTitle", SqlDbType.NVarChar).Value = ArTitle
                    cmd2.Parameters.Add("IsServiceGroup", SqlDbType.Bit).Value = False
                    cmd2.Parameters.Add("Status", SqlDbType.Bit).Value = True
                    cmd2.Parameters.Add("CreatedBy", SqlDbType.Int).Value = userID
                    cmd2.Parameters.Add("CreatedAt", SqlDbType.DateTime).Value = DateTime.Now
                    cmd2.Parameters.Add("ParentId", Data.SqlDbType.BigInt).Value = If(ParentId <> "", CInt(ParentId), 0)
                    cmd2.Parameters.Add("RequiredMins", SqlDbType.Int).Value = If(ServiceDuration <> "", CInt(ServiceDuration), 0)
                    cmd2.Parameters.Add("PriceType", Data.SqlDbType.NVarChar).Value = PriceType
                    cmd2.Parameters.Add("AvailableFor", SqlDbType.NVarChar).Value = Gender
                    cmd2.Parameters.Add("Tax", SqlDbType.Float).Value = If(Tax <> "", CDec(Tax), 0)
                    cmd2.Parameters.Add("IsEnableCommission", Data.SqlDbType.Bit).Value = If(EnableCommission = "on", True, False)
                    cmd2.Parameters.Add("IsExtraTimeNeeded", SqlDbType.NVarChar).Value = ExtraType
                    cmd2.Parameters.Add("ExtraMins", SqlDbType.Int).Value = If(ExtraDuration <> "", CInt(ExtraDuration), 0)

                    cmd2.ExecuteScalar()

                    nNewServiceId = CInt(cmd2.Parameters("@ServiceId").Value)

                    nServiceId = nNewServiceId

                End If
            Catch ex As Exception

            End Try


            If nServiceId > 0 Then

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
                    sqlcomm.Parameters.Add("RetailPrice", Data.SqlDbType.Float).Value = If(RetailPrice <> "", CDec(RetailPrice), 0)
                    sqlcomm.Parameters.Add("SpecialPrice", Data.SqlDbType.Float).Value = If(SpecialPrice <> "", CDec(SpecialPrice), 0)
                    sqlcomm.Parameters.Add("CreatedBy", Data.SqlDbType.Int).Value = userID
                    sqlcomm.ExecuteNonQuery()
                    sqlcomm.Parameters.Clear()
                    sqlcomm.Dispose()

                    sqlConn.Close()
                Catch ex As Exception
                    MsgBox(ex.InnerException)
                End Try

                Try
                    Dim sqlString As String
                    Dim strConn = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                    Dim sqlConn As SqlConnection = New SqlConnection(strConn)
                    sqlConn.Open()
                    sqlString = "delete FROM ServiceCommission where ServiceId = @ServiceId"
                    Dim sqlcomm As SqlCommand = New SqlCommand()
                    sqlcomm.CommandText = sqlString
                    sqlcomm.Connection = sqlConn
                    sqlcomm.CommandType = Data.CommandType.Text
                    sqlcomm.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = nServiceId
                    sqlcomm.ExecuteNonQuery()
                    sqlcomm.Parameters.Clear()
                    sqlcomm.Dispose()

                    sqlString = "insert into [ServiceCommission] (ServiceId,ProductCommission, ServiceCommission, VoucherCommission, CreatedBy, CreatedAt) Values(@ServiceId,@ProductCommission, @ServiceCommission, @VoucherCommission, @CreatedBy, Getdate())"
                    sqlcomm.CommandText = sqlString
                    sqlcomm.Connection = sqlConn
                    sqlcomm.CommandType = Data.CommandType.Text
                    sqlcomm.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = nServiceId
                    sqlcomm.Parameters.Add("ProductCommission", Data.SqlDbType.Float).Value = If(ProductCom <> "", CDec(ProductCom), 0)
                    sqlcomm.Parameters.Add("ServiceCommission", Data.SqlDbType.Float).Value = If(ServiceCom <> "", CDec(ServiceCom), 0)
                    sqlcomm.Parameters.Add("VoucherCommission", Data.SqlDbType.Float).Value = If(VoucherCm <> "", CDec(VoucherCm), 0)

                    sqlcomm.Parameters.Add("CreatedBy", Data.SqlDbType.Int).Value = userID
                    sqlcomm.ExecuteNonQuery()
                    sqlcomm.Parameters.Clear()
                    sqlcomm.Dispose()

                    sqlConn.Close()
                Catch ex As Exception

                End Try


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

                    Dim sLocations As String
                    If sLocationsId.Length > 1 Then
                        sLocations = sLocationsId.Substring(0, sLocationsId.Length - 1)
                    End If

                    If sLocations.Length > 0 Then
                        Dim aLocationId() As String = Split(sLocations, ",")

                        For Each s As String In aLocationId
                            If Not String.IsNullOrEmpty(s) Then
                                Try
                                    Dim nLID As Integer = Utility.IntegerData("SELECT TOP 1 AreaID FROM Areas Where AreaName='" & s & "'")

                                    sqlString = "insert into [ServiceLocations] (ServiceId,AreaId, CreatedBy, CreatedAt) Values(@ServiceId,@AreaId, @CreatedBy, Getdate())"
                                    sqlcomm.CommandText = sqlString
                                    sqlcomm.Connection = sqlConn
                                    sqlcomm.CommandType = Data.CommandType.Text
                                    sqlcomm.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = nServiceId
                                    sqlcomm.Parameters.Add("AreaId", Data.SqlDbType.BigInt).Value = nLID
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
                Catch ex As Exception

                End Try


            End If


            cn.Close()
        Catch ex As Exception

        End Try


    End Sub
    Private Sub LoadServices(Optional ByVal sSearch As String = "")
        Try
            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
            Dim query As String = ""
            If (txtSearch.Text.ToString().Trim.Length > 0) Then
                query = "SELECT s.ServiceId, s.Title, isnull(s.ArTitle,'') ArTitle, isnull(s.RequiredMins,'') RequiredHours, ISNULL(SR.RetailPrice,0)  RetailPrice, isnull(L.AreaName,'') AreaName, GroupName = isnull((select Title from Services where ServiceId= s.parentId),'') FROM (select * from Services where IsServiceGroup = 0 And status = 1 And IsPackage = 0 And (s.Title Like '%" & txtSearch.Text & "%' or s.ArTitle Like '%" & txtSearch.Text & "%')) s left join ServiceRates SR  on s.ServiceId = SR.ServiceId left join ServiceLocations SL on s.ServiceId = SL.ServiceId Left join Areas L on SL.AreaId = L.AreaId  "
            Else
                'query = "SELECT * FROM SERVICES  Where IsServiceGroup=1 "
                query = "Select Distinct S1.ServiceId,((Case when S2.Title Is Not null then (S2.Title +' > ') else '' end) + (Case when S1.Title is not null then (S1.Title) else '' end) ) TitleHead, S1.ServiceId FROM SERVICES S Inner Join SERVICES S1 ON S.ParentId=S1.ServiceId Inner Join SERVICES S2 On S1.ParentId=S2.ServiceId where S.ServiceId Not In (Select ParentId from SERVICES) ORDER BY S1.ServiceId ASC"
            End If
            Dim da As SqlDataAdapter = New SqlDataAdapter(query, conn)
            Dim table As DataTable = New DataTable()
            da.Fill(table)
            lvService.DataSource = table
            lvService.DataBind()
        Catch ex As Exception

        End Try

    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function ServiceById(ByVal ServiceId As String) As ServiceModel
        Dim service As New ServiceModel

        Using conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Using cmd As New SqlCommand()
                cmd.CommandText = "Select * FROM Services where IsServiceGroup = 0 And status = 1 And IsPackage = 0 And ServiceId = @ServiceId"
                cmd.Parameters.Clear()
                cmd.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = ServiceId
                cmd.Connection = conn
                conn.Open()
                Using reader As SqlDataReader = cmd.ExecuteReader()
                    If reader.HasRows Then
                        While reader.Read()
                            service.ServiceId = If(reader("ServiceId") Is DBNull.Value, "", reader("ServiceId").ToString())
                            service.Title = If(reader("Title") Is DBNull.Value, "", reader("Title").ToString())
                            service.ParentId = If(reader("ParentId") Is DBNull.Value, "0", reader("ParentId").ToString())
                            service.RequiredMins = If(reader("RequiredMins") Is DBNull.Value, "0", reader("RequiredMins").ToString())
                            service.PriceType = If(reader("PriceType") Is DBNull.Value, "0", reader("PriceType").ToString())
                            service.AvailableFor = If(reader("AvailableFor") Is DBNull.Value, "0", reader("AvailableFor").ToString())
                            service.Tax = If(reader("Tax") Is DBNull.Value, "0", reader("Tax").ToString())

                            Dim parentId As Integer = 0

                            If reader("ParentId") IsNot Nothing Then
                                Integer.TryParse(reader("ParentId").ToString(), parentId)
                            End If


                            service.hdnParentID = parentId

                            If reader("IsEnableCommission") Is DBNull.Value Then

                                service.IsEnableCommission = ""
                            Else
                                If reader("IsEnableCommission") = "0" Then
                                    service.IsEnableCommission = ""
                                Else
                                    service.IsEnableCommission = "on"
                                End If

                            End If

                            service.IsExtraTimeNeeded = If(reader("IsExtraTimeNeeded") Is DBNull.Value, "0", reader("IsExtraTimeNeeded").ToString())
                            service.ExtraMins = If(reader("ExtraMins") Is DBNull.Value, "0", reader("ExtraMins").ToString())
                            service.ArTitle = If(reader("ArTitle") Is DBNull.Value, "", reader("ArTitle").ToString())

                        End While
                    End If
                    reader.Close()
                End Using

                conn.Close()
            End Using
        End Using

        Using conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Using cmd As New SqlCommand()
                cmd.CommandText = "Select * FROM ServiceRates where ServiceId = @ServiceId"
                cmd.Parameters.Clear()
                cmd.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = ServiceId
                cmd.Connection = conn
                conn.Open()
                Using reader As SqlDataReader = cmd.ExecuteReader()
                    If reader.HasRows Then
                        While reader.Read()
                            service.SpecialPrice = If(reader("SpecialPrice") Is DBNull.Value, "", reader("SpecialPrice").ToString())
                            service.RetailPrice = If(reader("RetailPrice") Is DBNull.Value, "", reader("RetailPrice").ToString())

                        End While
                    End If
                    reader.Close()
                End Using

                conn.Close()

            End Using
        End Using

        Using conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Using cmd As New SqlCommand()
                cmd.CommandText = "Select * FROM ServiceCommission where ServiceId = @ServiceId"
                cmd.Parameters.Clear()
                cmd.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = ServiceId
                cmd.Connection = conn
                conn.Open()
                Using reader As SqlDataReader = cmd.ExecuteReader()
                    If reader.HasRows Then
                        While reader.Read()
                            service.ProductCommision = If(reader("ProductCommission") Is DBNull.Value, "", reader("ProductCommission").ToString())
                            service.ServiceCommision = If(reader("ServiceCommission") Is DBNull.Value, "", reader("ServiceCommission").ToString())
                            service.VoucherCommision = If(reader("VoucherCommission") Is DBNull.Value, "", reader("VoucherCommission").ToString())
                        End While
                    End If
                    reader.Close()
                End Using

                conn.Close()

            End Using
        End Using

        Dim sServiceLocations As String = ""

        Using conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Using cmd As New SqlCommand()
                cmd.CommandText = "Select * FROM ServiceLocations where ServiceId = @ServiceId"
                cmd.Parameters.Clear()
                cmd.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = ServiceId
                cmd.Connection = conn
                conn.Open()
                Using reader As SqlDataReader = cmd.ExecuteReader()
                    If reader.HasRows Then
                        While reader.Read()
                            Dim sLocationId As String = If(reader("AreaId") Is DBNull.Value, "0", reader("AreaId").ToString())
                            If sLocationId <> "0" Then
                                Dim sLocationName As String = Utility.StringData("SELECT TOP 1 AreaName FROM Areas Where AreaID='" & sLocationId & "'")
                                sServiceLocations &= sLocationName & ";"
                            End If

                        End While
                    End If
                    reader.Close()
                End Using

                conn.Close()
            End Using
        End Using

        If sServiceLocations.Length > 1 Then
            sServiceLocations = sServiceLocations.Substring(0, sServiceLocations.Length - 1)
        End If

        service.Locations = sServiceLocations

        Return service

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Sub DeleteServiceById(ByVal ServiceId As String)
        Try
            Using conn As New SqlConnection()
                conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                Using cmd As New SqlCommand()
                    cmd.CommandText = "delete FROM ServiceCommission where ServiceId = @ServiceId"
                    cmd.Parameters.Clear()
                    cmd.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = CInt(ServiceId)
                    cmd.Connection = conn
                    conn.Open()
                    cmd.ExecuteNonQuery()
                    conn.Close()
                End Using
            End Using
        Catch ex As Exception

        End Try

        Try
            Using conn As New SqlConnection()
                conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                Using cmd As New SqlCommand()
                    cmd.CommandText = "delete FROM ServiceRates where ServiceId = @ServiceId"
                    cmd.Parameters.Clear()
                    cmd.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = CInt(ServiceId)
                    cmd.Connection = conn
                    conn.Open()
                    cmd.ExecuteNonQuery()
                    conn.Close()
                End Using
            End Using
        Catch ex As Exception

        End Try

        Try
            Using conn As New SqlConnection()
                conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                Using cmd As New SqlCommand()
                    cmd.CommandText = "delete FROM ServiceLocations where ServiceId = @ServiceId"
                    cmd.Parameters.Clear()
                    cmd.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = CInt(ServiceId)
                    cmd.Connection = conn
                    conn.Open()
                    cmd.ExecuteNonQuery()
                    conn.Close()
                End Using
            End Using
        Catch ex As Exception

        End Try

        Try
            Using conn As New SqlConnection()
                conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                Using cmd As New SqlCommand()
                    cmd.CommandText = "delete FROM Services where ServiceId = @ServiceId"
                    cmd.Parameters.Clear()
                    cmd.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = CInt(ServiceId)
                    cmd.Connection = conn
                    conn.Open()
                    cmd.ExecuteNonQuery()
                    conn.Close()
                End Using
            End Using
        Catch ex As Exception

        End Try

    End Sub




    Protected Function GetRelatedServices(xElement As String) As String
        Dim finalString As String
        Dim services As String
        Dim Arservices As String
        Dim Duration As String
        Dim Amount As String
        Dim LocationParam As String

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "SELECT ServiceRates.RetailPrice,s.* FROM ServiceRates join ( SELECT * FROM SERVICES Where ParentId=@s ) s on s.ServiceId=ServiceRates.ServiceId"

        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.BigInt).Value = xElement

        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        Dim areaList As List(Of String) = New List(Of String)


        While reader.Read()
            services += "<a href='#' onclick='GetById(" + reader("ServiceId").ToString() + ")' data-toggle='modal' data-target='#editservice'>" + reader("Title").ToString() + "</a>"
            services += "<br/>"


            Arservices += reader("ArTitle").ToString()
            Arservices += "<br/>"

            Duration += reader("RequiredMins").ToString()

            If reader("RequiredMins").ToString() <> "" Then
                Duration += " min."
            End If
            Duration += "<br/>"

            Amount += reader("RetailPrice").ToString()

            If reader("RetailPrice").ToString() <> "" Then
                Amount += " " + Utility.GetCurrencySymbol()
            End If

            Amount += "<br/>"

            areaList.Add(reader("ServiceId").ToString())

            'LocationParam += GetRelatedLocation(Eval( reader("ServiceId").ToString() ))
            'LocationParam += "<br/>"

        End While

        reader.Close()
        conn.Close()


        For Each item As String In areaList
            LocationParam += GetRelatedLocation(item) + "</br>"
            Amount += "<br/>"
        Next


        finalString = "<td>" + services + "</td>" + "<td>" + Arservices + "</td>" + "<td>" + Duration + "</td>" + "<td>" + Amount + "</td>" + "<td>" + LocationParam + "</td>"

        Return finalString

    End Function



    Protected Function GetRelatedLocation(xElement As String) As String
        Dim locationString As String

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "SELECT * FROM [appointment].[vw_SERVICEAREA] WHERE serviceId=@s"

        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.BigInt).Value = xElement

        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()

        While reader.Read()

            If Not String.IsNullOrEmpty(locationString) Then
                locationString += ", "
            End If

            locationString += reader("AreaName").ToString()


        End While

        reader.Close()
        conn.Close()


        If Not String.IsNullOrEmpty(locationString) Then
            locationString += "."
        End If


        Return locationString

    End Function


End Class
