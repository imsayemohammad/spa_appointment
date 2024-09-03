
Imports System.Data
Imports System.Data.SqlClient

Partial Class CategoryList
    Inherits System.Web.UI.Page




    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")

        If userID = 0 Then
            Response.Redirect("/login")
        End If

        LoadCategories()
    End Sub


    Private Sub LoadCategories()

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim query As String = ""

        Dim id As String = Request.QueryString("id")
        Dim childId As String = Request.QueryString("childId")


        If String.IsNullOrEmpty(id) And String.IsNullOrEmpty(childId) Then

            lblParentCategoryName.Visible = False
            pnlParentCategory.Visible = True
            pnlChildCategory.Visible = False
            pnlSubCategory.Visible = False



            If String.IsNullOrEmpty(txtSaerch.Text) Then
                query = "SELECT CategoryID,Title FROM Category Where Parent is null OR Parent=0"

            Else
                query = "SELECT CategoryID,Title FROM Category Where Title like '%" & txtSaerch.Text & "%' AND (Parent is null OR Parent=0 ) "
            End If








            Dim da As SqlDataAdapter = New SqlDataAdapter(query, conn)
            Dim table As DataTable = New DataTable()

            da.Fill(table)

            lstCategory.DataSource = table
            lstCategory.DataBind()



        ElseIf Not String.IsNullOrEmpty(id) Then

            If String.IsNullOrEmpty(txtSaerch.Text) Then
                query = "SELECT CategoryID,Title FROM Category Where Parent=" + id
            Else
                'Title like '%" & txtSaerch.text & "%'
                query = "SELECT CategoryID,Title FROM Category Where  Title like '%" & txtSaerch.Text & "%' AND Parent=" + id

            End If



            Dim c As Category = CategoryByCategoryId(id)

            lblParentCategoryName.Text = c.CategoryName
            lblParentCategoryName.Visible = True
            pnlParentCategory.Visible = False
            pnlChildCategory.Visible = True
            pnlSubCategory.Visible = False

            Dim da As SqlDataAdapter = New SqlDataAdapter(query, conn)
            Dim table As DataTable = New DataTable()

            da.Fill(table)

            lstChildCategory.DataSource = table
            lstChildCategory.DataBind()

            ltrBackButton.Text = "<div class='col-md-2 col-sm-2 col-12'>" &
                                      "<div class='form-group'>  " &
              "<label>&nbsp;</label>" &
              "<div class='form-group'>" &
              "<a class='btn btn-secondary waves-effect btn-block' href='/category'>Back  </a>" &
              "</div>" &
                                      "</div>  " &
                              "</div> "

        ElseIf Not String.IsNullOrEmpty(childId) Then

            If String.IsNullOrEmpty(txtSaerch.Text) Then
                query = "SELECT CategoryID,Title FROM Category Where Parent=" + childId
            Else

                query = "SELECT CategoryID,Title FROM Category Where  Title like '%" & txtSaerch.Text & "%' AND Parent=" + childId
            End If



            Dim c As Category = CategoryByCategoryId(childId)

            lblSubChild.Text = c.CategoryName
            lblSubChild.Visible = True
            pnlParentCategory.Visible = False
            pnlChildCategory.Visible = False
            pnlSubCategory.Visible = True


            Dim da As SqlDataAdapter = New SqlDataAdapter(query, conn)
            Dim table As DataTable = New DataTable()

            da.Fill(table)

            lstSubChildCategory.DataSource = table
            lstSubChildCategory.DataBind()
            ltrBackButton.Text = "<div class='col-md-2 col-sm-2 col-12'>" &
                                    "<div class='form-group'>  " &
            "<label>&nbsp;</label>" &
            "<div class='form-group'>" &
            "<a class='btn btn-secondary waves-effect btn-block' href='?id=" + c.ParentId + "'>Back</a>" &
            "</div>" &
                                    "</div>  " &
                            "</div> "

        End If

    End Sub













    <System.Web.Services.WebMethod()>
    Public Shared Function CategoryByCategoryId(ByVal CatagoryId As String) As Category

        Dim category = New Category()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "SELECT  top 1 * FROM Category Where CategoryID=@s"

        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = CatagoryId

        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()



        While reader.Read()

            category.CategoryID = reader("CategoryID").ToString()
            category.CategoryName = reader("Title").ToString()
            category.ParentId = reader("Parent").ToString()
            category.ArTitle = reader("ArTitle").ToString()



        End While

        reader.Close()
        conn.Close()

        Return category

    End Function



    Public Class Category
        Public Property CategoryID() As String
        Public Property CategoryName() As String
        Public Property ParentId() As String
        Public Property ArTitle() As String




    End Class





    Protected Sub SaveSupplierData(sender As Object, e As EventArgs) Handles btnsubmit.Click



        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")


        If Not String.IsNullOrEmpty(txtCatagory.Text) Then

            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

            conn.Open()

            Dim M As String = ""
            Dim selectString = ""
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)

            If Not String.IsNullOrEmpty(hidCatagoryID.Value) Then

                selectString = "UPDATE  Category   SET  ArTitle=@ArTitle,Title=@Title,UpdatedBy=@CreateBy,UpdatedDate=GETDATE()  where categoryId=@CatagoryId "
                cmd.Parameters.Add("CatagoryId", Data.SqlDbType.Int).Value = hidCatagoryID.Value

            Else

                Dim id As String = Request.QueryString("id")
                Dim childId As String = Request.QueryString("childId")

                If String.IsNullOrEmpty(id) And String.IsNullOrEmpty(childId) Then
                    selectString = "INSERT INTO [Category] (Title,CreateDate,CreateBy,Parent,ArTitle) VALUES (@Title,GETDATE(),@CreateBy,0,@ArTitle)"

                ElseIf Not String.IsNullOrEmpty(id) Then

                    selectString = "INSERT INTO [Category] (Title,CreateDate,CreateBy,Parent,ArTitle) VALUES (@Title,GETDATE(),@CreateBy,@Parent,@ArTitle)"

                    cmd.Parameters.Add("Parent", Data.SqlDbType.Int).Value = id

                ElseIf Not String.IsNullOrEmpty(childId) Then
                    selectString = "INSERT INTO [Category] (Title,CreateDate,CreateBy,Parent,ArTitle) VALUES (@Title,GETDATE(),@CreateBy,@Parent,@ArTitle)"
                    cmd.Parameters.Add("Parent", Data.SqlDbType.Int).Value = childId

                End If





            End If





            cmd.Parameters.Add("Title", Data.SqlDbType.NVarChar).Value = txtCatagory.Text
            cmd.Parameters.Add("ArTitle", Data.SqlDbType.NVarChar).Value = ArTitle.Text
            cmd.Parameters.Add("CreateBy", Data.SqlDbType.Int).Value = userID




            cmd.CommandText = selectString

            M = cmd.ExecuteNonQuery


            If M > 0 Then
                txtCatagory.Text = String.Empty
                LoadCategories()
            End If


            conn.Close()

        End If




    End Sub


    '<System.Web.Services.WebMethod()>
    'Public Shared Function SaveCategory(ByVal CatagoryName As String, ByVal CatagoryId As String)
    '    Dim userID As Integer =Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")


    '    If Not String.IsNullOrEmpty(CatagoryName) Then

    '        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

    '        conn.Open()

    '        Dim M As String = ""
    '        Dim selectString = ""
    '        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)

    '        If Not String.IsNullOrEmpty(CatagoryId) Then

    '            selectString = "UPDATE  Category   SET  Title=@Title,UpdatedBy=@CreateBy,UpdatedDate=GETDATE()  where categoryId=@CatagoryId "
    '            cmd.Parameters.Add("CatagoryId", Data.SqlDbType.Int).Value = CatagoryId


    '        Else


    '            selectString = "INSERT INTO [Category] (Title,CreateDate,CreateBy) VALUES (@Title,GETDATE(),@CreateBy)"


    '        End If





    '        cmd.Parameters.Add("Title", Data.SqlDbType.NVarChar).Value = CatagoryName
    '        cmd.Parameters.Add("CreateBy", Data.SqlDbType.Int).Value = userID


    '        cmd.CommandText = selectString

    '        M = cmd.ExecuteNonQuery


    '        conn.Close()

    '    End If

    'End Function


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
