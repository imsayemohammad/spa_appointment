<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AddPackage.aspx.vb" Inherits="AddPackage" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
    <title>The Home Spa</title>

    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css'>
    <meta charset="utf-8"/>
    <meta name="description" content="Home Spa" />
    <meta name="keywords" content="Home Spa" />

    <meta name="viewport" content="width=device-width, initial-scale=1.0" />


    <link href="assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="assets/plugins/bootstrap-datepicker/bootstrap-datepicker.min.css" rel="stylesheet" type="text/css" />
    <link href="assets/plugins/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet" />

    <link href="assets/plugins/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" />

    <link href="assets/plugins/chartist-js/dist/chartist.min.css" rel="stylesheet" />
    <link href="assets/plugins/chartist-plugin-tooltip-master/dist/chartist-plugin-tooltip.css" rel="stylesheet" />

    <link href="assets/plugins/c3-master/c3.min.css" rel="stylesheet" />

    <link href="assets/plugins/toast-master/css/jquery.toast.css" rel="stylesheet" />

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.4.1/jquery.fancybox.min.css" />


    <link href="/css/style.css" rel="stylesheet" />

    <link href="/css/pages/dashboard1.css" rel="stylesheet" />

    <link href="/css/colors/default-dark.css" id="theme" rel="stylesheet" />


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
                    <%-- <div class="modal-header">
                        <div >
                            <button  style="float: right;" type="button" class="close closebtn">&times;</button>
                        </div>
                    </div>--%>

                    <div class="modal-header">
                        <h4 class="modal-title"></h4>
                        <button type="button" onclick="ClearID();" class="close closebtn">&times;</button>
                    </div>


                    <div class="modal-body">
                        <div class="">
                            <form role="form">
                                <div class="tab-content staffTabContent">
                                    <div class="tab-pane active" role="tabpanel" id="s-DETAILS">
                                        <div class="row">
                                            <div class="col-md-6 col-12">
                                                <div class="row">
                                                    <div class="col-md-12 col-12">
                                                        <div class="form-group">
                                                            <h4 class="modal-title">Add/Edit Package
                                                            </h4>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4 col-12">
                                                        <div class="form-group">
                                                            <label class="control-label">Title</label>
                                                        </div>
                                                    </div>


                                                    <div class="col-md-8 col-12">
                                                        <div class="form-group">
                                                            <asp:TextBox ID="txtTitle" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ControlToValidate="txtTitle" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator9" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4 col-12">
                                                        <div class="form-group">
                                                            <label class="control-label">Arabic Title</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-8 col-12">
                                                        <div class="form-group">
                                                            <asp:TextBox ID="txtArTitle" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4 col-12">
                                                        <div class="form-group">
                                                            <label class="control-label">
                                                                Branch
                                                            </label>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-8 col-12">
                                                        <div class="form-group">

                                                            <asp:DropDownList ID="ddlLocation" runat="server" ClientIDMode="Static" CssClass="form-control">
                                                                <asp:ListItem Text="Select Location" Value="0"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4 col-12">
                                                        <div class="form-group">
                                                            <label>Start Date: </label>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-8">
                                                        <div class="form-group">

                                                            <div class="input-group">
                                                                <asp:TextBox ID="txtstartDT" runat="server" CssClass="form-control mydatepicker" placeholder="mm/dd/yyyy" ClientIDMode="Static"></asp:TextBox>
                                                                <span class="input-group-addon"><i class="icon-calender"></i></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4 col-12">
                                                        <div class="form-group">
                                                            <label>End Date: </label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <div class="form-group">

                                                            <div class="input-group">
                                                                <asp:TextBox ID="txtEndDT" runat="server" CssClass="form-control mydatepicker" placeholder="mm/dd/yyyy" ClientIDMode="Static"></asp:TextBox>
                                                                <span class="input-group-addon"><i class="icon-calender"></i></span>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4 col-12">
                                                        <div class="form-group">
                                                            <label class="control-label">Price</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-8 col-12">
                                                        <div class="form-group">
                                                            <div class="input-group">
                                                                <div class="input-group-addon">
                                                                    AED
                                                                </div>
                                                                <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" placeholder="" ClientIDMode="Static"></asp:TextBox>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="col-md-4 col-12">
                                                        <div class="form-group">
                                                            <label class="control-label">
                                                                Book From Website
                                                            </label>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-8 col-12">
                                                        <div class="form-group">

                                                            <asp:DropDownList ID="ddlBook" runat="server" ClientIDMode="Static" CssClass="form-control">
                                                                <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                                                <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4 col-12">
                                                        <div class="form-group">
                                                            <label class="control-label">
                                                                Status
                                                            </label>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-8 col-12">
                                                        <div class="form-group">
                                                            <asp:DropDownList ID="ddlStatus" runat="server" ClientIDMode="Static" CssClass="form-control">
                                                                <asp:ListItem Text="Running" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="Closed" Value="0"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4 col-12">
                                                        <div class="form-group">
                                                            <label class="control-label">
                                                                Parent Package
                                                            </label>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-8 col-12">
                                                        <div class="form-group">
                                                            <asp:DropDownList ID="ddlGroup" runat="server" ClientIDMode="Static" CssClass="form-control">
                                                                <asp:ListItem Text="Select Service Package" Value="0"></asp:ListItem>
                                                            </asp:DropDownList>

                                                        </div>
                                                    </div>

                                                    <%--   <div class="col-md-4 col-12">
                                                        <div class="form-group">
                                                            <label>Big Image: </label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-8 col-12">
                                                        <div class="form-group">

                                                            <div class="upload-picture">
                                                                <div class="text-cemter image-holder">
                                                                    <%Dim serviceid = Request.QueryString("serviceid")
                                                                        Dim hasimage = Utility.StringData("Select BigIconOne From Services Where ServiceId = " & serviceid & "")
                                                                        If Not String.IsNullOrEmpty(hasimage) then  %>
                                                                    <asp:Image ID="imgSmallImage" runat="server" ClientIDMode="Static" />
                                                                    <%Else %>
                                                                    <img src="/images/avatar.png" width="100" alt="Upload Picture" />
                                                                    <% End If %>


                                                                    <div class="upload-wrapper" data-toggle="tooltip" data-placement="right" title="" data-original-title="upload picture here" aria-describedy="">
                                                                        <div class="inner">
                                                                            <a href="javascript:;" class="file-upload-button"><span class="mdi mdi-upload"></span></a>

                                                                            <asp:FileUpload ID="fuImageFile" accept="image/*" onchange="loadFile(event)" ClientIDMode="Static" runat="server" />
                                                                            <asp:HiddenField ID="hdnImageUrl" runat="server" />
                                                                        </div>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4 col-12">
                                                        <div class="form-group">
                                                            <label>Small Image: </label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-8 col-12">
                                                        <div class="form-group">

                                                            <div class="upload-picture">
                                                                <div class="text-cemter image-holder">
                                                                    <%Dim serviceid1 = Request.QueryString("serviceid")
                                                                        Dim hasimage1 = Utility.StringData("Select BigIconOne From Services Where ServiceId = " & serviceid1 & "")
                                                                        If Not String.IsNullOrEmpty(hasimage1) Then  %>
                                                                    <asp:Image ID="imgIcon" runat="server" ClientIDMode="Static" />
                                                                    <%Else %>
                                                                    <img src="/images/avatar.png" width="80" alt="Upload Picture" />
                                                                    <% End If %>


                                                                    <div class="upload-wrapper" data-toggle="tooltip" data-placement="right" title="" data-original-title="upload picture here" aria-describedy="">
                                                                        <div class="inner">
                                                                            <a href="javascript:;" class="file-upload-button"><span class="mdi mdi-upload"></span></a>
                                                                          
                                                                            <asp:FileUpload ID="fuIcon" accept="image/*" onchange="loadFileIcon(event)" ClientIDMode="Static" runat="server" />
                                                                            <asp:HiddenField ID="hdnIconUrl" runat="server" />
                                                                        </div>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>--%>
                                                </div>
                                            </div>

                                            <div class="col-md-6 col-12">
                                                <div class="row">
                                                    <asp:ToolkitScriptManager ID="ScriptManager1" runat="server">
                                                    </asp:ToolkitScriptManager>

                                                    <div class="col-md-12 col-12">
                                                        <div class="form-group">
                                                            <h4 class="modal-title">Linked Service Products
                                                            </h4>

                                                        </div>
                                                    </div>
                                                    <asp:UpdatePanel ID="Up1" style="width: 100%;" class="row" runat="server">
                                                        <ContentTemplate>
                                                            <div class="col-md-12 col-12">
                                                                <div class="form-group">

                                                                    <asp:GridView DataKeyNames="ServiceId" Width="100%" ID="gvSkuPrice" OnRowCreated="gvSkuPrice_RowCreated" runat="server" AutoGenerateColumns="false" CellPadding="10" ForeColor="#333333" CssClass="table table-striped"
                                                                        GridLines="None" AllowPaging="True" PageSize="20" Style="float: left; margin-bottom: 10px;"
                                                                        OnRowDeleting="OnRowDeleting" OnDataBound="gvSkuPrice_DataBound" OnRowUpdating="gvSkuPrice_RowUpdating" OnRowEditing="gvSkuPrice_RowEditing" OnRowCancelingEdit="gvSkuPrice_RowCancelingEdit">
                                                                        <PagerSettings Position="TopAndBottom" />
                                                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                                        <Columns>

                                                                            <asp:TemplateField HeaderText="Description" SortExpression="Data" ItemStyle-HorizontalAlign="Right">
                                                                                <ItemTemplate>
                                                                                    <asp:DropDownList ID="ddlGroup" runat="server" ClientIDMode="Static" CssClass="form-control" AppendDataBoundItems="true" DataSourceID="sdsProduct" DataTextField="Title" DataValueField="ServiceId" AutoPostBack="true" OnSelectedIndexChanged="ddlGroup_SelectedIndexChanged" EnableViewState="false">
                                                                                    </asp:DropDownList>

                                                                                    <asp:SqlDataSource ID="sdsProduct" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="select ServiceId, Title, PackagePrice from Services where IsServiceGroup = 0 And status = 1 And IsPackage = 0  order by Title asc "></asp:SqlDataSource>
                                                                                    <%--<asp:HiddenField ID="hdServiceId" Visible="false" Value='<%# Eval("ServiceId") %>' runat="server" />--%>
                                                                                    <asp:HiddenField ID="hdServiceId" Visible="false" runat="server" Value='<%# Eval("ServiceId") %>' />
                                                                                    <%--<asp:HiddenField ID="hdSalesPrice"  Visible="false"  Value='<%# Eval("PackagePrice") %>' runat="server" />--%>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" ForeColor="Black" />
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Qty" ItemStyle-HorizontalAlign="Right">
                                                                                <ItemTemplate>
                                                                                    <asp:UpdatePanel runat="server" ID="UpId2"
                                                                                        UpdateMode="Conditional" ChildrenAsTriggers="true">
                                                                                        <ContentTemplate>
                                                                                            <asp:TextBox ID="posku" onClick="this.select();" CssClass="form-control" runat="server" Style="text-align: right" Text='<%# Eval("Qty") %>' Width="50px"></asp:TextBox>
                                                                                        </ContentTemplate>
                                                                                    </asp:UpdatePanel>

                                                                                </ItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" ForeColor="Black" />
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Description" SortExpression="Data" ItemStyle-HorizontalAlign="Right">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtDescription" Style="text-align: left" CssClass="form-control" runat="server" Text='<%# Eval("ShortDescription") %>' Width="100px"></asp:TextBox>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" ForeColor="Black" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Price" SortExpression="Data" ItemStyle-HorizontalAlign="Right">
                                                                                <ItemTemplate>
                                                                                    <asp:UpdatePanel runat="server" ID="UpId"
                                                                                        UpdateMode="Conditional" ChildrenAsTriggers="true">
                                                                                        <ContentTemplate>
                                                                                            <asp:TextBox ID="txtSalesPrice" Enabled="true" CssClass="form-control" runat="server" Style="text-align: right" Text='<%# Eval("PricePerItem") %>' Width="50px"></asp:TextBox>
                                                                                            <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidatorCASEQty" ControlToValidate="txtSalesPrice"
                                                                                         ValidationExpression="/^(0|[1-9]\d*)?(\.\d+)?(?<=\d)$/" Display="Dynamic" ErrorMessage="Invalid Quantity"
                                                                                        EnableClientScript="true" runat="server" />--%>
                                                                                        </ContentTemplate>
                                                                                    </asp:UpdatePanel>


                                                                                </ItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" ForeColor="Black" />
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Total" ItemStyle-HorizontalAlign="Right">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtTotal" CssClass="form-control" Enabled="false" runat="server" Width="80" Style="text-align: right;" Text='<%# Eval("ItemTotal") %>'></asp:TextBox>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" ForeColor="Black" />
                                                                            </asp:TemplateField>
                                                                            <asp:CommandField ShowDeleteButton="True" ButtonType="Image" DeleteImageUrl="/images/icons/ic-delete.png"></asp:CommandField>
                                                                        </Columns>
                                                                        <EmptyDataTemplate>
                                                                            <div>
                                                                            </div>
                                                                        </EmptyDataTemplate>
                                                                        <FooterStyle BackColor="" Font-Bold="True" ForeColor="White" />
                                                                        <PagerStyle BackColor="#d1d0d0" ForeColor="Black" HorizontalAlign="Center" />
                                                                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                                        <HeaderStyle Font-Bold="True" ForeColor="White" />
                                                                        <EditRowStyle BackColor="#999999" />
                                                                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                                    </asp:GridView>

                                                                </div>
                                                            </div>
                                                            <div class="col-md-2 col-12">
                                                                <div class="form-group">
                                                                    <asp:Button ID="btnAdd" CssClass="btn btn-info waves-effect btn-block waves-light btnsubmit" runat="server" Text="Add" ClientIDMode="Static" />
                                                                </div>
                                                            </div>
                                                        </ContentTemplate>
                                                       
                                                    </asp:UpdatePanel>

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
                        <asp:Button ID="btnsave" ValidationGroup="form" CssClass="btn btn-danger waves-effect waves-light btnsubmit" runat="server" Text="Save" ClientIDMode="Static" />
                        <button type="button" class="btn btn-secondary waves-effect closebtn">Cancel</button>
                    </div>
                </div>
            </div>
        </div>


        <asp:HiddenField ID="hdnPackageid" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnServicPackageid" runat="server" ClientIDMode="Static" />

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
    <script type="text/javascript" src="/js/custom.min.js"></script>
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
    <%--<script type="text/javascript">
        $('#btnsave').click(function () {
           $("#<%=btnsave.ClientID %>").click();
        })
    </script>--%>
    <script type="text/javascript">
        function changeMe(oPrice, oQty, oSubTotal) {
            debugger;
            // alert("price: " + oPrice + " Qty: " + oQty);
            var Price = document.getElementById(oPrice).value;
            var Qty = document.getElementById(oQty).value;
            var SubTotal = 0;

            SubTotal = Number(Price) * Number(Qty);
            document.getElementById(oSubTotal).value = parseFloat(Math.round(SubTotal * 100) / 100).toFixed(2);
            // alert("subtotal : " + Number(document.getElementById(oSubTotal).value));
            var rows = document.getElementById('gvSkuPrice').getElementsByTagName("tr").length;

            var controlID1 = "E";
            SubTotal = 0;

            for (i = 1; i < Number(rows) ; i++) {
                var a1 = "";
                if (i <= 7) {
                    a1 = "gvSkuPrice_ctl0";
                }
                else {
                    a1 = "gvSkuPrice_ctl";
                }
                var a2 = i + 2;
                var a3 = "_txtTotal";
                controlID1 = a1 + a2 + a3;
                SubTotal = SubTotal + Number(document.getElementById(controlID1).value)
            }


            //var controlID1 = "txtTotal";
            //SubTotal = 0;
            //for (i = 1; i < Number(rows) ; i++) {
            //    SubTotal = SubTotal + Number(document.getElementById('txtTotal').value)
            //    //alert("Total : " + SubTotal);
            //}


            document.getElementById('txtPrice').value = parseFloat(Math.round(SubTotal * 100) / 100).toFixed(2);
        }

    </script>


    <script type="text/javascript">

        $('#txtstartDT').on('change', function () {
            var x = new Date($('#txtstartDT').val());
            var y = new Date($('#txtEndDT').val());

            if (y - x < 0) {
                document.getElementById('btnsave').disabled = true;
                alert("Please Enter Valid Date");

            } else {

                document.getElementById('btnsave').disabled = false;
            }
        });

        $('#txtstartDT').on('change', function () {
            var y = new Date($('#txtEndDT').val());
            var x = new Date($('#txtstartDT').val());

            if (y - x < 0) {

                document.getElementById('btnsave').disabled = true;
                alert("Please Enter Valid Date");
            } else {

                document.getElementById('btnsave').disabled = false;
            }
        });
    </script>

    <%-- <script type="text/javascript">
        $(document).ready(function () {
            $("<%=imgSmallImage.ClientID %>").hide();
             $("<%=imgIcon.ClientID %>").hide();
        });

    </script>

    <script type="text/javascript">
        var loadFile = function (event) {
            $("<%=imgSmallImage.ClientID %>").show();
            var output = document.getElementById("<%=imgSmallImage.ClientID %>");
            output.src = URL.createObjectURL(event.target.files[0]);
        };

        var loadFileIcon = function (event) {
            $("<%=imgIcon.ClientID %>").show();
            var output = document.getElementById("<%=imgIcon.ClientID %>");
            output.src = URL.createObjectURL(event.target.files[0]);
        };
    </script>--%>
</body>

</html>
