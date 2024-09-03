<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" ValidateRequest="false" CodeFile="AllServices.aspx.vb" Inherits="AllServices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="toppart" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">

    <div class="container-fluid">

        <div class="row page-titles">
            <div class="col-md-5 align-self-center">
                <h3 class="text-themecolor">Services</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/Home">Home</a></li>
                    <li class="breadcrumb-item active">Services</li>
                </ol>
            </div>

        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="card">

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row">

                                    <div class="col-md-6 col-sm-6 col-12">
                                        <div class="form-group">
                                            <label>Search by Service Name</label>
                                            <asp:TextBox ID="txtSearch" CssClass="form-control " runat="server" ClientIDMode="Static"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <asp:Button ID="btnSearch" class="btn btn-danger waves-effect btn-block waves-light btnsubmit" CausesValidation="false" ClientIDMode="Static" runat="server" Text="Search" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <%--<div class="form-group">
                                                <label>&nbsp;</label>
                                                <div class="form-group">
                                                    <select class="form-control custom-select" data-placeholder="Export As" tabindex="1">
                                                        <option>Export As</option>
                                                        <option value="xlsx">Excel</option>                                              
                                                        <option value="pdf">PDF</option>
                                                        <option value="csv">CSV</option>
                                                    </select>
                                                </div>
                                            </div>--%>
                                    </div>
                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <button type="button" onclick="ClearID()" class="btn btn-info waves-effect btn-block waves-light" data-toggle="modal" data-target="#editservice">New Service</button>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                                <div class="row">
                                    <div class="col-lg-12 col-xlg-12 col-md-12 col-12">

                                        <div class="table-responsive">
                                            <div class="">
                                                <asp:Literal ID="ltlServiceGroup" runat="server"></asp:Literal>
                                                <asp:Literal ID="ltlServiceList" runat="server"></asp:Literal>

                                                <asp:ListView ID="lvService" runat="server" DataKeyNames="ServiceId">
                                                    <EmptyDataTemplate>
                                                        <table id="Table1" runat="server" style="">
                                                            <tr>
                                                                <td>Currently No Service available.</td>
                                                            </tr>
                                                        </table>
                                                    </EmptyDataTemplate>

                                                    <ItemTemplate>


                                                        <table class="table table-hover table-striped">
                                                            <asp:Label ID="lblGroup" runat="server" Text='<%# Eval("TitleHead") %>' Font-Bold="True" />
                                                            <thead>
                                                                <tr id="Tr1" runat="server" style="">

                                                                    <th>Sevice Name</th>
                                                                    <th>Arabic Sevice Name</th>
                                                                    <th>Duration</th>
                                                                    <th>Amount</th>
                                                                    <th>Location</th>
                                                                </tr>
                                                            </thead>
                                                            <tr>

                                                                <%--<td><a href="#" onclick='GetById(<%# Eval("ServiceId")%>)' data-toggle="modal" data-target="#editservice">
                                                                <asp:Label ID="lblGroup" runat="server" Text='<%# Eval("Title") %>' /></a>
                                                                </td>--%>

                                                                <%#GetRelatedServices(Eval("ServiceId")) %>
                                                            </tr>
                                                        </table>
                                                        <br />
                                                    </ItemTemplate>
                                                </asp:ListView>
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

    <div class="modal fade none-border editservice" id="editservice">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="lblHeader" runat="server">Add/Change Service                           
                    </h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                </div>
                <div class="modal-body">
                    <form role="form">
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs profile-tab">
                            <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#es-DETAILS" role="tab">DETAILS</a> </li>
                            <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#es-STAFF" role="tab">LOCATION</a> </li>
                            <%--<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#es-RESOURCES" role="tab">RESOURCES</a> </li>--%>
                            <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#es-DISTRIBUTION" role="tab">DISTRIBUTION</a></li>
                        </ul>
                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div class="tab-pane active" role="tabpanel" id="es-DETAILS">
                                <div class="row">
                                    <div class="col-md-4 col-12">
                                        <div class="form-group">
                                            <label class="control-label">Service Name</label>
                                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="" ClientIDMode="Static"></asp:TextBox>
                                            <span class="mand">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtName" SetFocusOnError="true"
                                                    Display="Dynamic" ValidationGroup="form" runat="server" Text="*" ErrorMessage="*"></asp:RequiredFieldValidator>
                                            </span>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">
                                                Treatment Type
                                            <span data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Choose the Service." aria-describedby="">
                                                <i class="ti-help-alt text-danger"></i>
                                            </span>
                                            </label>
                                            <asp:DropDownList ID="ddlGroup" runat="server" ClientIDMode="Static" CssClass="form-control custom-select">
                                                <asp:ListItem Text="Select Treatment Type" Value="0"></asp:ListItem>
                                            </asp:DropDownList>

                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">Available For</label>
                                            <asp:DropDownList ID="ddlGender" runat="server" ClientIDMode="Static" CssClass="form-control custom-select">
                                                <asp:ListItem Text="Everyone" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="Male Only" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="Female Only" Value="2"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label">
                                                TAX
                    <span class="font-10 text-inverse">Included in prices</span>
                                            </label>
                                            <asp:DropDownList ID="ddlTax" runat="server" ClientIDMode="Static" CssClass="form-control custom-select">
                                                <asp:ListItem Text="Not Applicable" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="Default Tax(5%)" Value="5"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>

                                        <div class="form-group">
                                            <div class="checkbox checkbox-success">
                                                <asp:CheckBox ID="chkEnableCommission" TextAlign="Right" ClientIDMode="Static" Text="ENABLE COMMISSION" runat="server" />
                                                <%--<input id="chkEnableCommission" runat="server" name="chkEnableCommission" type="checkbox">
                                                <label for="chkEnableCommission"><strong class="font-10">ENABLE COMMISSION</strong> </label>--%>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-md-8 col-12">
                                        <div class="row">
                                            <div class="col-md-4 col-12">
                                                <div class="form-group">
                                                    <label class="control-label">Arabic Service Name</label>
                                                    <asp:TextBox ID="txtArName" runat="server" CssClass="form-control" placeholder="" ClientIDMode="Static"></asp:TextBox>
                                                    <%-- <span class="mand">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtArName" SetFocusOnError="true"
                                                    Display="Dynamic" ValidationGroup="form" runat="server" Text="*" ErrorMessage="*"></asp:RequiredFieldValidator>
                                            </span>--%>
                                                </div>
                                            </div>
                                            <div class="col-md-4 col-12">
                                                <div class="form-group">
                                                    <label class="control-label">
                                                        Pricing Type
                    <span data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Choose the most relevant type, for internal reference and not currently visible to clients." aria-describedby="">
                        <i class="ti-help-alt text-danger"></i>
                    </span>
                                                    </label>
                                                    <asp:DropDownList ID="ddlPriceType" runat="server" ClientIDMode="Static" CssClass="form-control custom-select">
                                                        <asp:ListItem Text="Single" Value="0"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="row">
                                            <div class="col-md-4 col-12">
                                                <div class="form-group">
                                                    <label class="control-label">Duration</label>
                                                    <asp:DropDownList ID="ddlServiceDuration" runat="server" ClientIDMode="Static" CssClass="form-control custom-select">
                                                        <asp:ListItem Text="None" Value="0"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-md-4 col-12">
                                                <div class="form-group">
                                                    <label class="control-label">Retail Price</label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon">
                                                            <%=Utility.GetCurrencySymbol()%>
                                                        </div>
                                                        <asp:TextBox ID="txtRetailPrice" runat="server" CssClass="form-control" placeholder="" ClientIDMode="Static"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4 col-12">
                                                <div class="form-group">
                                                    <label class="control-label">Special Price</label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon">
                                                            <%=Utility.GetCurrencySymbol()%>
                                                        </div>
                                                        <asp:TextBox ID="txtSpecialPrice" runat="server" CssClass="form-control" placeholder="" ClientIDMode="Static"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-8 col-12">
                                                <div class="form-group">
                                                    <label class="control-label">Extra Time Type</label>
                                                    <asp:DropDownList ID="ddlExtraType" runat="server" ClientIDMode="Static" CssClass="form-control custom-select">
                                                        <asp:ListItem Text="No Extra Time" Value="0"></asp:ListItem>
                                                        <asp:ListItem Text="Processing Time After" Value="1"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-md-4 col-12">
                                                <div class="form-group">
                                                    <label class="control-label">Duration</label>
                                                    <asp:DropDownList ID="ddlExtraDuration" runat="server" ClientIDMode="Static" CssClass="form-control custom-select">
                                                        <asp:ListItem Text="None" Value="0"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>

                                        </div>

                                    </div>

                                </div>
                            </div>
                            <div class="tab-pane" role="tabpanel" id="es-STAFF">
                                <div class="row">
                                    <div class="col-md-12 col-12">

                                        <p>Assign locations where this staff member can be booked.</p>
                                        <br>


                                        <div class="form-group">

                                            <asp:CheckBoxList ID="chkFeatureName" runat="server" ClientIDMode="Static" RepeatDirection="Vertical" CssClass="checkbox checkbox-success chkLocationName" DataSourceID="sdsLocation" DataTextField="AreaName" DataValueField="AreaID"></asp:CheckBoxList>

                                            <asp:SqlDataSource ID="sdsLocation" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                                                SelectCommand="Select 0 as [AreaID], 'All Locations' as [AreaName] union  Select [AreaID], [AreaName] from Areas   ORDER BY AreaID ASC"></asp:SqlDataSource>
                                        </div>


                                    </div>
                                </div>
                            </div>

                            <div class="tab-pane" role="tabpanel" id="es-DISTRIBUTION">
                                <div class="row">
                                    <div class="col-md-4 col-12">
                                        <div class="form-group">
                                            <label class="control-label">Service Commission</label>
                                            <div class="input-group">
                                                <span class="input-group-addon" id="basic-addon1">%</span>
                                                <%--<input type="text" class="form-control" placeholder="Username" aria-describedby="basic-addon1">--%>
                                                <asp:TextBox ID="txtServiceCom" runat="server" CssClass="form-control" placeholder="" ClientIDMode="Static"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4 col-12">
                                        <div class="form-group">
                                            <label class="control-label">Product Commission</label>
                                            <div class="input-group">
                                                <span class="input-group-addon" id="basic-addon1">%</span>
                                                <asp:TextBox ID="txtProductCom" runat="server" CssClass="form-control" placeholder="" ClientIDMode="Static"></asp:TextBox>
                                                <%--<input type="text" class="form-control" placeholder="Username" aria-describedby="basic-addon1">--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4 col-12">
                                        <div class="form-group">
                                            <label class="control-label">Voucher Sales Commission</label>
                                            <div class="input-group">
                                                <span class="input-group-addon" id="basic-addon1">%</span>
                                                <asp:TextBox ID="txtVoucherCm" runat="server" CssClass="form-control" placeholder="" ClientIDMode="Static"></asp:TextBox>
                                                <%--<input type="text" class="form-control" placeholder="Username" aria-describedby="basic-addon1">--%>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <%--<button type="button" class="btn btn-inverse">Delete</button>--%>
                    <asp:Button ID="btnDelete" ValidationGroup="form" CssClass="btn btn-inverse"
                        runat="server" Text="Delete" ClientIDMode="Static" />
                    <%--<button type="button" class="btn btn-danger waves-effect waves-light save-category" data-dismiss="modal">Save</button>--%>
                    <asp:HiddenField ID="hdnParentID" runat="server" ClientIDMode="Static" />
                    <asp:Button ID="btnsubmit" ValidationGroup="form" CssClass="btn btn-danger waves-effect waves-light btnsubmit"
                        runat="server" Text="Save" ClientIDMode="Static" />
                    <button type="button" onclick="ClearID()" class="btn btn-secondary waves-effect" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- END MODAL -->

    <!-- ============================================================== -->
    <!-- End Container fluid  -->
    <!-- ============================================================== -->

    <asp:HiddenField ID="hdnServiceid" runat="server" ClientIDMode="Static" />



