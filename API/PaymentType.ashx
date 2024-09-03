<%@ WebHandler Language="VB" Class="PaymentType" %>

Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web

Public Class PaymentType : Implements IHttpHandler

    Dim context As HttpContext

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Me.context = context

        Dim json = Me.GetAllCountry()

        json = String.Format("{0}", json)
        context.Response.ContentType = "text/json"
        context.Response.Write(json)
    End Sub




    Private Function GetAllCountry() as String



        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)



        Dim countries as String

        conn.Open()

        Dim selectString = "SELECT * FROM PaymentType"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)


        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        Dim currentItemNumber as Integer = 1


        While reader.Read()

            Dim PaymentTypeName As String = String.Empty

            If Not reader("PaymentTypeName") Is  Nothing then
                PaymentTypeName = reader("PaymentTypeName").ToString()
            End If


          


            if currentItemNumber = 1 then
                countries += " { ""paymentTypeId"" : " + reader("PaymentTypeId").ToString() + ",""paymentTypeName"" : """ + PaymentTypeName + """}"
            else
                countries += ", { ""paymentTypeId"" : " + reader("PaymentTypeId").ToString() + ",""paymentTypeName"" : """ + PaymentTypeName + """}"
            End If
            currentItemNumber += 1
        End While

        reader.Close()
        conn.Close()


        context.Response.Write("{ ""data"" : { ""paymentTypes"":[ " + countries + "] }, ""code"": 200 ,""message"": ""Succesfull"",""isSuccess"": true } ")


    End Function



    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class