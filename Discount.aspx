<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Discount.aspx.vb" Inherits="BrandList" %>

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
                <h3 class="text-themecolor">Discount Types</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">

                    <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                    <li class="breadcrumb-item"><a href="/Pos">Pos</a></li>
                    <li class="breadcrumb-item active">Discount Types</li>
                </ol>
            </div>

        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="card">



                    <ul class="nav nav-tabs profile-tab">
                        <li class="nav-item"><a class="nav-link" href="/paymentypes">Payment Types</a></li>
                        <li class="nav-item"><a class="nav-link" href="/vat">Vat</a></li>
                        <li class="nav-item"><a class="nav-link  active" href="/discount">Discount Types</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Sales Settings</a></li>
                        <li class="nav-item"><a class="nav-link " href="#">Invoices &amp; Receipts</a></li>
                    </ul>


                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6 col-sm-6 col-12">
                                        <div class="form-group">
                                            <label>Search by discount name </label>
                                            <%--                                        <input type="text" class="form-control" placeholder="">--%>

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
                                                <button type="button" class="btn btn-info waves-effect btn-block waves-light" data-toggle="modal" data-target="#editcategorymodal" onclick="ClearID()">Add New</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </div>


                            <div class="row">
                                <div class="col-lg-12 col-xlg-12 col-md-12 col-12">
                                    <div>
                                        <table class="table table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                    <th>DISCOUNT TYPE</th>
                                                    <th>VALUE</th>
                                                    <th>DATE ADDED</th>
                                                    <th>Action</th>


                                                </tr>
                                            </thead>
                                            <tbody>


                                                <asp:ListView ID="lstDiscount" runat="server">
                                                    <ItemTemplate>
                                                        <tr>


                                                            <td>
                                                                <a href="#" onclick='GetDiscountById(<%# Eval("DiscountID")%>)' data-toggle="modal" data-target="#editcategorymodal"><%# Eval("DiscountName")%></a>
                                                            </td>


                                                            <td>






                                                                <asp:Label Visible='<%# If(Eval("DiscountType").Trim().Equals("Percentage"), true, false) %>'
                                                                    runat="server">                                         
                                                                                             

                                                            <a href="#" onclick='GetDiscountById(<%# Eval("DiscountID")%>)' data-toggle="modal" data-target="#editcategorymodal"> <%# Eval("DiscountAmount")  %> %</a>

                                                                </asp:Label>



                                                                <asp:Label Visible='<%# If(Eval("DiscountType").Trim().Equals("Amount"), true, false) %>'
                                                                    runat="server">                                         
                                                            <a href="#" onclick='GetDiscountById(<%# Eval("DiscountID")%>)' data-toggle="modal" data-target="#editcategorymodal"><%# Eval("DiscountAmount")%> AED</a>
                                                                  
                                                                </asp:Label>




                                                            </td>

                                                            <td>
                                                                <a href="#" onclick='GetDiscountById(<%# Eval("DiscountID")%>)' data-toggle="modal" data-target="#editcategorymodal"><%# Eval("CreateDateFrom")%></a>
                                                            </td>

                                                            <td>


                                                                <a href="#" onclick='GetDiscountById(<%# Eval("DiscountID")%>)' data-toggle="modal" data-target="#editcategorymodal">
                                                                    <img src="images/icons/ic-edit.png" /></a>
                                                                |
                                                        <a href="#" onclick='DeleteDiscountById(<%# Eval("DiscountID")%>)'>
                                                            <img src="images/icons/ic-delete.png" /></a>
                                                            </td>


                                                        </tr>

                                                    </ItemTemplate>
                                                </asp:ListView>

                                            </tbody>

                                        </table>





                                        <div class="modal fade none-border editcategorymodal" id="editcategorymodal">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title">Add/Edit Discount
                                                        </h4>
                                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="ClearID()">×</button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form role="form">
                                                            <div class="row">
                                                                <div class="col-md-12 col-xs-12">
                                                                    <div class="form-group">
                                                                        <asp:HiddenField ID="hidDiscountID" runat="server" ClientIDMode="Static" />
                                                                        <label class="control-label">DISCOUNT NAME</label>

                                                                        <asp:TextBox ID="txtDiscountName" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ControlToValidate="txtDiscountName" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidatortxtDiscountName" runat="server"
                                                                            ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                        <%--                                                                        <input type="text" class="form-control" placeholder="Enter Brand Name" id="txtBrand">--%>
                                                                    </div>



                                                                    <div class="form-group">

                                                                        <label class="control-label">DISCOUNT VALUE</label>


                                                                        <div class="row">
                                                                            <div class="col-md-4">

                                                                                <asp:TextBox ID="txtDiscountValue" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                                <asp:RequiredFieldValidator ControlToValidate="txtDiscountName" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1" runat="server"
                                                                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                            </div>
                                                                            <div class="col-md-4">
                                                                                <asp:RadioButton runat="server" GroupName="rbGroup" ID="rbpercentage" Text="% percentage"></asp:RadioButton>
                                                                            </div>
                                                                            <div class="col-md-4">
                                                                                <asp:RadioButton runat="server" ID="rbBDTamount" GroupName="rbGroup" Text="AED amount"></asp:RadioButton>
                                                                            </div>

                                                                        </div>







                                                                    </div>

                                                                    <%----%>
                                                                    <%--                                                                    <div class="form-group">--%>
                                                                    <%--                                                                        <asp:CheckBox ID="chkEnableForServiceSales" runat="server" ClientIDMode="Static" />--%>
                                                                    <%--                                                                        <label for="chkEnableForServiceSales">ENABLE FOR SERVICE SALES </label>--%>
                                                                    <%--                                                                    </div>--%>




                                                                    <div class="form-group">
                                                                        <asp:CheckBox ID="chkEnableForServiceSales" runat="server" ClientIDMode="Static" />
                                                                        <label for="chkEnableForServiceSales">ENABLE FOR SERVICE SALES</label>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <asp:CheckBox ID="chkEnableForProductSales" runat="server" ClientIDMode="Static" />
                                                                        <label for="chkEnableForProductSales">ENABLE FOR PRODUCT SALES</label>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <asp:CheckBox ID="chkEnableForVoucherSales" runat="server" ClientIDMode="Static" />
                                                                        <label for="chkEnableForVoucherSales">ENABLE FOR VOUCHER SALES</label>
                                                                    </div>


                                                                </div>

                                                            </div>
                                                        </form>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <%--                                                        <button type="button" class="btn btn-inverse">Delete</button>--%>
                                                        <%--                                                        <button type="button" class="btn btn-danger waves-effect waves-light save-brand" data-dismiss="modal">Save</button>--%>
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
            //hidPaymentTypeID,txtPaymentTypeName
            document.getElementById('hidDiscountID').value = "";
            document.getElementById('txtDiscountName').value = "";
            document.getElementById('txtDiscountValue').value = "";

            //   chkEditable, chkDeletetable

            document.getElementById("chkEnableForServiceSales").checked = false;
            document.getElementById("chkEnableForProductSales").checked = false;
            document.getElementById("chkEnableForVoucherSales").checked = false;



            $("#<%= rbpercentage.ClientID%> ").attr('checked', false);

            $("#<%= rbBDTamount.ClientID%> ").attr('checked', false);





        }


        function DeleteDiscountById(x) {


            var DiscountID = x;


            if (confirm("Are You Sure You Want To Delete ?")) {


                $.ajax({
                    type: 'Post',
                    url: 'Discount.aspx/DeleteDiscountById',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ DiscountID: DiscountID }),
                    dataType: "json",
                    success: function () {
                        location.reload();

                    }
                });

            } else {

            }

        }

        //DeletePaymentTypeById,GetPaymentTypeById,PaymentTypeID


        function GetDiscountById(x) {

            var DiscountID = x;


            $.ajax({
                type: 'Post',
                url: 'Discount.aspx/GetDiscountById',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ DiscountID: DiscountID }),
                dataType: "json",
                success: function (result) {


                    $.each(result,
                        function (key, value) {

                            ClearID();

                            document.getElementById('hidDiscountID').value = value.hidDiscountID;
                            document.getElementById('txtDiscountName').value = value.txtDiscountName;
                            document.getElementById('txtDiscountValue').value = value.txtDiscountValue;








                            if (value.chkEnableForProductSales !== false) {
                                document.getElementById("chkEnableForProductSales").checked = true;
                            } else {
                                document.getElementById("chkEnableForProductSales").checked = false;

                            }


                            if (value.chkEnableForVoucherSales !== false) {
                                document.getElementById("chkEnableForVoucherSales").checked = true;
                            } else {
                                document.getElementById("chkEnableForVoucherSales").checked = false;

                            }







                            if (value.chkEnableForServiceSales !== false) {

                                document.getElementById("chkEnableForServiceSales").checked = true;
                            } else {
                                document.getElementById("chkEnableForServiceSales").checked = true;

                            }


                            if (value.rbpercentage !== false) {

                                $("#<%= rbpercentage.ClientID%> ").attr('checked', true);

                            }




                            if (value.rbBDTamount !== false) {

                                $("#<%= rbBDTamount.ClientID%> ").attr('checked', true);

                            }







                        });
                }
            });
            }


    </script>

</asp:Content>

