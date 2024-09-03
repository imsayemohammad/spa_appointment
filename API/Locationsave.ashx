<%@ WebHandler Language="VB" Class="Locationsave" %>

Imports System
Imports System.Data
Imports System.Web

Public Class Locationsave : Implements IHttpHandler

    Dim context As HttpContext

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Me.context = context
        Dim json = Me.SaveLocation()
        json = String.Format("{0}", json)
        context.Response.ContentType = "text/json"
        context.Response.Write(json)
    End Sub

    Private Function SaveLocation() As String
        Dim savelocationret as String = String.Empty
        Dim userId = 0

        If Not String.IsNullOrEmpty(context.Request.Params("clientid")) Or Not String.IsNullOrEmpty(context.Request.Params("addresstype")) Or Not String.IsNullOrEmpty(context.Request.Params("areaId")) Then

            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
            conn.Open()
            Dim M As Integer = 0
            Dim selectString = ""
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)

            selectString = "INSERT INTO ClientLocation(ClientID,City,State,ZipCode,AreaId,Address,ArAddress,AddressType,ArAddressType,Street,ArStreet ,ApartmentNo,ArApartmentNo) VALUES(@ClientID,@City,@State,@ZipCode,@AreaId,@Address,@ArAddress,@AddressType,@ArAddressType,@Street,@ArStreet ,@ApartmentNo,@ArApartmentNo) SET @ClientLocationID = SCOPE_IDENTITY()"

            if context.Request.Params("lang").Equals("en") then
                cmd.Parameters.Add("Address", Data.SqlDbType.NVARCHAR).Value = context.Request.Params("address")
                cmd.Parameters.Add("ArAddress", Data.SqlDbType.NVARCHAR).Value = DBNull.Value
                cmd.Parameters.Add("AddressType", Data.SqlDbType.NVARCHAR).Value = context.Request.Params("addressType")
                cmd.Parameters.Add("ArAddressType", Data.SqlDbType.NVARCHAR).Value = DBNull.Value
                cmd.Parameters.Add("Street", Data.SqlDbType.NVARCHAR).Value = context.Request.Params("street")
                cmd.Parameters.Add("ArStreet", Data.SqlDbType.NVARCHAR).Value = DBNull.Value
                cmd.Parameters.Add("ApartmentNo", Data.SqlDbType.NVARCHAR).Value = context.Request.Params("apartmentNo")
                cmd.Parameters.Add("ArApartmentNo", Data.SqlDbType.NVARCHAR).Value = DBNull.Value
            Else If context.Request.Params("lang").Equals("ar") Then
                cmd.Parameters.Add("Address", Data.SqlDbType.NVARCHAR).Value = DBNull.Value
                cmd.Parameters.Add("ArAddress", Data.SqlDbType.NVARCHAR).Value = context.Request.Params("address")
                cmd.Parameters.Add("AddressType", Data.SqlDbType.NVARCHAR).Value = DBNull.Value
                cmd.Parameters.Add("ArAddressType", Data.SqlDbType.NVARCHAR).Value = context.Request.Params("addressType")
                cmd.Parameters.Add("Street", Data.SqlDbType.NVARCHAR).Value = DBNull.Value
                cmd.Parameters.Add("ArStreet", Data.SqlDbType.NVARCHAR).Value = context.Request.Params("street")
                cmd.Parameters.Add("ApartmentNo", Data.SqlDbType.NVARCHAR).Value = DBNull.Value
                cmd.Parameters.Add("ArApartmentNo", Data.SqlDbType.NVARCHAR).Value = context.Request.Params("apartmentNo")
            End If

            cmd.Parameters.Add("@ClientLocationID", Data.SqlDbType.Int).Direction = ParameterDirection.Output
            cmd.Parameters.Add("ClientID", Data.SqlDbType.Bigint).Value = context.Request.Params("clientid")
            cmd.Parameters.Add("City", Data.SqlDbType.NVARCHAR).Value = context.Request.Params("city")
            cmd.Parameters.Add("State", Data.SqlDbType.NVARCHAR).Value = context.Request.Params("state")
            cmd.Parameters.Add("ZipCode", Data.SqlDbType.NVARCHAR).Value = context.Request.Params("zipCode")
            cmd.Parameters.Add("AreaId", Data.SqlDbType.Bigint).Value = context.Request.Params("areaId")
           

            cmd.CommandText = selectString
            cmd.ExecuteScalar()
            M = CInt(cmd.Parameters("@ClientLocationID").Value)
            conn.Close()
            If M > 0 Then
                savelocationret += "{ ""data"" : { ""clientlocationid"":""" + M.ToString() + """,""title"":""Saved Successfully"" }, ""code"": ""200"" ,""message"": ""Succesfully Inserted"",""isSuccess"": true } "
            else
                savelocationret += "{ ""data"" : { ""clientlocationid"":""" + M.ToString() + """,""title"":""Internal Server error"" }, ""code"": ""500"" ,""message"": ""Insertion Failed"",""isSuccess"": true } "
            End If

        End If

        return savelocationret
    End Function

    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class