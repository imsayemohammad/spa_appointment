<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Team_popup.aspx.vb" Inherits="Team_popup" %>

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


    <link href="/css/pages/google-vector-map.css" rel="stylesheet" type="text/css" />
    <link href="/css/pages/jquery-gmaps-latlon-picker.css" rel="stylesheet" type="text/css" />

    <script src="/assets/plugins/jquery/jquery.min.js" type="text/javascript"></script>
    <!-- google maps api -->
    <%--<script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyAAoCreJSTSKMSraR3BTeIV8TBxoyI4OWA&amp;libraries=places"></script>--%>
    <script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyAAoCreJSTSKMSraR3BTeIV8TBxoyI4OWA&amp" type="text/javascript"></script>
    <script src="/js/jquery-gmaps-latlon-picker.js" type="text/javascript"></script>
    <%--<script src="/assets/plugins/gmaps/gmaps.min.js"></script>
    <script src="/assets/plugins/gmaps/jquery.gmaps.js"></script>--%>
    <!--<script type="text/javascript" charset="UTF-8" src="http://maps.googleapis.com/maps-api-v3/api/js/34/4/util.js"></script>-->
    <style type="text/css">
        .wt1 {
            width: 357px !important;
        }

        .spanarea span {
            position: absolute;
            font-size: 0.3em;
            top: -1px;
            color: #fff;
            right: 15.5px;
        }
    </style>

</head>



<body class="iframeBG">
    <form id="form1" runat="server">

        <div class="addeditclientmodal">
            <div>
                <div>
                    <div class="modal-header">
                        <h4 class="modal-title"><strong>Add/Edit </strong>Team </h4>
                        <button type="button" class="close closebtn" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <form role="form">
                            <div class="row fix-height-32">
                                <div class="col-md-8 col-12 scroll">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">

                                            <asp:HiddenField ID="hidTeamID" runat="server" ClientIDMode="Static" />
                                            <label class="control-label">Team NAME</label>

                                            <asp:TextBox ID="txtTeamName" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                            <asp:RequiredFieldValidator ControlToValidate="txtTeamName" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1" runat="server"
                                                ErrorMessage="*"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>

                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="form-group">
                                                <label class="control-label">Details</label>
                                                <asp:TextBox ID="txtTeamDetails" Rows="5" TextMode="MultiLine" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="form-group">
                                                <div class="checkbox checkbox-success">
                                                    <asp:CheckBox ID="chkStatus" runat="server"  />
                                                    <label for="chkStatus">Status </label>
                                                </div>
                                                
                                            </div>
                                        </div>
                                    </div>              
                                    <div class="col-md-12 col-12">
                                        <div class="form-group">
                                            <label>
                                                Team Color:
                                                <span data-toggle="tooltip" data-placement="bottom" title="" data-original-title="See your Calendar Settings page under Setup to set how colors are displayed on the calendar" aria-describedby="">
                                                    <i class="ti-help-alt text-danger"></i>
                                                </span>

                                            </label>
                                            <div class="appnt-color">

                                                <div class="pink">
                                                    <input id="radio_1"  value="pink" runat="server" clientidmode="Static" name="group1" type="radio" class="with-gap"/>
                                                    <label for="radio_1"></label>
                                                </div>
                                                <div class="purple">
                                                    <input id="radio_2"  value="purple" runat="server" clientidmode="Static" name="group1" type="radio" class="with-gap"/>
                                                    <label for="radio_2"></label>
                                                </div>
                                                <div class="indigo">
                                                    <input id="radio_3"  value="indigo" runat="server" clientidmode="Static" name="group1" type="radio" class="with-gap"/>
                                                    <label for="radio_3"></label>
                                                </div>
                                                <div class="blue">
                                                    <input id="radio_4"  value="blue" runat="server" clientidmode="Static" name="group1" type="radio" class="with-gap" />
                                                    <label for="radio_4"></label>
                                                </div>
                                                <div class="cyan">
                                                    <input id="radio_5"  value="cyan" runat="server" clientidmode="Static" name="group1" type="radio" class="with-gap"/>
                                                    <label for="radio_5"></label>
                                                </div>
                                                <div class="teal">
                                                    <input id="radio_6"   value="teal" runat="server" clientidmode="Static" name="group1" type="radio" class="with-gap"/>
                                                    <label for="radio_6"></label>
                                                </div>
                                                <div class="green">
                                                    <input id="radio_7" value="green"  runat="server" clientidmode="Static" name="group1" type="radio" class="with-gap"/>
                                                    <label for="radio_7"></label>
                                                </div>
                                                <div class="lime">
                                                    <input id="radio_8"  value="lime" runat="server" clientidmode="Static" name="group1" type="radio" class="with-gap" />
                                                    <label for="radio_8"></label>
                                                </div>                  `
                                                <div class="yellow">
                                                    <input id="radio_9"  value="yellow" runat="server" clientidmode="Static" name="group1" type="radio" class="with-gap"/>
                                                    <label for="radio_9"></label>
                                                </div>
                                                <div class="orange">
                                                    <input id="radio_10" value="orange" runat="server" clientidmode="Static" name="group1" type="radio" class="with-gap"/>
                                                    <label for="radio_10"></label>
                                                </div>
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
                        <button type="button" class="btn btn-secondary waves-effect closebtn" data-dismiss="modal"  >Close</button>
                    </div>
                </div>

            </div>
        </div>




    </form>



    <script src="../assets/plugins/jquery/jquery.min.js" type="text/javascript"></script>
    <!-- Bootstrap popper Core JavaScript -->
    <script src="../assets/plugins/bootstrap/js/popper.min.js" type="text/javascript"></script>
    <script src="../assets/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!-- slimscrollbar scrollbar JavaScript -->
    <script src="/js/perfect-scrollbar.jquery.min.js" type="text/javascript"></script>
    <!--Wave Effects -->
    <script src="/js/waves.js" type="text/javascript"></script>
    <!--Menu sidebar -->
    <script src="/js/sidebarmenu.js" type="text/javascript"></script>
    <!--fancy box-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.4.1/jquery.fancybox.min.js" type="text/javascript"></script>

    <!--Custom JavaScript -->
    <script src="/js/custom.min.js" type="text/javascript"></script>
    <!-- ============================================================== -->
    <!-- This page plugins -->
    <!-- ============================================================== -->
    <!--sparkline JavaScript -->
    <script src="../assets/plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>

    <script src="../assets/plugins/bootstrap-datepicker/bootstrap-datepicker.min.js" type="text/javascript"></script>
    <script src="../assets/plugins/bootstrap-daterangepicker/daterangepicker.js" type="text/javascript"></script>

    <!--c3 JavaScript -->
    <script src="/assets/plugins/d3/d3.min.js" type="text/javascript"></script>
    <script src="/assets/plugins/c3-master/c3.min.js" type="text/javascript"></script>
    <!-- Popup message jquery -->
    <script src="/assets/plugins/toast-master/js/jquery.toast.js" type="text/javascript"></script>


    <script type="text/javascript">
        $("#ChkLocation_0").click(function () {
            $('input:checkbox').not(this).prop('checked', this.checked);
        });

        $("#ChkService_0").click(function () {
            $('input:checkbox').not(this).prop('checked', this.checked);
        });

    </script>

</body>

</html>
