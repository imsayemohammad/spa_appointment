<%@ WebHandler Language="VB" Class="Orders" %>

Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web

Public Class Orders : Implements IHttpHandler

    Dim context As HttpContext

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Me.context = context

        Dim json = Me.GetAllOrders()

        json = String.Format("{0}", json)
        context.Response.ContentType = "text/json"
        context.Response.Write(json)
    End Sub




    Private Function GetAllOrders() as String

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim dictionary As New Dictionary(Of Integer, string)
        Dim orders as String

        conn.Open()

        Dim selectString = String.EMpty

        if context.Request.Params("status").Equals("all") then
            selectString = "SELECT ServiceCode,CreatedAt,Note,PaymentCode,PaymentType,ServiceRequestMasterId,ClientId,StartDate,convert(varchar,StartDate, 110) as StartDateFormatedDate, LTRIM(RIGHT(CONVERT(VARCHAR(20), StartDate, 100), 7)) as StartDateFormatedTime,ServiceRequestMasters.Status,TotalServiceRate FROM ServiceRequestMasters WHERE ClientId=" + context.Request.Params("userId") + " ORDER BY StartDate"
        Else If context.Request.Params("status").Equals("active") then
            selectString = "SELECT  ServiceCode,CreatedAt,Note,PaymentCode,PaymentType,ServiceRequestMasterId,ClientId,StartDate,convert(varchar,StartDate, 110) as StartDateFormatedDate, LTRIM(RIGHT(CONVERT(VARCHAR(20), StartDate, 100), 7)) as StartDateFormatedTime,ServiceRequestMasters.Status,TotalServiceRate FROM ServiceRequestMasters Where ServiceRequestMasters.Status='Active' AND ClientId=" + context.Request.Params("userId") + " ORDER BY StartDate"
        Else If context.Request.Params("status").Equals("cancle") then
            selectString = "SELECT  ServiceCode,CreatedAt,Note,PaymentCode,PaymentType,ServiceRequestMasterId,ClientId,StartDate,convert(varchar,StartDate, 110) as StartDateFormatedDate, LTRIM(RIGHT(CONVERT(VARCHAR(20), StartDate, 100), 7)) as StartDateFormatedTime,ServiceRequestMasters.Status,TotalServiceRate FROM ServiceRequestMasters Where ServiceRequestMasters.Status='Cancle' AND ClientId=" + context.Request.Params("userId") + " ORDER BY StartDate"
        Else If context.Request.Params("status").Equals("complete") then
            selectString = "SELECT  ServiceCode,CreatedAt,Note,PaymentCode,PaymentType,ServiceRequestMasterId,ClientId,StartDate,convert(varchar,StartDate, 110) as StartDateFormatedDate, LTRIM(RIGHT(CONVERT(VARCHAR(20), StartDate, 100), 7)) as StartDateFormatedTime,ServiceRequestMasters.Status,TotalServiceRate FROM ServiceRequestMasters Where ServiceRequestMasters.Status='Complete' AND ClientId=" + context.Request.Params("userId") + " ORDER BY StartDate"
        Else If context.Request.Params("status").Equals("pending") then
            selectString = "SELECT  ServiceCode,CreatedAt,Note,PaymentCode,PaymentType,ServiceRequestMasterId,ClientId,StartDate,convert(varchar,StartDate, 110) as StartDateFormatedDate, LTRIM(RIGHT(CONVERT(VARCHAR(20), StartDate, 100), 7)) as StartDateFormatedTime,ServiceRequestMasters.Status,TotalServiceRate FROM ServiceRequestMasters Where ServiceRequestMasters.Status='Pending' AND ClientId=" + context.Request.Params("userId") + " ORDER BY StartDate"
        Else If context.Request.Params("status").Equals("requested") then
            selectString = "SELECT ServiceRequestMasterId,ClientId,StartDate,convert(varchar,StartDate, 110) as StartDateFormatedDate, LTRIM(RIGHT(CONVERT(VARCHAR(20), StartDate, 100), 7)) as StartDateFormatedTime,ServiceRequestMasters.Status,TotalServiceRate FROM ServiceRequestMasters Where ServiceRequestMasters.Status='Requested' AND ClientId=" + context.Request.Params("userId") + " ORDER BY StartDate"
        End If




        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        Dim currentItemNumber as Integer = 1

        While reader.Read()
            DIM ServiceRequestMasterId = "", StartDateFormatedDate = "", StartDateFormatedTime = "", Status = "", ClientId = 0, ServiceCode = "", CreatedAt = "", Note = "", PaymentCode = "", PaymentType = ""
            Dim id as Integer = 0
            Dim TotalServiceRate as Double = 0

            If Not reader("ServiceRequestMasterId") Is Nothing Then
                ServiceRequestMasterId = reader("ServiceRequestMasterId").ToString()
                Integer.TryParse(ServiceRequestMasterId, id)
            End If

            If Not reader("StartDateFormatedDate") Is Nothing Then
                Dim expirationDate as Datetime
                DateTime.TryParse(reader("StartDateFormatedDate").ToString(), expirationDate)
                StartDateFormatedDate = expirationDate.ToString("yyyy-MM-dd")
            End If

            If Not reader("StartDateFormatedTime") Is Nothing Then
                StartDateFormatedTime = reader("StartDateFormatedTime").ToString()
            End If

            If Not reader("Status") Is Nothing Then
                Status = reader("Status").ToString()
            End If


            If Not reader("TotalServiceRate") Is Nothing Then
                Double.tryParse(reader("TotalServiceRate").ToString(), TotalServiceRate)
                'TotalServiceRate = reader("TotalServiceRate").ToString()
            End If


            If Not reader("ClientId") Is Nothing Then
                Integer.tryParse(reader("ClientId").ToString(), ClientId)
                'TotalServiceRate = reader("TotalServiceRate").ToString()
            End If

            'If Not reader("ServiceCode") Is Nothing Then
            '    ServiceCode = reader("ServiceCode")   '.ToString()
            'End If

            'If Not reader("CreatedAt") Is Nothing Then
            '    Dim expirationDate as Datetime
            '    DateTime.TryParse(reader("CreatedAt").ToString(), expirationDate)
            '    CreatedAt = expirationDate.ToString("yyyy-MM-dd")
            'End If

            'If Not reader("Note") Is Nothing Then
            '    Note = reader("Note").ToString()
            'End If
            'If Not reader("PaymentCode") Is Nothing Then
            '    PaymentCode = reader("PaymentCode").ToString()
            'End If
            'If Not reader("PaymentType") Is Nothing Then
            '    PaymentType = reader("PaymentType").ToString()
            'End If


            dictionary.Add(id, "  ""serviceRequestMasterId"" : " + ServiceRequestMasterId + ",""userId"":" + ClientId.ToString() + ",""serviceCode"" : """ + ServiceCode + """,""submitDate"" : """ + CreatedAt + """,""status"":""" + status + """,""note"":""" + Note + """,""paymentType"":""" + PaymentType + """,""paymentCode"":""" + PaymentCode + """,""totalPrice"":" + TotalServiceRate.ToString() + ",""timeinfo"":{""bookingDate"" : """ + StartDateFormatedDate + """,""timeSlot"":""" + StartDateFormatedTime + """}")


        End While

        reader.Close()
        conn.Close()

        Dim comma as Boolean = True
        For Each pair In dictionary
            Dim staffInfo as String = String.EMpty
            Dim serviceInfo As String = GetServices(pair.Key, staffInfo)

            If comma Then
                orders += "{" + pair.Value + ",""servicesByClient"":[" + serviceInfo + "],""staffInfo"":[" + staffInfo + "]}"
                comma = false
            Else
                orders += ",{" + pair.Value + ",""servicesByClient"":[" + serviceInfo + "],""staffInfo"":[" + staffInfo + "]}"
            End If
        Next
        context.Response.Write("{ ""data"" : { ""orders"":[ " + orders + "] }, ""code"": 200 ,""message"": ""Succesfull"",""isSuccess"": true } ")
    End Function

    Private Function GetServices(key As Integer, ByRef staffInfo As String) As String

        Dim rootUrlForAndroid As String = System.Configuration.ConfigurationManager.AppSettings("rootUrlForAndroid").ToString()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim dictionary As New Dictionary(Of string, Integer)
        Dim services as String = ""

        conn.Open()

        Dim selectString = "SELECT sd.*,CONCAT(sf.FirstName,' ',sf.LastName) as Name,CONCAT(sf.ArFirstName,' ',sf.ArLastName)  as Arname,sf.SmallImage as staffImage FROM ServiceRequestDetails sd left join Staff  sf on sd.StaffID=sf.StaffID Where sd.ServiceRequestMasterId=" + key.ToString()
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        Dim currentItemNumber as Integer = 1


        While reader.Read()
            Dim Name as String = ""
            Dim StaffName as String = ""
            Dim StaffImage as String = ""

            if context.Request.Params("lang").Equals("en") AND Not reader("Title") Is Nothing then
                Name = reader("Title").ToString()
                StaffName = reader("Name").ToString()

            Else If context.Request.Params("lang").Equals("ar") AND Not reader("ArTitle") Is Nothing then
                Name = reader("ArTitle").ToString()
                StaffName = reader("Arname").ToString()
            End If

            If Not reader("staffImage") Is Nothing then
                If Not string.isNullOrEmpty(reader("staffImage").ToString()) Then
                    StaffImage = rootUrlForAndroid + reader("staffImage").ToString()
                End If
            End If

            Dim serviceType = ""

            If Not reader("IsPackage") Is Nothing Then
                If reader("IsPackage").Equals(1) Then
                    serviceType = "package"
                Else
                    serviceType = "service"
                End If
            Else
                serviceType = "service"

            End If


            if currentItemNumber = 1 then

                services += " { ""serviceId"" : " + reader("ServiceRequestDetailId").ToString() + ",""title"" : """ + Name + """,""serviceType"" : """ + serviceType + """,""serviceType"" : """ + serviceType + """}"
                staffInfo += "{ ""staffId"":""" + reader("StaffId").ToString() + """,""staffName"":""" + StaffName + """,""Image"":""" + StaffImage + """, ""serviceId"" : " + reader("ServiceRequestDetailId").ToString() + "}"
                currentItemNumber += 1
            else
                services += " ,{ ""serviceId"" : " + reader("ServiceRequestDetailId").ToString() + ",""title"" : """ + Name + """,""serviceType"" : """ + serviceType + """,""serviceType"" : """ + serviceType + """}"
                staffInfo += " ,{ ""staffId"":""" + reader("StaffId").ToString() + """,""staffName"":""" + StaffName + """,""Image"":""" + StaffImage + """, ""serviceId"" : " + reader("ServiceRequestDetailId").ToString() + "}"
            End If
        End While

        reader.Close()
        conn.Close()

        Return services
    End Function




    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class