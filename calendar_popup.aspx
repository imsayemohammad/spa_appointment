<%@ Page Language="VB" AutoEventWireup="false" CodeFile="calendar_popup.aspx.vb" Inherits="calendar_popup" %>

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
                        <h4 class="modal-title"><strong>New </strong>Appointment</h4>
                        <button type="button" class="close closebtn" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <form role="form">
                            <div class="row fix-height-325">
                                <div class="col-md-8 col-12 scroll">
                                    <div class="row">
                                        <div class="col-md-4 col-sm-4 col-12">
                                            <div class="form-group">
                                                <label>Date: </label>
                                                <div class="input-group">
                                                    <asp:TextBox ID="txtdate" CssClass="form-control mydatepicker" runat="server" placeholder="mm/dd/yyyy" ClientIDMode="Static"></asp:TextBox>
                                                    <span class="input-group-addon"><i class="icon-calender"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3 col-sm-3 col-12 text-center">
                                            <a href="#"><i class="fa fa-refresh"></i>Repeat</a>
                                        </div>
                                    </div>

                                    <div id="DivContainer">
                                        <div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label class="control-label">Start Time</label>
                                                <select id="ddltime" class="form-control form-white" data-placeholder="Choose a time" name="category-color">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-10">
                                            <div class="form-group">
                                                <label class="control-label">Service</label>
                                                <select class="form-control" id="ddlChooseaservice">
                                                    <option value="-1">Choose a service</option>
                                                </select>
                                            </div>
                                        </div>
                                        <%--<asp:Panel ID="pnlstaffduration" runat="server" ClientIDMode="Static">--%>
                                        <div class="col-md-2 staffduration">
                                            <div class="form-group">
                                                <label class='control-label'>Duration</label>
                                                <select id="ddlduration" disabled="disabled" class="form-control form-white" data-placeholder="Choose a time" name="category-color">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-10 staffduration">
                                            <div class="form-group">
                                                <label class="control-label">Staff</label>
                                                <select id="ddlstaff" class="form-control custom-select" data-placeholder="Choose Staff" tabindex="1">
                                                    <option value="0">Choose Staff</option>
                                                </select>
                                            </div>
                                        </div>
                                        <%--</asp:Panel>--%>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label class="control-label">Appointment notes</label>
                                                <asp:TextBox ID="txtappointnote" runat="server" ClientIDMode="Static" TextMode="MultiLine" CssClass="form-control" Rows="5" />
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="col-md-4 col-12">
                                    <div class="card-body bg-light-inverse">
                                        <h4 class="card-title">Add Client</h4>
                                        <div class="input-group">
                                            <asp:TextBox ID="txtclient" runat="server" ClientIDMode="Static" CssClass="form-control" placeholder="Search for..." />
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" ValidationGroup="form" SetFocusOnError="true" runat="server" ErrorMessage="* required"
                                                ControlToValidate="txtclient" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <asp:HiddenField ID="hdnclientid" runat="server" ClientIDMode="Static" />
                                            <span class="input-group-btn">
                                                <button class="btn btn-info" type="button"><i class="fa fa-search"></i></button>
                                            </span>
                                        </div>
                                        <hr />
                                        <%--<div class="alert alert-warning">
                                            <h3 class="text-warning"><i class="fa fa-exclamation-triangle"></i>To add a client</h3>
                                            Use the search to add a client, or keep empty to save as walk-in.
                                        </div>
                                        <hr />--%>
                                        <br />
                                        <%--<button type="button" class="btn btn-info waves-effect btn-block waves-light" data-toggle="modal" data-target="#addeditclientmodal">Add New Client</button>--%>
                                        <%--<label id="lblbtnadd" runat="server">--%>
                                        <a id="btnadd" class="btn btn-info waves-effect btn-block waves-light addnewFancy" href="Client_popup.aspx?page=calendar" data-fancybox data-type="iframe" style="color: #fff">Add New</a>
                                        <%--</label>--%>
                                    </div>
                                    <br />
                                    <br />
                                    <br />
                                    <div id="dvtotamt" class="text-center">
                                        <hr />
                                        <br />
                                        <span>Total: 
                                                <asp:Label ID="lbltotamount" runat="server" ClientIDMode="Static" Text="00"></asp:Label>
                                            AED</span>
                                    </div>
                                </div>
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

        <asp:HiddenField ID="hdnStaffid" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdncount" runat="server" ClientIDMode="Static" />

    </form>

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

        function loadData(id, ddltimer, ddlduration, ddlstaff, selectedValue, ddltimeselectedValue) {
            $.ajax({
                url: 'calendar_popup.aspx/GetServiceddlData',
                contentType: 'application/json; charset=utf-8',
                datatype: 'JSON',
                type: 'POST',
                success: function (data) {
                    for (var i = 0; i < data.d.length; i++) {
                        var letsSelect = false;
                        if (data.d[i].split('-')[1] === selectedValue) {
                            letsSelect = true;
                        }
                        if (letsSelect) {
                            $("#" + id).append('<option value="'
                                + data.d[i].split('-')[1] + '" selected>'
                                + data.d[i].split('-')[0] + '</option>');
                        } else {
                            $("#" + id).append('<option value="'
                                + data.d[i].split('-')[1] + '">'
                                + data.d[i].split('-')[0] + '</option>');
                        }
                    }

                }
            });

            $.ajax({
                url: 'calendar_popup.aspx/GetTimeddlData',
                contentType: 'application/json; charset=utf-8',
                datatype: 'JSON',
                type: 'POST',
                success: function (data) {
                    for (var j = 0; j < data.d.length; j++) {
                        var letsddltimeSelect = false;
                        if (data.d[j].split('-')[1] === ddltimeselectedValue) {
                            letsddltimeSelect = true;
                        }
                        if (letsddltimeSelect) {
                            $("#" + ddltimer).append('<option value="'
                                + data.d[j].split('-')[1] + '" selected>'
                                + data.d[j].split('-')[0] + '</option>');
                        } else {
                            $("#" + ddltimer).append('<option value="'
                                + data.d[j].split('-')[1] + '">'
                                + data.d[j].split('-')[0] + '</option>');
                        }
                    }
                    //$.each(data.d, function (i, item) {
                    //    $("#" + ddltimer).append('<option value="'
                    //        + item.split('-')[1] + '">'
                    //        + item.split('-')[0] + '</option>');
                    //});
                }
            });

            $.ajax({
                url: 'calendar_popup.aspx/GetServiceDuration',
                contentType: 'application/json; charset=utf-8',
                datatype: 'JSON',
                type: 'POST',
                success: function (data) {
                    $.each(data.d, function (i, item) {
                        $("#" + ddlduration).append('<option value="'
                            + item.split('-')[1] + '">'
                            + item.split('-')[0] + '</option>');
                    });

                    //for (var k = 0; k < data.d.length; k++) {
                    //    var letsSelect = false;
                    //    if (data.d[k].split('-')[1] === selectedValue) {
                    //        letsSelect = true;
                    //    }
                    //    if (letsSelect) {
                    //        $("#" + ddlduration).append('<option value="'
                    //            + data.d[k].split('-')[1] + '" selected>'
                    //            + data.d[k].split('-')[0] + '</option>');
                    //    } else {
                    //        $("#" + ddlduration).append('<option value="'
                    //            + data.d[k].split('-')[1] + '">'
                    //            + data.d[k].split('-')[0] + '</option>');
                    //    }
                    //}

                }
            });

            $.ajax({
                url: 'calendar_popup.aspx/GetStaff',
                contentType: 'application/json; charset=utf-8',
                datatype: 'JSON',
                type: 'POST',
                success: function (data) {
                    for (var l = 0; l < data.d.length; l++) {
                        var letsSelect = false;
                        if (data.d[l].split('-')[1] === selectedValue) {
                            letsSelect = true;
                        }
                        if (letsSelect) {
                            $("#" + ddlstaff).append('<option value="'
                                + data.d[l].split('-')[1] + '" selected>'
                                + data.d[l].split('-')[0] + '</option>');
                        } else {
                            $("#" + ddlstaff).append('<option value="'
                                + data.d[l].split('-')[1] + '">'
                                + data.d[l].split('-')[0] + '</option>');
                        }
                    }

                }
            });


        }
        function closeDiv(id) {
            var decreaseamt = $('#hdnamount' + id).val();
            var totamt = $("#<%= lbltotamount.ClientID%>").html();
            var updatetotamt = parseFloat(totamt) - parseFloat(decreaseamt);
            $("#<%= lbltotamount.ClientID%>").html(updatetotamt);
            if (updatetotamt == 0) {
                //$("#btnexcheckout").attr("disabled", "disabled");
                $('#btnexcheckout').attr('disabled', true);
            }
            $("#" + id).parent().slideUp('slow');
        }

        //Create new div here
        function AddService(count) {

            var div = document.createElement('DIV');

            div.innerHTML = " <div class='row clone-div'>" +
                "<div id='" + count + "' class='clone-close' onclick='closeDiv(" + count + ")'>" +
                "<i class='mdi mdi-close'></i>" +
                "</div>" +
                "<div class='col-md-2'>" +
                "<div class='form-group'>" +
                "<label class='control-label'>Start Time</label>" +
                "<select id='ddltime" + count + "' class='form-control form-white' data-placeholder='Choose a time' name='category-color'>" +
                "</select>" +
                "</div>" +
                "</div>" +
                "<div class='col-md-10'>" +
                "<div class='form-group'>" +
                "<label class='control-label'>Service</label>" +
                "<select id='ddlChooseaservice" + count + "' class='form-control'>" +
                "<option>Choose a service</option>" +
                "</select>" +
                "</div>" +
                "</div>" +
                "<div class='col-md-2'>" +
                "<div class='form-group'>" +
                "<label class='control-label'>Duration</label>" +
                "<select id='ddlduration" + count + "' class='form-control form-white' data-placeholder='Choose a time' name='category-color'>" +
                "</select>" +
                "</div>" +
                "</div>" +
                "<div class='col-md-10'>" +
                "<div class='form-group'>" +
                "<label class='control-label'>Staff</label>" +
                "<select id='ddlstaff" + count + "' class='form-control custom-select' data-placeholder='Choose Staff' tabindex='1'>" +
                "</select>" +
                "</div>" +
                "</div>" +
                "<input id='hdnamount" + count + "' type='hidden'>" +
                "<input id='hdnduration" + count + "' type='hidden'>" +
                "</div>";

            document.getElementById("DivContainer").appendChild(div);

        }

        function RemoveService(div) {
            document.getElementById("DivContainer").removeChild(div.parentNode);
        }

        function GetTimeDuration(id, count) {
            var serviceid = id;
            $.ajax({
                type: 'Post',
                url: 'calendar_popup.aspx/GetTimeDuration',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ serviceid: serviceid }),
                dataType: "json",
                success: function (result) {
                    var tmduration = result.d.timeduration;
                    document.getElementById('ddlduration' + count).value = tmduration;

                    var duration = document.getElementById('ddlduration' + count).value;
                    //document.getElementById('hdnduration' + count).value = value.timeduration;
                    //$("#ddlduration" + count).val(result.d.timeduration);
                    var service = document.getElementById('ddlChooseaservice').value;
                    var servicename = $("#ddlChooseaservice option:selected").text();
                    var starttime = document.getElementById('ddltime').value;
                    var servicerate = document.getElementById('hdnamount' + count).value;
                    //var duration = $("#ddlduration" + count).val();
                    var staffid = document.getElementById('ddlstaff').value;

                    //test
                    ServiceArray[arraycount] = { ServiceId: service, Starttime: starttime, Duration: duration, servicerate: servicerate, StaffId: staffid };
                    arraycount++;
                    //alert(ServiceArray);

                }

            });
        }

        function GetServiceRate(id, count) {
            var serviceid = id;
            var lastamount = $("#<%= lbltotamount.ClientID%>").html();

            $.ajax({
                type: 'Post',
                url: 'calendar_popup.aspx/GetServiceRate',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ serviceid: serviceid, lastamount: lastamount }),
                dataType: "json",
                success: function (result) {
                    $("#<%= lbltotamount.ClientID%>").html(result.d.totamount);
                    document.getElementById('hdnamount' + count).value = result.d.retailprice;
                    if (result.d.retailprice != 0) {
                        $('#btnexcheckout').attr('disabled', false);
                    }
                }

            });
            }

            function InsertServiceinfo() {
                var clientid = $("#<%= hdnclientid.ClientID%>").val();
                var totalamount = $("#<%= lbltotamount.ClientID%>").html();
                var todate = $("#<%= txtdate.ClientID%>").val();
                var note = $("#<%= txtappointnote.ClientID%>").val();
                $.ajax({
                    type: 'Post',
                    url: 'calendar_popup.aspx/InsertServiceinfo',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ ServiceArray: ServiceArray, clientid: clientid, totalamount: totalamount, todate: todate, note: note }),
                    dataType: "json",
                    async: true,
                    cache: false,
                    success: function (data) {
                        //alert(data);
                    },

                    failure: function (errMsg) {
                        //alert(errMsg);
                    }
                });
            }

            $(document).ready(function () {
                $('#btnexcheckout').attr('disabled', true);
                $.ajax({
                    url: 'calendar_popup.aspx/GetServiceddlData',
                    contentType: 'application/json; charset=utf-8',
                    datatype: 'JSON',
                    type: 'POST',
                    success: function (data) {
                        $.each(data.d, function (i, item) {
                            $("#ddlChooseaservice").append('<option value="'
                                + item.split('-')[1] + '">'
                                + item.split('-')[0] + '</option>');
                        });
                    }
                });

                $.ajax({
                    url: 'calendar_popup.aspx/GetTimeddlData',
                    contentType: 'application/json; charset=utf-8',
                    datatype: 'JSON',
                    type: 'POST',
                    success: function (data) {
                        $.each(data.d, function (i, item) {
                            $("#ddltime").append('<option value="'
                                + item.split('-')[1] + '">'
                                + item.split('-')[0] + '</option>');
                        });
                    }
                });

                $.ajax({
                    url: 'calendar_popup.aspx/GetStaff',
                    contentType: 'application/json; charset=utf-8',
                    datatype: 'JSON',
                    type: 'POST',
                    success: function (data) {
                        $.each(data.d, function (i, item) {
                            $("#ddlstaff").append('<option value="'
                                + item.split('-')[1] + '">'
                                + item.split('-')[0] + '</option>');
                        });
                    }
                });

                $('#ddlChooseaservice').change(function () {
                    var lolRand = Math.floor((Math.random() * 10000) + 1);
                    AddService(lolRand);
                    var selectedValueId = this.value;
                    var ddltimeselectedValue = document.getElementById('ddltime').value;
                    loadData("ddlChooseaservice" + lolRand, "ddltime" + lolRand, "ddlduration" + lolRand, "ddlstaff" + lolRand, selectedValueId, ddltimeselectedValue);
                    GetTimeDuration(selectedValueId, lolRand);
                    GetServiceRate(selectedValueId, lolRand);
                    $("#ddlChooseaservice").val('-1');
                });

                $('#btnsubmit').click(function () {
                    InsertServiceinfo();
                });


                $("#<%= txtclient.ClientID%>").autocomplete({
                    source: function (request, response) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "calendar_popup.aspx/GetclientData",
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
                        $("#<%= txtclient.ClientID%>").val(ui.item.label);
                        $("#<%= hdnclientid.ClientID%>").val(ui.item.val);
                    }
                });
            });
    </script>

    <%--<script src="http://code.jquery.com/ui/1.11.2/jquery-ui.js" type="text/javascript"></script>--%>

    <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js" type="text/javascript"></script>

    <script type="text/javascript" src="/js/custom.min.js"></script>

</body>

</html>
