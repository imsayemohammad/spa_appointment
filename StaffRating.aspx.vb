
Partial Class StaffRating
    Inherits System.Web.UI.Page

     Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If Not String.IsNullOrEmpty(System.Web.HttpContext.Current.Session.SessionID) Then
                Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By LogId DESC")
                Utility.lblAdd("Select (FirstName + ' ' + LastName) Name From Staff Where Staffid=" & Request.QueryString("id") & "",lblStaffName)
                Dim sessionid As String = System.Web.HttpContext.Current.Session.SessionID
                Dim dbsessionid As String = Utility.StringData("Select TOP 1 SessionId From UserLog_Data Where UserId =" & userid & "")
                loaddata()
                If sessionid = dbsessionid Then
                    'hdnuserid.Value = CType(userid, String)
                    'Response.Write(userid)
                    loaddata()
                Else
                    Response.Redirect("/login")
                End If
            Else
                Response.Redirect("/login")
            End If
        End If
    End Sub

    Protected Function GetServiceinfo(ByVal serviceid As Integer) As String
        Dim m As String = ""
        Dim connection = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
        Dim conn As New Data.SqlClient.SqlConnection(connection)
        conn.Open()
        Dim selectString = "Select Title, ArTitle From [dbo].[Services] Where ServiceId = @ServiceId AND Status = 1"
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
        cmd.Parameters.Clear()
        cmd.Parameters.Add("ServiceId", Data.SqlDbType.Int).Value = serviceid
        'cmd.Parameters.Add("StaffID", Data.SqlDbType.Int).Value = Request.QueryString("id")
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        While reader.Read()
            m += reader("Title").ToString()
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
            txtsearch.Text = Request.QueryString("search")
        End If

        If txtsearch.Text <> "" Then
            whereclause += "Where c.FirstName like '" & txtsearch.Text & "%' or c.LastName like '" & txtsearch.Text & "%' or (c.FirstName + ' ' + c.LastName) like '" & txtsearch.Text & "%' or c.Phone1 like'" & txtsearch.Text & "%'"
            conditionclause += "&search=" & txtsearch.Text & " "
        End If

        currentPage = If(Request.QueryString("page") <> "", Request.QueryString("page"), "1")
        pageSize = "10"
        searchCriteria = "/staffrating?id=" & Request.QueryString("id") & "&page="

        Dim sql As String = ""
        sql = "DECLARE @PageNum AS INT;DECLARE @PageSize AS INT;SET @PageNum =" & currentPage & ";SET @PageSize = " & pageSize & "; select *  from ( select  ROW_NUMBER() over( order by StaffID desc) AS RowNum , StaffRatingId, c.ClientId, StaffId, ServiceId, Rating, Comment, (c.FirstName + ' ' + c.LastName) Name, c.Phone1, c.Email From StaffRatings st INNER JOIN Client c ON st.ClientID = c.ClientID " & whereclause & " )as MyTable WHERE RowNum BETWEEN (@PageNum - 1) * @PageSize + 1 AND @PageNum * @PageSize  ORDER BY MyTable.RowNum desc "
        sdsstaffrating.SelectCommand = sql
        sdsstaffrating.DataBind()

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
            whereclause += "Where c.FirstName like '" & txtsearch.Text & "%' or c.LastName like '" & txtsearch.Text & "%' or (c.FirstName + ' ' + c.LastName) like '" & txtsearch.Text & "%' or c.Phone1 like'" & txtsearch.Text & "%'"
        End If

        Dim selectString = "Select Count(*) totalRows From StaffRatings st INNER JOIN Client c ON st.ClientID = c.ClientID " & whereclause & " "
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
                whand = " Where "
                linkcar = "?"
            Else
                whand = " AND "
                linkcar = "&"
            End If
            querystr += linkcar & "search=" & txtsearch.Text
            whclause = True

        End If

        If Request.QueryString("id") <> "" Then
            'Nothing
            If whclause = False Then
                whand = " Where "
                linkcar = "?"
            Else
                whand = " AND "
                linkcar = "&"
            End If
            querystr += linkcar & "id=" & Request.QueryString("id")
            whclause = True

        End If
        'Response.Redirect("/staffrating" & querystr &"&id=" & Request.QueryString("id"))
        Response.Redirect("/staffrating" & querystr)
    End Sub



    Protected Function GetRating(ByVal staffid As Integer) As String
        Dim m As String = ""
        Dim connection = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
        Dim conn As New Data.SqlClient.SqlConnection(connection)
        conn.Open()
        Dim selectString = "Select AVG(Rating) Rating From StaffRatings Where StaffId=@StaffId"
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
        cmd.Parameters.Clear()
        cmd.Parameters.Add("StaffId", Data.SqlDbType.Int).Value = staffid
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        While reader.Read()
            Dim rating = reader("Rating").ToString()
            m += rating.TrimEnd(New String({"0", "."}))
        End While

        reader.Close()
        conn.Close()

        Return m
    End Function

End Class
