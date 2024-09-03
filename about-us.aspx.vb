Imports System.Data.SqlClient

Partial Class about_us
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        If IsPostBack = False Then
            Dim cmd = New SqlCommand()
            Dim con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString())
            con.Open()

            With cmd
                .Connection = con
                .CommandText = "Select Title,BigDetails from HTML where Htmlid=@Htmlid"
                .Parameters.Add("Htmlid", Data.SqlDbType.Int).Value = 36
            End With

            Dim ds As New Data.DataSet()
            Dim adapter = New SqlDataAdapter(cmd)
            adapter.Fill(ds)
            con.Close()

            For Each row As Data.DataRow In ds.Tables(0).Rows
                ltrTitle.Text ="<h2>" & row("Title").ToString() & "<span><a href=""/"">Home</a>  /  " & row("Title").ToString() & "</span></h2>"
                ltrlBigDetails.Text = row("BigDetails").ToString()
            Next
        End If


    End Sub

End Class
