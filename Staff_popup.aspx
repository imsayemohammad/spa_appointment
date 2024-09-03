<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Staff_popup.aspx.vb" Inherits="Staff_popup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
    <title>The Home Spa</title>

    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css'>
    <meta charset="utf-8">
    <meta name="description" content="Home Spa" />
    <meta name="keywords" content="Home Spa" />
    <!-- Device View -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- Bootstrap Core CSS -->
    <link href="../assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../assets/plugins/bootstrap-datepicker/bootstrap-datepicker.min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/plugins/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet" />

    <link href="../assets/plugins/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" />
    <!-- This page CSS -->
    <!-- chartist CSS -->
    <link href="../assets/plugins/chartist-js/dist/chartist.min.css" rel="stylesheet" />
    <link href="../assets/plugins/chartist-plugin-tooltip-master/dist/chartist-plugin-tooltip.css" rel="stylesheet" />
    <!--c3 CSS -->
    <link href="../assets/plugins/c3-master/c3.min.css" rel="stylesheet" />
    <!--Toaster Popup message CSS -->
    <link href="../assets/plugins/toast-master/css/jquery.toast.css" rel="stylesheet" />
    <!--fancy box-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.4.1/jquery.fancybox.min.css" />

    <!-- Custom CSS -->
    <link href="/css/style.css" rel="stylesheet" />
    <!-- Dashboard 1 Page CSS -->
    <link href="/css/pages/dashboard1.css" rel="stylesheet" />
    <!-- You can change the theme colors from here -->
    <link href="/css/colors/default-dark.css" id="theme" rel="stylesheet" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->

    <!--[if lt IE 9]>
    <script src="http://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="http://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

    <style type="text/css">
        input[type="checkbox"] {
            margin-right: 22px;
        }

        .myGroupCheckBox {
            list-style: none;
            width: 700px;
        }

            .myGroupCheckBox li {
                display: inline;
                width: 250px;
            }
    </style>

</head>

