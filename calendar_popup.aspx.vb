
Imports System.Activities.Statements
Imports System.Data.SqlClient
Imports System.Data
Partial Class calendar_popup
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            txtdate.Text = Utility.Dayformat(DateTime.Now).ToString()
            If Not String.IsNullOrEmpty(System.Web.HttpContext.Current.Session.SessionID) Then
                Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By LogId DESC")

                Dim sessionid As String = System.Web.HttpContext.Current.Session.SessionID
                Dim dbsessionid As String = Utility.StringData("Select TOP 1 SessionId From UserLog_Data Where UserId =" & userid & "")

                If sessionid = dbsessionid Then
                    txtdate.Text = Utility.Dayformat(DateTime.Now).ToString()
                Else
                    'Response.Redirect("/login")
                End If
            Else
                Response.Redirect("/login")
            End If
        End If
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function GetServiceddlData() As String()
        Dim lstService As New List(Of String)()
        Using conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Using cmd As New SqlCommand()
                'Dim str = "SELECT ServiceId, Title FROM [dbo].[Services] WHERE ParentId <> 0 GROUP BY ServiceId, Title"
                'Dim str = "SELECT ServiceId, (Title + ' ' + '('+ CONVERT(nvarchar(10), RequiredMins) + 'Min' + ')') Title FROM [dbo].[Services] WHERE ParentId <> 0 GROUP BY ServiceId, Title, RequiredMins"

                Dim str = "SELECT ServiceId, (Title + ' ' + '('+ CONVERT(nvarchar(10), RequiredMins) + 'Min' + ')') Title FROM [dbo].[Services] WHERE IsServiceGroup = 0 And IsPackage = 0 GROUP BY ServiceId, Title, RequiredMins"
                cmd.CommandText = str
                'cmd.Parameters.Add("Title", Data.SqlDbType.VarChar).Value = Title
                cmd.Connection = conn
                conn.Open()
                Using sdr As SqlDataReader = cmd.ExecuteReader()
                    If sdr.HasRows = True Then
                        While sdr.Read()
                            lstService.Add(String.Format("{1}-{0}", sdr("ServiceId"), sdr("Title")))
                        End While
                    End If

                End Using
                conn.Close()

            End Using

            Return lstService.ToArray
        End Using
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetTimeddlData() As String()
        Dim lstTimeshift As New List(Of String)()
        Using conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Using cmd As New SqlCommand()

                Dim str = "SELECT TimeShift FROM WorkingHours Order By TimeShift ASC"
                cmd.CommandText = str
                cmd.Connection = conn
                conn.Open()
                Using sdr As SqlDataReader = cmd.ExecuteReader()
                    If sdr.HasRows = True Then
                        While sdr.Read()
                            lstTimeshift.Add(String.Format("{1}-{0}", sdr("TimeShift"), sdr("TimeShift")))
                        End While
                    End If

                End Using
                conn.Close()

            End Using

            Return lstTimeshift.ToArray
        End Using
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetServiceDuration() As String()
        Dim lstServiceDuration As New List(Of String)()
        Using conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Using cmd As New SqlCommand()

                Dim str = "Select Duration, Title From ServiceDuration Where Status=1 GROUP BY Duration, Title"
                cmd.CommandText = str
                cmd.Connection = conn
                conn.Open()
                Using sdr As SqlDataReader = cmd.ExecuteReader()
                    If sdr.HasRows = True Then
                        While sdr.Read()
                            lstServiceDuration.Add(String.Format("{1}-{0}", sdr("Duration"), sdr("Title")))
                        End While
                    End If

                End Using
                conn.Close()

            End Using

            Return lstServiceDuration.ToArray
        End Using
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetStaff() As String()
        Dim lstStaff As New List(Of String)()
        Using conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Using cmd As New SqlCommand()

                Dim str = "SELECT StaffID, (FirstName + ' ' + LastName) Name FROM Staff Where Status=1 GROUP BY StaffID, FirstName, LastName"
                cmd.CommandText = str
                cmd.Connection = conn
                conn.Open()
                Using sdr As SqlDataReader = cmd.ExecuteReader()
                    If sdr.HasRows = True Then
                        While sdr.Read()
                            lstStaff.Add(String.Format("{1}-{0}", sdr("StaffID"), sdr("Name")))
                        End While
                    End If

                End Using
                conn.Close()

            End Using

            Return lstStaff.ToArray
        End Using
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetTimeDuration(ByVal serviceid As String) As Model
        Dim duration As New Model
        Using conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Using cmd As New SqlCommand()
                cmd.CommandText = "SELECT RequiredMins FROM [dbo].[Services] Where ServiceId=@ServiceId"
                cmd.Parameters.Clear()
                cmd.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = serviceid
                cmd.Connection = conn
                conn.Open()
                Using reader As SqlDataReader = cmd.ExecuteReader()
                    While reader.Read()
                        duration.timeduration = If(reader("RequiredMins") Is DBNull.Value, "", reader("RequiredMins").ToString())
                    End While
                End Using
                conn.Close()
            End Using
            Return duration
        End Using
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetServiceRate(ByVal serviceid As String, lastamount As String) As Model
        Dim amount As New Model
        Using conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Using cmd As New SqlCommand()
                cmd.CommandText = "SELECT RetailPrice FROM [dbo].[ServiceRates] Where ServiceId=@ServiceId"
                cmd.Parameters.Clear()
                cmd.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = serviceid
                cmd.Connection = conn
                conn.Open()
                Using reader As SqlDataReader = cmd.ExecuteReader()
                    While reader.Read()
                        'Dim totamt = If(reader("RetailPrice") Is DBNull.Value, "", reader("RetailPrice").ToString())
                        Dim retailprice = CDec(reader("RetailPrice").ToString())
                        amount.retailprice = CDec(reader("RetailPrice").ToString())
                        Dim totamt = CDec(retailprice + CDec(lastamount))
                        amount.totamount = totamt
                    End While
                End Using
                conn.Close()
            End Using
            Return amount
        End Using
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function GetclientData(ByVal name As String) As String()
        Dim clientname As New List(Of String)()
        Using conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Using cmd As New SqlCommand()
                Dim str = "SELECT ClientID, (FirstName + ' ' + LastName) Name FROM Client WHERE FirstName Like + '%' + @txtmassage +'%' Or LastName Like + '%' + @txtmassage +'%' group by FirstName, LastName, ClientID"
                cmd.CommandText = str
                cmd.Parameters.Add("txtmassage", Data.SqlDbType.VarChar).Value = name

                cmd.Connection = conn
                conn.Open()
                Using sdr As SqlDataReader = cmd.ExecuteReader()
                    If sdr.HasRows = True Then
                        While sdr.Read()
                            clientname.Add(String.Format("{1}-{0}", sdr("ClientID"), sdr("Name")))
                        End While
                    End If

                End Using
                conn.Close()
            End Using

            Return clientname.ToArray
        End Using
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function InsertServiceinfo(ByVal ServiceArray As List(Of Service), ByVal clientid As String, ByVal totalamount As String, ByVal todate As String, ByVal note As String) As Service

        Try
            If Not ServiceArray Is Nothing Then
                Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By LogId DESC")
                Dim dDate As DateTime = DateTime.Now()
                Dim dateformat As String = dDate.ToString("yyyy-MM-dd")
                Dim areaid As Integer = Utility.IntegerData("Select TOP 1 ClientLocationID From [dbo].[ClientLocation] Where ClientID=" & clientid & " Order BY ClientLocationID ASC")
                Dim sqlString As String
                Dim strConn = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                Dim sqlConn As SqlConnection = New SqlConnection(strConn)
                sqlConn.Open()
                sqlString = "Insert into [ServiceRequestMasters] ([ClientId],[Status], [TotalServiceRate], [CompletedByClientAt],[ClientStatus],[AreaId],[AddressId],[StartDate],[Note],[CreateBy],[CreatedAt]) " &
                " Values(@ClientId,@Status, @TotalServiceRate, Getdate(),@ClientStatus,@AreaId,@AddressId, @StartDate, @Note, @CreateBy, Getdate()) SET @ServiceRequestMasterId = SCOPE_IDENTITY()"
                Dim sqlcomm As SqlCommand = New SqlCommand()
                sqlcomm.CommandText = sqlString
                sqlcomm.Connection = sqlConn
                sqlcomm.CommandType = Data.CommandType.Text
                sqlcomm.Parameters.Add("@ServiceRequestMasterId", Data.SqlDbType.Int).Direction = ParameterDirection.Output
                sqlcomm.Parameters.Add("ClientId", Data.SqlDbType.BigInt).Value = clientid
                sqlcomm.Parameters.Add("Status", Data.SqlDbType.NVarChar).Value = "Active"
                sqlcomm.Parameters.Add("TotalServiceRate", Data.SqlDbType.Float).Value = totalamount
                'sqlcomm.Parameters.Add("PaymentCode", Data.SqlDbType.NVarChar).Value = ""
                'sqlcomm.Parameters.Add("ArPaymentCode", Data.SqlDbType.NVarChar).Value = ""
                'sqlcomm.Parameters.Add("PaymentType", Data.SqlDbType.NVarChar).Value = ""
                'sqlcomm.Parameters.Add("ArPaymentType", Data.SqlDbType.NVarChar).Value = ""
                'sqlcomm.Parameters.Add("PaymentStatus", Data.SqlDbType.NVarChar).Value = ""
                sqlcomm.Parameters.Add("ClientStatus", Data.SqlDbType.NVarChar).Value = "Active"
                sqlcomm.Parameters.Add("AreaId", Data.SqlDbType.BigInt).Value = areaid
                sqlcomm.Parameters.Add("AddressId", Data.SqlDbType.BigInt).Value = areaid
                sqlcomm.Parameters.Add("StartDate", Data.SqlDbType.DateTime).Value = todate
                sqlcomm.Parameters.Add("Note", Data.SqlDbType.NVarChar).Value = note
                sqlcomm.Parameters.Add("CreateBy", Data.SqlDbType.Int).Value = userid
                sqlcomm.ExecuteScalar()

                Dim nNewServiceMId = CInt(sqlcomm.Parameters("@ServiceRequestMasterId").Value)

                sqlcomm.Parameters.Clear()
                sqlcomm.Dispose()

                For Each item As Service In ServiceArray
                    If Not String.IsNullOrEmpty(item.ServiceId) Then
                        Try
                            Dim servicetitle = Utility.StringData("Select Title From [dbo].[Services] Where ServiceId=" & item.ServiceId & "")

                            sqlString = "insert into [ServiceRequestDetails] ([ServiceRequestMasterId],[StaffId], [Title], [ServiceRate],[CreatedBy],[CreatedAt],[StartDate],[TimeRange],[ServiceId],[CancelledAt],[Status]) " &
                            " Values(@ServiceRequestMasterId, @StaffId, @Title, @ServiceRate, @CreatedBy, Getdate(), @StartDate, @TimeRange, @ServiceId, Getdate(),@Status)"
                            sqlcomm.CommandText = sqlString
                            sqlcomm.Connection = sqlConn
                            sqlcomm.CommandType = Data.CommandType.Text
                            sqlcomm.Parameters.Add("ServiceRequestMasterId", Data.SqlDbType.BigInt).Value = nNewServiceMId
                            sqlcomm.Parameters.Add("StaffId", Data.SqlDbType.BigInt).Value = item.StaffId
                            sqlcomm.Parameters.Add("Title", Data.SqlDbType.NVarChar).Value = servicetitle
                            'sqlcomm.Parameters.Add("ArTitle", Data.SqlDbType.NVarChar).Value = ""
                            'sqlcomm.Parameters.Add("Description", Data.SqlDbType.NVarChar).Value = ""
                            'sqlcomm.Parameters.Add("ArDescription", Data.SqlDbType.NVarChar).Value = ""
                            sqlcomm.Parameters.Add("ServiceRate", Data.SqlDbType.Float).Value = item.Servicerate
                            sqlcomm.Parameters.Add("CreatedBy", Data.SqlDbType.Int).Value = userid
                            sqlcomm.Parameters.Add("StartDate", Data.SqlDbType.DateTime).Value = dateformat + " " + item.Starttime
                            sqlcomm.Parameters.Add("TimeRange", Data.SqlDbType.NVarChar).Value = item.Duration
                            sqlcomm.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = item.ServiceId
                            'sqlcomm.Parameters.Add("RequiredHours", Data.SqlDbType.NVarChar).Value = ""
                            'sqlcomm.Parameters.Add("ServiceCancelled", Data.SqlDbType.Int).Value = ""
                            sqlcomm.Parameters.Add("Status", Data.SqlDbType.NVarChar).Value = "Active"
                            sqlcomm.ExecuteNonQuery()
                            sqlcomm.Parameters.Clear()
                            sqlcomm.Dispose()

                        Catch ex As Exception

                        End Try
                    End If

                Next
            End If
        Catch ex As Exception
            'MsgBox(ex.InnerException)
        End Try

        Dim lstservice = New Service()
        Return lstservice
    End Function


End Class
