<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="BrandList.aspx.vb" Inherits="BrandList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="toppart" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">
    <div class="container-fluid">
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
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <ul class="nav nav-tabs profile-tab">
                        <li class="nav-item"><a class="nav-link" href="/products">PRODUCTS</a> </li>
                        <li class="nav-item"><a class="nav-link" href="orders.html">ORDERS</a> </li>
                        <li class="nav-item"><a class="nav-link active" href="/brand">BRANDS</a> </li>
                        <li class="nav-item"><a class="nav-link " href="/category">CATEGORIES</a></li>
                        <li class="nav-item"><a class="nav-link" href="/supplier">SUPPLIERS</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6 col-sm-6 col-12">
                                        <div class="form-group">
                                            <label>Search by brand name</label>
                                            <asp:TextBox ID="txtSearch" runat="server" class="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <asp:Button ID="btnSaerch" runat="server" class="btn btn-danger waves-effect btn-block waves-light btnsubmit" Text="Search" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <button type="button" class="btn btn-info waves-effect btn-block waves-light" data-toggle="modal" data-target="#editcategorymodal" data-backdrop="static" data-keyboard="false" onclick="ClearID()">Add New</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12 col-xlg-12 col-md-12 col-12">
                                    <div>
                                        <table class="table table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                    <th>BRAND NAME</th>
                                                    <th>Details</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:ListView ID="lstBrand" runat="server">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td>
                                                                <a href="#"><%# Eval("Title")%></a>
                                                            </td>
                                                            <td>
                                                                <a href="#"><%# Eval("Smalldetails")%></a>
                                                            </td>

                                                            <td>
                                                                <a href="#" onclick='GetBrandById(<%# Eval("BrandID")%>)' data-toggle="modal" data-target="#editcategorymodal">
                                                                    <img src="images/icons/ic-edit.png" /></a>
                                                                |
                                                                
                                                                <a href="#" onclick='DeleteBrandById(<%# Eval("BrandID")%>)'>
                                                                    <img src="images/icons/ic-delete.png" /></a>
                                                            </td>
                                                        </tr>

                                                    </ItemTemplate>
                                                </asp:ListView>

                                            </tbody>

                                        </table>

                                        <h6 class="card-subtitle">Displaying <code class="bg-light-success">
                                            <asp:Label ID="lblStart" runat="server" Text=""></asp:Label>
                                            -
                                                <asp:Label ID="lblEnd" runat="server" Text=""></asp:Label>
                                            of
                                                <asp:Label ID="lblTotal" runat="server" Text=""></asp:Label>
                                            total </code></h6>
                                        <asp:Literal ID="ltlpag" runat="server"></asp:Literal>


                                        <div class="modal fade none-border editcategorymodal" id="editcategorymodal">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title">Add/Edit Brand                               
                                                        </h4>
                                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="ClearID()">×</button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form role="form">
                                                            <div class="row">
                                                                <div class="col-md-12 col-xs-12">
                                                                    <div class="form-group">
                                                                        <asp:HiddenField ID="hidBrandID" runat="server" ClientIDMode="Static" />
                                                                        <label class="control-label">Brand NAME</label>

                                                                        <asp:TextBox ID="txtBrand" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ControlToValidate="txtBrand" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator8txtBrand" runat="server"
                                                                            ErrorMessage="*"></asp:RequiredFieldValidator>

                                                                    </div>
                                                                </div>
                                                                <div class="col-md-12 col-xs-12">
                                                                    <div class="form-group">
                                                                        <label class="control-label">Details</label>
                                                                        <asp:TextBox ID="txtBrandDetails" Rows="5" TextMode="MultiLine" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <asp:Button ID="btnsave" ValidationGroup="form" CssClass="btn btn-danger waves-effect waves-light btnsubmit"
                                                            runat="server" Text="Save" ClientIDMode="Static" />
                                                        <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal" onclick="ClearID()">Close</button>
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
            </div>


        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">

    <script>

        function ClearID() {

            document.getElementById('txtBrand').value = "";
            document.getElementById('txtBrandDetails').value = "";
            document.getElementById('hidBrandID').value = "";
        }





        $('.save-brand').click(function () {



            var BrandName = $("#txtBrand").val();
            var BrandDetails = $("#txtBrandDetails").val();
            var BrandID = $("#hidBrandID").val();

            $.ajax({
                type: 'Post',
                url: 'BrandList.aspx/SaveBrand',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ BrandName: BrandName, BrandDetails: BrandDetails, BrandID: BrandID }),
                dataType: "json",
                success: function (result) {
                    $("#txtCatagory").val("");
                    window.location.reload();
                }
            });



        });





        function GetBrandById(x) {

            var BrandId = x;

         



                $.ajax({
                    type: 'Post',
                    url: 'BrandList.aspx/GetBrandById',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ BrandId: BrandId }),
                    dataType: "json",
                    success: function (result) {


                        $.each(result,
                            function (key, value) {

                                ClearID();

                                document.getElementById('txtBrand').value = value.BrandName;
                                document.getElementById('txtBrandDetails').value = value.BrandDetails;
                                document.getElementById('hidBrandID').value = value.BrandID;

                            });



                    }

                });

            

        }







        function DeleteBrandById(x) {
            var BrandId = x;

            if (confirm('Are you sure want to delete?')) {


                $.ajax({
                    type: 'Post',
                    url: 'BrandList.aspx/DeleteBrandById',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ BrandId: BrandId }),
                    dataType: "json",
                    success: function (result) {
                        $.each(result,
                            function (key, value) {


                                alert(value);
                                location.reload();
                            });
                    }
                });
            }
        }

    </script>

</asp:Content>

