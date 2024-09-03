Imports System.Data.SqlClient
Imports System.Web
Imports System.Globalization
Imports System.Data

Partial Class MasterPage
    Inherits System.Web.UI.MasterPage
    Public CatMob As New StringBuilder()

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim conb As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        If conb.State = ConnectionState.Open Then
            conb.Close()
        End If

        '  GetUser()
        'Dim virtualPath As String = Page.AppRelativeVirtualPath.ToLower()
        'If virtualPath = "~/default.aspx" Then
        '    NavID.Attributes.Add("class", "navbar custom-nav home-nav")
        'Else
        '    NavID.Attributes.Add("class", "navbar custom-nav fixed-nav")
        'End If

        'If virtualPath = "~/default.aspx" Then
        '    BottomFooter.Visible = False
        'End If

        If IsLogin() Then
            'LogOutID.Visible = True
            'DasboardID.Visible = True
            Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By LogId DESC")
            Utility.lblAdd("Select UserName From UserInfo Where UserId=" & userid & "",lblusername)
            Utility.lblAdd("Select Email From UserInfo Where UserId=" & userid & "",lbluseremail)
        Else
            'logInID.Visible = True
            'SignUpID.Visible = True
        End If
    End Sub


    Private Function IsLogin() As Boolean
        Dim retVal As Boolean = False
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()
        Dim selectString = "SELECT * FROM UserLog_Data where  SessionId=@SessionId "
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
        cmd.Parameters.Add("SessionId", Data.SqlDbType.VarChar, 1000)
        cmd.Parameters("SessionId").Value = System.Web.HttpContext.Current.Session.SessionID
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        retVal = reader.HasRows
        conn.Close()
        Return retVal
    End Function


End Class

