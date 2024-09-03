Imports System.Data.SqlClient

Partial Class faq
    Inherits System.Web.UI.Page


    Private Sub faq_Load(sender As Object, e As EventArgs) Handles Me.Load

        If IsPostBack = False Then

            ltrlFaq.Text = getFAQ()

        End If

    End Sub

    'Public Function Getfaq() As String

    '    Dim M As String
    '    M = ""
    '    Dim conb As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
    '    conb.Open()
    '    Dim cmdb As SqlCommand = New SqlCommand
    '    cmdb.Connection = conb

    '    cmdb.CommandText = " select Title, SmallDetails from listDetails where listMasterID=@listMasterID"
    '    cmdb.Parameters.Add("listMasterID", Data.SqlDbType.Int).Value = "1007"

    '    Dim objReaderb As SqlDataReader = cmdb.ExecuteReader()

    '    Dim i = 0
    '    Dim rotate As String = ""
    '    While objReaderb.Read()
    '        i = i + 1

    '        M += "<div class=""container""> <div class=""row""> <h4><span>Q: " & objReaderb("Title").ToString() & "</span></h4> </div><div class=""row""><h5><span>Answer: " & objReaderb("SmallDetails").ToString() & "</span></h5></div></div>"

    '    End While

    '    objReaderb.Close()
    '    conb.Close()

    '    Return M
    'End Function

    Protected Function getFAQ() As String
        Dim m As String = ""
        Dim i As Int32 = 0
        Dim cmd = New SqlCommand()
        Dim con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString())
        con.Open()

        With cmd
            .Connection = con
            .CommandText = "select Title, SmallDetails from listDetails where listMasterID=@listMasterID order by listMasterID ASC"
            .Parameters.Add("listMasterID", Data.SqlDbType.NVarChar).Value = "1007"
        End With

        Dim ds As New Data.DataSet()
        Dim adapter = New SqlDataAdapter(cmd)
        adapter.Fill(ds)
        con.Close()

        For Each row As Data.DataRow In ds.Tables(0).Rows

            If (i = 0) Then
                m += "<div class=""col-sm-12"">"

            ElseIf (i Mod 8 = 0) Then
                m += "</div>"
                m += "<div class=""col-sm-12"">"
            End If

            m += "  <h2>" & row("Title").ToString() & "</h2> <p>" & row("SmallDetails").ToString() & "</p>"

            i += 1
        Next

        If m.Length > 0 Then
            m += "</div>"
        End If


        Return m
    End Function


End Class
