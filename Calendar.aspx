<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Calendar.aspx.vb" Inherits="Calendar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <link href='../assets/plugins/fullcalendars/lib/fullcalendar.min.css' rel='stylesheet' />
    <link href='../assets/plugins/fullcalendars/lib/fullcalendar.print.min.css' rel='stylesheet' media='print' />
    <link href='../assets/plugins/fullcalendars/scheduler.min.css' rel='stylesheet' />
    <style>
        #calendar {
            max-width: 100%;
            margin: 0px auto;
        }

        .fancybox-content{
                padding:0!important;
                margin:0!important;
             }
             .fancybox-slide{
                padding:0!important;
                margin:0!important;
             }
             .modal-footer{
                position:absolute;
                width:100%;
                bottom:0;
                left:0;
             }
    </style>
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
                <h3 class="text-themecolor">Calendar</h3>
            </div>
            <div class="col-md-7 align-self-center">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                    <li class="breadcrumb-item active">Calendar</li>
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
                    <div class="row">

                        <div class="col-lg-12">

                            <div class="card-body b-l calender-sidebar">
                                <div class="row">

                                    <div class="col-md-4 col-sm-4 col-12">
                                        <div class="form-group">
                                            <label>All Locations: </label>
                                            <select class="form-control custom-select" data-placeholder="Choose location" tabindex="1">
                                                <option selected="selected" value="">All locations</option>
                                                <option value="">The Home Spa Al Ain</option>
                                                <option value="">The Home Spa Abu Dhabi</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-sm-3 col-12">
                                        <div class="form-group">
                                            <label>Working Staffs: </label>
                                            <select class="form-control custom-select" data-placeholder="Choose location" tabindex="1">
                                                <option selected="selected" value="">Working Staff</option>
                                                <option value="">Working Staff</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-md-2 col-sm-2 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <button type="submit" class="btn btn-danger waves-effect btn-block waves-light">Search</button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3 col-sm-3 col-12">
                                        <div class="form-group">
                                            <label>&nbsp;</label>
                                            <div class="form-group">
                                                <a href="/drivermonitor" class="btn btn-outline-info waves-effect btn-block waves-light">Driver Monitor (Real time)</a>

                                            </div>
                                        </div>
                                    </div>

                                </div>

                                <hr class="m-t-0 m-b-30">

                                <div class="row">
                                    <div class="col-md-12 col-sm-12 col-12">
                                        <div id='calendar'></div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>




    <%-- <!-- BEGIN MODAL -->

    <div class="modal eve-modal fade" id="evemodal" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                
            </div>
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->--%>


    <div class="modal fade none-border addeditclientmodal" id="addeditclientmodal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Add/Edit Client                           
                    </h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
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
                                                    <input type="text" class="form-control" placeholder="">
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-12">
                                                <div class="form-group">
                                                    <label class="control-label">Last Name</label>
                                                    <input type="text" class="form-control" placeholder="">
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
                                                        <input type="text" class="form-control" aria-label="" value="+971 00 123 4567">
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
                                                        <input type="text" class="form-control" aria-label="" value="+971 00 123 4567">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12 col-12">
                                                <div class="form-group">
                                                    <label class="control-label">Email</label>
                                                    <input type="text" class="form-control" placeholder="">
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-12">
                                                <div class="form-group">
                                                    <label class="control-label">SEND NOTIFICATIONS BY</label>
                                                    <select class="form-control custom-select" data-placeholder="Choose" tabindex="1">
                                                        <option selected="selected" value="">Don't send notifications</option>
                                                        <option value="">Email</option>
                                                        <option value="">SMS</option>
                                                        <option value="">Email and SMS</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-12 col-12">
                                                <div class="form-group">
                                                    <label class="control-label">REFERRAL SOURCE</label>
                                                    <select class="form-control custom-select" data-placeholder="Choose" tabindex="1">
                                                        <option selected="selected" value="">Select source</option>
                                                        <option value="">Walkin</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-12 col-12">
                                                <div class="form-group">
                                                    <div class="form-check">
                                                        <label class="custom-control custom-radio">
                                                            <input id="radio1" name="radio" type="radio" checked class="custom-control-input">
                                                            <span class="custom-control-indicator"></span>
                                                            <span class="custom-control-description">Male</span>
                                                        </label>
                                                        <label class="custom-control custom-radio">
                                                            <input id="radio2" name="radio" type="radio" class="custom-control-input">
                                                            <span class="custom-control-indicator"></span>
                                                            <span class="custom-control-description">Female</span>
                                                        </label>
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
                                                    <textarea class="form-control" rows="5"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-md-12 col-12">
                                                <div class="form-group">
                                                    <div class="checkbox checkbox-success">
                                                        <input id="checkbox1" type="checkbox">
                                                        <label for="checkbox1">DISPLAY ON ALL BOOKINGS </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-12">
                                                <div class="form-group">
                                                    <label>BIRTHDAY</label>
                                                    <div class="input-group">
                                                        <input type="text" class="form-control mydatepicker" placeholder="mm/dd/yyyy">
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
                                    <div class="col-md-12 col-12">
                                        <div class="form-group">
                                            <label class="control-label">ADDRESS</label>
                                            <textarea class="form-control" rows="5"></textarea>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <div class="form-group">
                                            <label class="control-label">SUBURB</label>
                                            <input type="text" class="form-control" placeholder="">
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <div class="form-group">
                                            <label class="control-label">CITY</label>
                                            <input type="text" class="form-control" placeholder="">
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <div class="form-group">
                                            <label class="control-label">STATE</label>
                                            <input type="text" class="form-control" placeholder="">
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <div class="form-group">
                                            <label class="control-label">ZIP / POST CODE</label>
                                            <input type="text" class="form-control" placeholder="">
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-inverse">Delete</button>
                    <button type="button" class="btn btn-danger waves-effect waves-light save-category" data-dismiss="modal">Save</button>
                    <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- ============================================================== -->
    <!-- End Container fluid  -->
    <!-- ============================================================== -->
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
    <!-- This page plugins -->
    <script src="../assets/plugins/switchery/dist/switchery.min.js"></script>
    <script src="../assets/plugins/select2/dist/js/select2.full.min.js" type="text/javascript"></script>
    <script src="../assets/plugins/bootstrap-select/bootstrap-select.min.js" type="text/javascript"></script>
    <script src="../assets/plugins/bootstrap-tagsinput/dist/bootstrap-tagsinput.min.js"></script>
    <script src="../assets/plugins/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../assets/plugins/multiselect/js/jquery.multi-select.js"></script>

    <script>
        jQuery(document).ready(function () {
            // Switchery
            var elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch'));
            $('.js-switch').each(function () {
                new Switchery($(this)[0], $(this).data());
            });
            // For select 2
            $(".select2").select2();
            $('.selectpicker').selectpicker();
            //Bootstrap-TouchSpin
            $(".vertical-spin").TouchSpin({
                verticalbuttons: true,
                verticalupclass: 'ti-plus',
                verticaldownclass: 'ti-minus'
            });
            var vspinTrue = $(".vertical-spin").TouchSpin({
                verticalbuttons: true
            });
            if (vspinTrue) {
                $('.vertical-spin').prev('.bootstrap-touchspin-prefix').remove();
            }
            $("input[name='tch1']").TouchSpin({
                min: 0,
                max: 100,
                step: 0.1,
                decimals: 2,
                boostat: 5,
                maxboostedstep: 10,
                postfix: '%'
            });
            $("input[name='tch2']").TouchSpin({
                min: -1000000000,
                max: 1000000000,
                stepinterval: 50,
                maxboostedstep: 10000000,
                prefix: '$'
            });
            $("input[name='tch3']").TouchSpin();
            $("input[name='tch3_22']").TouchSpin({
                initval: 40
            });
            $("input[name='tch5']").TouchSpin({
                prefix: "pre",
                postfix: "post"
            });
            // For multiselect
            $('#pre-selected-options').multiSelect();
            $('#optgroup').multiSelect({
                selectableOptgroup: true
            });
            $('#public-methods').multiSelect();
            $('#select-all').click(function () {
                $('#public-methods').multiSelect('select_all');
                return false;
            });
            $('#deselect-all').click(function () {
                $('#public-methods').multiSelect('deselect_all');
                return false;
            });
            $('#refresh').on('click', function () {
                $('#public-methods').multiSelect('refresh');
                return false;
            });
            $('#add-option').on('click', function () {
                $('#public-methods').multiSelect('addOption', {
                    value: 42,
                    text: 'test 42',
                    index: 0
                });
                return false;
            });
            $(".ajax").select2({
                ajax: {
                    url: "https://api.github.com/search/repositories",
                    dataType: 'json',
                    delay: 250,
                    data: function (params) {
                        return {
                            q: params.term, // search term
                            page: params.page
                        };
                    },
                    processResults: function (data, params) {
                        // parse the results into the format expected by Select2
                        // since we are using custom formatting functions we do not need to
                        // alter the remote JSON data, except to indicate that infinite
                        // scrolling can be used
                        params.page = params.page || 1;
                        return {
                            results: data.items,
                            pagination: {
                                more: (params.page * 30) < data.total_count
                            }
                        };
                    },
                    cache: true
                },
                escapeMarkup: function (markup) {
                    return markup;
                }, // let our custom formatter work
                minimumInputLength: 1,
                templateResult: formatRepo, // omitted for brevity, see the source of this page
                templateSelection: formatRepoSelection // omitted for brevity, see the source of this page
            });
        });
    </script>
    <!-- ============================================================== -->

    <script>
        jQuery('.mydatepicker, #datepicker').datepicker();
        jQuery('#datepicker-autoclose').datepicker({
            autoclose: true,
            todayHighlight: true
        });
    </script>

    <script src='../assets/plugins/fullcalendars/lib/moment.min.js'></script>
    <script src='../assets/plugins/fullcalendars/lib/fullcalendar.min.js'></script>
    <script src='../assets/plugins/fullcalendars/scheduler.min.js'></script>
    <script>
        $(document).ready(function () {
          
            $(function () { // document ready
               
                $('#calendar').fullCalendar({
                    defaultView: 'agendaDay',
                    defaultDate: '2018-04-07',
                    editable: true,
                    selectable: true,
                    eventLimit: true, // allow "more" link when too many events
                    header: {
                        left: 'prev,next today',
                        center: '',
                        right: 'title'
                    },
                    views: {
                        agendaTwoDay: {
                            type: 'agenda',
                            duration: { days: 2 },

                            // views that are more than a day will NOT do this behavior by default
                            // so, we need to explicitly enable it
                            groupByResource: true

                            //// uncomment this line to group by day FIRST with resources underneath
                            //groupByDateAndResource: true
                        }
                    },

                    //// uncomment this line to hide the all-day slot
                    allDaySlot: false,
                    slotDuration: '00:15',
                    //resourceAreaWidth: '25%',

                    resources: [
                      { id: 'a', title: 'Driver1', },
                      { id: 'b', title: 'Andru', eventColor: '' },
                      { id: 'c', title: 'Maria', eventColor: '' },
                      { id: 'd', title: 'John', eventColor: '' },
                      { id: 'e', title: 'Driver2' },
                      { id: 'f', title: 'Andru', eventColor: '' },
                      { id: 'g', title: 'Maria', eventColor: '' },
                      { id: 'h', title: 'John', eventColor: '' },
                      { id: 'e', title: 'Driver3' },
                      { id: 'f', title: 'Andru', eventColor: '' },
                      { id: 'g', title: 'Maria', eventColor: '' },
                      { id: 'h', title: 'John', eventColor: '' }
                    ],
                    events: [
                      { id: '1', resourceId: 'a', start: '2018-04-06', end: '2018-04-08', title: 'event 1' },
                      { id: '2', resourceId: 'a', start: '2018-04-07T09:00:00', end: '2018-04-07T14:00:00', title: 'event 2' },
                      { id: '3', resourceId: 'b', start: '2018-04-07T12:00:00', end: '2018-04-08T06:00:00', title: 'event 3' },
                      { id: '4', resourceId: 'c', start: '2018-04-07T07:30:00', end: '2018-04-07T09:30:00', title: 'event 4' },
                      { id: '5', resourceId: 'd', start: '2018-04-07T10:00:00', end: '2018-04-07T15:00:00', title: 'event 5' }
                    ],

                    select: function (start, end, jsEvent, view, resource) {
                        console.log(
                          'select',
                          start.format(),
                          end.format(),
                          resource ? resource.id : '(no resource)'
                        );


                        //$('#evemodal').modal('show');

                        var link = "calendar_popup.aspx";
                        $.fancybox.open({

                            src: link,
                            type: 'iframe',
                            iframe: {
                                closeClick: false,
                                css: {
                                    smallBtn: 'false',
                                    width: '100%',
                                    height:'100%'
                                }
                            },
                            closeClick: false,
                            toolbar: false,
                            smallBtn: false,
                            fitToView: true,
                            beforeShow: function () {
                                this.width = 500;
                                this.height = 100;
                                // If helpers.overlay = false doesn't work, uncomment below.
                                // $('#fancybox-overlay').remove();
                            },
                            helpers: {
                                overlay: { closeClick: false }
                            }
                        });

                        //window.top.location.href = "calendar_popup.aspx";
                    },

                    eventMouseover: function (data, event, view) {

                        tooltip = '<div class="tooltiptopicevent eve-tooltip">'
                        + '<h3>Completed</h3>'
                        + '<h4>Essential</h4>'
                        + '<ul>'
                        + '<li>Adam smith</li>'
                        + '<li>4:00pm-4:45pm</li>'
                        + '<li>Maria</li>'
                        + '<li>AED 105</li>'
                        + '<li>lorem ipsum dolor sit Curabitur ex nibh, venenatis eget ipsum ac, vehicula semper ligula. Curabitur tempor sodales dolor sit ame</li>'
                        + '</ul>'
                        + '</div>';


                        $("body").append(tooltip);
                        $(this).mouseover(function (e) {
                            $(this).css('z-index', 10000);
                            $('.tooltiptopicevent').fadeIn('500');
                            $('.tooltiptopicevent').fadeTo('10', 1.9);
                        }).mousemove(function (e) {
                            $('.tooltiptopicevent').css('top', e.pageY + 10);
                            $('.tooltiptopicevent').css('left', e.pageX + 20);
                        });
                    },
                    eventMouseout: function (data, event, view) {
                        $(this).css('z-index', 8);

                        $('.tooltiptopicevent').remove();
                        if (view.name !== 'timelineDay') {
                            $(jsEvent.target).attr('title', event.title);
                        }

                    },


                    //  dayClick: function(date, jsEvent, view, resource) {
                    //    console.log(
                    //      'dayClick',
                    //      date.format(),
                    //      resource ? resource.id : '(no resource)'
                    //    );
                    //  }
                });

            });

        });
    </script>
</asp:Content>

