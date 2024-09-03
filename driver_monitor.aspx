<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="driver_monitor.aspx.vb" Inherits="driver_monitor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="toppart" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">
    <!-- ============================================================== -->
    <!-- Container fluid  -->
    <!-- ============================================================== -->
    <div class="container-fluid">
        <!-- ============================================================== -->
        <!-- Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <div class="row page-titles">
            <div class="col-md-5 align-self-center">
                <h3 class="text-themecolor">Driver Monitor</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                    <li class="breadcrumb-item active">Driver Monitor</li>
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
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-8">
                                <div id="overlayermap" class="gmaps"></div>
                            </div>
                            <div class="col-md-4">
                                <h3 class="card-title text-info">Car 1</h3>
                                <ul class="list-group m-b-20">
                                    <li class="list-group-item bg-light-inverse"><strong>Driver Name: John</strong></li>
                                    <li class="list-group-item">Team Member 1</li>
                                    <li class="list-group-item">Team Member 2</li>
                                    <li class="list-group-item">Team Member 3</li>
                                    <li class="list-group-item">Team Member 4</li>
                                </ul>

                                <h4 class="card-subtitle">Current Locaion</h4>
                                <p>Akshya Nagar 1st Block 1st Cross, Rammurthy nagar, Bangalore-560016</p>
                                <h4 class="card-subtitle">Destination Locaion</h4>
                                <p>Akshya Nagar 1st Block 1st Cross, Rammurthy nagar, USA</p>
                                <hr>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>

    </div>
    <!-- ============================================================== -->
    <!-- End Container fluid  -->
    <!-- ============================================================== -->
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
    <!-- google maps api -->
    <script src="https://maps.google.com/maps/api/js?key=AIzaSyCUBL-6KdclGJ2a_UpmB2LXvq7VOcPT7K4&sensor=true"></script>
    <script src="/assets/plugins/gmaps/gmaps.min.js"></script>
    <script src="/assets/plugins/gmaps/jquery.gmaps.js"></script>
    <script>


        $(document).ready(function () {
            map = new GMaps({
                el: '#overlayermap',
                lat: -12.043333,
                lng: -77.028333
            });
            map.drawOverlay({
                lat: map.getCenter().lat(),
                lng: map.getCenter().lng(),
                layer: 'overlayLayer',
                content: '<div class="gmaps-overlay">Driver John<div class="gmaps-overlay_arrow above"></div></div>',
                verticalAlign: 'top',
                horizontalAlign: 'center'
            });
        });
    </script>
</asp:Content>

