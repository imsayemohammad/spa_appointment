<%@ WebHandler Language="VB" Class="SaveTimeSlotToService" %>
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web
Imports Newtonsoft.Json

Public Class SaveTimeSlotToService : Implements IHttpHandler

    Dim context As HttpContext

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Me.context = context
        Dim json = Me.SaveTimeSlotToService()
        json = String.Format("{0}", json)
        context.Response.ContentType = "text/json"
        context.Response.Write(json)
    End Sub


    Private Function SaveTimeSlotToService() As String


        if context.Request.Params("bookingDate") IsNot Nothing AND context.Request.Params("timeSlot") IsNot Nothing AND context.Request.Params("staffId") IsNot Nothing AND context.Request.Params("services") IsNot Nothing then


            Dim json = JsonConvert.DeserializeObject(Of List(Of Integer))(context.Request.Params("services"))

            for Each j in json

                Dim M As Integer = 0
                Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
                conn.Open()
                Dim selectString = ""
                Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)

                Dim timeSloat = context.Request.Params("timeSlot")
                Dim a = timeSloat.Split("-")
                Dim StartDateTime As String = a(0)
                Dim EndDateTime As String = a(1)
                Dim StartDate = context.Request.Params("bookingDate")

                selectString = "UPDATE ServiceRequestDetails SET StaffID=@StaffID,StartDateTime=Cast(@StartDateTime as DATETime),EndDateTime=Cast(@EndDateTime as DATETime),StartDate=Cast(@StartDate as DATETime),Status='Requested' WHERE ServiceRequestDetailId=@ServiceId"

                cmd.Parameters.Add("StartDateTime", Data.SqlDbType.DATETIME).Value = StartDate + " " + StartDateTime
                cmd.Parameters.Add("EndDateTime", Data.SqlDbType.DATETIME).Value = StartDate + " " + EndDateTime
                cmd.Parameters.Add("StartDate", Data.SqlDbType.DATETIME).Value = StartDate + " " + StartDateTime
                cmd.Parameters.Add("ServiceId", Data.SqlDbType.BIGINT).Value = j
                cmd.Parameters.Add("StaffID", Data.SqlDbType.BIGINT).Value = context.Request.Params("staffId")

                cmd.CommandText = selectString
                M = cmd.ExecuteNonQuery()
                conn.Close()
            Next
            Return "{ ""data"" : { ""timeinfo"":{""bookingDate"":""" + context.Request.Params("bookingDate") + """,""timeSlot"":""" + context.Request.Params("timeSlot") + """,""services"":" + context.Request.Params("services") + ",""staffId"":" + context.Request.Params("staffId") + "} }, ""code"": 201 ,""message"": ""Successfully Inserted"",""isSuccess"": true } "

        End If


    End Function



    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class