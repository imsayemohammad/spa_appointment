<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Company.aspx.vb" Inherits="Company" %>

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
                <h3 class="text-themecolor">Setup</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                    <li class="breadcrumb-item"><a href="/accounts">Account</a></li>
                    <li class="breadcrumb-item active">Company</li>
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
                        <li class="nav-item"><a class="nav-link active" href="/company">Company Details</a></li>
                        <li class="nav-item"><a class="nav-link" href="/currency">Currency</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Resources</a></li>
                        <li class="nav-item"><a class="nav-link" href="/calendarsettings">Calendar Settings</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Online Booking Settings</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Staff Notifications</a></li>
                    </ul>
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row company-form">
                                    <div class="col-md-12 col-12">
                                        <h4>Company Setup</h4>
                                        <p>Manage your company general settings</p>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Business Name:</label>
                                            <%--                                            <input type="text" class="form-control" id="CompanyBusinessName">--%>
                                            <asp:TextBox ID="CompanyBusinessName" CssClass="form-control" runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator ControlToValidate="CompanyBusinessName" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator9CompanyBusinessName" runat="server"
                                                ErrorMessage="*"></asp:RequiredFieldValidator>


                                        </div>
                                        <div class="form-group">
                                            <label>Description</label>

                                            <%--  <textarea class="form-control" rows="5" id="CompanyDescription"></textarea>--%>


                                            <asp:TextBox ID="CompanyDescription" Rows="5" TextMode="MultiLine" CssClass="form-control" runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator ControlToValidate="CompanyDescription" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1CompanyDescription" runat="server"
                                                ErrorMessage="*"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="form-group">
                                            <label>Address</label>

                                            <%-- <input type="text" class="form-control" id="CompanyAddress">--%>


                                            <asp:TextBox ID="CompanyAddress" CssClass="form-control" runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator ControlToValidate="CompanyAddress" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1CompanyAddress" runat="server"
                                                ErrorMessage="*"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="form-group">
                                            <label>Website</label>

                                            <%-- <input type="text" class="form-control" id="CompanyWebsite"> --%>
                                            <asp:TextBox ID="CompanyWebsite" CssClass="form-control" runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator ControlToValidate="CompanyWebsite" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1CompanyWebsite" runat="server"
                                                ErrorMessage="*"></asp:RequiredFieldValidator>


                                        </div>
                                        <div class="form-group">
                                            <label>Contact Number</label>
                                            <div class="input-group">
                                                <div class="input-group-btn">
                                                    <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <i class="flag-icon flag-icon-ae m-r-10" title="ae" id="ae"></i>
                                                    </button>
                                                    <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; transform: translate3d(0px, 38px, 0px); top: 0px; left: 0px; will-change: transform;">
                                                        <a class="dropdown-item" href="#">
                                                            <i class="flag-icon flag-icon-ae m-r-10" title="ae" id="ae"></i>
                                                            United Arab Emirates +971
                                                        </a>
                                                        <a class="dropdown-item" href="#">
                                                            <i class="flag-icon flag-icon-us m-r-10" title="ae" id="ae"></i>
                                                            United States +1
                                                        </a>
                                                        <a class="dropdown-item" href="#">
                                                            <i class="flag-icon flag-icon-gb m-r-10" title="ae" id="ae"></i>
                                                            United Kingdom +2
                                                        </a>
                                                    </div>
                                                </div>

                                                <input type="text" class="form-control" aria-label="" placeholder="+971 00 123 4567" id="CompanyPhoneNumber">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Business Type</label>
                                            <select class="form-control custom-select" id="CompnayBusinessType">
                                                <option value="mobile-therapy">Mobile
                                                    Therepy</option>
                                                <option value="mobile-therapy">Mobile
                                                    Therepy</option>
                                                <option value="mobile-therapy">Mobile
                                                    Therepy</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label>Time Zone</label>

                                            <asp:DropDownList class="form-control " ID="dropDownTimeZoneList" runat="server">
                                            </asp:DropDownList>
                                        </div>

                                        <div class="form-group">
                                            <label>Time Format</label>
                                            <asp:DropDownList class="form-control " ID="dropDownTimeFormatList" runat="server">
                                            </asp:DropDownList>
                                        </div>




                                        <div class="form-group">
                                            <label>Currency</label>


                                            <asp:DropDownList class="form-control " ID="dropDownCurrencyList" runat="server">
                                            </asp:DropDownList>


                                        </div>
                                        <div class="form-group">
                                            <asp:Button ID="btnsubmit" ValidationGroup="form" CssClass="btn btn-danger waves-effect waves-light  btnsubmit"
                                                runat="server" Text="Save" ClientIDMode="Static" />

                                        </div>

                                    </div>
                                    <div class="col-md-6"></div>


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


        $(document).ready(function () {

            $.ajax({
                type: 'Post',
                url: 'Company.aspx/GetData',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {

                    $.each(result,
                        function (key, value) {
                            $("#<%=dropDownCurrencyList.ClientID %>").val(value.Currency);
                            $("#<%=dropDownTimeZoneList.ClientID %>").val(value.TimeZone);
                            $("#<%=dropDownTimeFormatList.ClientID %>").val(value.TimeFormat);
                        });




                }
            });

        });

        $('.save-category').click(function () {




            var CompanyBusinessName = $("#CompanyBusinessName").val();
            var CompanyDescription = $("#CompanyDescription").val();
            var CompanyAddress = $("#CompanyAddress").val();
            var CompanyWebsite = $("#CompanyWebsite").val();
            var CompanyPhoneNumber = $("#CompanyPhoneNumber").val();
            var CompnayTimeZone = $("#CompnayTimeZone").val();
            var CompanyTimeFormat = $("#CompanyTimeFormat").val();
            var CompnayCounty = $("#CompnayCounty").val();
            var CompanyCurrncy = $("#CompanyCurrncy").val();
            var CompnayBusinessType = $("#CompnayBusinessType").val();
            //CompnayBusinessType


            //alert(CompanyBusinessName);

            //CompanyBusinessName, CompanyDescription, CompanyAddress, CompanyWebsite, CompanyPhoneNumber,CompnayTimeZone,CompanyTimeFormat,CompnayCounty,CompanyCurrncy
            $.ajax({
                type: 'Post',
                url: 'Company.aspx/SaveCompnay',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ CompanyBusinessName: CompanyBusinessName, CompanyDescription: CompanyDescription, CompanyAddress: CompanyAddress, CompanyWebsite: CompanyWebsite, CompanyPhoneNumber: CompanyPhoneNumber, CompnayTimeZone: CompnayTimeZone, CompanyTimeFormat: CompanyTimeFormat, CompnayCounty: CompnayCounty, CompanyCurrncy: CompanyCurrncy, CompnayBusinessType: CompnayBusinessType }),
                dataType: "json",
                success: function (result) {


                    //                        $('#clientmessageshow').show();
                    //                        $('#clientmessageshow').html(result);


                    $("#CompanyBusinessName").val("");
                    $("#CompanyDescription").val("");
                    $("#CompanyAddress").val("");
                    $("#CompanyWebsite").val("");
                    $("#CompanyPhoneNumber").val("");
                    $("#CompnayTimeZone").val("");
                    $("#CompanyTimeFormat").val("");
                    $("#CompnayCounty").val("");
                    $("#CompanyCurrncy").val("");

                    window.location.reload();

                }
            });



        });


    </script>

</asp:Content>

