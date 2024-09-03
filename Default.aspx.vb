Imports System.Data.SqlClient

Partial Class _Default
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If IsLogin() Then

        Else
            'Response.Redirect(Context.Items("domainName"))
            Response.Redirect("/login")
        End If

        hdnUserID.Value = GetUser()
    End Sub

    Private Function IsLogin() As Boolean
        Dim retVal As Boolean = False
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("spaconnectionstring").ToString)
        conn.Open()
        Dim selectString = "SELECT * FROM UserLog_Data where SessionId=@SessionId "
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
        cmd.Parameters.Add("SessionId", Data.SqlDbType.VarChar, 1000)
        cmd.Parameters("SessionId").Value = System.Web.HttpContext.Current.Session.SessionID
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        retVal = reader.HasRows
        conn.Close()
        Return retVal
    End Function

    Private Function GetUser() As Integer
        Dim retVal As Integer = 0
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("spaconnectionstring").ToString)
        conn.Open()
        Dim selectString = "SELECT * FROM UserLog_Data where  SessionId=@SessionId "
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
        cmd.Parameters.Add("SessionId", Data.SqlDbType.VarChar, 1000)
        cmd.Parameters("SessionId").Value = System.Web.HttpContext.Current.Session.SessionID
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        retVal = reader.HasRows
        reader.Read()
        retVal = reader("UserId").ToString
        conn.Close()
        Return retVal
    End Function

End Class
