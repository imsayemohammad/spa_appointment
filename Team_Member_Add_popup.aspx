<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Team_Member_Add_popup.aspx.vb" Inherits="Team_popup" %>


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

    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" type="text/css" />

    <style type="text/css">
        .ui-autocomplete {
            max-width: 400px;
            max-height: 250px;
            overflow: auto;
            /*left: 392px;
            top: 175px;*/
        }
    </style>

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
    <script type="text/javascript">
        var ServiceArray = new Array();
        var arraycount = 0;
    </script>
</head>



<body class="iframeBG">
    <form id="form1" runat="server">
        
        
        <div class="addeditclientmodal">
            <div>
                <div>
                    <div class="modal-header">
                        <h4 class="modal-title"><strong>New </strong>Team Member </h4>
                        <button type="button" class="close closebtn" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <form role="form">
                            <div class="row fix-height-32">
                                <div class="col-md-8 col-12 scroll">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                                                                            
                                            <label class="control-label">Staff Name</label>
                                            <asp:TextBox ID="txtStaffName" runat="server" ClientIDMode="Static" CssClass="form-control" placeholder="Search for Staff " />
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatortxtStaffName" Display="Dynamic" ValidationGroup="form" SetFocusOnError="true" runat="server" ErrorMessage="* required"
                                                                        ControlToValidate="txtStaffName" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <asp:HiddenField ID="hdnStaffId" runat="server" ClientIDMode="Static" />
                                            <asp:HiddenField ID="hdnTeamId" runat="server" ClientIDMode="Static" />



                                        </div>
                                    </div>

                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="form-group">
                                                <label class="control-label">Details</label>
                                                <asp:TextBox ID="txtTeamMemberDetails" Rows="5" TextMode="MultiLine" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                            </div>
                                        </div>
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




    </form>

<%--
        <div class="addeditclientmodal">
            <div>
                <div>
                    <div class="modal-header">
                        <h4 class="modal-title"><strong>New </strong>Appointment</h4>
                        <button type="button" class="close closebtn" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <form role="form">
                            <div class="row fix-height-325">


                                <asp:TextBox ID="txtStaffName" runat="server" ClientIDMode="Static" CssClass="form-control" placeholder="Search for..." />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatortxtStaffName" Display="Dynamic" ValidationGroup="form" SetFocusOnError="true" runat="server" ErrorMessage="* required"
                                    ControlToValidate="txtStaffName" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:HiddenField ID="hdnStaffId" runat="server" ClientIDMode="Static" />

                            </div>

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button id="btnexcheckout" class="btn btn-inverse waves-effect waves-light">Express checkout</button>
                        <button id="btnsubmit" type="button" class="btn btn-danger waves-effect waves-light">Save Appointment</button>
                        <button type="button" class="closebtn btn btn-secondary waves-effect">Close</button>
                    </div>
                </div>

            </div>
        </div>


    </form>--%>

    <script type="text/javascript" src="/assets/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap popper Core JavaScript -->
    <script type="text/javascript" src="/assets/plugins/bootstrap/js/popper.min.js"></script>
    <script type="text/javascript" src="/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
    <!-- slimscrollbar scrollbar JavaScript -->
    <script type="text/javascript" src="/js/perfect-scrollbar.jquery.min.js"></script>
    <!--Wave Effects -->
    <script type="text/javascript" src="/js/waves.js"></script>
    <!--Menu sidebar -->
    <script type="text/javascript" src="/js/sidebarmenu.js"></script>
    <!--fancy box-->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.4.1/jquery.fancybox.min.js"></script>

    <!--Custom JavaScript -->

    <!-- ============================================================== -->
    <!-- This page plugins -->
    <!-- ============================================================== -->
    <!--sparkline JavaScript -->
    <script type="text/javascript" src="/assets/plugins/sparkline/jquery.sparkline.min.js"></script>

    <script type="text/javascript" src="/assets/plugins/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
    <script type="text/javascript" src="/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>

    <script type="text/javascript">
        jQuery('.mydatepicker, #datepicker').datepicker();
        jQuery('#datepicker-autoclose').datepicker({
            autoclose: true,
            todayHighlight: true
        });

    </script>

    <script type="text/javascript">

        $(document).ready(function () {



            $("#<%= txtStaffName.ClientID%>").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Team_Member_Add_popup.aspx/GetclientData",
                        data: "{'name':'" + request.term + "'}",
                        dataType: "json",
                        success: function (data) {
                            //response(data.d);
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.split('-')[0],
                                    val: item.split('-')[1]
                                }
                            }));
                        },
                        error: function (result) {
                            alert(result.responseText);
                        }
                    });
                },
                select: function (event, ui) {
                    $("#<%= txtStaffName.ClientID%>").val(ui.item.label);
                $("#<%= hdnStaffid.ClientID%>").val(ui.item.val);
            }
            });
        });
    </script>

    <%--<script src="http://code.jquery.com/ui/1.11.2/jquery-ui.js" type="text/javascript"></script>--%>

    <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js" type="text/javascript"></script>

    <script type="text/javascript" src="/js/custom.min.js"></script>

</body>

</html>
