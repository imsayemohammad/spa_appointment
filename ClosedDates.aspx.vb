
Imports System.Data.SqlClient


Partial Class ClosedDates
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If Not String.IsNullOrEmpty(System.Web.HttpContext.Current.Session.SessionID) Then
                Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By LogId DESC")

                Dim sessionid As String = System.Web.HttpContext.Current.Session.SessionID
                Dim dbsessionid As String = Utility.StringData("Select TOP 1 SessionId From UserLog_Data Where UserId =" & userid & "")
                loaddata()
                If sessionid = dbsessionid Then
                    hdnuserid.Value = CType(userid, String)
                    'txtsearchdate.Text = Utility.Dayformat(DateTime.Now).ToString()
                    'Response.Write(userid)
                    loaddata()
                Else
                    'Response.Redirect("/login")
                End If
            Else
                Response.Redirect("/login")
            End If
        End If
    End Sub

    Protected Function GetLocationData(ByVal closeddatesid As Integer) As String
        Dim m As String = ""
        Dim connection = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
        Dim count As Integer = Utility.IntegerData("SELECT Count(ClosedDatesId) countdata FROM ClosedDatesLocation Where ClosedDatesId=" & closeddatesid & "")
        Dim conn As New Data.SqlClient.SqlConnection(connection)
        conn.Open()

        Dim selectString = "Select a.AreaId, a.AreaName From ClosedDatesLocation cdl INNER JOIN Areas a ON cdl.AreaId = a.AreaId Where ClosedDatesId=@ClosedDatesId"
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
        cmd.Parameters.Clear()
        cmd.Parameters.Add("ClosedDatesId", Data.SqlDbType.Int).Value = closeddatesid
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        While reader.Read()
            m += reader("AreaName").ToString()

            If count <> 0 Then
                If count > 1 Then
                    m += "<br /> "
                End If
            End If
        End While

        reader.Close()
        conn.Close()

        Return m
    End Function

    Protected Sub loaddata()

        Dim currentPage As String
        Dim pageSize As String
        Dim pageNumber As String
        Dim searchCriteria As String
        Dim whereclause As String = ""
        Dim conditionclause As String = ""

        If Request.QueryString("search") <> "" Then
            txtsearchdate.Text = Request.QueryString("search")
        End If

        If txtsearchdate.Text <> "" Then
            'whereclause += "Where StartDate like '" & txtsearchdate.Text & "%' or PhoneNo like '" & txtsearch.Text & "%' or PhoneNo2 like'" & txtsearch.Text & "%' or Email like'" & txtsearch.Text & "%' or Email2 like '" & txtsearch.Text & "%' or City like '" & txtsearch.Text & "%' "
            whereclause += "Where convert(varchar, StartDate, 101) like '" & txtsearchdate.Text & "%' "
            conditionclause += "&search=" & txtsearchdate.Text & " "
        End If

        currentPage = If(Request.QueryString("page") <> "", Request.QueryString("page"), "1")
        pageSize = "10"
        searchCriteria = "/ClosedDates?page="

        Dim sql As String = ""
        sql = "DECLARE @PageNum AS INT;DECLARE @PageSize AS INT;SET @PageNum =" & currentPage & ";SET @PageSize = " & pageSize & "; select *  from ( select  ROW_NUMBER() over( order by ClosedDatesId desc) AS RowNum , ClosedDatesId, StartDate, EndDate, Description From ClosedDates " & whereclause & " )as MyTable WHERE RowNum BETWEEN (@PageNum - 1) * @PageSize + 1 AND @PageNum * @PageSize  ORDER BY MyTable.RowNum desc "
        'sql = "DECLARE @PageNum AS INT;DECLARE @PageSize AS INT;SET @PageNum =" & currentPage & ";SET @PageSize = " & pageSize & ";SELECT *  from ( select  ROW_NUMBER() over( order by ID desc) AS RowNum , * ClosedDates cd LEFT JOIN ClosedDatesLocation cdl ON cd.ClosedDatesId = cdl.ClosedDatesId where cd.ClosedDatesId is not null " & sql1 & ") as MyTable WHERE RowNum BETWEEN (@PageNum - 1) * @PageSize + 1 AND @PageNum * @PageSize  ORDER BY ID desc  "
        sdscloseddates.SelectCommand = sql
        sdscloseddates.DataBind()

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
            txtsearchdate.Text = Request.QueryString("search")
        End If

        If txtsearchdate.Text <> "" Then
            whereclause += "Where convert(varchar, StartDate, 101) like '" & txtsearchdate.Text & "%'"
            'whereclause += "Where Name like '" & txtsearchdate.Text & "%' or PhoneNo like '" & txtsearchdate.Text & "%' or PhoneNo2 like'" & txtsearch.Text & "%' or Email like'" & txtsearch.Text & "%' or Email2 like '" & txtsearch.Text & "%' or City like '" & txtsearch.Text & "%' "
        End If

        Dim selectString = "Select Count(*) totalRows From ClosedDates " & whereclause & " "
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

        If txtsearchdate.Text <> "" Then
            'Nothing
            If whclause = False Then
                whand = " Where "
                linkcar = "?"
            Else
                whand = " AND "
                linkcar = "&"
            End If
            querystr += linkcar & "search=" & txtsearchdate.Text
            whclause = True

        End If

        Response.Redirect("/ClosedDates" & querystr)
    End Sub


    'Private Function getPageNumber(ByVal pageSize As Integer, whereclause As String) As Integer

    '    Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
    '    conn.Open()

    '    Dim selectString = "SELECT Count(*) totalRows From ClosedDates cd LEFT JOIN ClosedDatesLocation cdl ON cd.ClosedDatesId = cdl.ClosedDatesId where cd.ClosedDatesId is not null " & whereclause

    '    Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
    '    Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
    '    reader.Read()
    '    Dim totalRows As Integer = reader("totalRows").ToString()
    '    'lbltotalGiftCard.Text = totalRows
    '    reader.Close()
    '    conn.Close()

    '    Return Math.Ceiling(totalRows / pageSize)

    'End Function

End Class
