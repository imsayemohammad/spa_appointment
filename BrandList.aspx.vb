
Imports System.Data
Imports System.Data.SqlClient
Imports Microsoft.Ajax.Utilities

Partial Class BrandList
    Inherits System.Web.UI.Page



    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")

        If userID = 0 Then
            Response.Redirect("/login")
        Else
            LoadBrands()
        End If










    End Sub






    <System.Web.Services.WebMethod()>
    Public Shared Function GetBrandById(ByVal BrandId As String) As Brand


        Dim brand = New Brand()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "SELECT  top 1 * FROM Brand Where BrandID=@s"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = BrandId

        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()


        While reader.Read()
            brand.BrandID = reader("BrandID").ToString()
            brand.BrandName = reader("Title").ToString()
            brand.BrandDetails = reader("Smalldetails").ToString()
        End While

        reader.Close()
        conn.Close()

        Return brand

    End Function







    Private Sub LoadBrands()

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
        pageSize = "3"
        searchCriteria = "/brand?page="







        If String.IsNullOrEmpty(txtSearch.Text) Then
         
            query = "DECLARE @PageNum AS INT; " &
                    "DECLARE @PageSize AS INT,@start as int,@End as Int,@Total int; " &
                    "SET @PageNum =" & currentPage & ";SET @PageSize = " & pageSize & ";  " &
                    "IF OBJECT_ID('tempdb..#t') IS NOT NULL  " &
                    "DROP TABLE #t; " &
                    "SELECT * INTO #t FROM ( " &
                    " select *  from (SELECT ROW_NUMBER() over( order by BrandID desc) AS RowNum,*   FROM Brand Where Title like '%"+txtSearch.Text+"%' )as MyTable WHERE RowNum BETWEEN (@PageNum - 1) * @PageSize + 1 AND @PageNum * @PageSize  " &
                    ") as s; " &
                    "SET @start=(SELECT top 1 RowNum FROM #t) ;  " &
                    "SET @End=(SELECT top 1 RowNum FROM #t ORDER BY RowNum DESC ) ; " &
                    "SET @Total=(SELECT COUNT(*) FROM Brand); " &
                    "SELECT *,@start as [form] ,@End  as  [To],@Total as TotalRows FROM #t ORDER BY RowNum DESC;  "


        Else
            query = "DECLARE @PageNum AS INT; " &
                    "DECLARE @PageSize AS INT,@start as int,@End as Int,@Total int; " &
                    "SET @PageNum =" & currentPage & ";SET @PageSize = " & pageSize & ";  " &
                     "IF OBJECT_ID('tempdb..#t') IS NOT NULL  " &
                     "DROP TABLE #t; " &
                     "SELECT * INTO #t FROM ( " &
                    " select *  from (SELECT ROW_NUMBER() over( order by BrandID desc) AS RowNum,*   FROM Brand )as MyTable WHERE RowNum BETWEEN (@PageNum - 1) * @PageSize + 1 AND @PageNum * @PageSize  " &
                     ") as s; " &
                      "SET @start=(SELECT top 1 RowNum FROM #t) ;  " &
                    "SET @End=(SELECT top 1 RowNum FROM #t ORDER BY RowNum DESC ) ; " &
                     "SET @Total=(SELECT COUNT(*) FROM Brand); " &
            "SELECT *,@start as [form] ,@End  as  [To],@Total as TotalRows FROM #t ORDER BY RowNum DESC;"
        End If








        Dim da As SqlDataAdapter = New SqlDataAdapter(query, conn)
        Dim table As DataTable = New DataTable()

       

        da.Fill(table)

        For Each o As object In table.Rows
           
           

            lblStart.Text=o("form").ToString()
            lblEnd.Text=o("To").ToString()
            lblTotal.Text=o("TotalRows").ToString()

             
        Next


        lstBrand.DataSource = table
        lstBrand.DataBind()

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



        If String.IsNullOrEmpty(txtSearch.Text) Then
            selectString = "SELECT Count(BrandID) as totalRows  FROM Brand "
        Else
            selectString = "SELECT Count(BrandID) as totalRows  FROM Brand Where Title  Like '%" + txtSearch.Text + "%' "
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

    Public Class Brand
        Public Property BrandID() As String
        Public Property BrandName() As String
        Public Property BrandDetails() As String


    End Class


    Protected Sub SaveSupplierData(sender As Object, e As EventArgs) Handles btnsave.Click

        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")


        If Not String.IsNullOrEmpty(txtBrand.Text) Then

            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

            conn.Open()

            Dim M As String = ""
            Dim selectString = ""
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)

            If Not String.IsNullOrEmpty(hidBrandID.Value) Then
                selectString = "UPDATE Brand SET Title=@Title,Smalldetails=@Smalldetails,UpdatedBy=@CreateBy,UpdatedDate=GETDATE() Where BrandID=@BrandID"
                cmd.Parameters.Add("BrandID", Data.SqlDbType.Int).Value = hidBrandID.Value
            Else
                selectString = "INSERT INTO [Brand] (Title,Smalldetails,CreateDate,CreateBy) VALUES (@Title,@Smalldetails,GETDATE(),@CreateBy)"
            End If

            cmd.Parameters.Add("Title", Data.SqlDbType.NVarChar).Value = txtBrand.Text
            cmd.Parameters.Add("Smalldetails", Data.SqlDbType.NVarChar).Value = txtBrandDetails.Text
            cmd.Parameters.Add("CreateBy", Data.SqlDbType.Int).Value = userID

            cmd.CommandText = selectString

            M = cmd.ExecuteNonQuery

            If M > 0 Then
                LoadBrands()
            End If


            conn.Close()

        End If


    End Sub



    <System.Web.Services.WebMethod()>
    Public Shared Function SaveBrand(ByVal BrandName As String, ByVal BrandDetails As String, ByVal BrandID As String)




        Dim userID As Integer = GetUserIDByUserName(HttpContext.Current.Request.Cookies("auserName").Value.ToString())


        If Not String.IsNullOrEmpty(BrandName) Or Not String.IsNullOrEmpty(BrandDetails) Then

            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

            conn.Open()

            Dim M As String = ""
            Dim selectString = ""
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)

            If Not String.IsNullOrEmpty(BrandID) Then
                selectString = "UPDATE Brand SET Title=@Title,Smalldetails=@Smalldetails,UpdatedBy=@CreateBy,UpdatedDate=GETDATE() Where BrandID=@BrandID"
                cmd.Parameters.Add("BrandID", Data.SqlDbType.Int).Value = BrandID
            Else
                selectString = "INSERT INTO [Brand] (Title,Smalldetails,CreateDate,CreateBy) VALUES (@Title,@Smalldetails,GETDATE(),@CreateBy)"
            End If

            cmd.Parameters.Add("Title", Data.SqlDbType.NVarChar).Value = BrandName
            cmd.Parameters.Add("Smalldetails", Data.SqlDbType.NVarChar).Value = BrandDetails
            cmd.Parameters.Add("CreateBy", Data.SqlDbType.Int).Value = userID

            cmd.CommandText = selectString

            M = cmd.ExecuteNonQuery


            conn.Close()

        End If

    End Function






    Private Shared Function GetUserIDByUserName(s As String) As Integer


        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        Dim userId As Integer = 0

        conn.Open()

        Dim selectString = "SELECT  top 1 * FROm UserInfo Where UserName=@s"


        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.NVarChar).Value = s

        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()



        While reader.Read()

            Integer.TryParse(reader("UserId").ToString(), userId)

        End While

        reader.Close()
        conn.Close()

        Return userId
    End Function




End Class
