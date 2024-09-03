<%@ WebHandler Language="VB" Class="Areas" %>

Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web

Public Class Areas : Implements IHttpHandler

    Dim context As HttpContext

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Me.context = context
        Dim json = Me.GetAllCountry()
        json = String.Format("{0}", json)
        context.Response.ContentType = "text/json"
        context.Response.Write(json)
    End Sub




    Private Function GetAllCountry() As String

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)



        Dim countries as String

        conn.Open()

        Dim selectString = "SELECT * FROM Countries "
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)


        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        Dim currentItemNumber as Integer = 1
        'CountryID,CountryName,MobileCode

        While reader.Read()


            if currentItemNumber=1 then

                countries += " { ""id"" : " + reader("CountryID").ToString() + ",""Country Name "" : """ + reader("CountryName").ToString() + """}"

                
            else
                countries += " ,{ ""id"" : " + reader("CountryID").ToString() + ",""Country Name "" : """ + reader("CountryName").ToString() + """}"
            End If
            currentItemNumber += 1
        End While

        reader.Close()
        conn.Close()


        context.Response.Write("{ ""data"" : { ""countries"":[ " +  countries + "] }, ""code"": ""201"" ,""message"": ""Succesfully Inserted"",""isSuccess"": true } ")

    End Function

                                      


    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class