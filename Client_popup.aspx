<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Client_popup.aspx.vb" Inherits="Client_popup" %>

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
                        <h4 class="modal-title">Add/Edit Client
                        </h4>
                        <button type="button" onclick="ClearID();" class="close closebtn">&times;</button>
                    </div>

                    <div class="modal-body">
                        <form role="form">
                            <!-- Nav tabs -->
                            <ul class="nav nav-tabs profile-tab">
                                <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#s-DETAILS" role="tab">DETAILS</a> </li>
                                <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#s-LOCATIONS" role="tab">LOCATIONS</a> </li>
                            </ul>
                            <!-- Tab panes -->
                            <div class="tab-content">
                                <div class="tab-pane active" role="tabpanel" id="s-DETAILS">
                                    <div class="row">
                                        <div class="col-md-6 col-12">
                                            <div class="row">
                                                <div class="col-md-6 col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">First Name</label>
                                                        <asp:TextBox ID="txtFirstName" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ControlToValidate="txtFirstName" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator8" runat="server"
                                                            ErrorMessage="*"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">Last Name</label>
                                                        <asp:TextBox ID="txtLastName" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ControlToValidate="txtLastName" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator9" runat="server"
                                                            ErrorMessage="*"></asp:RequiredFieldValidator>
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
                                                                </div>
                                                            </div>
                                                            <asp:TextBox ID="txtPhone" CssClass="form-control" runat="server" placeholder="+971 00 123 4567" ClientIDMode="Static"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ControlToValidate="txtPhone" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator2" runat="server"
                                                                ErrorMessage="*"></asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" Display="Dynamic" runat="server" ControlToValidate="txtPhone"
                                                                                            ErrorMessage="* invalid" ValidationGroup="form" ForeColor="Red" ValidationExpression="^((\+971)?[0-9]\d*)$" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">Telephone</label>
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
                                                            <asp:TextBox ID="txtTelephone" CssClass="form-control" runat="server" placeholder="+971 00 123 4567" ClientIDMode="Static"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ControlToValidate="txtPhone" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1" runat="server"
                                                                ErrorMessage="*"></asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" Display="Dynamic" runat="server" ControlToValidate="txtTelephone"
                                                                                            ErrorMessage="* invalid" ValidationGroup="form" ForeColor="Red" ValidationExpression="^((\+971)?[0-9]\d*)$" />
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-6 col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">Email</label>
                                                        <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ControlToValidate="txtEmail" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator3" runat="server"
                                                            ErrorMessage="*"></asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" Display="Dynamic" runat="server" ErrorMessage="* invalid" ValidationGroup="form"
                                                            ControlToValidate="txtEmail" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">SEND NOTIFICATIONS BY</label>
                                                        <asp:DropDownList ID="ddlNotification" runat="server" CssClass="form-control custom-select" data-placeholder="Choose staff" ClientIDMode="Static">
                                                            <asp:ListItem>Don't send notifications</asp:ListItem>
                                                            <asp:ListItem Value="Email">Email</asp:ListItem>
                                                            <asp:ListItem Value="SMS">SMS</asp:ListItem>
                                                            <asp:ListItem Value="Email and SMS">Email and SMS</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>


                                                <div class="col-md-6 col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">REFERRAL SOURCE</label>
                                                        <asp:DropDownList ID="ddlrefsource" runat="server" CssClass="form-control" data-placeholder="Choose staff" ClientIDMode="Static">
                                                            <asp:ListItem>Select source</asp:ListItem>
                                                            <asp:ListItem Value="Walkin">Walkin</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 col-12">
                                                    <div class="form-group">
                                                        <div class="form-check">
                                                            <label class="control-label">GENDER</label>
                                                            <asp:DropDownList ID="ddlgender" runat="server" CssClass="form-control" data-placeholder="Choose Gender" ClientIDMode="Static">
                                                                <asp:ListItem>Male</asp:ListItem>
                                                                <asp:ListItem>Female</asp:ListItem>
                                                            </asp:DropDownList>

                                                            <%--<asp:RadioButtonList ID="rdbgender" runat="server" Checked="True" ClientIDMode="Static" RepeatDirection="Horizontal" CssClass="custom-control custom-radio">
                                                                <asp:ListItem Selected="True">Male</asp:ListItem>
                                                                <asp:ListItem>Female</asp:ListItem>
                                                            </asp:RadioButtonList>--%>
                                                        </div>
                                                    </div>
                                                </div>


                                            </div>
                                        </div>
                                        <div class="col-md-6 col-12">
                                            <div class="row">
                                                <div class="col-md-12 col-12">
                                                    <div class="form-group">
                                                        <label class="control-label">CLIENT NOTES</label>
                                                        <asp:TextBox ID="txtNotes" CssClass="form-control" ClientIDMode="Static" TextMode="MultiLine" Rows="5" runat="server"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-md-12 col-12">
                                                    <div class="form-group">
                                                        <div class="checkbox checkbox-success">
                                                            <%--<input id="checkbox1" type="checkbox">--%>
                                                            <asp:CheckBox ID="chkbookings" runat="server" ClientIDMode="Static" />
                                                            <label for="chkbookings">DISPLAY ON ALL BOOKINGS </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 col-12">
                                                    <div class="form-group">
                                                        <label>BIRTHDAY</label>
                                                        <div class="input-group">
                                                            <asp:TextBox ID="txtdob" runat="server" ClientIDMode="Static" CssClass="form-control mydatepicker" placeholder="mm/dd/yyyy"></asp:TextBox>
                                                            <span class="input-group-addon"><i class="icon-calender"></i></span>
                                                        </div>
                                                    </div>
                                                </div>


                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" role="tabpanel" id="s-LOCATIONS">
                                    <div class="row">
                                        <div class="col-md-6 col-12">
                                            <div class="row">
                                                <div class="col-md-8">
                                                    <div class="form-group">
                                                        <label class="control-label">Address's</label>
                                                        <%--<asp:ScriptManager ID="ScriptManager1" runat="server" />
                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                    <ContentTemplate>--%>

                                                        <asp:DropDownList ID="ddlAddress" CssClass="form-control" data-placeholder="Choose location" AutoPostBack="true" ClientIDMode="Static" runat="server"
                                                            DataSourceID="sdsddlAddress" DataTextField="AddressType" DataValueField="ClientLocationID">
                                                        </asp:DropDownList>

                                                        <%--</ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="ddlAddress" EventName="SelectedIndexChanged" />
                                                    </Triggers>
                                                </asp:UpdatePanel>--%>

                                                        <asp:SqlDataSource ID="sdsddlAddress" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                                                            SelectCommand="Select 0 [ClientLocationID],'Select Location' [AddressType] UNION Select [ClientLocationID], [AddressType] from [ClientLocation] WHERE ClientID = @ClientID ORDER BY ClientLocationID ASC">
                                                            <SelectParameters>
                                                                <asp:QueryStringParameter Name="ClientID" QueryStringField="id" Type="Int64" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <div>
                                                            <label>&nbsp;</label>
                                                        </div>
                                                        <asp:Button ID="btnaddlocation" CssClass="btn btn-info waves-effect btn-block waves-light btnsubmit" runat="server" Text="Add New Location" ClientIDMode="Static" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label">ADDRESS TYPE</label>
                                                <asp:TextBox ID="txtaddresstp" CssClass="form-control" ClientIDMode="Static" runat="server" placeholder="e.g. Home, Office"></asp:TextBox>
                                                <asp:RequiredFieldValidator ControlToValidate="txtaddresstp" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator10" runat="server"
                                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label">ADDRESS</label>
                                                <asp:TextBox ID="txtaddress" CssClass="form-control" ClientIDMode="Static" TextMode="MultiLine" Rows="5" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ControlToValidate="txtaddress" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator7" runat="server"
                                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label">CITY</label>
                                                        <asp:TextBox ID="txtCity" CssClass="form-control" ClientIDMode="Static" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ControlToValidate="txtCity" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator4" runat="server"
                                                            ErrorMessage="*"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label">STATE</label>
                                                        <asp:TextBox ID="txtstate" CssClass="form-control" ClientIDMode="Static" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ControlToValidate="txtstate" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator5" runat="server"
                                                            ErrorMessage="*"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label">ZIP / POST CODE</label>
                                                        <asp:TextBox ID="txtzipcode" CssClass="form-control" ClientIDMode="Static" runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ControlToValidate="txtzipcode" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator6" runat="server"
                                                            ErrorMessage="*"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label">SUBURB</label>
                                                        <asp:TextBox ID="txtsuburb" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="col-md-6 col-12">
                                            <div class="form-group">
                                                <%--<label class="control-label">MAP</label>
                                                        <div style="width: 100%" class="gllpMap">MAP</div>

                                                        <fieldset class="gllpLatlonPicker">
                                                            <div class="row">
                                                                <div class="col-md-10">
                                                                    <input type="text" class="form-control gllpSearchField" placeholder="Find Location" />
                                                                </div>
                                                                <div style="text-align: right" class="col-md-2 spanarea">
                                                                    <input type="button" class="gllpSearchButton btn btn-primary btn-fill" id="searchButton" value="Search" />
                                                                </div>
                                                            </div>


                                                            <br />
                                                            Latitude:

                                                            <input id="txtLatitude" runat="server" clientidmode="Static" value="25.1939565" class="form-control gllpLatitude" data-val="true" data-val-number="The field Latitude must be a number." data-val-required="The Latitude field is required." name="Latitude" type="text" />

                                                            Longitude:

                                                            <input id="txtLongitude" runat="server" clientidmode="Static" value="55.2316175000001" class="form-control gllpLongitude" data-val="true" data-val-number="The field Longitude must be a number." data-val-required="The Longitude field is required." name="Longitude" type="text" />

                                                            <br />

                                                            <div class="row">
                                                                <div class="col-md-10">
                                                                    <input type="text" class="form-control gllpZoom" value="12" />
                                                                </div>
                                                                <div style="text-align: right" class="col-md-2 spanarea">
                                                                    <input type="button" class="gllpUpdateButton btn btn-primary btn-fill" value="Zoom" />
                                                                    <%--<asp:Button ID="btnzoom" runat="server" Text="Zoom" class="gllpUpdateButton btn btn-primary btn-fill" />
                                                                </div>
                                                            </div>
                                                        </fieldset>--%>

                                                <%-- <div id="clientlocation" class="gmaps m-b-15"></div>
                                                        <h5>
                                                            <strong>Latitude:</strong> -12.043333
                                                            &nbsp;| &nbsp;
                                                            <strong>Longitude:</strong> -77.028333
                                                        </h5>--%>

                                                <fieldset class="gllpLatlonPicker">
                                                    <div class="row">

                                                        <div class="col-md-6">
                                                            <label>&nbsp;</label>
                                                            <input type="text" class="form-control gllpSearchField" placeholder="Find Location" />
                                                        </div>
                                                        <div class="col-md-6">

                                                            <div>
                                                                <label>&nbsp;</label>
                                                            </div>
                                                            <button type="button" class="btn btn-danger waves-effect waves-light save-category waves-input-wrapper gllpSearchButton">Search</button>
                                                        </div>

                                                    </div>

                                                    <br />
                                                    <div class="gllpMap"
                                                        style="width: 100%">
                                                        Google Maps
                                                    </div>
                                                    <br />
                                                    <div class="form-group">
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <label class="control-label">Latitude:</label>
                                                                <input id="txtLatitude" runat="server" clientidmode="Static" type="text" class="form-control gllpLatitude" value="25.1939565" data-val="true" data-val-number="The field Latitude must be a number." data-val-required="The Latitude field is required." name="Latitude" />
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label
                                                                    class="control-label">
                                                                    Longitude:</label>
                                                                <input id="txtLongitude" runat="server" clientidmode="Static" type="text" class="form-control gllpLongitude" value="55.2316175000001" data-val="true" data-val-number="The field Longitude must be a number." data-val-required="The Longitude field is required." name="Longitude" />
                                                            </div>
                                                        </div>

                                                    </div>

                                                    <div class="form-group">
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <label
                                                                    class="control-label">
                                                                    Zoom:</label>
                                                                <input type="text" class="form-control gllpZoom" value="10" />
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div>
                                                                    <label>&nbsp;</label>
                                                                </div>
                                                                <button type="button" class="btn btn-danger waves-effect gllpUpdateButton">Update Map</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>

                                        </div>

                                    </div>
                                </div>

                            </div>
                        </form>
                    </div>

                    <div class="modal-footer">
                        <asp:Label ID="lblmsg" runat="server" Font-Size="Medium" ForeColor="Red"></asp:Label>
                        <asp:Button ID="btndelete" OnClientClick="return confirm('Are you sure you want to delete?')" class="btn btn-inverse" runat="server" Text="Delete" />
                        <asp:Button ID="btnsubmit" ValidationGroup="form" CssClass="btn btn-danger waves-effect waves-light save-category btnsubmit" runat="server" Text="Save" ClientIDMode="Static" />
                        <button type="button" onclick="ClearID()" class="btn btn-secondary waves-effect closebtn">Close</button>
                    </div>
                </div>

            </div>
        </div>

        <asp:HiddenField ID="hdnClientid" runat="server" ClientIDMode="Static" />

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
        jQuery('.mydatepicker, #datepicker').datepicker();
        jQuery('#datepicker-autoclose').datepicker({
            autoclose: true,
            todayHighlight: true
        });

        $('#<%= ddlAddress.ClientID%>').change(function () {
            var hash = window.location.hash;
            hash && $('ul.nav a[href="' + hash + '"]').tab('show');

            /* add hash to url when tabs selected (for bookmarking) */
            $('.nav-tabs a').on('shown', function (e) {
                window.location.hash = this.hash;
            });
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

    <%--<script type="text/javascript">
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
    </script>--%>

    <%--<script type="text/javascript">
        $('#btnsave').click(function () {
            var clientid = $("#<%= hdnClientid.ClientID%>").val();
            var FirstName = $("#<%= txtFirstName.ClientID%>").val();
            var LastName = $("#<%= txtLastName.ClientID%>").val();
            var Phone = $("#<%= txtPhone.ClientID%>").val();
            var Telephone = $("#<%= txtTelephone.ClientID%>").val();
            var bookings = "0";
            if ($("#<%= rdbgender.ClientID%>").prop('checked')) {
                bookings = "1";
            }
            else {
                bookings = "0";
            }
            var Email = $("#<%= txtEmail.ClientID%>").val();
            var Notification = $("#<%= ddlNotification.ClientID%>").val();
            var refsource = $("#<%= ddlrefsource.ClientID%>").val();
            var gender = $("#<%= rdbgender.ClientID%>").val();
            var Notes = $("#<%= txtNotes.ClientID%>").val();
            var dob = $("#<%= txtdob.ClientID%>").val();
            var address = $("#<%= txtaddress.ClientID%>").val();
            var City = $("#<%= txtCity.ClientID%>").val();
            var state = $("#<%= txtstate.ClientID%>").val();
            var zipcode = $("#<%= txtzipcode.ClientID%>").val();
            var suburb = $("#<%= txtsuburb.ClientID%>").val();
            var latitude = $("#<%= txtLatitude.ClientID%>").val();
            var longitude = $("#<%= txtLongitude.ClientID%>").val();

            if (FirstName !== "") {
                $.ajax({
                    url: 'Client.aspx/SaveData',
                    type: 'POST',
                    cache: false,
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ clientid: clientid, FirstName: FirstName, LastName: LastName, Phone: Phone, Telephone: Telephone, bookings: bookings, Email: Email, Notification: Notification, refsource: refsource, gender: gender, Notes: Notes, dob: dob, address: address, City: City, state: state, zipcode: zipcode, suburb: suburb, latitude: latitude, longitude: longitude }),
                    dataType: "json",
                    success: function (data) {

                        $("#<%= hdnClientid.ClientID%>").val("");
                        $("#<%= txtFirstName.ClientID%>").val("");
                        $("#<%= txtLastName.ClientID%>").val("");
                        $("#<%= txtPhone.ClientID%>").val("");
                        $("#<%= txtTelephone.ClientID%>").val("");
                        $("#<%= chkbookings.ClientID%>").prop('checked', false);
                        $("#<%= txtEmail.ClientID%>").val("");
                        $("#<%= ddlNotification.ClientID%>").val("");
                        $("#<%= ddlrefsource.ClientID%>").val("");
                        $("#<%= rdbgender.ClientID%>").prop('checked', false);
                        $("#<%= txtNotes.ClientID%>").val("");
                        $("#<%= txtdob.ClientID%>").val("");
                        $("#<%= txtaddress.ClientID%>").val("");
                        $("#<%= txtCity.ClientID%>").val("");
                        $("#<%= txtstate.ClientID%>").val("");
                        $("#<%= txtzipcode.ClientID%>").val("");
                        $("#<%= txtsuburb.ClientID%>").val("");
                        $("#<%= txtLatitude.ClientID%>").val("25.1939565");
                        $("#<%= txtLongitude.ClientID%>").val("55.2316175000001");

                        window.location.reload();
                    }
                });
            } else {
                //alert("work");
            }
        });

        function GetClientById(x) {
            var clientid = x;
            $.ajax({
                type: 'Post',
                url: 'Client.aspx/ClientByClientId',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ clientid: clientid }),
                dataType: "json",
                success: function (result) {
                    $.each(result,
                        function (key, value) {
                            document.getElementById('hdnClientid').value = value.clientid;
                            document.getElementById('txtFirstName').value = value.FirstName;
                            document.getElementById('txtLastName').value = value.LastName;
                            document.getElementById('txtPhone').value = value.Phone;
                            document.getElementById('txtTelephone').value = value.Telephone;
                            if (value.booking !== false) {
                                //document.getElementById('chkbookings').prop('checked', true);
                                document.getElementById("chkbookings").checked = true;
                            } else {
                                document.getElementById("chkbookings").checked = false;
                                //document.getElementById('chkbookings').prop('checked', false);
                            }
                            document.getElementById('txtEmail').value = value.Email;
                            document.getElementById('ddlNotification').value = value.Notification;
                            document.getElementById('ddlrefsource').value = value.refsource;
                            if (value.gender !== false) {
                                document.getElementById("rdbgender").checked = true;
                                //document.getElementById('rdbgender').prop('checked', true);
                            } else {
                                document.getElementById("rdbgender").checked = false;
                                //document.getElementById('rdbgender').prop('checked', false);
                            }
                            document.getElementById('txtNotes').value = value.Notes;
                            document.getElementById('txtdob').value = value.dob;
                            document.getElementById('txtaddress').value = value.address;
                            document.getElementById('txtCity').value = value.City;
                            document.getElementById('txtstate').value = value.state;
                            document.getElementById('txtzipcode').value = value.zipcode;
                            document.getElementById('txtsuburb').value = value.suburb;
                            document.getElementById('txtLatitude').value = value.latitude;
                            document.getElementById('txtLongitude').value = value.longitude;
                        });
                }

            });
        }

        function ClearID() {

            document.getElementById('hdnClientid').value = "";
            document.getElementById('txtFirstName').value = "";
            document.getElementById('txtLastName').value = "";
            document.getElementById('txtPhone').value = "";
            document.getElementById('txtTelephone').value = "";
            //document.getElementById('chkbookings').prop('checked', false);
            document.getElementById("chkbookings").checked = false;
            document.getElementById('txtEmail').value = "";
            //document.getElementById('ddlNotification').value = "";
            //document.getElementById('ddlrefsource').value = "";
            //document.getElementById('rdbgender').prop('checked', false);
            document.getElementById("rdbgender").checked = false;
            document.getElementById('txtNotes').value = "";
            document.getElementById('txtdob').value = "";
            document.getElementById('txtaddress').value = "";
            document.getElementById('txtCity').value = "";
            document.getElementById('txtstate').value = "";
            document.getElementById('txtzipcode').value = "";
            document.getElementById('txtsuburb').value = "";
            document.getElementById('txtLatitude').value = "25.1939565";
            document.getElementById('txtLongitude').value = "55.2316175000001";
        }

    </script>--%>
</body>

</html>
