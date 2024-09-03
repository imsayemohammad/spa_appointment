<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="ProductList.aspx.vb" Inherits="ProductList" %>

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





        <div class="modal fade none-border addeditclientmodal" id="addeditclientmodal">

            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Add/Edit Product 
                        </h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    </div>
                    <div class="modal-body">
                        <form role="form">
                            <div class="">
                                <div class="" id="s-DETAILS">

                                    <div class="row">

                                        <div class="col-md-6 col-12">
                                            <div class="row">

                                                <div class="col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">Product Name</label>


                                                        <asp:TextBox ID="txtProductName" CssClass="form-control" runat="server" ClientIDMode="Static" placeholder="e.g Best Spa"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ControlToValidate="txtProductName" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidatortxtProductName" runat="server"
                                                            ErrorMessage="*"></asp:RequiredFieldValidator>

                                                    </div>
                                                </div>


                                                <div class="col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">Arabic Product Name</label>


                                                        <asp:TextBox ID="txtArProductName" CssClass="form-control" runat="server" ClientIDMode="Static" placeholder="e.g Best Spa"></asp:TextBox>

                                                    </div>
                                                </div>


                                                <!--category-->
                                                <div class="col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">
                                                            Category</label>
                                                        <asp:DropDownList class="form-control " placeholder="--Select Category--" ID="dropDownCategoryList" runat="server" ClientIDMode="Static" TabIndex="1">
                                                        </asp:DropDownList>
                                                        <asp:RequiredFieldValidator ControlToValidate="dropDownCategoryList" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidatordropDownCategoryList" runat="server"
                                                            ErrorMessage="*"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>

                                                <!--brand-->
                                                <div class="col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">
                                                            Brand</label>
                                                        <asp:DropDownList class="form-control " placeholder="--Select Brand--" ID="dropDownBrandList" runat="server" ClientIDMode="Static" TabIndex="1">
                                                        </asp:DropDownList>
                                                        <asp:RequiredFieldValidator ControlToValidate="dropDownBrandList" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1dropDownBrandList" runat="server"
                                                            ErrorMessage="*"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>
                                                <!--brand-->
                                            </div>
                                        </div>
                                        <!--left-column-->

                                        <!--right-column-->
                                        <div class="col-md-6 col-12">
                                            <div class="row">
                                                <!--barcode-->
                                                <div class="col-md-6 col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">Bar Code <span>ISBN, UFC, etc</span></label>
                                                        <%--                                                        <input type="text" class="form-control" >--%>

                                                        <asp:TextBox ID="txtBarcode" CssClass="form-control" runat="server" ClientIDMode="Static" placeholder="e.g. 123ABC"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ControlToValidate="txtBarcode" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidatortxtBarcode" runat="server"
                                                            ErrorMessage="*" placeholder="e.g. 123ABC"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>
                                                <!--barcode-->

                                                <!--sku-->
                                                <div class="col-md-6 col-12">
                                                    <div class="form-group">
                                                        <label class="control-label sku">SKU <span>Stock Keeping Unit</span></label>
                                                        <%--                                                        <input type="text" class="form-control" placeholder="e.g. 123ABC">--%>

                                                        <asp:TextBox ID="txtSku" CssClass="form-control" runat="server" ClientIDMode="Static" placeholder="e.g. 123AB"></asp:TextBox>
                                                        <%--                                                        <asp:RequiredFieldValidator ControlToValidate="txtSku" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1txtSku" runat="server"--%>
                                                        <%--                                                            ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                                                    </div>
                                                </div>
                                                <!--sku-->

                                                <!--description-->
                                                <div class="col-md-12 col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">Description</label>
                                                        <%--                                                        <textarea class="form-control" rows="5"></textarea>  --%>

                                                        <asp:TextBox ID="txtDescription" TextMode="MultiLine" Rows="6" CssClass="form-control" runat="server" ClientIDMode="Static" placeholder="e.g. the world's most spectecular product!"></asp:TextBox>

                                                    </div>
                                                </div>


                                                <div class="col-md-12 col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">Arabic Description</label>
                                                        <%--                                                        <textarea class="form-control" rows="5"></textarea>  --%>

                                                        <asp:TextBox ID="txtArDescription" TextMode="MultiLine" Rows="6" CssClass="form-control" runat="server" ClientIDMode="Static" placeholder="e.g. the world's most spectecular product!"></asp:TextBox>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!--right-column-->
                                    </div>

                                    <div class="row enable-disable">
                                        <div class="col-md-6 col-12">
                                            <!--switch(enable retail sales)-->
                                            <div class="checkbox checkbox-success">
                                                <!--<input id="checkbox1" type="checkbox">-->
                                                <h4 class="switch-label">Enable Retail     Sales 
                                                </h4>
                                                <div class="switch switch-product">
                                                    <label class="">
                                                        <input class="switch-retail--js" type="checkbox" checked>
                                                        <span class="slider round-check lever"></span>
                                                    </label>
                                                </div>
                                            </div>
                                            <!--switch(enable retail sales)-->

                                            <p style="display: none; text-align: center; margin-top: 10px;" class="hintsp">Switch on 'Enable Retail Sales' to sell this product at checkout.</p>


                                            <div class="row enable-slide">

                                                <!--retail-price-->
                                                <div class="col-md-6 col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">Retail Price</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon">
                                                                <%=Utility.GetCurrencySymbol()%>
                                                            </div>
                                                            <%--                                                            <input type="text" class="form-control" placeholder="0.00"> --%>


                                                            <asp:TextBox ID="txtRetailPrice" CssClass="form-control" runat="server" ClientIDMode="Static" placeholder="0.00"></asp:TextBox>


                                                        </div>
                                                    </div>
                                                </div>
                                                <!--retail-price-->

                                                <!--speceial-price-->
                                                <div class="col-md-6 col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">Special Price</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon">
                                                                <%=Utility.GetCurrencySymbol()%>
                                                            </div>
                                                            <%--                                                            <input type="text" class="form-control" placeholder="0.00">--%>


                                                            <asp:TextBox ID="txtSpecialPrice" CssClass="form-control" runat="server" ClientIDMode="Static" placeholder="0.00"></asp:TextBox>


                                                        </div>
                                                    </div>
                                                </div>
                                                <!--speceial-price-->

                                                <!--tax-->
                                                <div class="col-md-12 col-12">
                                                    <div class="form-group">
                                                        <label class="control-label tax-label">Tax <span class="in-label">Included in prices</span></label>


                                                        <asp:DropDownList class="form-control " placeholder="--Select Supplier--" ID="dropDownVatList" runat="server" ClientIDMode="Static">
                                                        </asp:DropDownList>

                                                    </div>
                                                </div>
                                                <!--tax-->

                                                <!--comission-->
                                                <div class="col-12">
                                                    <div class="form-group">
                                                        <div class="checkbox checkbox-success">
                                                            <asp:CheckBox ID="chkStickControl" runat="server" ClientIDMode="Static" />
                                                            <label for="chkStickControl">Enable Commision </label>
                                                        </div>

                                                    </div>
                                                </div>
                                                <!--comission-->

                                            </div>
                                        </div>


                                        <div class="col-md-6 col-12">

                                            <div class="checkbox checkbox-success">
                                                <!--<input id="checkbox1" type="checkbox">-->
                                                <h4 class="switch-label">Enable Stock Control 
                                                </h4>
                                                <div class="switch switch-product">
                                                    <label class="">
                                                        <input class="switch-stock--js" type="checkbox" checked>
                                                        <span class="slider round-check lever"></span>
                                                    </label>
                                                </div>

                                            </div>

                                            <p style="display: none; text-align: center; margin-top: 10px;" class="hintspStock">
                                                Switch on 'Enable Stock Control' to sell this product at checkout.
                                            </p>


                                            <div class="row stock-slide" style="display: none;">

                                                <!--supply-price-->
                                                <div class="col-md-6 col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">
                                                            Supply Price
                                                        </label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon">
                                                                <%=Utility.GetCurrencySymbol()%>
                                                            </div>
                                                            <asp:TextBox ID="txtSupplierPrice" CssClass="form-control" runat="server" ClientIDMode="Static" placeholder="0.00"></asp:TextBox>

                                                        </div>
                                                    </div>
                                                </div>
                                                <!--supply-price-->

                                                <!--initial-stock-->
                                                <div class="col-md-6 col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">
                                                            Initial Stock
                                                        </label>
                                                        <%--                                                        <input type="text" class="form-control" value="10">--%>


                                                        <asp:TextBox ID="txtInitialStock" CssClass="form-control" runat="server" ClientIDMode="Static" placeholder="10"></asp:TextBox>



                                                    </div>
                                                </div>
                                                <!--initial-stock-->

                                                <!--supplier-->
                                                <div class="col-md-12 col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">Supplier</label>
                                                        <asp:DropDownList class="form-control " placeholder="--Select Supplier--" ID="dropDownSupplierList" runat="server" ClientIDMode="Static">
                                                        </asp:DropDownList>

                                                    </div>
                                                </div>
                                                <!--supplier-->

                                                <!--reorder-point-->
                                                <div class="col-md-6 col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">
                                                            Reorder Point
                                                        </label>
                                                        <%--                                                        <input type="text" class="form-control" value="0">--%>


                                                        <asp:TextBox ID="txtReorderPoint" CssClass="form-control" runat="server" ClientIDMode="Static" placeholder="0">
                                                        </asp:TextBox>
                                                        <%--                                                        <asp:RequiredFieldValidator ControlToValidate="txtReorderPoint" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1txtReorderPoint" runat="server"--%>
                                                        <%--                                                            ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                                                    </div>
                                                </div>
                                                <!--reorder-point-->

                                                <!--reorder-quantity-->
                                                <div class="col-md-6 col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">Reorder Qty.</label>
                                                        <%--                                                        <input type="text" class="form-control" value="0">--%>

                                                        <asp:TextBox ID="txtReoredrQty" CssClass="form-control" runat="server" ClientIDMode="Static" placeholder="0"></asp:TextBox>
                                                        <%--                                                        <asp:RequiredFieldValidator ControlToValidate="txtReoredrQty" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1txtReoredrQty" runat="server"--%>
                                                        <%--                                                            ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                                                    </div>
                                                </div>
                                                <!--reorder-quantity-->

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="modal-footer">
                        <%--                        <button type="button" class="btn btn-inverse">Delete</button>--%>

                        <%--                        <button type="button" class="btn btn-danger waves-effect waves-light " data-dismiss="modal">Save</button>--%>

                        <asp:HiddenField ID="hdProductid" runat="server" ClientIDMode="Static" />
                        <asp:Button ValidationGroup="form" ID="btnSave" runat="server" class="btn btn-danger waves-effect waves-light btnsubmit " Text="Save" />

                        <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">Close</button>
                    </div>
                </div>
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
                        <li class="nav-item"><a class="nav-link active" href="/products">PRODUCTS</a> </li>
                        <li class="nav-item"><a class="nav-link" href="orders.html">ORDERS</a> </li>
                        <li class="nav-item"><a class="nav-link" href="/brand">BRANDS</a> </li>
                        <li class="nav-item"><a class="nav-link" href="/category">CATEGORIES</a></li>
                        <li class="nav-item"><a class="nav-link " href="/supplier">SUPPLIERS</a></li>
                    </ul>
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row">

                                    <div class="col-md-6 col-sm-6 col-12">
                                        <div class="form-group">
                                            <label>Search by name or SKU</label>
                                            <%--                                            <input type="text" class="form-control" placeholder="">--%>

                                            <asp:TextBox ID="txtSearch" class="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <%-- <button type="submit" class="btn btn-danger waves-effect btn-block waves-light">Search</button>--%>

                                                <asp:Button ID="btnSaerch" runat="server" Text="Search" ClientIDMode="Static" class="btn btn-danger waves-effect btn-block waves-light btnsubmit " />

                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <select class="form-control custom-select" data-placeholder="Export As" tabindex="1">
                                                    <option>Export As</option>
                                                    <option value="xlsx">Excel</option>
                                                    <option value="pdf">PDF</option>
                                                    <option value="csv">CSV</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <button type="button" class="btn btn-info waves-effect btn-block waves-light" data-toggle="collapse" data-target="#extrafilter" aria-expanded="true" aria-controls="extrafilter"><i class="fa fa-sliders"></i>Filters</button>

                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-12 col-12 collapse show" id="extrafilter" style="">
                                        <div class="row">

                                            <div class="col-md-2 col-sm-2 col-12">
                                                <div class="form-group">
                                                    <div class="form-group">
                                                        <asp:DropDownList class="form-control" placeholder="All Brand" ID="dropDownBrandListSearch" runat="server" ClientIDMode="Static">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-2 col-sm-2 col-12">
                                                <div class="form-group">
                                                    <div class="form-group">
                                                        <asp:DropDownList class="form-control" placeholder="All Category" ID="dropDownCategoryListSearch" runat="server" ClientIDMode="Static">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-2 col-sm-2 col-12">
                                                <div class="form-group">
                                                    <div class="form-group">
                                                        <asp:DropDownList class="form-control" placeholder="All Supplier" ID="dropDownSupplierListSaerch" runat="server" ClientIDMode="Static">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-2 col-sm-2 col-12">
                                                <div class="form-group">
                                                    <div class="form-group">
                                                        <%--                                                        <button type="button" class="btn btn-warning waves-effect btn-block waves-light">Apply</button>--%>
                                                        <asp:Button ID="btnApply" runat="server" Text="Apply" class="btn btn-warning waves-effect btn-block waves-light btnsubmit " />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-2 col-sm-2 col-12">
                                                <div class="form-group">
                                                    <div class="form-group">
                                                        <button type="button" class="btn btn-secondary waves-effect btn-block waves-light" onclick="ClearDropDown()">Cancel</button>


                                                    </div>
                                                </div>
                                            </div>




                                            <div class="col-md-2 col-sm-2 col-12">
                                                <div class="form-group">
                                                    <div class="form-group">
                                                        <button type="button" class="btn btn-info waves-effect btn-block waves-light" data-toggle="modal" data-target="#addeditclientmodal" onclick="ClearID()">Add New</button>


                                                    </div>
                                                </div>
                                            </div>




                                        </div>
                                    </div>


                                </div>



                                <div class="row">
                                    <div class="col-lg-12 col-xlg-12 col-md-12 col-12">
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>PRODUCT NAME</th>
                                                        <th>SKU/BARCODE</th>
                                                        <th>RETAIL PRICE</th>
                                                        <th>STOCK ON HAND</th>
                                                        <th>UPDATED AT</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:ListView ID="lstProducts" runat="server">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td>
                                                                    <a href="javascript:;" onclick='GetProdctById(<%# Eval("ProductId")%>)' data-toggle="modal" data-target="#addeditclientmodal"><%# Eval("ProductTitle")%>
                                                                    </a>
                                                                </td>

                                                                <td>
                                                                    <a href="javascript:;" onclick='GetProdctById(<%# Eval("ProductId")%>)' data-toggle="modal" data-target="#addeditclientmodal"><%# Eval("BarCode")%>
                                                                    </a>
                                                                </td>

                                                                <td>
                                                                    <a href="javascript:;" onclick='GetProdctById(<%# Eval("ProductId")%>)' data-toggle="modal" data-target="#addeditclientmodal"><%# Eval("MarketPrice")%>
                                                                    </a>
                                                                </td>
                                                                <td>
                                                                    <a href="javascript:;" onclick='GetProdctById(<%# Eval("ProductId")%>)' data-toggle="modal" data-target="#addeditclientmodal"><%# Eval("Stockk")%>
                                                                    </a>
                                                                </td>

                                                                <td>
                                                                    <a href="javascript:;" onclick='GetProdctById(<%# Eval("ProductId")%>)' data-toggle="modal" data-target="#addeditclientmodal"><%# Eval("LastUpdated")%>
                                                                    </a>
                                                                </td>




                                                            </tr>
                                                        </ItemTemplate>
                                                    </asp:ListView>






                                                </tbody>

                                            </table>

                                            <asp:Literal ID="ltlpag" runat="server"></asp:Literal>

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

    <script type="text/javascript">
        $("#<%=txtSearch.ClientID %>").keypress(function (event) {
            if (event.keyCode === 13) {
                //alert('You pressed enter!');
                $("#<%=btnSaerch.ClientID %>").click();
            }
        });
    </script>

    <script type="text/javascript">

        function GetProdctById(x) {
            var ProductId = x;
            $.ajax({
                type: 'Post',
                url: 'ProductList.aspx/GetProdctById',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ ProductId: ProductId }),
                dataType: "json",
                success: function (result) {


                    $.each(result,
                        function (key, value) {

                            ClearID();

                            document.getElementById('hdProductid').value = value.ProductId;
                            document.getElementById('txtProductName').value = value.ProductTitle;
                            document.getElementById('txtArProductName').value = value.ArProductTitle;
                            document.getElementById('txtDescription').value = value.Description;
                            document.getElementById('txtArDescription').value = value.ArDescription;
                            document.getElementById('txtRetailPrice').value = value.MarketPrice;
                            document.getElementById('txtSpecialPrice').value = value.SellingPrice;
                            document.getElementById('txtSupplierPrice').value = value.PurchasePrice;
                            document.getElementById('txtInitialStock').value = value.Stock;
                            document.getElementById('txtBarcode').value = value.BarCode;

                            document.getElementById('txtReoredrQty').value = value.ReorderQty;
                            document.getElementById('txtReorderPoint').value = value.ReorderPoint;


                            $("#<%=dropDownSupplierList.ClientID %>").val(value.SupplierID);
                            $("#<%=dropDownCategoryList.ClientID %>").val(value.CategoryID);
                            $("#<%=dropDownBrandList.ClientID %>").val(value.BrandID);
                            $("#<%=dropDownVatList.ClientID %>").val(value.VatId);


                            if (value.CommissionStatus !== false) {
                                document.getElementById("chkStickControl").checked = true;
                            } else {
                                document.getElementById("chkStickControl").checked = false;
                            }





                        });
                }

            });
        }


        function ClearDropDown() {

            window.location.reload();

        }

        function ClearID() {


            $("#<%=hdProductid.ClientID %>").val(0);
            $("#<%=txtProductName.ClientID %>").val("");
            $("#<%=txtArProductName.ClientID %>").val("");
            $("#<%=txtDescription.ClientID %>").val("");
            $("#<%=txtArDescription.ClientID %>").val("");
            $("#<%=txtRetailPrice.ClientID %>").val("");
            $("#<%=txtSpecialPrice.ClientID %>").val("");
            $("#<%=txtSupplierPrice.ClientID %>").val("");
            $("#<%=txtInitialStock.ClientID %>").val("");
            $("#<%=txtBarcode.ClientID %>").val("");
            $("#<%=txtReoredrQty.ClientID %>").val("");
            $("#<%=txtReorderPoint.ClientID %>").val("");



            $("#<%=dropDownSupplierList.ClientID %>   ").val("");
            $("#<%=dropDownCategoryList.ClientID %>   ").val("");
            $("#<%=dropDownBrandList.ClientID %>   ").val("");
            $("#<%=dropDownVatList.ClientID %>").val("");

            document.getElementById("chkStickControl").checked = false;

        }


    </script>

</asp:Content>

