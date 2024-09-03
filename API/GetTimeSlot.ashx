<%@ WebHandler Language="VB" Class="GetTimeSlot" %>


Imports System.Data
Imports System.Data.SqlClient
Imports System.Web
Imports System.Web.Script.Serialization
Imports Newtonsoft.Json


Public Class GetTimeSlot : Implements IHttpHandler

    Dim context As HttpContext

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Me.context = context
        Dim json = Me.GetTimeSlot()
        json = String.Format("{0}", json)
        context.Response.ContentType = "text/json"
        context.Response.Write(json)
    End Sub


    Private Function GetTimeSlot() As String

        Dim json = New List(of Integer)
        Dim services as String = ""

        If context.Request.Params("services") IsNot Nothing Then
            services = context.Request.Params("services")
            services = services.Replace("&quot;:&quot;", "&quot;\:&quot;")
            If NOT string.isNullOrEmpty(services) then
                json = JsonConvert.DeserializeObject(Of List(Of Integer))(services)
            End If
        End If

        Dim companyStartTime as String = String.Empty
        Dim companyEndTime as String = String.Empty
        GetCompanyTimeDuration(companyStartTime, companyEndTime)

        Dim requireMints as Double = 0

        For Each serviceId In json
            requireMints += GetServiceDuration(serviceId.ToString())
        Next

        Dim timeLists = GenerateTimeSlots(companyStartTime, companyEndTime, requireMints)
        Dim bookingDate as String = context.Request.Params("bookingDate")
        Dim comma = True
        Dim jsonTimeSot As String = ""

        For Each times In timeLists
            For Each serviceId In json
                Dim staffId as Integer = 0
                staffId = GetStaffTimeSlot(times, bookingDate, serviceId)
                If Not staffId = 0 Then

                    if comma then
                        jsonTimeSot += "{"
                        comma = False
                    else
                        jsonTimeSot += ",{"
                    End If
                    jsonTimeSot += """bookingDate""" + ":""" + bookingDate + ""","
                    Dim time as String = times.key.Replace(" ", "") + "-" + times.value.Replace(" ", "")
                    jsonTimeSot += """timeSlot""" + ":" + """" + time + """" + ","
                    jsonTimeSot += """staffId""" + ":" + staffId.ToString() + ","
                    jsonTimeSot += """serviceId""" + ":" + serviceId.ToString() + ""
                    jsonTimeSot += "}"
                End If

            Next
        Next

        Dim dicOFUniqueTime = New Dictionary(Of String, String)



        Dim timeSeperateForResult = JsonConvert.DeserializeObject(Of List(Of TimeSeperateForResult))("[" + jsonTimeSot + "]")

        For Each timeSeperate in timeSeperateForResult
            If Not dicOFUniqueTime.ContainsKey(timeSeperate.timeSlot) then
                dicOFUniqueTime.Add(timeSeperate.timeSlot, timeSeperate.bookingDate)
            End If
        Next







        Dim jsonTime as String = ""
        Dim commafortime = True

        For Each timeSeperate in dicOFUniqueTime
            if commafortime then
                jsonTime += "{"
                commafortime = False
            else
                jsonTime += ",{"
            End If
            jsonTime += """bookingDate""" + ":""" + timeSeperate.value + ""","

            jsonTime += """timeSlot""" + ":" + """" + timeSeperate.key + """" + ","


            jsonTime += """staffs""" + ":" + "["

            Dim commafortimeyes = True


            For Each stafservice in timeSeperateForResult
                If timeSeperate.key.equals(stafservice.timeSlot) And timeSeperate.value.equals(stafservice.bookingDate) Then
                    If commafortimeyes then
                        jsonTime += "{"
                        commafortimeyes = false
                    Else
                        jsonTime += ",{"
                    End If
                    jsonTime += """staffId""" + ":" + stafservice.staffId.ToString() + ","
                    jsonTime += """serviceId""" + ":" + stafservice.serviceId.ToString() + ""
                    jsonTime += "}"
                End If
            Next
            jsonTime += "]"
            jsonTime += "}"
        Next





        Dim timeParsetest = JsonConvert.DeserializeObject(Of List(Of ParseTime))("[" + jsonTime + "]")
        Dim finalSlot = new List(Of ParseTime)

        For Each s in timeParsetest

            Dim ints = new List(of Integer)
            For Each ss in s.staffs
                ints.add(ss.serviceId)
            Next


            Dim ok as Boolean = ContainsAllService(ints, json)


            If ok then
                finalSlot.Add(s)
            End If
            ints.Clear()
        Next


        Dim jsonSerialiser = new JavaScriptSerializer()
        Dim jsonOutput = jsonSerialiser.Serialize(finalSlot)


        'SELECT
        'DATEADD(day,1,CAST(GETDATE()as Date)),
        'DATEADD(day,2,CAST(GETDATE()as Date)),
        'DATEADD(day,3,CAST(GETDATE()as Date)),
        'DATEADD(day,4,CAST(GETDATE()as Date)),
        'DATEADD(day,5,CAST(GETDATE()as Date)),
        'DATEADD(day,6,CAST(GETDATE()as Date)),
        'DATEADD(day,7,CAST(GETDATE()as Date)).
        '    DATEADD(day,8,CAST(GETDATE()as Date))



        'Dim json = New List(of Integer)
        'Dim services as String = ""
        'If context.Request.Params("services") IsNot Nothing Then
        '    services = context.Request.Params("services")
        ' '   services = services.Replace("&quot;:&quot;", "&quot;\:&quot;")
        '    If NOT string.isNullOrEmpty(services) then
        '        json = JsonConvert.DeserializeObject(Of List(Of Integer))(services)
        '    End If
        'End If









        'Dim jsonTimeSot as String = ""


        'Dim companyStartTime as String = String.Empty
        'Dim companyEndTime as String = String.Empty
        'Dim serviceId as String = context.Request.Params("serviceId")
        'Dim requireMints as Double = 0
        'Dim bookingDate as String = context.Request.Params("bookingDate")

        'GetCompanyTimeDuration(companyStartTime, companyEndTime)
        'requireMints = GetServiceDuration(context.Request.Params("serviceId"))

        'Dim timeLists as Dictionary(Of String, string) = GenerateTimeSlots(companyStartTime, companyEndTime, requireMints)





        'Dim comma = True
        'For Each times In timeLists
        '    Dim staffId as Integer = 0
        '    staffId = GetStaffTimeSlot(times, bookingDate, serviceId)
        '    If Not staffId = 0 Then

        '        if comma then
        '            jsonTimeSot += "{"
        '            comma = False
        '        else
        '            jsonTimeSot += ",{"
        '        End If
        '        jsonTimeSot += """bookingDate""" + ":""" + bookingDate + ""","
        '        Dim time as String = times.key.Replace(" ", "") + "-" + times.value.Replace(" ", "")
        '        jsonTimeSot += """timeSlot""" + ":" + """" + time + """" + ","
        '        jsonTimeSot += """staffId""" + ":" + staffId.ToString() + ","
        '        jsonTimeSot += """serviceId""" + ":" + serviceId.ToString() + ""
        '        jsonTimeSot += "}"
        '    End If

        'Next





       







        Return "{ ""data"" : { ""timeinfo"":"+jsonOutput+" }, ""code"": 200 ,""message"": ""Successfully Done"",""isSuccess"": true } "
    End Function

    Private Function ContainsAllService(staffs As List(Of Integer), integers As List(Of Integer)) As Boolean
        Dim ok as boolean = true
        For Each i in integers
            If Not staffs.Contains(i) then
                ok = false
                if ok = false then
                    return ok
                End If
            End If
        Next
        Return ok
    End Function


    Public class TimeSeperateForResult
        Property bookingDate as String
        Property timeSlot as String
        Property staffId as Integer
        Property serviceId as Integer
    End Class

    Public class ParseTime
        Property timeSlot as String
        
        Property staffs as List(of Test)

    End Class
    Public class Test
        Property staffId as Integer
        Property serviceId as Integer
    End Class


    Private Function GetStaffTimeSlot(keyValuePair As KeyValuePair(Of String, String), bookingDate As String, serviceId as String) As Integer
        return GetStaffIds(keyValuePair.Key, keyValuePair.value, bookingDate, serviceId)
    End Function

    Private Function GetStaffIds(key As String, value As String, bookingDate As String, serviceId As String) As Integer
        Dim ids as List(of Integer) = New List(of Integer)
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim selectString as String = "IF OBJECT_ID('tempdb..#Temptbl') IS NOT NULL DROP TABLE #Temptbl;CREATE TABLE #Temptbl (id int);INSERT INTO #Temptbl SELECT v.StaffId FROM vw_Test  v join staffservices s on v.StaffId=s.StaffId WHERE  CAST(StartTime AS time)<=CAST(@StartTime AS time) AND CAST(EndTime AS time)>=CAST(@EndTime AS time) AND s.ServiceId=@ServiceId;SELECT id FROM #Temptbl Where id  not in( SELECT DISTINCT StaffId FROM (SELECT StaffId,StartTime,EndTime,bookingDate FROM GetFreeStaffTimeIDMethid  Where StartTime>=CAST(@StartTime as Time) AND StartTime IS NOT NULL AND  EndTime>=CAST(@EndTime as Time) AND EndTime IS NOT NULL AND bookingDate=CAST(@bookingDate as Date) AND bookingDate IS NOT NULL) UUU);"


        conn.Open()

        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)

        cmd.Parameters.Add("ServiceId", SqlDbType.Bigint).Value = serviceId
        cmd.Parameters.Add("StartTime", SqlDbType.nvarchar).Value = key
        cmd.Parameters.Add("EndTime", SqlDbType.nvarchar).Value = value
        cmd.Parameters.Add("bookingDate", SqlDbType.nvarchar).Value = bookingDate


        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        Dim staffId = 0
        While reader.Read()

            Integer.TryParse(reader("id").ToString(), staffId)
        End While

        reader.Close()
        conn.Close()


        Return staffId
    End Function


    Private Function GenerateTimeSlots(companyStartTime As String, companyEndTime As String, requireMints As Double) As Dictionary(Of String, String)

        Dim dic as Dictionary(Of String, String) = new Dictionary(Of String, String)
        Dim startTime As DateTime = Convert.ToDateTime(companyStartTime)
        Dim endTime As DateTime = Convert.ToDateTime(companyEndTime)

        While startTime < endTime AND NOT requireMints = 0
            Dim start as String = startTime.ToString("hh:mm tt")
            Dim endd as String = ""
            startTime = startTime.AddMinutes(requireMints)
            endd = startTime.ToString("hh: mm tt")
            dic.Add(start, endd)
        End While

        Return dic
    End Function

    Private Function GetServiceDuration(serviceId As String) As Double
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim selectString as String = "SELECT RequiredMins FROM  Services WHERe ServiceId=@ServiceId"
        Dim serviceiiD = 0
        conn.Open()

        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("ServiceId", SqlDbType.Bigint).Value = serviceId
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()

        While reader.Read()
            Double.tryParse(reader("RequiredMins").ToString(), serviceiiD)
        End While

        reader.Close()
        conn.Close()

        Return serviceiiD
    End Function




    Private Sub GetCompanyTimeDuration(ByRef companyStartTime As String, ByRef companyEndTime As String)

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim selectString as String = "SELECT  FORMAT(StartTime,'hh:mm tt')  as CompanyStartTime , FORMAT(EndTime,'hh:mm tt')  as CompanyEndTime FROM CompanySetting "
        conn.Open()

        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()

        While reader.Read()
            companyStartTime = reader("CompanyStartTime").ToString()
            companyEndTime = reader("CompanyEndTime").ToString()
        End While

        reader.Close()
        conn.Close()
    End Sub



    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class