<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="LocationList.aspx.vb" Inherits="LocationList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="toppart" runat="Server">
    <link href="/css/pages/google-vector-map.css" rel="stylesheet" />
    <link href="/css/pages/jquery-gmaps-latlon-picker.css" rel="stylesheet" />

    <script src="/assets/plugins/jquery/jquery.min.js"></script>

    <script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyAAoCreJSTSKMSraR3BTeIV8TBxoyI4OWA&amp"></script>
    <script src="/js/jquery-gmaps-latlon-picker.js"></script>

<!--    <script type="text/javascript" charset="UTF-8" src="http://maps.googleapis.com/maps-api-v3/api/js/34/4/util.js"></script>-->

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

</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">

    <div class="container-fluid">

        <div class="row page-titles">
            <div class="col-md-5 align-self-center">
                <h3 class="text-themecolor">Locations</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                    <li class="breadcrumb-item active">Locations</li>
                </ol>
            </div>

        </div>


        <div class="row">
            <div class="col-md-12">
                <div class="card">

                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs profile-tab">
                        <li class="nav-item"><a class="nav-link" href="/accounts">Account</a> </li>
                        <%--<li class="nav-item"><a class="nav-link" href="/client">Client</a></li>--%>
                        <li class="nav-item"><a class="nav-link" href="/pos">POS</a></li>
                        <li class="nav-item"><a class="nav-link active" href="/location">Locations</a></li>
                        <li class="nav-item"><a class="nav-link" href="/country">Country</a></li>
                    </ul>
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" role="tabpanel">
                            <div class="card-body">
                                <div class="row">

                                    <div class="col-md-12 col-sm-12 col-12 text-right">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <button type="button" class="btn btn-info waves-effect btn-block waves-light" data-toggle="modal" data-target="#addeditclientmodal" style="width: auto;">Add New</button>
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
                                                        <th>LOCATION NAME</th>
                                                        <th>MOBILE NUMBER</th>
                                                        <th>EMAIL</th>
                                                        <th>CITY</th>
                                                        <th>STATE</th>
                                                        <th>ZIP CODE</th>
                                                        <th>ACTION</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:Literal ID="ltrLocation" runat="server"></asp:Literal>
                                                </tbody>

                                            </table>


                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal fade none-border addeditclientmodal" id="addeditclientmodal">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title">Add/Edit Location
                                        </h4>
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="ClearAll()">×</button>
                                    </div>
                                    <div class="modal-body">
                                        <form role="form">

                                            <div class="tab-content">
                                                <div class="tab-pane active" role="tabpanel" id="s-LOCATIONS">
                                                    <div class="row">
                                                        <!-- left column-->
                                                        <div class="col-md-6 col-12">
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="form-group">

                                                                        <%--                                                        <input type="hidden" class="form-control" id="hidLocationId" >--%>

                                                                        <asp:HiddenField ID="hidLocationId" runat="server" />


                                                                        <label class="control-label">
                                                                            Location Name:
                                                                        </label>



                                                                        <asp:TextBox ID="LocationName" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ControlToValidate="LocationName" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1LocationName" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-12">
                                                                    <div class="form-group">
                                                                        <label class="control-label">
                                                                            Arabic Location Name:
                                                                        </label>

                                                                        <asp:TextBox ID="ArabicLocationName" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>

                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label class="control-label">
                                                                            Contact
                                                                            Number:
                                                                        </label>

                                                                        <%--                                                        <input type="text" class="form-control" id="ContactNumber">--%>

                                                                        <asp:TextBox ID="ContactNumber" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ControlToValidate="ContactNumber" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1ContactNumber" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>



                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label class="control-label">
                                                                            Contact
                                                                            Email:
                                                                        </label>
                                                                        <%--      <input type="email" class="form-control" id="ContactEmail"> --%>

                                                                        <asp:TextBox ID="ContactEmail" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ControlToValidate="ContactEmail" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1ContactEmail" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>

                                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" Display="Dynamic" runat="server" ErrorMessage="* invalid" ValidationGroup="form" ControlToValidate="ContactEmail" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>


                                                                    </div>
                                                                </div>

                                                                <div class="col-md-12">
                                                                    <div class="form-group">
                                                                        <label class="control-label">
                                                                            Street
                                                                            Address:
                                                                        </label>
                                                                        <input type="text" class="form-control">
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-12">
                                                                    <div class="form-group">
                                                                        <label class="control-label">
                                                                            APT,
                                                                            SUIT, BLDG
                                                                        </label>
                                                                        <%--  <input type="text" class="form-control" id="AptStuiioBldg">--%>

                                                                        <asp:TextBox ID="AptStuiioBldg" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>



                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label class="control-label">CITY</label>
                                                                        <%-- <input type="text" required  class="form-control" placeholder="" id="City">--%>

                                                                        <asp:TextBox ID="City" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ControlToValidate="City" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1City" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>

                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label class="control-label">STATE</label>
                                                                        <%-- <input type="text" required class="form-control" placeholder="" id="State">--%>

                                                                        <asp:TextBox ID="State" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ControlToValidate="State" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1State" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label class="control-label">ZIP / POST CODE</label>
                                                                        <%-- <input type="text" required class="form-control" placeholder="" id="Zip"> --%>
                                                                        <asp:TextBox ID="Zip" CssClass="form-control" runat="server" ClientIDMode="Static"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ControlToValidate="Zip" SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ValidationGroup="form" ID="RequiredFieldValidator1Zip" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>


                                                                    </div>
                                                                </div>


                                                            </div>
                                                        </div>
                                                        <!-- left column-->

                                                        <!-- right column-->
                                                        <div class="col-md-6 col-12">
                                                            <div class="row gllpLatlonPicker">
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label>&nbsp;</label>
                                                                        <input type="text" class="form-control gllpSearchField" placeholder="Find Location" />
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <div>
                                                                            <label>&nbsp;</label>
                                                                        </div>
                                                                        <button type="button" class="btn btn-danger waves-effect waves-light save-category waves-input-wrapper gllpSearchButton">Search</button>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-12">
                                                                    <div class="form-group">
                                                                        <div class="gllpMap" style="width: 100%">
                                                                        </div>
                                                                    </div>

                                                                </div>

                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label class="control-label">Latitude:</label>
                                                                        <asp:TextBox ID="txtLatitude" runat="server" ClientIDMode="Static" type="text" class="form-control gllpLatitude" value="25.1939565" data-val="true" data-val-number="The field Latitude must be a number." data-val-required="The Latitude field is required." name="Latitude" />
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label class="control-label">
                                                                            Longitude:</label>
                                                                        <asp:TextBox ID="txtLongitude" runat="server" ClientIDMode="Static" type="text" class="form-control gllpLongitude" value="55.2316175000001" data-val="true" data-val-number="The field Longitude must be a number." data-val-required="The Longitude field is required." name="Longitude" />
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label class="control-label">
                                                                            Zoom:</label>
                                                                        <input type="text" class="form-control gllpZoom" value="10" />
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <div>
                                                                            <label>&nbsp;</label>
                                                                        </div>
                                                                        <button type="button" class="btn btn-danger waves-effect gllpUpdateButton">Update Map</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!-- right column-->

                                                    </div>
                                                </div>

                                            </div>
                                        </form>
                                    </div>
                                    <div class="modal-footer">


                                        <asp:Button ID="btnsubmit" ValidationGroup="form" CssClass="btn btn-danger waves-effect waves-light  btnsubmit" runat="server" Text="Save" ClientIDMode="Static" />
                                        <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal" onclick="ClearAll()">Close</button>
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

    <!--c3 JavaScript -->
    <script src="/assets/plugins/d3/d3.min.js"></script>
    <script src="/assets/plugins/c3-master/c3.min.js"></script>
    <!-- Popup message jquery -->
    <script src="/assets/plugins/toast-master/js/jquery.toast.js"></script>



    <script>
        function ClearAll() {
            document.getElementById('hidLocationId').value = "";
            document.getElementById('LocationName').value = "";
            document.getElementById('ContactNumber').value = "";
            document.getElementById('ContactEmail').value = "";
            document.getElementById('AptStuiioBldg').value = "";
            document.getElementById('City').value = "";
            document.getElementById('Zip').value = "";
            document.getElementById('State').value = "";
            document.getElementById('ArabicLocationName').value = "";
            document.getElementById('txtLatitude').value = "";
            document.getElementById('txtLongitude').value = "";

        }


        function DeleteLocationById(x) {


            var LocationId = x;


            if (confirm("Are You Sure You Want To Delete ?")) {
                $.ajax({
                    type: 'Post',
                    url: 'LocationList.aspx/DeleteLocationById',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({
                        LocationId: LocationId
                    }),
                    dataType: "json",
                    success: function (result) {
                        $.each(result,
                            function (key, value) {
                                alert(value);
                                location.reload();

                            });
                    }
                });
            }
        }


        function GetLocationById(x) {
            var LocationId = x;
            $.ajax({
                type: 'Post',
                url: 'LocationList.aspx/GetLocationById',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    LocationId: LocationId
                }),
                dataType: "json",
                success: function (result) {
                    $.each(result,
                        function (key, value) {


                            $("#<%=hidLocationId.ClientID %>").val(value.LocationId);
                            $("#<%=LocationName.ClientID %>").val(value.LocationName);
                            $("#<%=ContactNumber.ClientID %>").val(value.Phone);
                            $("#<%=ContactEmail.ClientID %>").val(value.Email);
                            $("#<%=ArabicLocationName.ClientID %>").val(value.ArabicLocationName);
                            $("#<%=AptStuiioBldg.ClientID %>").val("");
                            $("#<%=City.ClientID %>").val(value.City);
                            $("#<%=Zip.ClientID %>").val(value.ZipCode);
                            $("#<%=State.ClientID %>").val(value.State);
                            $("#<%=txtLatitude.ClientID %>").val(value.Latitude);
                            $("#<%=txtLongitude.ClientID %>").val(value.Longitude);
                        });
                }
            });
        }

    </script>

</asp:Content>
