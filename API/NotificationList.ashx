<%@ WebHandler Language="VB" Class="Notification" %>

Imports System
Imports System.Data.SqlClient
Imports System.Web

Public Class Notification : Implements IHttpHandler

    Dim context As HttpContext
    Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Me.context = context
        Dim json = Me.GetAllNotification()
        json = String.Format("{0}", json)
        context.Response.ContentType = "text/json"
        context.Response.Write(json)
    End Sub

    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

    Private Function GetAllNotification() AS String

        Dim notifications = Getnotification()

        Dim returntp = ("{ ""data"" : { ""notifications"":[ " + notifications + "]}, ""code"": ""200"" ,""message"": ""Successfully Done"",""isSuccess"": true } ")
        Return returntp
    End Function

    Private Function Getnotification() As String
        Dim notification as String = String.Empty
        conn.Open()

        Dim selectString = "SELECT *,CONVERT(VARCHAR(10), CreatedAt, 105) AS CreateDate, LTRIM(RIGHT(CONVERT(VARCHAR(20), CreatedAt, 100), 7)) AS CreateTime FROM ServiceRequestNotifications Where Status=1 And ClientID=" + context.Request.Params("userId")

        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        Dim currentItemNumber as Integer = 1
        While reader.Read()
            Dim title As String = reader("Title").ToString()

            if currentItemNumber = 1 then
                notification += " { ""srnotificationId"" : " + reader("ServiceRequestNotificationId").ToString() + ",""srmasterId"" : " + reader("ServiceRequestMasterId").ToString() + ",""title"" : """ + reader("Title").ToString() + """,""body"" : """ + reader("Body").ToString() + """,""createDate"" : """ + reader("CreateDate").ToString() + """,""createTime"" : """ + reader("CreateTime").ToString() + """}"
            else
                notification += ", { ""srnotificationId"" : " + reader("ServiceRequestNotificationId").ToString() + ",""srmasterId"" : " + reader("ServiceRequestMasterId").ToString() + ",""title"" : """ + reader("Title").ToString() + """,""body"" : """ + reader("Body").ToString() + """,""createDate"" : """ + reader("CreateDate").ToString() + """,""createTime"" : """ + reader("CreateTime").ToString() + """}"
            End If
            currentItemNumber += 1
        End While

        reader.Close()
        conn.Close()
        return notification
    End Function

End Class