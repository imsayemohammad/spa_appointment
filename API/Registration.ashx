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
        Dim M As Integer = 0
        If EmailAlreadyExists(context.Request.Params("email"), userId) Then
            context.Response.Write("{ ""data"" : {""user"":{ ""userId"":" + M.ToString() + ",""email"":"""+context.Request.Params("email")+""",""phone"":"""+context.Request.Params("phone")+""",""areaId"":"+context.Request.Params("areaId")+"}}, ""code"": 200 ,""message"": ""Email Already Exists"",""isSuccess"": true } ")
        Else
            If Not String.IsNullOrEmpty(context.Request.Params("email")) Or Not String.IsNullOrEmpty(context.Request.Params("phone")) Or Not String.IsNullOrEmpty(context.Request.Params("areaId")) Or Not String.IsNullOrEmpty(context.Request.Params("password")) Then

                Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
                conn.Open()
                
                Dim selectString = ""
                Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)

                selectString = "declare @ID table (ID int);INSERT INTO Client(Email,Phone1,[Password])  OUTPUT inserted.ClientID into @ID VALUES(@Email,@Phone1,@Password);INSERT INTO ClientLocation(ClientID,AreaId) VALUES ((SELECT TOP 1 ID  FROM @ID),@AreaId);SELECT TOP 1 ID  FROM @ID;"

                '@Email,@Phone1,@Password,@AreaId
                'email,phone,areaId,password
                cmd.Parameters.Add("Email", Data.SqlDbType.NVarChar).Value = context.Request.Params("email")
                cmd.Parameters.Add("Phone1", Data.SqlDbType.NVarChar).Value = context.Request.Params("phone")
                cmd.Parameters.Add("Password", Data.SqlDbType.NVarChar).Value = context.Request.Params("password")
                cmd.Parameters.Add("AreaId", Data.SqlDbType.Bigint).Value = context.Request.Params("areaId")


                cmd.CommandText = selectString
                M = cmd.ExecuteScalar()
                conn.Close()
                If M > 0 Then
                    context.Response.Write("{ ""data"" : {""user"":{ ""userId"":" + M.ToString() + ",""email"":"""+context.Request.Params("email")+""",""phone"":"""+context.Request.Params("phone")+""",""areaId"":"+context.Request.Params("areaId")+"} }, ""code"": 201 ,""message"": ""Succesfully Inserted"",""isSuccess"": true } ")
                else
                    context.Response.Write("{ ""data"" : {""user"":{ ""userId"":" + M.ToString() + ",""email"":"""+context.Request.Params("email")+""",""phone"":"""+context.Request.Params("phone")+""",""areaId"":"+context.Request.Params("areaId")+"}}, ""code"": 200 ,""message"": ""Insertion Failed"",""isSuccess"": true } ")
                    
                End If

            End If
        End If

 

    End Function

    Private Function EmailAlreadyExists(s As String, ByRef userId as Integer) As Boolean
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()
        Dim selectString = "SELECT Top 1 ClientID FROM Client Where Email like '%" + s + "%'"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        Dim M = 0




        While reader.Read()
            If Not reader("ClientID") Is Nothing Then
                M = 1
                integer.tryParse(reader("ClientID").ToString(), userId)
            End If

        End While

        reader.Close()
        conn.Close()


        if M = 0 Then
            Return False
        Else
            M = 1
            Return True
        End If



    End Function


    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class