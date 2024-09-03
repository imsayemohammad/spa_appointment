<%@ WebHandler Language="VB" Class="Registration" %>

Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web

Public Class Registration : Implements IHttpHandler

    Dim context As HttpContext

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Me.context = context
        Dim json = Me.SaveUser()
        json = String.Format("{0}", json)
        context.Response.ContentType = "text/json"
        context.Response.Write(json)
    End Sub




    Private Function SaveUser() As String

        'email,phone,areaId,password
        Dim userId = 0

        If Not String.IsNullOrEmpty(context.Request.Params("email")) Or Not String.IsNullOrEmpty(context.Request.Params("phone")) Or Not String.IsNullOrEmpty(context.Request.Params("areaId")) Or Not String.IsNullOrEmpty(context.Request.Params("password")) Then

            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
            conn.Open()
            Dim M As Integer = 0
            Dim AreaId As Integer = 0
            Dim selectString = ""
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
            Dim email = String.Empty

            selectString = "SELECT Top 1 Client.*,CONCAT(Client.FirstName,' ',Client.LastName) as Name,ClientLocation.AreaID FROM Client left  join ClientLocation on  Client.ClientId=ClientLocation.ClientId WHERE  Client.Email='" + context.Request.Params("email").Trim() + "' AND Client.PASSWORD='" + context.Request.Params("password").trim() + "'"




            cmd.CommandText = selectString
            Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()

            While reader.Read()


                'if context.Request.Params("lang").Equals("en") AND Not reader("Name") Is Nothing then
                email = reader("email").ToString()
                'Else If context.Request.Params("lang").Equals("ar") AND Not reader("ArName") Is Nothing then
                '    Name = reader("ArName").ToString()
                'End If



                If Not reader("ClientID") Is Nothing Then
                    Integer.tryParse(reader("ClientID").ToString(), M)
                End If
                If Not reader("AreaId") Is Nothing Then
                    Integer.tryParse(reader("AreaId").ToString(), AreaId)
                End If

            End While

            conn.Close()
            If M > 0 Then
                context.Response.Write("{ ""data"" : { ""user"":{""userId"":" + M.ToString() + ",""email"":""" + email + """,""areaId"":" + AreaId.ToString() + "} }, ""code"": 200 ,""message"": ""Successfully Logged In"",""isSuccess"": true } ")
            else
                context.Response.Write("{ ""data"" : { ""user"":{""userId"":" + M.ToString() + ",""email"":""" + email + """,""areaId"":" + AreaId.ToString() + "} }, ""code"": 200 ,""message"": ""Invalid User "",""isSuccess"": true } ")
            End If

        End If
    End Function



    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class