<%@ Page Language="VB" AutoEventWireup="false" CodeFile="closeddates_popup.aspx.vb" Inherits="closeddates_popup" %>

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
                        <h4 class="modal-title">New Closed Date<br />
                            <code class="font-14">Online bookings can not be placed during closed dates.</code>
                        </h4>
                        <button type="button" onclick="ClearID();" class="close closebtn">&times;</button>
                    </div>

                    <div class="modal-body">
                        <form role="form">
                            <div class="row">
                                <div class="col-sm-6 col-12">
                                    <div class="form-group">
                                        <label class="control-label">Start Date</label>
                                        <div class="input-group">
                                            <asp:TextBox ID="txtStartDate" CssClass="form-control mydatepicker" runat="server" placeholder="mm/dd/yyyy" ClientIDMode="Static"></asp:TextBox>
                                            <asp:RequiredFieldValidator ControlToValidate="txtStartDate" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1" runat="server"
                                                ErrorMessage="*"></asp:RequiredFieldValidator>
                                            <span class="input-group-addon"><i class="icon-calender"></i></span>
                                        </div>

                                    </div>
                                </div>
                                <div class="col-sm-6 col-12">
                                    <div class="form-group">
                                        <label class="control-label">End Date</label>
                                        <div class="input-group">
                                            <asp:TextBox ID="txtEndDate" CssClass="form-control mydatepicker" runat="server" placeholder="mm/dd/yyyy" ClientIDMode="Static"></asp:TextBox>
                                            <asp:RequiredFieldValidator ControlToValidate="txtEndDate" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator2" runat="server"
                                                ErrorMessage="*"></asp:RequiredFieldValidator>
                                            <span class="input-group-addon"><i class="icon-calender"></i></span>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-12">
                                    <div class="form-group">
                                        <label class="control-label">Description</label>
                                        <asp:TextBox ID="txtDescription" CssClass="form-control" runat="server" ClientIDMode="Static" placeholder="public holiday"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-12">
                                    <div class="form-group">
                                        <asp:CheckBoxList ID="ChkLocation" runat="server" ClientIDMode="Static" RepeatDirection="Vertical" CssClass="checkbox checkbox-success"
                                            DataSourceID="sdsLocation" DataTextField="AreaName" DataValueField="AreaId">
                                        </asp:CheckBoxList>

                                        <asp:SqlDataSource ID="sdsLocation" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                                            SelectCommand="Select 0 [AreaId],'All Locations' [AreaName] UNION Select [AreaId], [AreaName] from Areas WHERE [AreaStatus]=1  ORDER BY AreaId ASC"></asp:SqlDataSource>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="modal-footer">
                        <%--<button id="btndelete" type="button" onclick="return confirm('Are you sure you want to delete?')" class="btn btn-inverse">Delete</button>--%>
                        <asp:Button ID="btndelete" OnClientClick="return confirm('Are you sure you want to delete?')" class="btn btn-inverse" runat="server" Text="Delete" />
                        <asp:Button ID="btnsave" ValidationGroup="form" CssClass="btn btn-danger waves-effect waves-light btnsubmit"
                            runat="server" Text="Save" />
                        <button type="button" onclick="ClearID(); ClearData();" class="btn btn-secondary waves-effect closebtn">Close</button>
                    </div>

                </div>

            </div>

        </div>


        <asp:HiddenField ID="hdncloseddateid" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnuserid" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnScopeID" runat="server" ClientIDMode="Static" />

        <asp:SqlDataSource ID="sdscloseddates" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            DeleteCommand="DELETE FROM [ClosedDates] WHERE [ClosedDatesId] = @ClosedDatesId"
            InsertCommand="INSERT INTO [ClosedDates] ([StartDate], [EndDate], [Description], [CreatedBy], [CreatedAt]) VALUES (@StartDate, @EndDate, @Description, @CreatedBy, Getdate()) set @ScopeID=Scope_Identity()"
            SelectCommand="SELECT * FROM [ClosedDates]"
            UpdateCommand="UPDATE [ClosedDates] SET [StartDate] = @StartDate, [EndDate] = @EndDate, [Description] = @Description, [UpdatedBy] = @UpdatedBy, [UpdatedAt] = Getdate() WHERE [ClosedDatesId] = @ClosedDatesId">
            <DeleteParameters>
                <asp:Parameter Name="ClosedDatesId" Type="Int64" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="txtStartDate" Name="StartDate" PropertyName="Text" Type="DateTime" />
                <asp:ControlParameter ControlID="txtEndDate" Name="EndDate" PropertyName="Text" Type="DateTime" />
                <asp:ControlParameter ControlID="txtDescription" Name="Description" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="hdnuserid" Name="CreatedBy" PropertyName="Value" Type="Int32" />
                <asp:Parameter Direction="Output" Name="ScopeID" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="txtStartDate" Name="StartDate" PropertyName="Text" Type="DateTime" />
                <asp:ControlParameter ControlID="txtEndDate" Name="EndDate" PropertyName="Text" Type="DateTime" />
                <asp:ControlParameter ControlID="txtDescription" Name="Description" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="hdnuserid" Name="UpdatedBy" PropertyName="Value" Type="Int32" />
                <asp:QueryStringParameter Name="ClosedDatesId" QueryStringField="cdid" Type="Int64" />
            </UpdateParameters>
        </asp:SqlDataSource>

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

        <%--function GetDataById(x) {
            var closeddatesid = x;
            //alert(closeddatesid);

            var checkboxList = $("[id*=ChkLocation]");
            checkboxList.each(function () {
                $(this).prop("checked", false);
            });

            $.ajax({
                type: 'Post',
                url: 'ClosedDates.aspx/GetData',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ closeddatesid: closeddatesid }),
                dataType: "json",
                success: function (result) {
                    $.each(result,
                        function (key, value) {
                            document.getElementById('hdncloseddateid').value = value.closeddatesid;
                            document.getElementById('txtStartDate').value = value.startdate;
                            document.getElementById('txtEndDate').value = value.enddate;
                            document.getElementById('txtDescription').value = value.description;

                            var content = "";
                            var tempLoc = new Array();
                            tempLoc = value.Locations.split(";");
                            for (a in tempLoc) {
                                if (tempLoc.hasOwnProperty(a)) {
                                    $("#<%= ChkLocation.ClientID %>").find("input[type=checkbox]").each(function () {
                                        if ($(this).next('label').text() === tempLoc[a].toString()) {
                                            $(this).prop('checked', true);
                                        }

                                    });

                                }
                            }

                        });
                }

            });
        }

        $('#btndelete').click(function () {
            var closeddatesid = $("#<%= hdncloseddateid.ClientID%>").val();
            if (closeddatesid !== "") {
                $.ajax({
                    url: 'ClosedDates.aspx/DeleteData',
                    type: 'POST',
                    cache: false,
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ closeddatesid: closeddatesid }),
                    dataType: "json",
                    success: function (data) {
                        window.location.reload();
                        //alert("Successfully Deleted");
                    }
                });
            }

            else {
                //alert("work");
            }

        });--%>

        function ClearData() {

            document.getElementById('hdncloseddateid').value = "";
            var checkboxList = $("[id*=ChkLocation]");
            checkboxList.each(function () {
                $(this).prop("checked", false);
            });
            document.getElementById('txtStartDate').value = "";
            document.getElementById('txtEndDate').value = "";
            document.getElementById('txtDescription').value = "";
        }

    </script>
</body>
</html>
