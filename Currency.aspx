<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Currency.aspx.vb" Inherits="BrandList" %>

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
                <h3 class="text-themecolor">Currency</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                    <li class="breadcrumb-item"><a href="/accounts">Account</a></li>
                    <li class="breadcrumb-item active">Currency</li>
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
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs profile-tab">
                            <li class="nav-item"><a class="nav-link" href="/company">Company Details</a></li>
                            <li class="nav-item"><a class="nav-link active" href="/currency">Currency</a></li>
                            <li class="nav-item"><a class="nav-link" href="#">Resources</a></li>
                            <li class="nav-item"><a class="nav-link" href="#">Settings</a></li>
                            <li class="nav-item"><a class="nav-link" href="#">Online Booking Settings</a></li>
                            <li class="nav-item"><a class="nav-link" href="#">Staff Notifications</a></li>
                        </ul>
                        <!-- Tab panes -->
                    </ul>
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row">

                                    <div class="col-md-6 col-sm-6 col-12">
                                        <div class="form-group">
                                            <label>Search by currency name</label>
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



                                <div class="row">
                                    <div class="col-lg-12 col-xlg-12 col-md-12 col-12">
                                        <div>
                                            <table class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Currency Name</th>
                                                        <th>Currency Type</th>
                                                        <th>Currency Symbol</th>
                                                        <th>Currency Value</th>
                                                        <th>Action</th>

                                                    </tr>
                                                </thead>
                                                <tbody>


                                                    <asp:ListView ID="lstCurrency" runat="server">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td>
                                                                    <a href="#"><%# Eval("CurrName")%></a>
                                                                </td>
                                                                <td>
                                                                    <a href="#"><%# Eval("CurType")%></a>
                                                                </td>
                                                                <td>
                                                                    <a href="#"><%# Eval("Symbol")%></a>
                                                                </td>
                                                                <td>
                                                                    <a href="#"><%# Eval("DecimalValue")%></a>
                                                                </td>

                                                                <td>
                                                                    <a href="#" onclick='GetCurrencyById(<%# Eval("CurrID")%>)' data-toggle="modal" data-target="#editcategorymodal">
                                                                        <img src="images/icons/ic-edit.png" /></a>  |
                                                                    
                                                                    
                                                                    
                                                                    <a href="#" onclick='DeleteCurrencyById(<%# Eval("CurrID")%>)' ">
                                                                        <img src="images/icons/ic-delete.png" /></a> 
                                                                    
                                                                   
                                                                </td>



                                                            </tr>

                                                        </ItemTemplate>
                                                    </asp:ListView>

                                                </tbody>

                                            </table>

                                            <%--    <h6 class="card-subtitle">Displaying <code class="bg-light-success">1 - 25 of 3959 total </code></h6>--%>

                                            <!-- END MODAL -->

                                            <div class="modal fade none-border editcategorymodal" id="editcategorymodal">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h4 class="modal-title">Add/Edit Currency                               
                                                            </h4>
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="ClearID()">×</button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form role="form">
                                                                <div class="row">
                                                                    <div class="col-sm-6 col-12">
                                                                        <div class="form-group">
                                                                            <asp:HiddenField ID="hidCurrencyID" runat="server" ClientIDMode="Static" />
                                                                            <label class="control-label">Currency Name</label>

                                                                            <asp:TextBox ID="txtCurrencyName" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ControlToValidate="txtCurrencyName" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidatortxtCurrencyName" runat="server"
                                                                                ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-sm-6 col-12">
                                                                        <div class="form-group">
                                                                            <label class="control-label">Short Form</label>
                                                                            <asp:TextBox ID="txtShortForm" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ControlToValidate="txtShortForm" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1txtShortForm" runat="server"
                                                                                ErrorMessage="*"></asp:RequiredFieldValidator>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-sm-6 col-12">
                                                                        <div class="form-group">
                                                                            <label class="control-label">Extra Rate</label>
                                                                            <asp:TextBox ID="txtExtraRate" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ControlToValidate="txtExtraRate" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1txtExtraRate" runat="server"
                                                                                ErrorMessage="*"></asp:RequiredFieldValidator>

                                                                        </div>
                                                                    </div>

                                                                    <div class="col-sm-6 col-12">
                                                                        <div class="form-group">
                                                                            <label class="control-label">Currency Type</label>
                                                                            <asp:TextBox ID="txtCurrencyType" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ControlToValidate="txtCurrencyType" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1txtCurrencyType" runat="server"
                                                                                ErrorMessage="*"></asp:RequiredFieldValidator>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-sm-6 col-12">
                                                                        <div class="form-group">
                                                                            <label class="control-label">Currency  Value</label>
                                                                            <asp:TextBox ID="txtCurrencyValue" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ControlToValidate="txtCurrencyValue" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidatortxtCurrencyValue" runat="server"
                                                                                ErrorMessage="*"></asp:RequiredFieldValidator>

                                                                        </div>
                                                                    </div>

                                                                    <div class="col-sm-6 col-12">
                                                                        <div class="form-group">
                                                                            <label class="control-label">Currency  Symbol</label>
                                                                            <asp:TextBox ID="txtCurrencySymbol" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ControlToValidate="txtCurrencySymbol" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidatortxtCurrencySymbol" runat="server"
                                                                                ErrorMessage="*"></asp:RequiredFieldValidator>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-md-12 col-xs-12">
                                                                        <div class="form-group">

                                                                            <div class="form-group">
                                                                                <asp:CheckBox ID="chkIsInternational" runat="server" ClientIDMode="Static" />
                                                                                <label for="chkIsInternational">IsInternational</label>
                                                                            </div>

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
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">

    <script>

        function ClearID() {
            $("#<%=hidCurrencyID.ClientID %>").val("");
            $("#<%=txtCurrencyName.ClientID %>").val("");
            $("#<%=txtExtraRate.ClientID %>").val("");
            $("#<%=txtCurrencyType.ClientID %>").val("");
            $("#<%=txtCurrencyValue.ClientID %>").val("");
            $("#<%=txtCurrencySymbol.ClientID %>").val("");
            $("#<%=txtShortForm.ClientID %>").val("");

            document.getElementById("chkIsInternational").checked = false;
        }










        function GetCurrencyById(x) {

            var CurrencyId = x;

            $.ajax({
                type: 'Post',
                url: 'Currency.aspx/GetCurrencyById',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ CurrencyId: CurrencyId }),
                dataType: "json",
                success: function (result) {


                    $.each(result,
                        function (key, value) {

                            ClearID();
                            document.getElementById('hidCurrencyID').value = value.hidCurrencyID;
                            document.getElementById('txtCurrencyName').value = value.txtCurrencyName;
                            document.getElementById('txtExtraRate').value = value.txtExtraRate;
                            document.getElementById('txtCurrencyType').value = value.txtCurrencyType;
                            document.getElementById('txtCurrencyValue').value = value.txtCurrencyValue;
                            document.getElementById('txtCurrencySymbol').value = value.txtCurrencySymbol;
                            document.getElementById('txtShortForm').value = value.txtShortForm;

                            if (value.chkIsInternational !== false) {
                                document.getElementById("chkIsInternational").checked = true;
                            } else {
                                document.getElementById("chkIsInternational").checked = false;
                            }


                        });



                }

            });



        }



         
          
        function DeleteCurrencyById(x) {


            var CurrencyId = x;


            if (confirm("Are You Sure You Want To Delete ?")) {


                $.ajax({
                    type: 'Post',
                    url: 'Currency.aspx/DeleteCurrencyById',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ CurrencyId: CurrencyId }),
                    dataType: "json",
                    success: function () {
                        location.reload();

                    }
                });

            } else {

            }

        }


    </script>

</asp:Content>

