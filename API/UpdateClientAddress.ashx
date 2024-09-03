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






        Dim areaId As Integer = 0
        If context.Request.Params("areaId") IsNot Nothing Then
            Integer.TryParse(context.Request.Params("areaId"), areaId)
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

        
        Dim isFavorite = 0
        If context.Request.Params("isFavorite") IsNot Nothing Then
            isFavorite = context.Request.Params("isFavorite")
        End If


        Dim clientAddressId as Integer = GetClientAddresId(userId, location, latitude, longitude, addressType, apartmentNo, streetNo, areaId,isFavorite)

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
            addressInfo += """streetAddress""" + ":""" + streetNo.ToString() + ""","
            addressInfo += """isFavorite""" + ":" + isFavorite.ToString() + ""

        End If

        context.Response.Write("{ ""data"" : { ""addressInfo"":{" + addressInfo + " ,""locationInfo"":{" + locationInfo + "}} }, ""code"": 201 ,""message"": ""Succesfully Updated"",""isSuccess"": true } ")



    End Function


    Private Function GetClientAddresId(userId As String, location As String, latitude As String, longitude As String, addressType As String, apartmentNo As String, streetNo As String, areaId as String, isFavorite as Integer) As Integer

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()
        Dim M As Integer = 0
        Dim selectString = ""
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)


        'addressId


        If context.Request.Params("addressId") IsNot Nothing Then
            selectString = "UPDATE ClientLocation set  ClientID=@ClientID,AreaId=@AreaId,Address=@Address,AddressType=@AddressType,ApartmentNo=@ApartmentNo,Street=@Street,Latitude=@Latitude,Longitude=@Longitude,UpdatedBy=@CreateBy,UpdatedDate=GETDATE(),isFavorite=@isFavorite Where ClientLocationID=@ClientLocationID  SET @id =@ClientLocationID"
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
        cmd.Parameters.Add("isFavorite", Data.SqlDbType.bit).Value = isFavorite
        cmd.Parameters.Add("@id", Data.SqlDbType.Int).Direction = ParameterDirection.Output

        cmd.CommandText = selectString
        cmd.ExecuteNonQuery()
        INteger.tryParse(cmd.Parameters("@id").Value.ToString(), M)
        conn.Close()


        Return M
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


