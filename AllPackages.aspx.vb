
Partial Class AllPackages
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Not String.IsNullOrEmpty(System.Web.HttpContext.Current.Session.SessionID) Then
                Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By LogId DESC")

                Dim sessionid As String = System.Web.HttpContext.Current.Session.SessionID
                Dim dbsessionid As String = Utility.StringData("Select TOP 1 SessionId From UserLog_Data Where UserId =" & userid & "")
                loaddata()
                If sessionid = dbsessionid Then
                    loaddata()
                Else
                    Response.Redirect("/login")
                End If
            Else
                Response.Redirect("/login")
            End If
        End If
    End Sub
    Protected Sub loaddata()

        Dim currentPage As String
        Dim pageSize As String
        Dim pageNumber As String
        Dim searchCriteria As String
        Dim whereclause As String = ""
        Dim conditionclause As String = ""

        If Request.QueryString("search") <> "" Then
            txtsearch.Text = Request.QueryString("search")
        End If

        If txtsearch.Text <> "" Then
            whereclause += "and (Title like '%" & txtsearch.Text & "%' or ArTitle like '%" & txtsearch.Text & "%')"
            conditionclause += "&search=" & txtsearch.Text & " "
        End If

        currentPage = If(Request.QueryString("page") <> "", Request.QueryString("page"), "1")
        pageSize = "20"
        searchCriteria = "/packages?page="

        Dim sql As String = ""
        'sql = "DECLARE @PageNum AS INT;DECLARE @PageSize AS INT;SET @PageNum =" & currentPage & ";SET @PageSize = " & pageSize & "; select *  from ( select  ROW_NUMBER() over( order by ServiceId desc) AS RowNum , *  From appointment.vw_Service_Package_ListView  " & whereclause & " )as MyTable WHERE RowNum BETWEEN (@PageNum - 1) * @PageSize + 1 AND @PageNum * @PageSize  ORDER BY MyTable.RowNum desc "
        sql = "DECLARE @PageNum AS INT;DECLARE @PageSize AS INT;SET @PageNum =" & currentPage & ";SET @PageSize = " & pageSize & "; select *  from ( select  ROW_NUMBER() over( order by ServiceId desc) AS RowNum , *  From [dbo].[Services] Where IsPackage=1 And status = 1 And ParentId <> 0 " & whereclause & " )as MyTable WHERE RowNum BETWEEN (@PageNum - 1) * @PageSize + 1 AND @PageNum * @PageSize  ORDER BY MyTable.RowNum desc "
        sdsPackage.SelectCommand = sql
        sdsPackage.DataBind()

        pageNumber = getPageNumber(pageSize)
        ltlpag.Text = ""
        If pageNumber > 1 Then
            ltlpag.Text = Utility.GetPager(currentPage, pageNumber, 5, searchCriteria, conditionclause)
        End If

    End Sub
    Private Function getPageNumber(ByVal pageSize As Integer) As Integer

        Dim whereclause As String = ""
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()

        If Request.QueryString("search") <> "" Then
            txtsearch.Text = Request.QueryString("search")
        End If

        If txtsearch.Text <> "" Then
            whereclause += "and (Title like '%" & txtsearch.Text & "%' or ArTitle like '%" & txtsearch.Text & "%')"
        End If

        'Dim selectString = "Select Count(*) totalRows From Services where IsServiceGroup = 0 And status = 1 And IsPackage = 1 " & whereclause & " "
        Dim selectString = "Select Count(*) totalRows From [dbo].[Services] Where IsPackage=1 And status = 1 And ParentId <> 0 " & whereclause & " "
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        reader.Read()
        Dim totalRows As Integer = reader("totalRows").ToString()
        reader.Close()
        conn.Close()
        'lblsearchresult.Text = totalRows
        Return Math.Ceiling(totalRows / pageSize)
    End Function
    Protected Sub btnsearch_Click(sender As Object, e As EventArgs) Handles btnsearch.Click

        Dim whclause As Boolean
        Dim whand As String = ""
        Dim sql1 As String = ""
        Dim querystr As String = ""
        Dim linkcar As String = ""

        If txtsearch.Text <> "" Then
            'Nothing
            If whclause = False Then
                whand = " and "
                linkcar = "?"
            Else
                whand = " AND "
                linkcar = "&"
            End If
            querystr += linkcar & "search=" & txtsearch.Text
            whclause = True

        End If

        Response.Redirect("/packages" & querystr)
    End Sub

End Class
