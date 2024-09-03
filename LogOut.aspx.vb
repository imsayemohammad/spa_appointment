
Partial Class LogOut
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("spaconnectionstring").ToString)
        conn.Open()
        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By LogId DESC")
        'Response.Write(System.Web.HttpContext.Current.Session.SessionID)

        Dim M As Integer = 0
        Dim selectString = "DELETE from [UserLog_Data] where UserId=@UserId"
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
        cmd.Parameters.Add("UserId", Data.SqlDbType.NVarChar).Value = userID
        cmd.CommandText = selectString
        cmd.ExecuteScalar()
        conn.Close()
        Session.Clear()
        Session.Abandon()
        Response.Redirect(Context.Items("domainName"))
        'Response.Redirect("login.aspx")
    End Sub
End Class
