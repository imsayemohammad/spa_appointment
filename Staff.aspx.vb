
Imports System.Data.SqlClient

Partial Class Staff
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            If Not String.IsNullOrEmpty(System.Web.HttpContext.Current.Session.SessionID) Then
                Dim userid As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By LogId DESC")

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
            dim rating = reader("Rating").ToString()
            m += rating.TrimEnd(New String({"0", "."}))
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
            whereclause += "Where FirstName like '" & txtsearch.Text & "%' or LastName like '" & txtsearch.Text & "%' or (FirstName + ' ' + LastName) like '" & txtsearch.Text & "%' or Phone1 like'" & txtsearch.Text & "%'"
            conditionclause += "&search=" & txtsearch.Text & " "
        End If

        currentPage = If(Request.QueryString("page") <> "", Request.QueryString("page"), "1")
        pageSize = "10"
        searchCriteria = "/staff?page="

        Dim sql As String = ""
        sql = "DECLARE @PageNum AS INT;DECLARE @PageSize AS INT;SET @PageNum =" & currentPage & ";SET @PageSize = " & pageSize & "; select *  from ( select  ROW_NUMBER() over( order by StaffID desc) AS RowNum , *,(FirstName + ' ' + LastName) Name From Staff " & whereclause & " )as MyTable WHERE RowNum BETWEEN (@PageNum - 1) * @PageSize + 1 AND @PageNum * @PageSize  ORDER BY MyTable.RowNum desc "
        sdsstaff.SelectCommand = sql
        sdsstaff.DataBind()

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
            whereclause += "Where FirstName like '" & txtsearch.Text & "%' or LastName like '" & txtsearch.Text & "%' or (FirstName + ' ' + LastName) like '" & txtsearch.Text & "%' or Phone1 like'" & txtsearch.Text & "%'"
        End If

        Dim selectString = "Select Count(*) totalRows From Staff " & whereclause & " "
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

        Response.Redirect("/staff" & querystr)
    End Sub



    <System.Web.Services.WebMethod()>
    Public Shared Sub SaveData(ByVal staffid As String, ByVal FirstName As String, ByVal LastName As String, ByVal Phone As String, ByVal Email As String, ByVal Notes As String, ByVal StartDate As String, ByVal EndDate As String, ByVal Permission As String)
        'Dim userID As Integer = CType(HttpContext.Current.Request.Cookies("aUserID").Value.ToString(), Integer)
        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")

        If Not String.IsNullOrEmpty(FirstName) Then
            Dim selectString As String = ""
            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
            conn.Open()
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
            If Not String.IsNullOrEmpty(staffid) Then
                selectString = "UPDATE [Staff] SET [FirstName] = @FirstName, [LastName] = @LastName, [Phone1] = @Phone1, [Email] = @Email, [Notes] = @Notes, [StartDate] = @StartDate, [EndDate] = @EndDate, [UserPermission] = @UserPermission, [UpdatedBy] = @ChangeBy, [UpdatedDate] = Getdate() WHERE [StaffID] = @StaffID"
                cmd.Parameters.Add("StaffID", Data.SqlDbType.Int).Value = staffid
            Else
                selectString = "INSERT INTO [Staff] ([FirstName], [LastName], [Phone1], [Email], [Notes], [StartDate], [EndDate], [UserPermission], [CreateBy], [CreateDate]) VALUES (@FirstName, @LastName, @Phone1, @Email, @Notes, @StartDate, @EndDate, @UserPermission, @ChangeBy, Getdate())"
            End If

            cmd.Parameters.Add("FirstName", Data.SqlDbType.NVarChar).Value = FirstName
            cmd.Parameters.Add("LastName", Data.SqlDbType.NVarChar).Value = LastName
            cmd.Parameters.Add("Phone1", Data.SqlDbType.NVarChar).Value = Phone
            cmd.Parameters.Add("Email", Data.SqlDbType.NVarChar).Value = Email
            cmd.Parameters.Add("Notes", Data.SqlDbType.NVarChar).Value = Notes
            cmd.Parameters.Add("StartDate", Data.SqlDbType.DateTime).Value = StartDate
            cmd.Parameters.Add("EndDate", Data.SqlDbType.DateTime).Value = EndDate
            cmd.Parameters.Add("UserPermission", Data.SqlDbType.NVarChar).Value = Permission
            cmd.Parameters.Add("ChangeBy", Data.SqlDbType.Int).Value = userID

            cmd.CommandText = selectString
            cmd.ExecuteNonQuery()

            conn.Close()
        End If
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function StaffByStaffId(ByVal StaffId As String) As StaffModel
        Dim staff As New StaffModel
        Using conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
            Using cmd As New SqlCommand()
                cmd.CommandText = "SELECT * FROM [Staff] Where StaffID=@StaffID"
                cmd.Parameters.Clear()
                cmd.Parameters.Add("@StaffID", Data.SqlDbType.Int).Value = StaffId
                cmd.Connection = conn
                conn.Open()
                Using reader As SqlDataReader = cmd.ExecuteReader()
                    While reader.Read()
                        Dim strtdate = CDate(reader("StartDate"))
                        Dim enddate = CDate(reader("EndDate"))
                        staff.StaffId = reader("StaffID").ToString()
                        staff.FirstName = reader("FirstName").ToString()
                        staff.LastName = reader("LastName").ToString()
                        staff.Phone = reader("Phone1").ToString()
                        staff.Email = reader("Email").ToString()
                        staff.Notes = reader("Notes").ToString()
                        staff.StartDate = Utility.Dayformat(strtdate).ToString()
                        staff.EndDate = Utility.Dayformat(enddate).ToString()
                        staff.Permission = reader("UserPermission").ToString()
                    End While
                End Using
                conn.Close()
            End Using
            Return staff
        End Using
    End Function
End Class
