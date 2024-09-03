<%@ WebHandler Language="VB" Class="Location" %>

Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web

Public Class Location : Implements IHttpHandler

    Dim context As HttpContext

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Me.context = context
        Dim json = Me.SaveLocation()
        json = String.Format("{0}", json)
        context.Response.ContentType = "text/json"
        context.Response.Write(json)
    End Sub




    Private Function SaveLocation() As String


        If Not String.IsNullOrEmpty(context.Request.Params("LocationName")) Or Not String.IsNullOrEmpty(context.Request.Params("City")) Or Not String.IsNullOrEmpty(context.Request.Params("ZipCode")) Or Not String.IsNullOrEmpty(context.Request.Params("State")) Then




            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

            conn.Open()





            Dim M As Integer
            Dim selectString = ""
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)



            selectString = "INSERT INTO [Areas] (AreaName,Phone,Email, [Description],City,ZipCode,State,CreateDate,CreatedBy,AreaStatus,ArAreaName,Latitude,Longitude) VALUES (@LocationName,@Phone,@Email, @Description,@City,@ZipCode,@State,getdate(),@CreateBy,@AreaStatus,@ArabicLocationName,@Latitude,@Longitude)"








            'LocationId     ----While Update
            'LocationName,Phone,Email,Description,ArabicLocationName,City,ZipCode,State,UserId,Latitude,Longitude --While save

            cmd.Parameters.Add("LocationName", Data.SqlDbType.NVarChar).Value = context.Request.Params("LocationName")
            cmd.Parameters.Add("Phone", Data.SqlDbType.NVarChar).Value = context.Request.Params("Phone")
            cmd.Parameters.Add("Email", Data.SqlDbType.NVarChar).Value = context.Request.Params("Email")
            cmd.Parameters.Add("Description", Data.SqlDbType.NVarChar).Value = context.Request.Params("Description")
            cmd.Parameters.Add("ArabicLocationName", Data.SqlDbType.NVarChar).Value = context.Request.Params("ArabicLocationName")
            cmd.Parameters.Add("City", Data.SqlDbType.NVarChar).Value = context.Request.Params("City")
            cmd.Parameters.Add("ZipCode", Data.SqlDbType.NVarChar).Value = context.Request.Params("ZipCode")
            cmd.Parameters.Add("State", Data.SqlDbType.NVarChar).Value = context.Request.Params("State")
            cmd.Parameters.Add("CreateBy", Data.SqlDbType.BigInt).Value = context.Request.Params("UserId")
            cmd.Parameters.Add("AreaStatus", Data.SqlDbType.Bit).Value = 1 'context.Request.Params("AreaStatus")
            cmd.Parameters.Add("Latitude", Data.SqlDbType.Decimal).Value = context.Request.Params("Latitude")
            cmd.Parameters.Add("Longitude", Data.SqlDbType.Decimal).Value = context.Request.Params("Longitude")



            cmd.CommandText = selectString

            M = cmd.ExecuteNonQuery




            conn.Close()




            If M > 0 Then
                context.Response.Write("{ ""data"" : {""title"":""Saved Successfully"" }, ""code"": ""201"" ,""message"": ""Succesfully Inserted"",""isSuccess"": true } ")
            else

                context.Response.Write("{ ""data"" : { ""title"":""Internal Server error"" }, ""code"": ""200"" ,""message"": ""Insertion Failed"",""isSuccess"": true } ")
            End If
        else
            context.Response.Write("{ ""data"" : {  ""title"":""Please Provide All Required Fileds "" }, ""code"": ""200"" ,""message"": ""Insertion Failed"",""isSuccess"": true } ")

        End If




    End Function




    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class