<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="CategoryList.aspx.vb" Inherits="CategoryList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="toppart" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">

    <div class="container-fluid">
        <!-- ============================================================== -->
        <!-- Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <div class="row page-titles">
            <div class="col-md-5 align-self-center">
                <h3 class="text-themecolor">Inventory</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                    <li class="breadcrumb-item active">Inventory</li>
                </ol>
            </div>

        </div>
        <!-- ============================================================== -->
        <!-- End Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Sales overview chart -->
        <!-- ============================================================== -->
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs profile-tab">
                        <li class="nav-item"><a class="nav-link" href="/products">PRODUCTS</a> </li>
                        <li class="nav-item"><a class="nav-link" href="orders.html">ORDERS</a> </li>
                        <li class="nav-item"><a class="nav-link " href="/brand">BRANDS</a> </li>
                        <li class="nav-item"><a class="nav-link active" href="/category">CATEGORIES</a></li>
                        <li class="nav-item"><a class="nav-link" href="/supplier">SUPPLIERS</a></li>
                    </ul>
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row">

                                    <div class="col-md-6 col-sm-6 col-12">
                                        <div class="form-group">
                                            <label>Search by category name</label>
                                            <%--                                            <input type="text" class="form-control" placeholder="">--%>

                                            <asp:TextBox ID="txtSaerch" class="form-control" placeholder="" runat="server" ClientIDMode="Static"></asp:TextBox>
                                        </div>
                                    </div>



                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <%--                                                <button type="submit" class="btn btn-danger waves-effect btn-block waves-light">Search</button>--%>
                                                <asp:Button ID="btnSaerch" class="btn btn-danger waves-effect btn-block waves-light btnsubmit" runat="server" Text="Search" />

                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <button type="button" class="btn btn-info waves-effect btn-block waves-light" data-toggle="modal" data-target="#editcategorymodal">Add New</button>
                                            </div>
                                        </div>
                                    </div>

                                    <asp:Literal ID="ltrBackButton" runat="server"></asp:Literal>

                                </div>



                                <div class="row">
                                    <div class="col-lg-12 col-xlg-12 col-md-12 col-12">
                                        <div class="table-responsive">


                                            <asp:Panel ID="pnlParentCategory" runat="server">
                                                <table class="table table-bordered table-striped">
                                                    <thead>
                                                        <tr>
                                                            <th>CATEGORY NAME</th>
                                                            <th>Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <asp:ListView ID="lstCategory" runat="server">
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td>
                                                                        <a href="#"><%# Eval("Title")%>
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <a href="#" onclick='GetCategoryById(<%# Eval("CategoryID")%>)' data-toggle="modal" data-target="#editcategorymodal">
                                                                            <img src="images/icons/ic-edit.png" />
                                                                        </a>
                                                                        |
                                                                        <a href='?id=<%# Eval("CategoryID")%>'>Add Child Category
                                                                        </a>
                                                                    </td>

                                                                </tr>
                                                            </ItemTemplate>
                                                        </asp:ListView>
                                                    </tbody>
                                                </table>

                                            </asp:Panel>



                                            <asp:Panel ID="pnlChildCategory" runat="server">
                                                <table class="table table-bordered table-striped">
                                                    <thead>

                                                        <tr>
                                                            <th>
                                                                <asp:Label ID="lblParentCategoryName" runat="server" Text="" Visible="False"></asp:Label></th>
                                                            <th></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <asp:ListView ID="lstChildCategory" runat="server">
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td>
                                                                        <a href="#"><%# Eval("Title")%>
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <a href="#" onclick='GetCategoryById(<%# Eval("CategoryID")%>)' data-toggle="modal" data-target="#editcategorymodal">
                                                                            <img src="images/icons/ic-edit.png" />
                                                                        </a>
                                                                        |
                                                                    <a href='?childId=<%# Eval("CategoryID")%>'>Add Child Category
                                                                    </a>



                                                                    </td>

                                                                </tr>
                                                            </ItemTemplate>
                                                        </asp:ListView>
                                                    </tbody>
                                                </table>


                                                <%--                                                <a href='/category'>Back--%>
                                                <%--                                                </a>--%>
                                            </asp:Panel>





                                            <asp:Panel ID="pnlSubCategory" runat="server">
                                                <table class="table table-bordered table-striped">
                                                    <thead>

                                                        <tr>
                                                            <th>
                                                                <asp:Label ID="lblSubChild" runat="server" Text="" Visible="False"></asp:Label></th>
                                                            <th></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <asp:ListView ID="lstSubChildCategory" runat="server">
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td>
                                                                        <a href="#"><%# Eval("Title")%>
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <a href="#" onclick='GetCategoryById(<%# Eval("CategoryID")%>)' data-toggle="modal" data-target="#editcategorymodal">
                                                                            <img src="images/icons/ic-edit.png" />
                                                                        </a>
                                                                    </td>

                                                                </tr>

                                                            </ItemTemplate>
                                                        </asp:ListView>
                                                    </tbody>

                                                </table>


                                                <%--                                                <asp:Literal ID="backTO2ndCategory" runat="server"></asp:Literal>--%>
                                            </asp:Panel>



                                            <%--                                            <h6 class="card-subtitle">Displaying <code class="bg-light-success">1 - 25 of 3959 total </code></h6>--%>

                                            <div class="modal fade none-border editcategorymodal" id="editcategorymodal">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h4 class="modal-title">Add/Edit Category                               
                                                            </h4>
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="ClearID()">×</button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form role="form">
                                                                <div class="row">
                                                                    <div class="col-md-12 col-xs-12">
                                                                        <div class="form-group">
                                                                            <%-- <input type="hidden" class="form-control" id="hidCatagoryID" value="">--%>
                                                                            <asp:HiddenField ID="hidCatagoryID" runat="server" ClientIDMode="Static" />
                                                                            <label class="control-label">Category NAME</label>
                                                                            <%-- <input type="text" class="form-control" placeholder="Enter Catgory Name" id="txtCatagory">--%>
                                                                            <asp:TextBox ID="txtCatagory" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ControlToValidate="txtCatagory" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator9" runat="server"
                                                                                ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="control-label">Arabic Category NAME</label>

                                                                            <asp:TextBox ID="ArTitle" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>

                                                                        </div>



                                                                    </div>
                                                                </div>
                                                            </form>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <%--                                                            <button type="button" class="btn btn-inverse">Delete</button>--%>
                                                            <%--<button type="button" class="btn btn-danger waves-effect waves-light save-category" data-dismiss="modal">Save</button>--%>

                                                            <asp:Button ID="btnsubmit" ValidationGroup="form" CssClass="btn btn-danger waves-effect waves-light  btnsubmit"
                                                                runat="server" Text="Save" ClientIDMode="Static" />

                                                            <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal" onclick="ClearID()">Close</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- END MODAL -->


                                            <%----%>
                                            <%--                                            <nav aria-label="Page navigation example" class="m-t-40">--%>
                                            <%--                                                <ul class="pagination">--%>
                                            <%--                                                    <li class="page-item disabled">--%>
                                            <%--                                                        <a class="page-link" href="#" tabindex="-1">Previous</a>--%>
                                            <%--                                                    </li>--%>
                                            <%--                                                    <li class="page-item"><a class="page-link" href="#">1</a></li>--%>
                                            <%--                                                    <li class="page-item"><a class="page-link" href="#">2</a></li>--%>
                                            <%--                                                    <li class="page-item"><a class="page-link" href="#">3</a></li>--%>
                                            <%--                                                    <li class="page-item">--%>
                                            <%--                                                        <a class="page-link" href="#">Next</a>--%>
                                            <%--                                                    </li>--%>
                                            <%--                                                </ul>--%>
                                            <%--                                            </nav>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">



    <script>


        function ClearID() {
            $("#<%= hidCatagoryID.ClientID%>").val("");
            $("#<%= txtCatagory.ClientID%>").val("");
            $("#<%= ArTitle.ClientID%>").val("");


            
        }


        function GetCategoryById(x) {
            var CatagoryId = x;



            $.ajax({
                type: 'Post',
                url: 'CategoryList.aspx/CategoryByCategoryId',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ CatagoryId: CatagoryId }),
                dataType: "json",
                success: function (result) {


                    $.each(result,
                        function (key, value) {


                            document.getElementById('txtCatagory').value = value.CategoryName;
                            document.getElementById('hidCatagoryID').value = value.CategoryID;
                            document.getElementById('ArTitle').value = value.ArTitle;

                            

                            // console.log(value.CategoryName);
                            // console.log(value.CategoryID);
                        });



                }

            });



        }


        $('.save-category').click(function () {


            //            var CatagoryName = $("#txtCatagory").val();
            //            var CatagoryId = $("#hidCatagoryID").val();

            var CatagoryId = $("#<%= hidCatagoryID.ClientID%>").val();
            var CatagoryName = $("#<%= txtCatagory.ClientID%>").val();


            $.ajax({
                type: 'Post',
                url: 'CategoryList.aspx/SaveCategory',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ CatagoryName: CatagoryName, CatagoryId: CatagoryId }),
                dataType: "json",
                success: function (result) {

                    $("#<%= hidCatagoryID.ClientID%>").val("");
                    $("#<%= txtCatagory.ClientID%>").val("");
                    location.reload();
                }
            });


        });


    </script>
</asp:Content>

