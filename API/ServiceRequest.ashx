<%@ WebHandler Language="VB" Class="ServiceRequest" %>
Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web
Imports Newtonsoft.Json

Public Class ServiceRequest : Implements IHttpHandler

    Dim context As HttpContext

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Me.context = context
        Dim json = Me.Save()
        json = String.Format("{0}", json)
        context.Response.ContentType = "text/json"
        context.Response.Write(json)
    End Sub



    Private Function Save() As String

        Dim userId As Integer = 0
        If context.Request.Params("userId") IsNot Nothing Then
            Integer.TryParse(context.Request.Params("userId"), userId)
        End If


        Dim location As String = ""
        If context.Request.Params("addressName") IsNot Nothing Then
            location = context.Request.Params("addressName")
        End If

        Dim latitude As Double = 0
        If context.Request.Params("latitude") IsNot Nothing Then
            latitude = context.Request.Params("latitude")
        End If

        Dim longitude As Double = 0
        If context.Request.Params("longitude") IsNot Nothing Then
            longitude = context.Request.Params("longitude")
        End If

        Dim status As String = "Requested"



        Dim paymentCode As String = String.Empty
        If context.Request.Params("paymentCode") IsNot Nothing Then
            paymentCode = context.Request.Params("paymentCode")
        End If


        Dim totalServiceRate As Double
        If context.Request.Params("totalServiceRate") IsNot Nothing Then
            Double.TryParse(context.Request.Params("totalServiceRate"), totalServiceRate)
        End If

        Dim paymentType As String = String.Empty
        If context.Request.Params("paymentType") IsNot Nothing Then
            paymentType = context.Request.Params("paymentType")
        End If


        Dim areaId As Integer = 0
        If context.Request.Params("areaId") IsNot Nothing Then
            Integer.TryParse(context.Request.Params("areaId"), areaId)
        End If

        Dim startDate As String = String.Empty
        If context.Request.Params("bookingDate") IsNot Nothing Then
            startDate = context.Request.Params("bookingDate")
        End If

        Dim timeRange As String = String.Empty
        If context.Request.Params("timeSlot") IsNot Nothing Then
            timeRange = context.Request.Params("timeSlot")
        End If

        Dim note As String = String.Empty
        If context.Request.Params("timeSlot") IsNot Nothing Then
            timeRange = context.Request.Params("timeSlot")
        End If


        Dim addressType = String.Empty
        If context.Request.Params("addressType") IsNot Nothing Then
            addressType = context.Request.Params("addressType")
        End If


        Dim apartmentNo = String.Empty
        If context.Request.Params("apartmentNo") IsNot Nothing Then
            apartmentNo = context.Request.Params("apartmentNo")
        End If


        Dim streetNo = String.Empty
        If context.Request.Params("streetAddress") IsNot Nothing Then
            streetNo = context.Request.Params("streetAddress")
        End If




        Dim services = String.Empty
        Dim Json as List(Of Service)

        If context.Request.Params("servicesByClient") IsNot Nothing Then
            services = context.Request.Params("servicesByClient")
            services = services.Replace("&quot;:&quot;", "&quot;\:&quot;")
            If NOT string.isNullOrEmpty(services) then
                json = JsonConvert.DeserializeObject(Of List(Of Service))(services)
            End If
        End If




        Dim clientAddressId as Integer = GetClientAddresId(userId, location, latitude, longitude, addressType, apartmentNo, streetNo, areaId)

        Dim locationInfo as String = ""
        Dim addressInfo as String = ""

        if clientAddressId > 0 then
            locationInfo += """latitude""" + ":" + latitude.ToString() + ","
            locationInfo += """longitude""" + ":" + longitude.ToString() + ","
            locationInfo += """streetAddress""" + ":""" + streetNo.ToString() + """"

            addressInfo += """addressId""" + ":" + clientAddressId.ToString() + ","
            addressInfo += """addressName""" + ":""" + location.ToString() + ""","
            addressInfo += """addressType""" + ":""" + addressType.ToString() + ""","
            addressInfo += """areaId""" + ":" + areaId.ToString() + ","
            addressInfo += """streetAddress""" + ":""" + streetNo.ToString() + """"

        End If

        Dim code as String = String.EMpty
        Dim masterId as Integer = GetMasterID(userId, location, latitude, longitude, status, totalServiceRate, paymentCode, paymentType, areaId, startDate, timeRange, note, clientAddressId, code)
        Dim servicesString As String = SaveReduestDetailsData(masterId, json) 'masterId
        Dim outResult = String.Empty
        Dim timeInfo = String.Empty


        outResult += """serviceRequestMasterId""" + ":" + masterId.ToString() + ","
        outResult += """userId""" + ":" + userId.ToString() + ","
        outResult += """totalServiceRate""" + ":" + totalServiceRate.ToString() + ","
        outResult += """paymentCode""" + ":""" + paymentCode + ""","
        outResult += """paymentType""" + ":""" + paymentType + ""","
        outResult += """note""" + ":""" + note.ToString() + ""","
        outResult += """submitDate""" + ":""" + DateTime.Now.ToString("yyyy-MM-dd") + ""","
        outResult += """serviceCode""" + ":""" + code.ToString() + """"


        timeInfo += """bookingDate""" + ":""" + startDate.ToString() + ""","
        timeInfo += """timeSlot""" + ":""" + timeRange.ToString() + """"

        context.Response.Write("{ ""data"" : { ""serviceInfo"":{" + outResult + ",""timeinfo"":{" + timeInfo + "},""addressInfo"":{" + addressInfo + " ,""locationInfo"":{" + locationInfo + "}},  ""servicesByClient"":[" + servicesString + "]} }, ""code"": 201 ,""message"": ""Succesfully Inserted"",""isSuccess"": true } ")
        'context.Response.Write("{ ""data"" : { ""test"":"+servicesString+" }, ""code"": 201 ,""message"": ""Succesfully Inserted"",""isSuccess"": true } ")


    End Function


    Private Function GetClientAddresId(userId As String, location As String, latitude As String, longitude As String, addressType As String, apartmentNo As String, streetNo As String, areaId as String) As Integer

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()
        Dim M As Integer = 0
        Dim selectString = ""
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)


        'addressId


        If context.Request.Params("addressId") Is Nothing Then
            selectString = "INSERT INTO ClientLocation(ClientID,AreaId,Address,AddressType,ApartmentNo,Street,Latitude ,Longitude,CreateBy,CreateDate)  VALUES(@ClientID,@AreaId,@Address,@AddressType,@ApartmentNo,@Street,@Latitude ,@Longitude,@CreateBy,GETDATE())  SET @id = SCOPE_IDENTITY()  "
        Else
            selectString = "UPDATE ClientLocation set  ClientID=@ClientID,AreaId=@AreaId,Address=@Address,AddressType=@AddressType,ApartmentNo=@ApartmentNo,Street=@Street,Latitude=@Latitude,Longitude=@Longitude,UpdatedBy=@CreateBy,UpdatedDate=GETDATE() Where ClientLocationID=@ClientLocationID  SET @id =@ClientLocationID"
            cmd.Parameters.Add("ClientLocationID", Data.SqlDbType.INT).Value = context.Request.Params("addressId")
        End If


        cmd.Parameters.Add("ClientID", Data.SqlDbType.BIGINT).Value = userId
        cmd.Parameters.Add("AreaId", Data.SqlDbType.BIGINT).Value = areaId
        cmd.Parameters.Add("Address", Data.SqlDbType.nvarchar).Value = location
        cmd.Parameters.Add("AddressType", Data.SqlDbType.nvarchar).Value = addressType
        cmd.Parameters.Add("ApartmentNo", Data.SqlDbType.nvarchar).Value = apartmentNo
        cmd.Parameters.Add("Street", Data.SqlDbType.nvarchar).Value = streetNo
        cmd.Parameters.Add("Latitude", Data.SqlDbType.float).Value = latitude
        cmd.Parameters.Add("Longitude", Data.SqlDbType.float).Value = longitude
        cmd.Parameters.Add("CreateBy", Data.SqlDbType.INT).Value = userId
        cmd.Parameters.Add("@id", Data.SqlDbType.Int).Direction = ParameterDirection.Output

        cmd.CommandText = selectString
        cmd.ExecuteNonQuery()
        INteger.tryParse(cmd.Parameters("@id").Value.ToString(), M)
        conn.Close()


        Return M
    End Function



    Private Function SaveReduestDetailsData(masterId As Integer, servicesForSaveDates As List(Of Service)) As String

        Dim outputString = String.Empty
        Dim comma as Boolean = False

        If Not servicesForSaveDates Is Nothing then


            For Each service as Service In servicesForSaveDates
                If comma then
                    outputString += ",{"

                Else
                    outputString += "{"
                    comma = true
                End If


                if service.child.Count() = 0 Then

                    service.PackageId = 0
                    service.IsPackage = 0
                    SaveReduestDetailsDataMethod(masterId, service)

                End If




                outputString += """serviceId""" + ":" + service.serviceId.ToString() + ","
                outputString += """serviceType""" + ":""" + service.serviceType + ""","
                outputString += """homeImage""" + ":""" + service.homeImage + ""","
                outputString += """status""" + ":""" + service.status + ""","
                outputString += """width""" + ":" + service.width.ToString() + ","
                outputString += """height""" + ":" + service.height.ToString() + ","
                outputString += """aspectRatio""" + ":" + service.aspectRatio.ToString() + ","
                outputString += """inactiveIcon""" + ":""" + service.inactiveIcon + ""","
                outputString += """activeIcon""" + ":""" + service.activeIcon + ""","
                outputString += """serviceRate""" + ":" + service.serviceRate.ToString() + ","
                outputString += """child""" + ":" + "["




                If service.serviceType.Equals("service") Then
                    If service.child IsNot Nothing Then

                        Dim commaa = False
                        For Each serviceChild as Service In service.child


                            if serviceChild.child.Count() = 0 Then

                                serviceChild.PackageId = 0
                                serviceChild.IsPackage = 0
                                SaveReduestDetailsDataMethod(masterId, serviceChild)

                            End If


                            If commaa then
                                outputString += ",{"

                            Else
                                outputString += "{"
                                commaa = true
                            End If

                            outputString += """serviceId""" + ":" + serviceChild.serviceId.ToString() + ","
                            outputString += """serviceType""" + ":""" + serviceChild.serviceType + ""","
                            outputString += """homeImage""" + ":""" + serviceChild.homeImage + ""","
                            outputString += """status""" + ":""" + serviceChild.status + ""","
                            outputString += """width""" + ":" + serviceChild.width.ToString() + ","
                            outputString += """height""" + ":" + serviceChild.height.ToString() + ","
                            outputString += """aspectRatio""" + ":" + serviceChild.aspectRatio.ToString() + ","
                            outputString += """inactiveIcon""" + ":""" + serviceChild.inactiveIcon + ""","
                            outputString += """activeIcon""" + ":""" + serviceChild.activeIcon + ""","
                            outputString += """serviceRate""" + ":" + serviceChild.serviceRate.ToString() + ","
                            outputString += """child""" + ":" + "["


                            If serviceChild.child IsNot Nothing Then
                                Dim comma2 = False
                                For Each service2Child as Service In serviceChild.child

                                    If comma2 then
                                        outputString += ",{"

                                    Else
                                        outputString += "{"
                                        comma2 = true
                                    End If


                                    outputString += """serviceId""" + ":" + service2Child.serviceId.ToString() + ","
                                    outputString += """serviceType""" + ":""" + service2Child.serviceType + ""","
                                    outputString += """homeImage""" + ":""" + service2Child.homeImage + ""","
                                    outputString += """status""" + ":""" + service2Child.status + ""","
                                    outputString += """width""" + ":" + service2Child.width.ToString() + ","
                                    outputString += """height""" + ":" + service2Child.height.ToString() + ","
                                    outputString += """aspectRatio""" + ":" + service2Child.aspectRatio.ToString() + ","
                                    outputString += """inactiveIcon""" + ":""" + service2Child.inactiveIcon + ""","
                                    outputString += """activeIcon""" + ":""" + service2Child.activeIcon + ""","
                                    outputString += """serviceRate""" + ":" + service2Child.serviceRate.ToString() + ","
                                    outputString += """child""" + ":" + "["

                                    If service2Child.child IsNot Nothing Then
                                        Dim comma3 = False
                                        For Each service3Child as Service In service2Child.child

                                            if service3Child.child.Count() = 0 Then

                                                service3Child.PackageId = 0
                                                service3Child.IsPackage = 0
                                                SaveReduestDetailsDataMethod(masterId, service3Child)

                                            End If


                                            If comma3 then
                                                outputString += ",{"

                                            Else
                                                outputString += "{"
                                                comma3 = true
                                            End If

                                            outputString += """serviceId""" + ":" + service2Child.serviceId.ToString() + ","
                                            outputString += """serviceType""" + ":""" + service2Child.serviceType + ""","
                                            outputString += """homeImage""" + ":""" + service2Child.homeImage + ""","
                                            outputString += """status""" + ":""" + service2Child.status + ""","
                                            outputString += """width""" + ":" + service2Child.width.ToString() + ","
                                            outputString += """height""" + ":" + service2Child.height.ToString() + ","
                                            outputString += """aspectRatio""" + ":" + service2Child.aspectRatio.ToString() + ","
                                            outputString += """inactiveIcon""" + ":""" + service2Child.inactiveIcon + ""","
                                            outputString += """activeIcon""" + ":""" + service2Child.activeIcon + ""","
                                            outputString += """serviceRate""" + ":" + service2Child.serviceRate.ToString() + ","
                                            outputString += """child""" + ":" + "["
                                            outputString += "]"
                                            outputString += "}"
                                        Next

                                    End If
                                    outputString += "]"
                                    outputString += "}"


                                Next
                            End If

                            outputString += "]"
                            outputString += "}"
                        Next
                    End If
                End If


                If service.serviceType.Equals("package") Then
                    If service.child IsNot Nothing Then
                        Dim commaa = False
                        For Each serviceChild as Service In service.child

                            If commaa then
                                outputString += ",{"

                            Else
                                outputString += "{"
                                commaa = true
                            End If

                            outputString += """serviceId""" + ":" + serviceChild.serviceId.ToString() + ","
                            outputString += """serviceType""" + ":""" + serviceChild.serviceType + ""","
                            outputString += """homeImage""" + ":""" + serviceChild.homeImage + ""","
                            outputString += """status""" + ":""" + serviceChild.status + ""","
                            outputString += """width""" + ":" + serviceChild.width.ToString() + ","
                            outputString += """height""" + ":" + serviceChild.height.ToString() + ","
                            outputString += """aspectRatio""" + ":" + serviceChild.aspectRatio.ToString() + ","
                            outputString += """inactiveIcon""" + ":""" + serviceChild.inactiveIcon + ""","
                            outputString += """activeIcon""" + ":""" + serviceChild.activeIcon + ""","
                            outputString += """serviceRate""" + ":" + serviceChild.serviceRate.ToString() + ","
                            outputString += """child""" + ":" + "["


                            If serviceChild.child IsNot Nothing Then

                                serviceChild.PackageId = service.serviceId
                                serviceChild.IsPackage = 1


                                If (service.serviceType.Equals("service")) Then
                                    serviceChild.PackageId = service.serviceId
                                    serviceChild.IsPackage = 1
                                    SaveReduestDetailsDataMethod(masterId, serviceChild)
                                End If

                                if serviceChild.child IsNot Nothing
                                    Dim comma2 = False
                                    For Each service2Child as Service In serviceChild.child
                                        If comma2 then
                                            outputString += ",{"

                                        Else
                                            outputString += "{"
                                            comma2 = true
                                        End If

                                        outputString += """serviceId""" + ":" + service2Child.serviceId.ToString() + ","
                                        outputString += """serviceType""" + ":""" + service2Child.serviceType + ""","
                                        outputString += """homeImage""" + ":""" + service2Child.homeImage + ""","
                                        outputString += """status""" + ":""" + service2Child.status + ""","
                                        outputString += """width""" + ":" + service2Child.width.ToString() + ","
                                        outputString += """height""" + ":" + service2Child.height.ToString() + ","
                                        outputString += """aspectRatio""" + ":" + service2Child.aspectRatio.ToString() + ","
                                        outputString += """inactiveIcon""" + ":""" + service2Child.inactiveIcon + ""","
                                        outputString += """activeIcon""" + ":""" + service2Child.activeIcon + ""","
                                        outputString += """serviceRate""" + ":" + service2Child.serviceRate.ToString() + ","
                                        outputString += """child""" + ":" + "["


                                        service2Child.PackageId = service.serviceId
                                        service2Child.IsPackage = 1
                                        SaveReduestDetailsDataMethod(masterId, service2Child)


                                        outputString += "]"
                                        outputString += "}"
                                    Next
                                End If
                            End If

                            outputString += "]"
                            outputString += "}"
                        Next
                    End If
                End If



                outputString += "]"
                outputString += "}"
            Next
        End If
        return outputString
    End Function


    Private Function SaveReduestDetailsDataMethod(masterId As Integer, servicesForSaveDate As Service) As String

        Dim outputString = ""
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()
        Dim M As Integer = 0
        Dim selectString = ""
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)

        If Not masterId = 0 AND Not servicesForSaveDate IS Nothing then

            'serviceId
            If context.Request.Params("serviceId") Is Nothing Then
                selectString = "INSERT INTO ServiceRequestDetails(ServiceRequestMasterId,Title,ServiceRate,Status,ServiceId,StaffID,IsPackage,PackageId)  VALUES(@ServiceRequestMasterId,@Title,@ServiceRate,@Status,@ServiceId,@StaffID,@IsPackage,@PackageId)  SET @id = SCOPE_IDENTITY()  "
            Else
                selectString = "UPDATE ServiceRequestDetails  SET ServiceRequestMasterId=@ServiceRequestMasterId,Title=@Title,ServiceRate=@ServiceRate,Status=@Status,ServiceId=@ServiceId,StaffID=@StaffID,IsPackage=@IsPackage,PackageId=@PackageId Where ServiceRequestDetailId=@ServiceRequestDetailId SET @id =@ServiceRequestDetailId  "
                cmd.Parameters.Add("ServiceRequestDetailId", Data.SqlDbType.BIGINT).Value = context.Request.Params("serviceId")
            End If





            cmd.Parameters.Add("ServiceRequestMasterId", Data.SqlDbType.BIGINT).Value = masterId
            cmd.Parameters.Add("StaffID", Data.SqlDbType.BIGINT).Value = 0

            cmd.Parameters.Add("ServiceId", Data.SqlDbType.BIGINT).Value = servicesForSaveDate.serviceId
            cmd.Parameters.Add("Title", Data.SqlDbType.NVarChar).Value = servicesForSaveDate.title
            cmd.Parameters.Add("ServiceRate", Data.SqlDbType.Float).Value = servicesForSaveDate.serviceRate
            cmd.Parameters.Add("Status", Data.SqlDbType.NVarChar).Value = "Requested"


            cmd.Parameters.Add("IsPackage", Data.SqlDbType.bit).Value = servicesForSaveDate.IsPackage
            cmd.Parameters.Add("PackageId", Data.SqlDbType.BIGINT).Value = servicesForSaveDate.PackageId



            servicesForSaveDate.status = "Requested"

            cmd.Parameters.Add("@id", Data.SqlDbType.Int).Direction = ParameterDirection.Output

            cmd.CommandText = selectString
            cmd.ExecuteNonQuery()
            INteger.tryParse(cmd.Parameters("@id").Value.ToString(), M)
            conn.Close()





            if M > 0 then
                outputString += """serviceId""" + ":" + M.ToString() + ","
                outputString += """serviceType""" + ":""" + servicesForSaveDate.serviceType + ","
                outputString += """title""" + ":""" + servicesForSaveDate.title + ""","
                outputString += """serviceRate""" + ":" + servicesForSaveDate.serviceRate.ToString() + ","
                outputString += """status""" + ":""" + servicesForSaveDate.status + """"
            End If
        End If
        Return outputString
    End Function




    Private Function GetMasterID(userId as String, location as String, latitude as String, longitude as String, status as String, totalServiceRate as String, paymentCode as String, paymentType as String, areaId as String, startDate as String, timeRange as String, note as String, clientAddressId As String,
                                 ByRef code As String) As Integer

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()
        Dim M As Integer = 0
        Dim addressIID = 0
        Dim selectString = ""
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)

        'serviceRequestMasterId

        If context.Request.Params("serviceRequestMasterId") Is Nothing Then
            selectString = "INSERT INTO ServiceRequestMasters(ClientId,Location,ArLocation,Latitude,Longitude,CurrentPageStatus,Status,TotalServiceRate,PaymentCode,ArPaymentCode,PaymentType,ArPaymentType,AreaId,AddressId,StartDate,TimeRange,Note,CreateBy,CreatedAt,ServiceCode)  VALUES(@ClientId,@Location,@ArLocation,@Latitude,@Longitude,@CurrentPageStatus,@Status,@TotalServiceRate,@PaymentCode,@ArPaymentCode,@PaymentType,@ArPaymentType,@AreaId,@AddressId,@StartDate,@TimeRange,@Note,@CreateBy,GETDATE(),@ServiceCode)  SET @id = SCOPE_IDENTITY()  "
        Else
            selectString = "UPDATE ServiceRequestMasters  SET   ClientId=@ClientId,Location=@Location,ArLocation=@ArLocation,Latitude=@Latitude,Longitude=@Longitude,CurrentPageStatus=@CurrentPageStatus,Status=@Status,TotalServiceRate=@TotalServiceRate,PaymentCode=@PaymentCode,ArPaymentCode=@ArPaymentCode,PaymentType=@PaymentType,ArPaymentType=@ArPaymentType,AreaId=@AreaId,AddressId=@AddressId,StartDate=@StartDate,TimeRange=@TimeRange,Note=@Note,UpdatedBy=@Note,UpdatedAt=GETDATE(),ServiceCode=@ServiceCode Where ServiceRequestMasterId=@ServiceRequestMasterId  SET @id =@ServiceRequestMasterId  "
            cmd.Parameters.Add("ServiceRequestMasterId", Data.SqlDbType.BIGINT).Value = context.Request.Params("serviceRequestMasterId")
        End If





        cmd.Parameters.Add("ClientId", Data.SqlDbType.BIGINT).Value = userId
        cmd.Parameters.Add("Location", Data.SqlDbType.NVarChar).Value = location
        cmd.Parameters.Add("ArLocation", Data.SqlDbType.NVarChar).Value = ""
        cmd.Parameters.Add("Latitude", Data.SqlDbType.Float).Value = latitude
        cmd.Parameters.Add("Longitude", Data.SqlDbType.Float).Value = longitude
        cmd.Parameters.Add("CurrentPageStatus", Data.SqlDbType.NVarChar).Value = DBNULL.VALUE
        cmd.Parameters.Add("Status", Data.SqlDbType.NVarChar).Value = "Requested"
        cmd.Parameters.Add("TotalServiceRate", Data.SqlDbType.Float).Value = totalServiceRate
        cmd.Parameters.Add("PaymentCode", Data.SqlDbType.NVarChar).Value = paymentCode
        cmd.Parameters.Add("ArPaymentCode", Data.SqlDbType.NVarChar).Value = DBNULL.VALUE
        cmd.Parameters.Add("PaymentType", Data.SqlDbType.NVarChar).Value = paymentType
        cmd.Parameters.Add("ArPaymentType", Data.SqlDbType.NVarChar).Value = DBNULL.VALUE
        cmd.Parameters.Add("AreaId", Data.SqlDbType.NVarChar).Value = areaId

        cmd.Parameters.Add("StartDate", Data.SqlDbType.NVarChar).Value = startDate
        cmd.Parameters.Add("TimeRange", Data.SqlDbType.NVarChar).Value = timeRange
        cmd.Parameters.Add("Note", Data.SqlDbType.NVarChar).Value = note
        cmd.Parameters.Add("CreateBy", Data.SqlDbType.INT).Value = userId
        Dim dbCode = udfRandomNumber()
        cmd.Parameters.Add("ServiceCode", Data.SqlDbType.NVarChar).Value = "#HS" + dbCode
        code = "#HS" + dbCode
        Integer.TryParse(clientAddressId, addressIID)
        cmd.Parameters.Add("AddressId", Data.SqlDbType.BIGINT).Value = addressIID

        cmd.Parameters.Add("@id", Data.SqlDbType.Int).Direction = ParameterDirection.Output

        cmd.CommandText = selectString
        cmd.ExecuteNonQuery()
        INteger.tryParse(cmd.Parameters("@id").Value.ToString(), M)
        conn.Close()

        Return M
    End Function


    Protected Function udfRandomNumber() as String

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim rdm As New Random()
        Dim allowChrs() As Char = "ABCDEFGHIJKLO0123456789MNOPQRSTUVWXYZ".ToCharArray()
        Dim sResult As String = ""

        For i As Integer = 0 To 5 - 1
            sResult += allowChrs(rdm.Next(0, allowChrs.Length))
        Next

        Dim strTicketNo = sResult


        Dim cmd As New SqlCommand("", conn)

        conn.Open()
        cmd.CommandText = "Select ServiceCode From ServiceRequestMasters Where ServiceCode =@ProductCode"
        cmd.Parameters.Clear()
        cmd.Parameters.AddWithValue("@ProductCode", strTicketNo)
        Dim redrMaster As SqlDataReader = cmd.ExecuteReader
        Dim cnt = 0
        If redrMaster.Read = True Then
            cnt = 1
        End If

        redrMaster.Close()
        conn.Close()

        If cnt > 0 Then
            udfRandomNumber()
        Else
            return strTicketNo
        End If
    End Function





    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class


Public Class Service
    Public Property serviceId As Integer
    Public Property PackageId As Integer
    Public Property IsPackage As Boolean
    Public Property serviceType As String
    Public Property title As String
    Public Property homeImage As String
    Public Property status As String = "Requested"
    Public Property width As Integer
    Public Property height As Integer
    Public Property aspectRatio As Integer
    Public Property inactiveIcon As String
    Public Property activeIcon As String
    Public Property serviceRate As Double
    Public Property child As List(of Service) = new List(of Service)


End Class

Public Class Package
    Public Property serviceId As Integer
    Public Property serviceType As String
    Public Property PackageId As Integer
    Public Property IsPackage As Boolean
    Public Property title As String
    Public Property homeImage As String
    Public Property width As Integer
    Public Property height As Integer
    Public Property aspectRatio As Integer
    Public Property inactiveIcon As String
    Public Property activeIcon As String
    Public Property serviceRate As Integer
    Public Property child As Child()
End Class



Public Class Child
    Public Property serviceId As Integer
    Public Property serviceType As String
    Public Property PackageId As Integer
    Public Property IsPackage As Boolean
    Public Property title As String
    Public Property homeImage As String
    Public Property width As Integer
    Public Property height As Integer
    Public Property aspectRatio As Integer
    Public Property inactiveIcon As String
    Public Property activeIcon As String
    Public Property serviceRate As Integer
    Public Property child As Object()
End Class


