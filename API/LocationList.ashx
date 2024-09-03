<%@ WebHandler Language="VB" Class="Locations" %>

Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web

Public Class Locations : Implements IHttpHandler

    Dim context As HttpContext

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Me.context = context
        Dim json = Me.GetAllCountry()
        json = String.Format("{0}", json)
        context.Response.ContentType = "text/json"
        context.Response.Write(json)
    End Sub

    Private Function GetAllCountry() AS String

        Dim countries = GetCountries()
        Dim returntp as String = String.Empty

        If context.Request.Params("userId") IsNot Nothing Then


            Dim userAddress as String = GetUserAddresses(context.Request.Params("userId"))

            returntp = ("{ ""data"" : { ""areas"":[ " + countries + "],""addressInfo"":[" + userAddress + "]}, ""code"": 200 ,""message"": ""Successfully Done"",""isSuccess"": true } ")

        Else
            returntp = ("{ ""data"" : { ""areas"":[ " + countries + "]}, ""code"": 200 ,""message"": ""Successfully Done"",""isSuccess"": true } ")
        End If



        Return returntp
    End Function

    Private Function GetUserAddresses(params As String) As String

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim selectString as String = "SELECT * FROM ClientLocation Where ClientID=" + params
        conn.Open()

        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        Dim currentItemNumber as Integer = 1
        Dim outputString as String = ""

        While reader.Read()

            if currentItemNumber = 1 then
                outputString += "{"
                currentItemNumber += 1
            else
                outputString += ",{"
            End If


            If reader("ClientLocationID") IsNot Nothing then
                outputString += """addressId""" + ":" + reader("ClientLocationID").ToString() + ","
            End If

            If reader("Address") IsNot Nothing then
                outputString += """addressName""" + ":""" + reader("Address").ToString() + ""","
            End If

            If reader("AddressType") IsNot Nothing then
                outputString += """addressType""" + ":""" + reader("AddressType").ToString() + ""","
            End If


            If reader("AreaId") IsNot Nothing then
                outputString += """areaId""" + ":" + reader("AreaId").ToString() + ","
            End If
            If reader("Street") IsNot Nothing then
                outputString += """streetAddress""" + ":""" + reader("Street").ToString() + ""","
            End If



            If reader("isFavorite") IsNot Nothing then
                outputString += """isFavorite""" + ":""" + reader("isFavorite").ToString() + ""","

            
            End If

            outputString += """locationInfo"": {"

            If reader("Latitude") IsNot Nothing then
                outputString += """latitude""" + ":" + reader("Latitude").ToString() + ","
            End If

            If reader("Longitude") IsNot Nothing then
                outputString += """longitude""" + ":" + reader("Longitude").ToString() + ","
            End If

            If reader("Street") IsNot Nothing then
                outputString += """streetAddress""" + ":""" + reader("Street").ToString() + """"
            End If

            outputString += "}"
            outputString += "}"
        End While

        reader.Close()
        conn.Close()

        Return outputString
    End Function


    Private Function GetCountries() as String
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim countries As String = String.Empty
        conn.Open()

        Dim userIds = new List(Of Integer)



        Dim selectString = "SELECT * FROM Areas "


        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        Dim currentItemNumber as Integer = 1
        While reader.Read()
            Dim AreaName As String = String.Empty


            If context.Request.Params("lang") IsNot Nothing Then
                if context.Request.Params("lang").Equals("en") then
                    AreaName = reader("AreaName").ToString()
                Else If context.Request.Params("lang").Equals("ar") then
                    AreaName = reader("ArAreaName").ToString()
                End If
            Else
                AreaName = reader("AreaName").ToString()
            End If





            if currentItemNumber = 1 then
                countries += " { ""areaId"" : " + reader("AreaId").ToString() + ",""areaName"" : """ + AreaName + """}"
            else
                countries += ", { ""areaId"" : " + reader("AreaId").ToString() + ",""areaName"" : """ + AreaName + """}"
            End If
            currentItemNumber += 1
        End While

        reader.Close()
        conn.Close()

        return countries
    End Function




    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class