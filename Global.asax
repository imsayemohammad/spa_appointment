<%@ Application Language="VB" %>
<%@ Import Namespace="System.Globalization" %>
<script RunAt="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application startup
        RegisterRoute(Routing.RouteTable.Routes)
        Application("SiteVisitedCounter") = 0
    End Sub



    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a new session is started
        Application.Lock()
        Application("SiteVisitedCounter") = Convert.ToInt32(Application("SiteVisitedCounter")) + 1
        Application.UnLock()
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.
    End Sub

    Sub RegisterRoute(ByVal routes As Routing.RouteCollection)

        routes.MapPageRoute("Home", "home", "~/Default.aspx")

        routes.MapPageRoute("logout", "logout", "~/Logout.aspx")

        routes.MapPageRoute("login", "login", "~/Login.aspx")
        routes.MapPageRoute("thank-you", "thank-you", "~/ThankYou.aspx")
        'routes.MapPageRoute("dashboard", "dashboard", "~/Dashboard.aspx")

        routes.MapPageRoute("staff", "staff", "~/Staff.aspx")
        routes.MapPageRoute("Staffinfo", "Staffinfo", "~/StaffInfo.aspx")
        routes.MapPageRoute("staffrating", "staffrating", "~/StaffRating.aspx")
        routes.MapPageRoute("Client", "Client", "~/Client.aspx")
        routes.MapPageRoute("Clientinfo", "Clientinfo", "~/ClientInfo.aspx")
        routes.MapPageRoute("clientrating", "clientrating", "~/ClientRating.aspx")
        routes.MapPageRoute("ClosedDates", "ClosedDates", "~/ClosedDates.aspx")
        routes.MapPageRoute("workinghours", "workinghours", "~/workinghours.aspx")
        routes.MapPageRoute("permissionlevels", "permissionlevels", "~/Permissionlevels.aspx")
        routes.MapPageRoute("accounts", "accounts", "~/Accounts.aspx")
        routes.MapPageRoute("calendar", "calendar", "~/Calendar.aspx")
        routes.MapPageRoute("drivermonitor", "drivermonitor", "~/driver_monitor.aspx")
        routes.MapPageRoute("calendarsettings", "calendarsettings", "~/calendarsettings.aspx")

        routes.MapPageRoute("error", "error", "~/Error.aspx")
        routes.MapPageRoute("activation", "activation", "~/Activation.aspx")
        'routes.MapPageRoute("privacy-policy", "{lang}/privacy-policy", "~/PrivacyPolicy.aspx")
        routes.MapPageRoute("about", "about", "~/About.aspx")
        routes.MapPageRoute("forget-password", "forget-password", "~/Forget-Password.aspx")
        routes.MapPageRoute("change-password", "change-password", "~/Change-Password.aspx")
        routes.MapPageRoute("reset-password", "reset-password", "~/Reset-Password.aspx")
        routes.MapPageRoute("faq", "faq", "~/Faq.aspx")

        'mahfuz
        routes.MapPageRoute("location", "location", "~/LocationList.aspx")
        routes.MapPageRoute("company", "company", "~/Company.aspx")
        routes.MapPageRoute("category", "category", "~/CategoryList.aspx")
        routes.MapPageRoute("brand", "brand", "~/BrandList.aspx")
        routes.MapPageRoute("services", "services", "~/AllServices.aspx")
        routes.MapPageRoute("servicegroups", "servicegroups", "~/ServiceGroups.aspx")
        routes.MapPageRoute("packages", "packages", "~/AllPackages.aspx")
        routes.MapPageRoute("dailysales", "dailysales", "~/DailySales.aspx")
        routes.MapPageRoute("appointments", "appointments", "~/Appointments.aspx")
        routes.MapPageRoute("invoices", "invoices", "~/Invoices.aspx")
        routes.MapPageRoute("payments", "payments", "~/Paymentts.aspx")
        routes.MapPageRoute("vouchers", "vouchers", "~/Vouchers.aspx")
        routes.MapPageRoute("messages", "messages", "~/Messages.aspx")
        routes.MapPageRoute("supplier", "supplier", "~/SupplierList.aspx")
        routes.MapPageRoute("products", "products", "~/ProductList.aspx")
        routes.MapPageRoute("country", "country", "~/Country.aspx")
        routes.MapPageRoute("pos", "pos", "~/Pos.aspx")
        routes.MapPageRoute("paymentypes", "paymentypes", "~/PaymenTypes.aspx")
        routes.MapPageRoute("vat", "vat", "~/Vat.aspx")
        routes.MapPageRoute("discount", "discount", "~/Discount.aspx")
        routes.MapPageRoute("currency", "currency", "~/Currency.aspx")
        routes.MapPageRoute("team", "team", "~/Team.aspx")
        routes.MapPageRoute("teampopup", "teampopup", "~/Team_popup.aspx")
        
        'mahfuz

    End Sub

    Protected Sub Application_BeginRequest(sender As [Object], e As EventArgs)

        'If Request.Url.ToString.ToLower().StartsWith("http://") And Not Request.Url.ToString.ToLower().StartsWith("http://localhost") Then
        '    PermanentRedirect(Request.Url.ToString.ToLower().Replace("http://", "https://"))
        'End If

        'If Request.Url.ToString.ToLower().StartsWith("http://") And Not Request.Url.ToString.ToLower().StartsWith("http://localhost") Then
        '    PermanentRedirect(Request.Url.ToString.ToLower().Replace("http://", "https://"))
        'End If
        If Request.Url.ToString.ToLower().StartsWith("https://") And Not Request.Url.ToString.ToLower().StartsWith("http://localhost") Then
            PermanentRedirect(Request.Url.ToString.ToLower().Replace("https://", "http://"))
        End If

        Dim domainName As String
        domainName = ConfigurationManager.AppSettings("RedirectUrl").ToString
        Context.Items.Add("domainName", domainName)
        Dim newCulture As CultureInfo = DirectCast(System.Threading.Thread.CurrentThread.CurrentCulture.Clone(), CultureInfo)
        newCulture.DateTimeFormat.ShortDatePattern = "MM/dd/yyyy"
        newCulture.DateTimeFormat.DateSeparator = "/"
        Threading.Thread.CurrentThread.CurrentCulture = newCulture
    End Sub


    Private Sub PermanentRedirect(ByVal url As String)
        Response.Clear()
        Response.Status = "301 Moved Permanently"
        Response.AddHeader("Location", url)
        Response.End()
    End Sub


</script>