<body class="iframeBG">
    <form id="form1" runat="server">
        <div class="addeditclientmodal">
            <div>
                <div>
                    <div class="modal-header">
                        <h4 class="modal-title">Edit Staff
                        </h4>
                        <button type="button" onclick="ClearID();" class="close closebtn">&times;</button>
                    </div>

                    <div class="modal-body">
                        <div class="">
                            <form role="form">
                                <!-- Nav tabs -->
                                <ul class="nav nav-tabs profile-tab">
                                    <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#s-DETAILS" role="tab">DETAILS</a> </li>
                                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#s-LOCATIONS" role="tab">LOCATIONS</a> </li>
                                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#s-SERVICES" role="tab">SERVICES</a> </li>
                                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#s-COMMISSION" role="tab">COMMISSION</a></li>
                                </ul>
                                <!-- Tab panes -->
                                <div class="tab-content staffTabContent">
                                    <div class="tab-pane active" role="tabpanel" id="s-DETAILS">
                                        <div class="row">
                                            <div class="col-md-6 col-12">
                                                <div class="row">
                                                    <div class="col-md-6 col-12">
                                                        <div class="form-group">
                                                            <label class="control-label">First Name</label>
                                                            <asp:TextBox ID="txtFirstName" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ControlToValidate="txtFirstName" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator9" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 col-12">
                                                        <div class="form-group">
                                                            <label class="control-label">Last Name</label>
                                                            <asp:TextBox ID="txtLastName" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ControlToValidate="txtLastName" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 col-12">
                                                        <div class="form-group">
                                                            <label class="control-label">Mobile Number</label>
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
                                                                        <a class="dropdown-item" href="#">
                                                                            <i class="flag-icon flag-icon-bd m-r-10" title="ae" id="ae"></i>
                                                                            Bangladesh +880
                                                                        </a>
                                                                    </div>
                                                                </div>
                                                                <asp:TextBox ID="txtPhone" CssClass="form-control" runat="server" placeholder="+971 00 123 4567" ClientIDMode="Static"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ControlToValidate="txtPhone" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" Display="Dynamic" runat="server" ControlToValidate="txtPhone" ErrorMessage="* invalid" ValidationGroup="form" ForeColor="Red" ValidationExpression="^([0-9]\d*)$" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 col-12">
                                                        <div class="form-group">
                                                            <label class="control-label">Email</label>
                                                            <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ControlToValidate="txtEmail" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" Display="Dynamic" runat="server" ErrorMessage="* invalid" ValidationGroup="form" ControlToValidate="txtEmail" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 col-12">
                                                        <div class="form-group">
                                                            <label class="control-label">
                                                                User Permission
                                                                <span data-toggle="tooltip" data-placement="bottom" title="" data-original-title="When saved, this staff member will receive email instructions to setup their own login password" aria-describedby="">
                                                                    <i class="ti-help-alt text-danger"></i>
                                                                </span>
                                                            </label>
                                                            <asp:DropDownList ID="ddlPermission" runat="server" CssClass="form-control custom-select" data-placeholder="Choose staff" ClientIDMode="Static">
                                                                <asp:ListItem Value="Low">Low</asp:ListItem>
                                                                <asp:ListItem Value="No Access">No Access</asp:ListItem>
                                                                <asp:ListItem Value="Medium">Medium</asp:ListItem>
                                                                <asp:ListItem Value="High">High</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6 col-12">
                                                        <div class="form-group">
                                                            <label class="control-label">
                                                                &nbsp;
                                                            </label>

                                                            <div class="switch staff-switch">
                                                                <label>
                                                                    <input id="chkstatus" runat="server" type="checkbox" clientidmode="Static" />
                                                                    <%--<asp:CheckBox ID="chkstatus" runat="server" CssClass="switch staff-switch" ClientIDMode="Static"/>--%>
                                                                    <span class="lever"></span>Enable Appointment Bookings
                                                                    <span class="enable-appointment" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Allows this staff member to perform client bookings on the calendar, switch off for admin staff such as receptionist" aria-describedby="">
                                                                        <i class="ti-help-alt text-danger"></i>
                                                                    </span>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>



                                                    <div class="col-md-12 col-12">
                                                        <div class="form-group">
                                                            <label>
                                                                Appointment Color:
                                                                <span data-toggle="tooltip" data-placement="bottom" title="" data-original-title="See your Calendar Settings page under Setup to set how colors are displayed on the calendar" aria-describedby="">
                                                                    <i class="ti-help-alt text-danger"></i>
                                                                </span>

                                                            </label>
                                                            <div class="appnt-color">
                                                                <div class="pink">
                                                                    <input id="radio_1" runat="server" value="pink" clientidmode="Static" name="group1" type="radio" class="with-gap" />
                                                                    <label for="radio_1"></label>
                                                                </div>
                                                                <div class="purple">
                                                                    <input id="radio_2" runat="server" value="purple" clientidmode="Static" name="group1" type="radio" class="with-gap" />
                                                                    <label for="radio_2"></label>
                                                                </div>
                                                                <div class="indigo">
                                                                    <input id="radio_3" runat="server" value="indigo" clientidmode="Static" name="group1" type="radio" class="with-gap" />
                                                                    <label for="radio_3"></label>
                                                                </div>
                                                                <div class="blue">
                                                                    <input id="radio_4" runat="server" value="blue" clientidmode="Static" name="group1" type="radio" class="with-gap" />
                                                                    <label for="radio_4"></label>
                                                                </div>
                                                                <div class="cyan">
                                                                    <input id="radio_5" runat="server" value="cyan" clientidmode="Static" name="group1" type="radio" class="with-gap" />
                                                                    <label for="radio_5"></label>
                                                                </div>
                                                                <div class="teal">
                                                                    <input id="radio_6" runat="server" value="teal" clientidmode="Static" name="group1" type="radio" class="with-gap" />
                                                                    <label for="radio_6"></label>
                                                                </div>
                                                                <div class="green">
                                                                    <input id="radio_7" runat="server" value="green" clientidmode="Static" name="group1" type="radio" class="with-gap" />
                                                                    <label for="radio_7"></label>
                                                                </div>
                                                                <div class="lime">
                                                                    <input id="radio_8" runat="server" value="lime" clientidmode="Static" name="group1" type="radio" class="with-gap" />
                                                                    <label for="radio_8"></label>
                                                                </div>
                                                                <div class="yellow">
                                                                    <input id="radio_9" runat="server" value="yellow" clientidmode="Static" name="group1" type="radio" class="with-gap" />
                                                                    <label for="radio_9"></label>
                                                                </div>
                                                                <div class="orange">
                                                                    <input id="radio_10" runat="server" value="orange" clientidmode="Static" name="group1" type="radio" class="with-gap" />
                                                                    <label for="radio_10"></label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>



                                                </div>
                                            </div>
                                            <div class="col-md-6 col-12">
                                                <div class="row">

                                                    <div class="col-md-6 col-12">
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="form-group">
                                                                    <label>Employment Start Date: </label>
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="txtstartDT" runat="server" CssClass="form-control mydatepicker" placeholder="mm/dd/yyyy" ClientIDMode="Static"></asp:TextBox>
                                                                        <span class="input-group-addon"><i class="icon-calender"></i></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-12">
                                                                <div class="form-group">
                                                                    <label>Employment End Date: </label>
                                                                    <div class="input-group">
                                                                        <asp:TextBox ID="txtEndDT" runat="server" CssClass="form-control mydatepicker" placeholder="mm/dd/yyyy" ClientIDMode="Static"></asp:TextBox>
                                                                        <span class="input-group-addon"><i class="icon-calender"></i></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>


                                                    <%--upload picture--%>

                                                    <div class="col-md-6 col-12">
                                                        <div class="form-group">
                                                            <label>Picture: </label>
                                                            <div class="upload-picture">
                                                                <div class="text-cemter image-holder">
                                                                    <%Dim staffid = Request.QueryString("staffid")
                                                                        Dim hasimage = Utility.StringData("Select BigImage From Staff Where StaffID = " & staffid & "")
                                                                        If Not String.IsNullOrEmpty(hasimage) then  %>
                                                                    <asp:Image ID="imgSmallImage" runat="server" ClientIDMode="Static" />
                                                                    <%Else %>
                                                                    <img src="images/avatar.png" alt="Upload Picture" />
                                                                    <% End If %>

                                                                    <%--<img src="https://via.placeholder.com/220x115">--%>
                                                                    <div class="upload-wrapper" data-toggle="tooltip" data-placement="right" title="" data-original-title="upload picture here" aria-describedy="">
                                                                        <div class="inner">
                                                                            <a href="javascript:;" class="file-upload-button"><span class="mdi mdi-upload"></span></a>
                                                                            <%--<input type="file">--%>
                                                                            <asp:FileUpload ID="fuImageFile" accept="image/*" onchange="loadFile(event)" ClientIDMode="Static" runat="server" />
                                                                            <asp:HiddenField ID="hdnImageUrl" runat="server" />
                                                                        </div>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%--upload picture--%>

                                                    <div class="col-md-12 col-12">
                                                        <div class="form-group">
                                                            <label class="control-label">Notes</label>
                                                            <asp:TextBox ID="txtNotes" CssClass="form-control" TextMode="MultiLine" Rows="5" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane" role="tabpanel" id="s-LOCATIONS">
                                        <div class="row">
                                            <div class="col-md-12 col-12">
                                                <p>Assign locations where this staff member can be booked.</p>
                                                <br />

                                                <div class="form-group">
                                                    <asp:CheckBoxList ID="ChkLocation" runat="server" ClientIDMode="Static" RepeatDirection="Vertical" CssClass="checkbox checkbox-success AllCheck" DataSourceID="sdsLocation" DataTextField="AreaName" DataValueField="AreaId">
                                                    </asp:CheckBoxList>

                                                    <asp:SqlDataSource ID="sdsLocation" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="Select 0 [AreaId],'All Locations' [AreaName] UNION Select [AreaId], [AreaName] from Areas WHERE [AreaStatus]=1  ORDER BY AreaId ASC"></asp:SqlDataSource>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane" role="tabpanel" id="s-SERVICES">
                                        <div class="row">
                                            <div class="col-md-12 col-2"></div>
                                            <div class="col-md-12 col-10">
                                                <p>Assign services this staff member can perform.</p>
                                                <br />

                                                <div class="">
                                                    <asp:CheckBoxList ID="ChkService" runat="server" ClientIDMode="Static" RepeatDirection="Vertical" CssClass="checkbox checkbox-success AllCheck checkbox1" DataSourceID="sdsChkService" DataTextField="Title" DataValueField="ServiceId">
                                                    </asp:CheckBoxList>

                                                    <asp:SqlDataSource ID="sdsChkService" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="Select 0 [ServiceId],'All Service' [Title] UNION Select [ServiceId], [Title] from Services WHERE [Status]=1  ORDER BY ServiceId ASC"></asp:SqlDataSource>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane" role="tabpanel" id="s-COMMISSION">
                                        <div class="row">
                                            <div class="col-md-4 col-12">
                                                <div class="form-group">
                                                    <label class="control-label">Service Commission</label>
                                                    <div class="input-group">
                                                        <span class="input-group-addon" id="basic-addon1">%</span>
                                                        <asp:TextBox ID="txtServiceCommission" CssClass="form-control" runat="server" ClientIDMode="Static" aria-describedby="basic-addon1"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4 col-12">
                                                <div class="form-group">
                                                    <label class="control-label">Product Commission</label>
                                                    <div class="input-group">
                                                        <span class="input-group-addon" id="basic-addon1">%</span>
                                                        <asp:TextBox ID="txtProductCommission" CssClass="form-control" runat="server" ClientIDMode="Static" aria-describedby="basic-addon1"></asp:TextBox>
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
                                                        <asp:TextBox ID="txtVSCommission" CssClass="form-control" runat="server" ClientIDMode="Static" aria-describedby="basic-addon1"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <asp:Label ID="lblmsg" runat="server" Font-Size="Medium" ForeColor="Red"></asp:Label>
                        <asp:Button ID="btndelete" OnClientClick="return confirm('Are you sure you want to delete?')" class="btn btn-inverse" runat="server" Text="Delete" />
                        <button type="button" class="btn btn-secondary waves-effect">Resend password setup email</button>
                        <asp:Button ID="btnsubmit" ValidationGroup="form" CssClass="btn btn-danger waves-effect waves-light save-category btnsubmit" runat="server" Text="Save" ClientIDMode="Static" />
                        <button type="button" onclick="ClearID()" class="btn btn-secondary waves-effect closebtn">Close</button>
                    </div>
                </div>

            </div>
        </div>



        <asp:HiddenField ID="hdnStaffid" runat="server" ClientIDMode="Static" />

    </form>



    <script src="../assets/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap popper Core JavaScript -->
    <script src="../assets/plugins/bootstrap/js/popper.min.js"></script>
    <script src="../assets/plugins/bootstrap/js/bootstrap.min.js"></script>
    <!-- slimscrollbar scrollbar JavaScript -->
    <script src="/js/perfect-scrollbar.jquery.min.js"></script>
    <!--Wave Effects -->
    <script src="/js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="/js/sidebarmenu.js"></script>
    <!--fancy box-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.4.1/jquery.fancybox.min.js"></script>

    <!--Custom JavaScript -->
    <script src="/js/custom.min.js"></script>
    <!-- ============================================================== -->
    <!-- This page plugins -->
    <!-- ============================================================== -->
    <!--sparkline JavaScript -->
    <script src="../assets/plugins/sparkline/jquery.sparkline.min.js"></script>

    <script src="../assets/plugins/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
    <script src="../assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>

    <script type="text/javascript">
        jQuery('.mydatepicker, #datepicker').datepicker();
        jQuery('#datepicker-autoclose').datepicker({
            autoclose: true,
            todayHighlight: true
        });

    </script>
    <script type="text/javascript">
        $("#ChkLocation_0").click(function () {
            $('input:checkbox').not(this).prop('checked', this.checked);
        });

        $("#ChkService_0").click(function () {
            $('input:checkbox').not(this).prop('checked', this.checked);
        });

    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("<%=imgSmallImage.ClientID %>").hide();
        });

    </script>

    <script type="text/javascript">
        var loadFile = function (event) {
            $("<%=imgSmallImage.ClientID %>").show();
            var output = document.getElementById("<%=imgSmallImage.ClientID %>");
            output.src = URL.createObjectURL(event.target.files[0]);
        };
    </script>

    <%--<script type="text/javascript">
        $('#btnsubmit').click(function () {
            var staffid = $("#<%= hdnStaffid.ClientID%>").val();
    var FirstName = $("#
    <%= txtFirstName.ClientID%>").val();
    var LastName = $("#
    <%= txtLastName.ClientID%>").val();
    var Phone = $("#
    <%= txtPhone.ClientID%>").val();
    var Email = $("#
    <%= txtEmail.ClientID%>").val();
    var Notes = $("#
    <%= txtNotes.ClientID%>").val();
    var StartDate = $("#
    <%= txtstartDT.ClientID%>").val();
    var EndDate = $("#
    <%= txtEndDT.ClientID%>").val();
    var Permission = $("#
    <%= ddlPermission.ClientID%>").val();
    //var Permission = "1";
    if (FirstName !== "") {
    $.ajax({
    url: 'Staff.aspx/SaveData',
    type: 'POST',
    cache: false,
    contentType: "application/json; charset=utf-8",
    data: JSON.stringify({
    staffid: staffid,
    FirstName: FirstName,
    LastName: LastName,
    Phone: Phone,
    Email: Email,
    Notes: Notes,
    StartDate: StartDate,
    EndDate: EndDate,
    Permission: Permission
    }),
    dataType: "json",
    success: function (data) {

    $("#
    <%= hdnStaffid.ClientID%>").val("");
    $("#
    <%= txtFirstName.ClientID%>").val("");
    $("#
    <%= txtLastName.ClientID%>").val("");
    $("#
    <%= txtPhone.ClientID%>").val("");
    $("#
    <%= txtEmail.ClientID%>").val("");
    $("#
    <%= txtNotes.ClientID%>").val("");
    $("#
    <%= txtstartDT.ClientID%>").val("");
    $("#
    <%= txtEndDT.ClientID%>").val("");
    $("#
    <%= ddlPermission.ClientID%>").val("");

    window.location.reload();
    }
    });
    } else {
    //alert("work");
    }


    });

    function GetStaffById(x) {
    var StaffId = x;
    //alert(StaffId);
    $.ajax({
    type: 'Post',
    url: 'Staff.aspx/StaffByStaffId',
    contentType: "application/json; charset=utf-8",
    data: JSON.stringify({
    StaffId: StaffId
    }),
    dataType: "json",
    success: function (result) {
    $.each(result,
    function (key, value) {
    document.getElementById('hdnStaffid').value = value.StaffId;
    document.getElementById('txtFirstName').value = value.FirstName;
    document.getElementById('txtLastName').value = value.LastName;
    document.getElementById('txtPhone').value = value.Phone;
    document.getElementById('txtEmail').value = value.Email;
    document.getElementById('txtNotes').value = value.Notes;
    //document.getElementById('txtstartDT').value = value.StartDate;
    $("#txtstartDT").val(value.StartDate);
    document.getElementById('txtEndDT').value = value.EndDate;
    document.getElementById('ddlPermission').value = value.Permission;
    // console.log(value.CategoryName);
    // console.log(value.CategoryID);
    });
    }

    });
    }

    function ClearID() {

    document.getElementById('hdnStaffid').value = "";
    document.getElementById('txtFirstName').value = "";
    document.getElementById('txtLastName').value = "";
    document.getElementById('txtPhone').value = "";
    document.getElementById('txtEmail').value = "";
    document.getElementById('txtNotes').value = "";
    document.getElementById('txtstartDT').value = "";
    document.getElementById('txtEndDT').value = "";
    document.getElementById('ddlPermission').value = "";

    $("#
    <%= RequiredFieldValidator1.ClientID%>").val("");
    $("#
    <%= RequiredFieldValidator2.ClientID%>").val("");
    $("#
    <%= RequiredFieldValidator3.ClientID%>").val("");
    $("#
    <%= RequiredFieldValidator9.ClientID%>").val("");
    }
    <%--</script>--%>
</body>

</html>