</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
        });


        $("#chkFeatureName_0").click(function () {
            $('input:checkbox').not(this).prop('checked', this.checked);
        });

        $('#btnsubmit').click(function () {
            $('#btnsubmit').disable = true;

            // btnsubmit
            var ServiceId = $("#<%= hdnServiceid.ClientID%>").val();
            var Title = $("#<%= txtName.ClientID%>").val();
            var ParentId = $("#<%= ddlGroup.ClientID%>").val();
            var PriceType = $("#<%= ddlPriceType.ClientID%>").val();
            var RetailPrice = $("#<%= txtRetailPrice.ClientID%>").val();
            var SpecialPrice = $("#<%= txtSpecialPrice.ClientID%>").val();
            var EnableCommission = $("#<%= chkEnableCommission.ClientID%>").val();
            var ServiceDuration = $("#<%= ddlServiceDuration.ClientID%>").val();
            var ExtraDuration = $("#<%= ddlExtraDuration.ClientID%>").val();
            var ExtraType = $("#<%= ddlExtraType.ClientID%>").val();
            var Gender = $("#<%= ddlGender.ClientID%>").val();
            var Tax = $("#<%= ddlTax.ClientID%>").val();
            var ProductCom = $("#<%= txtProductCom.ClientID%>").val();
            var ServiceCom = $("#<%= txtServiceCom.ClientID%>").val();
            var VoucherCm = $("#<%= txtVoucherCm.ClientID%>").val();
            var sLocationsId = "";
            var hdnParentID = $("#<%=hdnParentID.ClientID%>").val();
            var values = "";

            $("#<%= chkFeatureName.ClientID %>").find("input[type=checkbox]").each(function () {
                if (this.checked) {
                    if ($(this).next('label').text() !== "All Locations") {
                        sLocationsId += $(this).next('label').text() + ",";
                    }
                }
            });

            if (document.getElementById('chkEnableCommission').checked == true) {
                EnableCommission = "on";
            }

            var ArTitle = $("#<%= txtArName.ClientID%>").val();

            if (Title !== "") {
                $.ajax({
                    url: 'AllServices.aspx/SaveData',
                    type: 'POST',
                    cache: false,
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ ServiceId: ServiceId, Title: Title, ParentId: ParentId, PriceType: PriceType, RetailPrice: RetailPrice, SpecialPrice: SpecialPrice, EnableCommission: EnableCommission, ServiceDuration: ServiceDuration, ExtraType: ExtraType, ExtraDuration: ExtraDuration, Gender: Gender, Tax: Tax, ProductCom: ProductCom, ServiceCom: ServiceCom, VoucherCm: VoucherCm, sLocationsId: sLocationsId, ArTitle: ArTitle, hdnParentID: hdnParentID }),
                    dataType: "json",
                    success: function (data) {
                        $('#btnsubmit').disable = false;
                        ClearID();

                        window.location.reload();
                    }
                });
            } else {
                $('#btnsubmit').disable = false;
            }


        });

        $('#btnDelete').click(function () {
            var nId = $("#<%= hdnServiceid.ClientID%>").val();
            if (nId !== "") {
                DeleteById(nId);
            } else {
                //alert("work");
            }


        });

        function GetById(x) {
            ClearID();
            var ServiceId = x;
            $.ajax({
                type: 'Post',
                url: 'AllServices.aspx/ServiceById',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ ServiceId: ServiceId }),
                dataType: "json",
                success: function (result) {
                    $.each(result,
                        function (key, value) {
                            document.getElementById('txtName').value = value.Title;
                            document.getElementById('hdnServiceid').value = value.ServiceId;
                            document.getElementById('hdnParentID').value = value.hdnParentID;


                            $("#<%=ddlGroup.ClientID %>").val(value.ParentId);
                            $("#<%=ddlExtraDuration.ClientID %>").val(value.ExtraMins);
                            $("#<%=ddlExtraType.ClientID %>").val(value.IsExtraTimeNeeded);
                            $("#<%=ddlGender.ClientID %>").val(value.AvailableFor);
                            $("#<%=ddlPriceType.ClientID %>").val(value.PriceType);
                            $("#<%=ddlServiceDuration.ClientID %>").val(value.RequiredMins);
                            $("#<%=ddlTax.ClientID %>").val(value.Tax);
                            $("#<%=chkEnableCommission.ClientID %>").val(value.IsEnableCommission);

                            document.getElementById('txtRetailPrice').value = value.RetailPrice;
                            document.getElementById('txtSpecialPrice').value = value.SpecialPrice;

                            document.getElementById('txtProductCom').value = value.ProductCommision;
                            document.getElementById('txtServiceCom').value = value.ServiceCommision;
                            document.getElementById('txtVoucherCm').value = value.VoucherCommision;

                            document.getElementById('btnsubmit').value = "Update";

                            var content = "";
                            var tempLoc = new Array();
                            tempLoc = value.Locations.split(";");

                            for (a in tempLoc) {
                                $("#<%= chkFeatureName.ClientID %>").find("input[type=checkbox]").each(function () {
                                    if ($(this).next('label').text() == tempLoc[a].toString()) {
                                        $(this).prop('checked', true);
                                    }

                                });

                            }

                            if (value.IsEnableCommission == "on") {
                                $("#<%= chkEnableCommission.ClientID%>").prop('checked', true);
                            }

                            document.getElementById('txtArName').value = value.ArTitle;

                        });
                }

            });
            }

            function DeleteById(x) {
                var ServiceId = x;
                if (ServiceId !== "") {
                    $.ajax({
                        type: 'Post',
                        url: 'AllServices.aspx/DeleteServiceById',
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify({ ServiceId: ServiceId }),
                        dataType: "json",
                        success: function (result) {
                            $.each(result,
                                function (key, value) {
                                    window.location.reload();
                                });
                        }

                    });
                }
            }

            function ClearID() {


                $("#<%=txtName.ClientID %>").val("");
                $("#<%=hdnServiceid.ClientID %>").val("");
                $("#<%=hdnParentID.ClientID %>").val("");
                $("#<%=txtProductCom.ClientID %>").val("");
                $("#<%=txtSearch.ClientID %>").val("");
                $("#<%=txtRetailPrice.ClientID %>").val("");
                $("#<%=txtServiceCom.ClientID %>").val("");
                $("#<%=txtSpecialPrice.ClientID %>").val("");
                $("#<%=txtVoucherCm.ClientID %>").val("");
                $("#<%=ddlGroup.ClientID %>  ").val("");
                $("#<%=ddlServiceDuration.ClientID %>  ").val("");
                $("#<%=ddlExtraDuration.ClientID %>  ").val("");
                $("#<%=ddlExtraType.ClientID %>  ").val("");
                $("#<%=ddlGender.ClientID %>  ").val("");
                $("#<%=ddlPriceType.ClientID %>  ").val("");
                $("#<%=ddlServiceDuration.ClientID %>  ").val("");
                $("#<%=ddlTax.ClientID %>  ").val("");
                document.getElementById('btnsubmit').value = "Save";

                var checkboxList = $("[id*=chkFeatureName]");
                checkboxList.each(function () {
                    $(this).prop("checked", false);
                });

                $("#<%=txtArName.ClientID %>").val("");
            }

    </script>
</asp:Content>

