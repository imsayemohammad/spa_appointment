
Imports System.Data
Imports System.Data.SqlClient

Partial Class Team
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If Not String.IsNullOrEmpty(Request.QueryString("id")) Then
                LoadTeamName(Request.QueryString("id"))
                LoadTeamMembers()
            End If



        End If

    End Sub

    Private Sub LoadTeamMembers()

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim query As String = "SELECT td.Status,td.TeamID,s.StaffID,td.Description,CONCAT(FirstName,' ',LastName) as FullName FROM TeamDetails td  join Staff s on td.StaffID=s.StaffID Where  td.Status=1 AND  td.TeamID=" + Request.QueryString("id")

        Dim table As DataTable = New DataTable()
        Dim da As SqlDataAdapter = New SqlDataAdapter(query, conn)

        da.Fill(table)
        lstTeamMemeber.DataSource = table
        lstTeamMemeber.DataBind()


        

    End Sub

    Private Sub LoadTeamName(queryString As String)


        Dim M As Integer
        Dim totalNumberOfProducts As Integer = 0
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "SELECT * FROM TeamMST Where TeamID=@s"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)

        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = queryString

        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()

        While reader.Read()
            ltrTeamName.Text = reader("TeamName").ToString()
        End While

        reader.Close()
        conn.Close()


    End Sub

    Protected Function GetTeamID() As Integer
        Dim i = 0


        Integer.TryParse(Request.QueryString("id"), i)

        Return i

    End Function


    '   DeleteMemberBySupplierId


    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteMemberBySupplierId(ByVal TeamID As String, ByVal StaffID As String) As String
        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")
        Dim M As Integer
        Dim totalNumberOfProducts As Integer = 0

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)



        conn.Open()



        Dim selectString = "UPDATE TeamDetails SET Status=@Status,UpdatedBy=@UpdatedBy,UpdatedDate=GETDATE() Where TeamID=@TeamID AND StaffID=@StaffID "
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@TeamID", Data.SqlDbType.BigInt).Value = TeamID
        cmd.Parameters.Add("@StaffID", Data.SqlDbType.BigInt).Value = StaffID
        cmd.Parameters.Add("@UpdatedBy", Data.SqlDbType.Int).Value = userID
        cmd.Parameters.Add("Status", Data.SqlDbType.Bit).Value = 0



        cmd.ExecuteNonQuery()
        conn.Close()


        

    End Function

End Class
