<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Vouchers.aspx.vb" Inherits="Vouchers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="toppart" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" Runat="Server">
<div class="container-fluid">
<!-- ============================================================== -->
<!-- Bread crumb and right sidebar toggle -->
<!-- ============================================================== -->
<div class="row page-titles">
    <div class="col-md-5 align-self-center">
        <h3 class="text-themecolor">Sales</h3>
    </div>
    <div class="col-md-7 align-self-center">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
            <li class="breadcrumb-item active">Sales</li>
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
            <!-- Nav tabs -->
            <ul class="nav nav-tabs profile-tab">
                <li class="nav-item"> <a class="nav-link" href="sales.html">DAILY SALES</a> </li>
                <li class="nav-item"> <a class="nav-link" href="appointments.html">APPOINTMENTS</a> </li>
                <li class="nav-item"> <a class="nav-link" href="invoices.html">INVOICES</a> </li>
                <li class="nav-item"> <a class="nav-link" href="payments.html">PAYMENTS</a></li>
                <li class="nav-item"> <a class="nav-link active" href="vouchers.html">VOUCHERS</a></li>
            </ul>
            <!-- Tab panes -->
            <div class="tab-content">
                <div class="tab-pane active" role="tabpanel">
                    <div class="card-body">
                        <div class="row">
                                        
                            <div class="col-md-3 col-sm-3 col-12">
                                <div class="form-group">
                                    <label>Status: </label>
                                    <select class="form-control custom-select" data-placeholder="Choose location" tabindex="1">
                                        <option selected="selected" value="">All statuses</option>
                                        <option value="unpaid">Unpaid</option>
                                        <option value="active">Valid</option>
                                        <option value="expired">Expired</option>
                                        <option value="redeemed">Redeemed</option>
                                        <option value="refunded_sale">Refunded Invoice</option>
                                    </select>
                                </div>
                            </div>
                                            
                            <div class="col-md-3 col-sm-3 col-12">
                                <div class="form-group">
                                    <label>Search Code/Client</label>
                                    <input type="text" class="form-control" placeholder="">
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
                                            
                                                                                        
                        </div>
                                        
 
                    </div>
                </div>
            </div>
        </div>
                        
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col-lg-10 col-xlg-10 col-md-10 col-12">
                        <h4 class="card-title">Monday, 1 Jan 2018 to Wednesday, 17 Jan 2018</h4>
                        <h6 class="card-subtitle">All Statuses, generated <code class="bg-light-success">Wednesday, 17 Jan 2018 at 12:50pm</code></h6>
                    </div>
                    <div class="col-lg-2 col-xlg-2 col-md-2 col-12 m-t-10">
                        <select class="form-control custom-select" data-placeholder="Export As" tabindex="1">
                            <option>Export As</option>
                            <option value="xlsx">Excel</option>                                              
                            <option value="pdf">PDF</option>
                            <option value="csv">CSV</option>
                        </select>
                    </div>                                            
                </div>
                                        
                <hr>
                                        
                <div class="row">
                    <div class="col-lg-12 col-xlg-12 col-md-12 col-12">
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped">
                                <thead>
                                <tr>
                                    <th>ISSUE DATE</th>
                                    <th>EXPIRY DATE</th>
                                    <th>INVOICE NO.</th>
                                    <th>CLIENT</th>
                                    <th>TYPE</th>
                                    <th>STATUS</th>	
                                    <th>CODE</th>
                                    <th>TOTAL</th>
                                    <th>REDEEMED</th>
                                    <th>REMAINING</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td><a href="#">Saturday, 6 Jan 2018</a></td>
                                    <td><a href="#">Friday, 6 Jul 2018</a></td>
                                    <td><a href="#">90938-12143030</a></td>
                                    <td><a href="#">Jhon Maria</a></td>
                                    <td><a href="#">Polish Change (25min, Hands)</a></td>
                                    <td class="text-center"><a href="#"><span class="label label-info text-uppercase">VALID</span></a></td>
                                    <td><a href="#">VAJBXWNM</a></td>
                                    <td><a href="#">AED 50.00</a></td>
                                    <td><a href="#">AED 0.00</a></td>
                                    <td><a href="#">AED 50.00</a></td>
                                </tr>
                                                        
                                <tr>
                                    <td><a href="#">Saturday, 6 Jan 2018</a></td>
                                    <td><a href="#">Friday, 6 Jul 2018</a></td>
                                    <td><a href="#">90938-12143030</a></td>
                                    <td><a href="#">Jhon Maria</a></td>
                                    <td><a href="#">Polish Change (25min, Hands)</a></td>
                                    <td class="text-center"><a href="#"><span class="label label-danger text-uppercase">INVALID</span></a></td>
                                    <td><a href="#">VAJBXWNM</a></td>
                                    <td><a href="#">AED 50.00</a></td>
                                    <td><a href="#">AED 0.00</a></td>
                                    <td><a href="#">AED 50.00</a></td>
                                </tr>
                                <tr>
                                    <td><a href="#">Saturday, 6 Jan 2018</a></td>
                                    <td><a href="#">Friday, 6 Jul 2018</a></td>
                                    <td><a href="#">90938-12143030</a></td>
                                    <td><a href="#">Jhon Maria</a></td>
                                    <td><a href="#">Polish Change (25min, Hands)</a></td>
                                    <td class="text-center"><a href="#"><span class="label label-info text-uppercase">VALID</span></a></td>
                                    <td><a href="#">VAJBXWNM</a></td>
                                    <td><a href="#">AED 50.00</a></td>
                                    <td><a href="#">AED 0.00</a></td>
                                    <td><a href="#">AED 50.00</a></td>
                                </tr>
                                                        
                                <tr>
                                    <td><a href="#">Saturday, 6 Jan 2018</a></td>
                                    <td><a href="#">Friday, 6 Jul 2018</a></td>
                                    <td><a href="#">90938-12143030</a></td>
                                    <td><a href="#">Jhon Maria</a></td>
                                    <td><a href="#">Polish Change (25min, Hands)</a></td>
                                    <td class="text-center"><a href="#"><span class="label label-danger text-uppercase">INVALID</span></a></td>
                                    <td><a href="#">VAJBXWNM</a></td>
                                    <td><a href="#">AED 50.00</a></td>
                                    <td><a href="#">AED 0.00</a></td>
                                    <td><a href="#">AED 50.00</a></td>
                                </tr>
                                <tr>
                                    <td><a href="#">Saturday, 6 Jan 2018</a></td>
                                    <td><a href="#">Friday, 6 Jul 2018</a></td>
                                    <td><a href="#">90938-12143030</a></td>
                                    <td><a href="#">Jhon Maria</a></td>
                                    <td><a href="#">Polish Change (25min, Hands)</a></td>
                                    <td class="text-center"><a href="#"><span class="label label-info text-uppercase">VALID</span></a></td>
                                    <td><a href="#">VAJBXWNM</a></td>
                                    <td><a href="#">AED 50.00</a></td>
                                    <td><a href="#">AED 0.00</a></td>
                                    <td><a href="#">AED 50.00</a></td>
                                </tr>
                                                        
                                <tr>
                                    <td><a href="#">Saturday, 6 Jan 2018</a></td>
                                    <td><a href="#">Friday, 6 Jul 2018</a></td>
                                    <td><a href="#">90938-12143030</a></td>
                                    <td><a href="#">Jhon Maria</a></td>
                                    <td><a href="#">Polish Change (25min, Hands)</a></td>
                                    <td class="text-center"><a href="#"><span class="label label-danger text-uppercase">INVALID</span></a></td>
                                    <td><a href="#">VAJBXWNM</a></td>
                                    <td><a href="#">AED 50.00</a></td>
                                    <td><a href="#">AED 0.00</a></td>
                                    <td><a href="#">AED 50.00</a></td>
                                </tr>
                                </tbody>
                                                    
                            </table>
                                                
                            <nav aria-label="Page navigation example" class="m-t-40">
                                <ul class="pagination">
                                    <li class="page-item disabled">
                                        <a class="page-link" href="#" tabindex="-1">Previous</a>
                                    </li>
                                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                                    <li class="page-item">
                                        <a class="page-link" href="#">Next</a>
                                    </li>
                                </ul>
                            </nav>

                        </div>
                    </div>
                </div>
            </div>
        </div>
                        
                                                
    </div>
</div>

</div> 
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" Runat="Server">
</asp:Content>

