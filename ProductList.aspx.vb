
Imports System.Data
Imports System.Data.SqlClient
Imports Org.BouncyCastle.Math

Partial Class ProductList
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")

        If userID = 0 Then
            Response.Redirect("/login")
        End If

        If Not IsPostBack Then
            LoadCategory()
            LoadBrand()
            LoadSupplier()
            LoadVat()
        End If

        LoadProducts()
    End Sub




    Private Sub LoadVat()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim ds = New DataSet()
        Dim myda = New SqlDataAdapter("SELECT 0 as VatId,' Select Vat ' as VatTitle FROM Supplier UNION SELECT VatId,VatTitle FROM Vat", conn)

        myda.Fill(ds)

        dropDownVatList.DataSource = ds
        dropDownVatList.DataValueField = "VatId"
        dropDownVatList.DataTextField = "VatTitle"
        dropDownVatList.DataBind()

    End Sub




    Private Sub LoadProducts()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim query As String
        Dim currentPage As String
        Dim pageSize As String
        Dim pageNumber As String
        Dim searchCriteria As String
        Dim conditionclause As String = ""


        If Request.QueryString("search") <> "" Then
            txtSearch.Text = Request.QueryString("search")
        End If

        If dropDownSupplierListSaerch.SelectedValue <> 0 Then
            conditionclause += "&search=" & txtSearch.Text & ""
        End If

        If dropDownSupplierListSaerch.SelectedValue <> 0 Then
            conditionclause += "&supplier=" & dropDownSupplierListSaerch.SelectedValue & ""
        End If

        If Request.QueryString("supplier") <> "" Then
            dropDownSupplierListSaerch.SelectedValue = Request.QueryString("supplier")
        End If

        If dropDownBrandListSearch.SelectedValue <> 0 Then
            conditionclause += "&brand=" & dropDownBrandListSearch.SelectedValue & ""
        End If

        If Request.QueryString("brand") <> "" Then
            dropDownBrandListSearch.SelectedValue = Request.QueryString("brand")
        End If

        If dropDownCategoryListSearch.SelectedValue <> 0 Then
            conditionclause += "&category=" & dropDownCategoryListSearch.SelectedValue & ""
        End If

        If Request.QueryString("category") <> "" Then
            dropDownCategoryListSearch.SelectedValue = Request.QueryString("category")
        End If

        currentPage = If(Request.QueryString("page") <> "", Request.QueryString("page"), "1")
        pageSize = "5"
        searchCriteria = "/products?page="

        Dim search = String.Empty
        If Not String.IsNullOrEmpty(txtSearch.Text) Or Not dropDownBrandListSearch.SelectedItem.Value = 0 Or Not dropDownSupplierListSaerch.SelectedItem.Value = 0 Or Not dropDownCategoryListSearch.SelectedItem.Value = 0 Then

            Dim andd = False

            If Not String.IsNullOrEmpty(txtSearch.Text) Then
                If andd Then
                    search += "  AND "
                End If
                search += "(ProductTitle like '%" + txtSearch.Text + "%' "
                search += "OR BarCode like '%" + txtSearch.Text + "%' )"
                andd = True
            End If

            If Not dropDownSupplierListSaerch.SelectedItem.Value = 0 Then
                If andd Then
                    search += "  AND "
                End If
                search += "SupplierID=" + dropDownSupplierListSaerch.SelectedItem.Value
                andd = True
            End If


            If Not dropDownBrandListSearch.SelectedItem.Value = 0 Then
                If andd Then
                    search += "  AND "
                End If
                search += "BrandID=" + dropDownBrandListSearch.SelectedItem.Value
                andd = True
            End If


            If Not dropDownCategoryListSearch.SelectedItem.Value = 0 Then
                If andd Then
                    search += "  AND "
                End If
                search += "CategoryID=" + dropDownCategoryListSearch.SelectedItem.Value
                andd = True
            End If

            If Not String.IsNullOrEmpty(search) Then
                query = "DECLARE @PageNum AS INT;DECLARE @PageSize AS INT;SET @PageNum =" & currentPage & ";SET @PageSize = " & pageSize & "; select *  from (SELECT ROW_NUMBER() over( order by ProductId desc) AS RowNum,*   FROM vb_PorudtStock  " + "  Where  " + search + "  )as MyTable WHERE RowNum BETWEEN (@PageNum - 1) * @PageSize + 1 AND @PageNum * @PageSize  ORDER BY MyTable.RowNum desc"
            End If
        Else
            query = "DECLARE @PageNum AS INT;DECLARE @PageSize AS INT;SET @PageNum =" & currentPage & ";SET @PageSize = " & pageSize & "; select *  from (SELECT ROW_NUMBER() over( order by ProductId desc) AS RowNum,*   FROM vb_PorudtStock   )as MyTable WHERE RowNum BETWEEN (@PageNum - 1) * @PageSize + 1 AND @PageNum * @PageSize  ORDER BY MyTable.RowNum desc"
        End If

        Dim table As DataTable = New DataTable()
        Dim da As SqlDataAdapter = New SqlDataAdapter(query, conn)

        da.Fill(table)
        lstProducts.DataSource = table
        lstProducts.DataBind()

        pageNumber = getPageNumber(pageSize, search)
        ltlpag.Text = ""

        If pageNumber > 1 Then
            ltlpag.Text = Utility.GetPager(currentPage, pageNumber, 5, searchCriteria, conditionclause)
        End If

    End Sub




    Private Function getPageNumber(ByVal pageSize As Integer, query As String) As Integer
        Dim whereclause As String = ""
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()
        Dim selectString As String

        If String.IsNullOrEmpty(query) Then
            selectString = "SELECT Count(ProductId) as totalRows  FROM  vb_PorudtStock"
        Else
            selectString = "SELECT Count(ProductId) as totalRows  FROM  vb_PorudtStock  Where " + query
        End If

        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        reader.Read()
        Dim totalRows As Integer = reader("totalRows").ToString()
        reader.Close()
        conn.Close()
        Return Math.Ceiling(totalRows / pageSize)
    End Function


    Private Sub LoadSupplier()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim ds = New DataSet()
        Dim myda = New SqlDataAdapter("SELECT 0 as SupplierID,' Select Supplier ' as SupplierName FROM Supplier UNION SELECT SupplierID,SupplierName FROM Supplier", conn)

        myda.Fill(ds)

        dropDownSupplierList.DataSource = ds
        dropDownSupplierList.DataValueField = "SupplierID"
        dropDownSupplierList.DataTextField = "SupplierName"
        dropDownSupplierList.DataBind()

        dropDownSupplierListSaerch.DataSource = ds
        dropDownSupplierListSaerch.DataValueField = "SupplierID"
        dropDownSupplierListSaerch.DataTextField = "SupplierName"
        dropDownSupplierListSaerch.DataBind()
    End Sub



    Private Sub LoadBrand()

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim ds = New DataSet()
        Dim myda = New SqlDataAdapter("SELECT 0 as BrandID,' Select Brand ' as Title FROM Brand UNION SELECT BrandID,Title FROM Brand", conn)

        myda.Fill(ds)

        dropDownBrandList.DataSource = ds
        dropDownBrandList.DataValueField = "BrandID"
        dropDownBrandList.DataTextField = "Title"
        dropDownBrandList.DataBind()


        dropDownBrandListSearch.DataSource = ds
        dropDownBrandListSearch.DataValueField = "BrandID"
        dropDownBrandListSearch.DataTextField = "Title"
        dropDownBrandListSearch.DataBind()
    End Sub



    Private Sub LoadCategory()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim ds = New DataSet()
        Dim myda = New SqlDataAdapter("SELECT * FROM VW_Category ", conn)

        myda.Fill(ds)

        dropDownCategoryList.DataSource = ds
        dropDownCategoryList.DataValueField = "CategoryID"
        dropDownCategoryList.DataTextField = "Title"
        dropDownCategoryList.DataBind()


        dropDownCategoryListSearch.DataSource = ds
        dropDownCategoryListSearch.DataValueField = "CategoryID"
        dropDownCategoryListSearch.DataTextField = "Title"
        dropDownCategoryListSearch.DataBind()
    End Sub


    Protected Sub SaveSupplierData(sender As Object, e As EventArgs) Handles btnSave.Click
        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")
        Dim selectString As String = ""
        Dim productId As String = ""
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)
        Dim M = 0
        Dim reorderPoint = 0
        Dim reorderQty = 0


        If Not dropDownCategoryList.SelectedItem.Value = 0 And Not dropDownBrandList.SelectedItem.Value = 0 Then
            If Not String.IsNullOrEmpty(hdProductid.Value) And Not hdProductid.Value.Equals("0") Then
                selectString = "UPDATE Product SET     ArDescription=@ArDescription,ArProductTitle=@ArProductTitle,SupplierID=@SupplierID,CategoryID=@CategoryID,BrandID=@BrandID,ProductTitle=@ProductTitle,ProductCode=@ProductCode,BarCode=@BarCode,Description=@Description,MoreDescription=@MoreDescription,MadeIn=@MadeIn,MadeFor=@MadeFor,MarketPrice=@MarketPrice,SellingPrice=@SellingPrice,PurchasePrice=@PurchasePrice,ProductImage=@ProductImage,Featured=@Featured,Weight=@Weight,Status=@Status,UpdatedBy=@CreatedBy,UpdatedAt=GETDATE(),VatId=@VatId,CommissionStatus=@CommissionStatus,ReorderPoint=@ReorderPoint,ReorderQty=@ReorderQty OUTPUT inserted.ProductId  Where  ProductId=@ProductId"
                cmd.Parameters.Add("ProductId", Data.SqlDbType.BigInt).Value = hdProductid.Value
            Else
                selectString = "INSERT INTO Product(SupplierID,CategoryID,BrandID,ProductTitle,ProductCode,BarCode,Description,MoreDescription,MadeIn,MadeFor,MarketPrice,SellingPrice,PurchasePrice,ProductImage,Featured,Weight,Status,CreatedBy,CreatedAt,ArProductTitle,ArDescription,VatId,CommissionStatus,ReorderPoint,ReorderQty) OUTPUT inserted.ProductId   VALUES(@SupplierID,@CategoryID,@BrandID,@ProductTitle,@ProductCode,@BarCode,@Description,@MoreDescription,@MadeIn,@MadeFor,@MarketPrice,@SellingPrice,@PurchasePrice,@ProductImage,@Featured,@Weight,@Status,@CreatedBy,GETDATE(),@ArProductTitle,@ArDescription,@VatId,@CommissionStatus,@ReorderPoint,@ReorderQty)"
            End If

            Dim supplierID As Integer = 0
            Integer.TryParse(dropDownSupplierList.SelectedItem.Value, supplierID)

            cmd.Parameters.Add("SupplierID", Data.SqlDbType.BigInt).Value = supplierID
            cmd.Parameters.Add("CategoryID", Data.SqlDbType.Int).Value = dropDownCategoryList.SelectedItem.Value
            cmd.Parameters.Add("BrandID", Data.SqlDbType.Int).Value = dropDownBrandList.SelectedItem.Value
            cmd.Parameters.Add("ProductTitle", Data.SqlDbType.NVarChar).Value = txtProductName.Text
            cmd.Parameters.Add("ArProductTitle", Data.SqlDbType.NVarChar).Value = txtArProductName.Text
            cmd.Parameters.Add("ProductCode", Data.SqlDbType.NVarChar).Value = " "
            cmd.Parameters.Add("BarCode", Data.SqlDbType.NVarChar).Value = txtBarcode.Text
            cmd.Parameters.Add("Description", Data.SqlDbType.NVarChar).Value = txtDescription.Text
            cmd.Parameters.Add("ArDescription", Data.SqlDbType.NVarChar).Value = txtArDescription.Text
            cmd.Parameters.Add("MoreDescription", Data.SqlDbType.NVarChar).Value = " "
            cmd.Parameters.Add("MadeIn", Data.SqlDbType.NVarChar).Value = " "
            cmd.Parameters.Add("MadeFor", Data.SqlDbType.NVarChar).Value = " "

            Dim retailPrice As Double = 0
            Dim specialPrice As Double = 0
            Dim purchasePrice As Double = 0

            Double.TryParse(txtRetailPrice.Text, retailPrice)
            Double.TryParse(txtSpecialPrice.Text, specialPrice)
            Double.TryParse(txtSupplierPrice.Text, purchasePrice)

            cmd.Parameters.Add("MarketPrice", Data.SqlDbType.Float).Value = retailPrice
            cmd.Parameters.Add("SellingPrice", Data.SqlDbType.Float).Value = specialPrice
            cmd.Parameters.Add("PurchasePrice", Data.SqlDbType.Float).Value = purchasePrice
            cmd.Parameters.Add("ProductImage", Data.SqlDbType.NVarChar).Value = " "
            cmd.Parameters.Add("Featured", Data.SqlDbType.Bit).Value = 0
            cmd.Parameters.Add("Status", Data.SqlDbType.Bit).Value = 1
            cmd.Parameters.Add("Weight", Data.SqlDbType.NVarChar).Value = " "
            cmd.Parameters.Add("CreatedBy", Data.SqlDbType.Int).Value = userID


            Dim vatId = 0

            Integer.TryParse(dropDownVatList.SelectedItem.Value, vatId)
            cmd.Parameters.Add("VatId", Data.SqlDbType.BigInt).Value = vatId
            cmd.Parameters.Add("CommissionStatus", Data.SqlDbType.Bit).Value = chkStickControl.Checked

            Integer.TryParse(txtReoredrQty.Text, reorderQty)
            Integer.TryParse(txtReorderPoint.Text, reorderPoint)
            cmd.Parameters.Add("ReorderPoint", Data.SqlDbType.Int).Value = reorderPoint
            cmd.Parameters.Add("ReorderQty", Data.SqlDbType.Int).Value = reorderQty
            cmd.CommandText = selectString
            productId = cmd.ExecuteScalar()
            conn.Close()

            If Not String.IsNullOrEmpty(productId) And Not String.IsNullOrEmpty(txtInitialStock.Text) Then
                SaveStockData(productId, txtInitialStock.Text, userID)
            End If

            LoadProducts()
        End If
    End Sub

    Private Sub SaveStockData(productID As String, stockQtry As String, userId As Integer)

        Dim selectString As String = ""
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)

        If Not String.IsNullOrEmpty(ProductExists(productID)) Then

            Dim stockId = ProductExists(productID)
            selectString = "UPDATE [Stock] SET ProductId=@ProductId,SIN=@SIN,UpdatedBy=@CreatedBy,UpdatedAt=GETDATE()  Where StockId=@StockId"
            cmd.Parameters.Add("StockId", Data.SqlDbType.BigInt).Value = stockId
        Else
            selectString = "INSERT INTO [Stock] (ProductId,SIN,CreatedBy,CreatedAt) VALUES (@ProductId,@SIN,@CreatedBy,GETDATE())"
        End If

        cmd.Parameters.Add("ProductId", Data.SqlDbType.Int).Value = productID
        cmd.Parameters.Add("SIN", Data.SqlDbType.Int).Value = stockQtry
        cmd.Parameters.Add("CreatedBy", Data.SqlDbType.Int).Value = userId

        cmd.CommandText = selectString
        cmd.ExecuteNonQuery()
        conn.Close()
    End Sub

    Private Function ProductExists(productId As String) As String
        Dim stockId As String
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()
        Dim selectString = "SELECT  StockId FROM Stock Where ProductId=@s"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)

        cmd.Parameters.Add("@s", Data.SqlDbType.BigInt).Value = productId
        stockId = cmd.ExecuteScalar()
        conn.Close()
        Return stockId
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function GetProdctById(ByVal ProductId As String) As Product
        Dim product = New Product()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "SELECT  top 1 * FROM Product Where ProductId=@s"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.BigInt).Value = ProductId
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()

        While reader.Read()
            product.ProductId = reader("ProductId").ToString()
            product.ProductTitle = reader("ProductTitle").ToString()
            product.BarCode = reader("BarCode").ToString()
            product.CategoryID = reader("CategoryID").ToString()
            product.SupplierID = reader("SupplierID").ToString()
            product.Description = reader("Description").ToString()
            product.BrandID = reader("BrandID").ToString()
            product.MarketPrice = reader("MarketPrice").ToString()
            product.SellingPrice = reader("SellingPrice").ToString()
            product.PurchasePrice = reader("PurchasePrice").ToString()
            product.Stock = GetStockQtry(reader("ProductId").ToString()) 'reader("Stock").ToString()
            product.ArProductTitle = reader("ArProductTitle").ToString()
            product.ArDescription = reader("ArDescription").ToString()
            product.VatId = reader("VatId").ToString()
            product.CommissionStatus = reader("CommissionStatus")
            product.ReorderPoint = reader("ReorderPoint").ToString()
            product.ReorderQty = reader("ReorderQty").ToString()
        End While

        reader.Close()
        conn.Close()
        Return product
    End Function

    Private Shared Function GetStockQtry(s As String) As String
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim outString As String
        conn.Open()
        Dim selectString = "SELECT  SIN  FROM Stock Where ProductId=@s"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.BigInt).Value = s
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()

        While reader.Read()
            outString = reader("SIN").ToString()
        End While

        reader.Close()
        conn.Close()
        Return outString
    End Function


    Class Product
        Public Property ProductId() As String
        Public Property ProductTitle() As String
        Public Property BarCode() As String
        Public Property CategoryID() As String
        Public Property Description() As String
        Public Property BrandID() As String
        Public Property SupplierID() As String
        Public Property MarketPrice() As String
        Public Property SellingPrice() As String
        Public Property PurchasePrice() As String
        Public Property Stock() As String
        Public Property ArProductTitle() As String
        Public Property ArDescription() As String
        Public Property VatId() As String
        Public Property CommissionStatus() As Boolean
        Public Property ReorderPoint() As String
        Public Property ReorderQty() As String
                                                 
    End Class




End Class
