
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO

Partial Class ServiceGroups
    Inherits System.Web.UI.Page
    Dim userid As Integer = 0
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not String.IsNullOrEmpty(System.Web.HttpContext.Current.Session.SessionID) Then
            userid = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By LogId DESC")

            Dim sessionid As String = System.Web.HttpContext.Current.Session.SessionID
            Dim dbsessionid As String = Utility.StringData("Select TOP 1 SessionId From UserLog_Data Where UserId =" & userid & "")
            'LoadControl()
            LoadServiceGroups()
            If sessionid = dbsessionid Then
                If Page.IsPostBack = False Then
                    'LoadControl()
                    LoadServiceGroups()
                End If
            Else
                Response.Redirect("/login")
            End If
        Else
            Response.Redirect("/login")
        End If

        'If Page.IsPostBack = False Then
        '    LoadControl()
        '    LoadServiceGroups()
        'End If
    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        Try
            If txtSearch.Text.Trim.Length > 0 Then
                LoadServiceGroups()
            End If
        Catch ex As Exception

        End Try

    End Sub

    Private Sub LoadServiceGroups(Optional ByVal sSearch As String = "")
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim query As String
        Dim currentPage As String
        Dim pageSize As String
        Dim pageNumber As String
        Dim searchCriteria As String
        Dim whereclause As String = ""
        Dim conditionclause As String = ""

        If Request.QueryString("search") <> "" Then
            txtSearch.Text = Request.QueryString("search")
        End If

        If txtSearch.Text <> "" Then
            conditionclause += "&search=" & txtSearch.Text & " "
        End If

        currentPage = If(Request.QueryString("page") <> "", Request.QueryString("page"), "1")
        pageSize = "10"
        searchCriteria = "/ServiceGroups?page="


        If Not String.IsNullOrEmpty(txtSearch.Text) Then

            query = "DECLARE @PageNum AS INT; " &
                    "DECLARE @PageSize AS INT,@start as int,@End as Int,@Total int; " &
                    "SET @PageNum =" & currentPage & ";SET @PageSize = " & pageSize & ";  " &
                    "IF OBJECT_ID('tempdb..#t') IS NOT NULL  " &
                    "DROP TABLE #t; " &
                    "SELECT * INTO #t FROM ( " &
                    " select *  from (SELECT ROW_NUMBER() over( order by ServiceId desc) AS RowNum,* FROM Services where IsServiceGroup = 1 And status = 1 and (Title like '%" + txtSearch.Text + "%' or ArTitle like '%" + txtSearch.Text + "%'  or Description like '%" + txtSearch.Text + "%' or ArDescription like '%" + txtSearch.Text + "%' ))as MyTable WHERE RowNum BETWEEN (@PageNum - 1) * @PageSize + 1 AND @PageNum * @PageSize  " &
                    ") as s; " &
                    "SET @start=(SELECT top 1 RowNum FROM #t) ;  " &
                    "SET @End=(SELECT top 1 RowNum FROM #t ORDER BY RowNum DESC ) ; " &
                    "SET @Total=(SELECT Count(ServiceID) as totalRows  FROM Services where IsServiceGroup = 1 And status = 1 And IsPackage = 0 ); " &
                    "SELECT *,@start as [form] ,@End  as  [To],@Total as TotalRows FROM #t ORDER BY RowNum DESC;  "


        Else
            query = "DECLARE @PageNum AS INT; " &
                    "DECLARE @PageSize AS INT,@start as int,@End as Int,@Total int; " &
                    "SET @PageNum =" & currentPage & ";SET @PageSize = " & pageSize & ";  " &
                     "IF OBJECT_ID('tempdb..#t') IS NOT NULL  " &
                     "DROP TABLE #t; " &
                     "SELECT * INTO #t FROM ( " &
                    " select *  from (SELECT ROW_NUMBER() over( order by ServiceID desc) AS RowNum,* FROM Services where IsServiceGroup = 1 And status = 1 )as MyTable WHERE RowNum BETWEEN (@PageNum - 1) * @PageSize + 1 AND @PageNum * @PageSize  " &
                     ") as s; " &
                      "SET @start=(SELECT top 1 RowNum FROM #t) ;  " &
                    "SET @End=(SELECT top 1 RowNum FROM #t ORDER BY RowNum DESC ) ; " &
                     "SET @Total=(SELECT Count(ServiceID) as totalRows  FROM Services where IsServiceGroup = 1 And status = 1 ); " &
            "SELECT *,@start as [form] ,@End  as  [To],@Total as TotalRows FROM #t ORDER BY RowNum DESC;"
        End If
        Dim da As SqlDataAdapter = New SqlDataAdapter(query, conn)
        Dim table As DataTable = New DataTable()
        da.Fill(table)

        For Each o As Object In table.Rows
            lblStart.Text = o("form").ToString()
            lblEnd.Text = o("To").ToString()
            lblTotal.Text = o("TotalRows").ToString()
        Next


        lvGroup.DataSource = table
        lvGroup.DataBind()


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

        Dim selectString As String

        'If String.IsNullOrEmpty(txtSearch.Text) Then
        '    selectString = "SELECT Count(ServiceID) as totalRows  FROM Services where IsServiceGroup = 1 And status = 1 And IsPackage = 0  "
        'Else
        '    selectString = "Select  Count(ServiceID) as totalRows FROM Services where IsServiceGroup = 1 And status = 1 And IsPackage = 0 And (Title Like '%" & txtSearch.Text.ToString().Trim.Trim & "%') "
        'End If

        If String.IsNullOrEmpty(txtSearch.Text) Then
            selectString = "SELECT Count(ServiceID) as totalRows  FROM Services where IsServiceGroup = 1 And status = 1  "
        Else
            selectString = "Select  Count(ServiceID) as totalRows FROM Services where IsServiceGroup = 1 And status = 1  And (Title Like '%" & txtSearch.Text.ToString().Trim.Trim & "%') "
        End If


        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        reader.Read()
        Dim totalRows As Integer = reader("totalRows").ToString()
        reader.Close()
        conn.Close()
        'lblsearchresult.Text = totalRows
        Return Math.Ceiling(totalRows / pageSize)
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteServiceById(ByVal ServiceId As String) As String
        Try
            Dim parentid As Integer = Utility.IntegerData("SELECT ParentId FROM Services Where ServiceId='" & ServiceId & "'")
            If parentid = 0 Then
                'Dim servicecount As Integer = Utility.IntegerData("SELECT COUNT(ServiceId) FROM Services Where ServiceId='" & ServiceId & "'")
                Dim servicecount As Integer = Utility.IntegerData("SELECT COUNT(ServiceId) FROM Services Where  ParentId='" & ServiceId & "'")
                If servicecount > 0 Then
                    Return "Exist"
                Else
                    Using conn As New SqlConnection()
                        conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                        Using cmd As New SqlCommand()
                            cmd.CommandText = "delete FROM Services where ServiceId = @ServiceId or ParentId = @ServiceId"
                            cmd.Parameters.Clear()
                            cmd.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = ServiceId
                            cmd.Connection = conn
                            conn.Open()
                            cmd.ExecuteNonQuery()
                            cmd.Parameters.Clear()
                            cmd.Dispose()
                            conn.Close()
                        End Using
                        Return "success"
                    End Using
                End If
            Else
                Using conn As New SqlConnection()
                    conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
                    Using cmd As New SqlCommand()
                        cmd.CommandText = "delete FROM Services where ServiceId = @ServiceId"
                        cmd.Parameters.Clear()
                        cmd.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = ServiceId
                        cmd.Connection = conn
                        conn.Open()
                        cmd.ExecuteNonQuery()
                        cmd.Parameters.Clear()
                        cmd.Dispose()
                        conn.Close()
                    End Using
                End Using
                Return "success"
            End If
        Catch ex As Exception
            Return "Error"
        End Try
    End Function





    'Private Sub LoadControl()
    '    Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

    '    Dim hdServiceid As Integer = hdServiceid

    '    conn.Open()

    '    Try

    '        Dim selectString = "Select * FROM Services where IsServiceGroup = 1 And status = 1 And ServiceId <> " & hdServiceid & " And ParentId = 0 order by Title asc "
    '        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
    '        ddlGroup.Items.Clear()
    '        ddlGroup.Items.Add(New ListItem("Select Service Group", "0"))

    '        Dim objReaderb As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()

    '        If objReaderb.HasRows Then
    '            While objReaderb.Read()
    '                ddlGroup.Items.Add(New ListItem(objReaderb("Title"), objReaderb("ServiceId").ToString()))
    '                Dim selectChild = "Select * FROM Services where IsServiceGroup = 1 And status = 1 And ServiceId <> " & hdServiceid & "  And ParentId = " & objReaderb("ServiceId").ToString() & " order by Title asc "
    '                Dim cmdChild As SqlCommand = New SqlCommand(selectChild, conn)
    '                Dim objReaderChild As Data.SqlClient.SqlDataReader = cmdChild.ExecuteReader()

    '                If objReaderChild.HasRows Then
    '                    While objReaderChild.Read()
    '                        ddlGroup.Items.Add(New ListItem(objReaderb("Title") & "-->" & objReaderChild("Title"), objReaderChild("ServiceId").ToString()))
    '                        Dim selectChildChild = "Select * FROM Services where IsServiceGroup = 1 And status = 1  And ServiceId <> " & hdServiceid & "  And ParentId = " & objReaderChild("ServiceId").ToString() & " order by Title asc "
    '                        Dim cmdChildChild As SqlCommand = New SqlCommand(selectChildChild, conn)
    '                        Dim objReaderChildChild As Data.SqlClient.SqlDataReader = cmdChildChild.ExecuteReader()

    '                        If objReaderChildChild.HasRows Then
    '                            While objReaderChildChild.Read()
    '                                ddlGroup.Items.Add(New ListItem(objReaderb("Title") & "-->" & objReaderChild("Title") & "-->" & objReaderChildChild("Title"), objReaderChildChild("ServiceId").ToString()))
    '                            End While
    '                        End If
    '                    End While
    '                End If
    '            End While
    '        End If
    '        ddlGroup.SelectedValue = "0"
    '        objReaderb.Close()

    '    Catch ex As Exception

    '    End Try

    '    conn.Close()
    'End Sub

    '<System.Web.Services.WebMethod>
    'Public Shared Function upload(ByVal file As HttpContext) As String
    '    Dim Name As String = ""
    '    Try
    '        Dim c As String, prefix As String = ""
    '        Dim filesCollection As HttpFileCollection = HttpContext.Current.Request.Files
    '        Dim fileName = filesCollection(0)

    '        Name = System.IO.Path.GetFileName(fileName.FileName).Replace(" " & "%20", "_").ToString

    '        prefix = "Big_" & Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay)
    '        Name = prefix & "_" & Name

    '        Dim oFolder As String = System.AppDomain.CurrentDomain.BaseDirectory() & "\ContentImage\serviceIcons\"
    '        If (Not System.IO.Directory.Exists(oFolder)) Then
    '            System.IO.Directory.CreateDirectory(oFolder)
    '        End If

    '        Dim oFile As String = oFolder + Name


    '        fileName.SaveAs(HttpContext.Current.Server.MapPath(oFile))
    '    Catch ex As Exception

    '    End Try
    '    Return Name
    'End Function

    '<System.Web.Services.WebMethod()>
    'Public Shared Sub SaveData(ByVal ServiceGroupId As String, ByVal Title As String, ByVal Description As String, ByVal ParentId As String, ByVal ArTitle As String, ByVal ArDescription As String, ByVal IsPackage As String, ByVal BigIconOne As String, ByVal SmallIconOne As String)
    '    Try
    '        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")

    '        Dim con As String
    '        Dim sData As String = "0"
    '        Dim sDataNew As String = "0"

    '        Dim bSuccess As Boolean = False
    '        con = ConfigurationManager.ConnectionStrings("ConnectionString").ToString
    '        Dim cn As SqlConnection = New SqlConnection(con)
    '        cn.Open()

    '        Dim insertSQL As String = ""
    '        Dim updateSQL As String = ""

    '        If Not String.IsNullOrEmpty(ServiceGroupId) Then
    '            updateSQL = "update Services Set Title = @Title, Description = @Description, ArTitle = @ArTitle, ArDescription = @ArDescription, ParentId = @ParentId, UpdatedBy = @UpdatedBy,  UpdatedAt = @UpdatedAt, IsPackage = @IsPackage, BigIconOne = @BigIconOne, SmallIconOne =@SmallIconOne  where ServiceId = @ServiceId "

    '            Dim cmd2 As SqlCommand = New SqlCommand(updateSQL, cn)
    '            cmd2.Parameters.Add("Title", SqlDbType.NVarChar).Value = Title
    '            cmd2.Parameters.Add("Description", SqlDbType.NVarChar).Value = Description
    '            cmd2.Parameters.Add("ArTitle", SqlDbType.NVarChar).Value = ArTitle
    '            cmd2.Parameters.Add("ArDescription", SqlDbType.NVarChar).Value = ArDescription
    '            cmd2.Parameters.Add("ParentId", Data.SqlDbType.BigInt).Value = If(ParentId <> "", CInt(ParentId), 0)
    '            cmd2.Parameters.Add("UpdatedBy", SqlDbType.Int).Value = userID
    '            cmd2.Parameters.Add("UpdatedAt", SqlDbType.DateTime).Value = DateTime.Now
    '            cmd2.Parameters.Add("IsPackage", Data.SqlDbType.Bit).Value = CBool(IsPackage)
    '            cmd2.Parameters.Add("BigIconOne", SqlDbType.NVarChar).Value = BigIconOne
    '            cmd2.Parameters.Add("SmallIconOne", SqlDbType.NVarChar).Value = SmallIconOne
    '            cmd2.Parameters.Add("ServiceId", SqlDbType.BigInt).Value = ServiceGroupId
    '            cmd2.ExecuteNonQuery()
    '        Else

    '            insertSQL = "INSERT into Services(Title, Description, ArTitle, ArDescription, IsServiceGroup, Status, CreatedBy, CreatedAt, ParentId, IsPackage, BigIconOne, SmallIconOne)  values(@Title, @Description, @ArTitle, @ArDescription, @IsServiceGroup, @Status, @CreatedBy, @CreatedAt, @ParentId, @IsPackage, @BigIconOne, @SmallIconOne) "
    '            Dim cmd1 As SqlCommand = New SqlCommand(insertSQL, cn)
    '            cmd1.Parameters.Add("Title", SqlDbType.NVarChar).Value = Title
    '            cmd1.Parameters.Add("Description", SqlDbType.NVarChar).Value = Description
    '            cmd1.Parameters.Add("ArTitle", SqlDbType.NVarChar).Value = ArTitle
    '            cmd1.Parameters.Add("ArDescription", SqlDbType.NVarChar).Value = ArDescription
    '            cmd1.Parameters.Add("IsServiceGroup", SqlDbType.Bit).Value = True
    '            cmd1.Parameters.Add("Status", SqlDbType.Bit).Value = True
    '            cmd1.Parameters.Add("CreatedBy", SqlDbType.Int).Value = userID
    '            cmd1.Parameters.Add("CreatedAt", SqlDbType.DateTime).Value = DateTime.Now
    '            cmd1.Parameters.Add("ParentId", Data.SqlDbType.BigInt).Value = If(ParentId <> "", CInt(ParentId), 0)
    '            cmd1.Parameters.Add("IsPackage", Data.SqlDbType.Bit).Value = CBool(IsPackage)
    '            cmd1.Parameters.Add("BigIconOne", SqlDbType.NVarChar).Value = BigIconOne
    '            cmd1.Parameters.Add("SmallIconOne", SqlDbType.NVarChar).Value = SmallIconOne
    '            cmd1.ExecuteNonQuery()
    '        End If

    '        cn.Close()
    '    Catch ex As Exception

    '    End Try

    '    'Try
    '    '    Dim c As String, prefix As String = ""
    '    '    Dim filesCollection As HttpFileCollection = HttpContext.Current.Request.Files
    '    '    Dim fileName = filesCollection(0)

    '    '    Dim Name As String = System.IO.Path.GetFileName(fileName.FileName).Replace(" " & "%20", "_").ToString

    '    '    prefix = "Big_" & Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay)
    '    '    Name = prefix & "_" & Name

    '    '    Dim oFolder As String = System.AppDomain.CurrentDomain.BaseDirectory() & "\ContentImage\serviceIcons\"
    '    '    If (Not System.IO.Directory.Exists(oFolder)) Then
    '    '        System.IO.Directory.CreateDirectory(oFolder)
    '    '    End If

    '    '    Dim oFile As String = oFolder + Name


    '    '    fileName.SaveAs(HttpContext.Current.Server.MapPath(oFile))
    '    'Catch ex As Exception

    '    'End Try

    'End Sub

    '<System.Web.Services.WebMethod()>
    'Public Shared Function ServiceById(ByVal ServiceId As String) As ServiceGroupModel
    '    Dim group As New ServiceGroupModel


    '    Using conn As New SqlConnection()
    '        conn.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
    '        Using cmd As New SqlCommand()
    '            cmd.CommandText = "Select * FROM Services where IsServiceGroup = 1 And status = 1  And ServiceId = @ServiceId"
    '            cmd.Parameters.Clear()
    '            cmd.Parameters.Add("ServiceId", Data.SqlDbType.BigInt).Value = ServiceId
    '            cmd.Connection = conn
    '            conn.Open()
    '            Using reader As SqlDataReader = cmd.ExecuteReader()
    '                While reader.Read()
    '                    group.ServiceId = If(reader("ServiceId") Is DBNull.Value, "", reader("ServiceId").ToString())
    '                    group.Title = If(reader("Title") Is DBNull.Value, "", reader("Title").ToString())
    '                    group.Description = If(reader("Description") Is DBNull.Value, "", reader("Description").ToString())
    '                    group.ArTitle = If(reader("ArTitle") Is DBNull.Value, "", reader("ArTitle").ToString())
    '                    group.ArDescription = If(reader("ArDescription") Is DBNull.Value, "", reader("ArDescription").ToString())
    '                    group.ParentId = If(reader("ParentId") Is DBNull.Value, "", reader("ParentId").ToString())
    '                    group.Color = If(reader("Color") Is DBNull.Value, "", reader("Color").ToString())
    '                    group.IsPackage = If(reader("IsPackage") Is DBNull.Value Or reader("IsPackage") = "0", "", "on")
    '                    group.BigIconOne = If(reader("BigIconOne") Is DBNull.Value, "", System.AppDomain.CurrentDomain.BaseDirectory() & "ContentImage/serviceIcons/" & reader("BigIconOne").ToString())
    '                    group.SmallIconOne = If(reader("SmallIconOne") Is DBNull.Value, "", reader("SmallIconOne").ToString())
    '                    group.SmallIconTwo = If(reader("SmallIconTwo") Is DBNull.Value, "", reader("SmallIconTwo").ToString())

    '                End While
    '            End Using
    '            conn.Close()
    '        End Using
    '        Return group
    '    End Using
    'End Function

    '<System.Web.Services.WebMethod()>
    'Public Shared Function UploadSource(ByVal Image As String, ByVal ImageName As String) As String
    '    Try
    '        Dim getImageData As Byte() = Convert.FromBase64String(Image)

    '        '''' Upload Image File
    '        Dim c As String, prefix As String = ""

    '        Dim Name As String = ImageName.Replace(" " & "%20", "_").ToString
    '        prefix = "Big_" & Day(Now()) & Month(Now()) & Year(Now()) & Hour(TimeOfDay) & Minute(TimeOfDay) & Second(TimeOfDay)
    '        Name = prefix & "_" & Name

    '        Dim oFolder As String = System.AppDomain.CurrentDomain.BaseDirectory() & "\ContentImage\serviceIcons\"
    '        If (Not System.IO.Directory.Exists(oFolder)) Then
    '            System.IO.Directory.CreateDirectory(oFolder)
    '        End If

    '        Dim oFile As String = oFolder + Name

    '        If Not File.Exists(oFile) Then
    '            File.WriteAllBytes(oFile, getImageData)
    '        End If

    '        ''''' Save Original Photo

    '        'fileName.SaveAs(HttpContext.Current.Server.MapPath(oFile))

    '        Return Name

    '    Catch ex As Exception

    '    End Try

    '    Return ""
    'End Function

End Class
