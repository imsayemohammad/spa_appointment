<%@ WebHandler Language="VB" Class="Home" %>

Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web

Public Class Home : Implements IHttpHandler

    Dim context As HttpContext

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Me.context = context
        Dim json = Me.GetHome()
        json = String.Format("{0}", json)
        context.Response.ContentType = "text/json"
        context.Response.Write(json)
    End Sub




    Private Function GetHome()
        Dim banners as String = GetBanners()
        Dim Services as String = GetServices()
        Dim Packages as String = GetPackages()

        context.Response.Write("{ ""data"" : { ""banners"":[ " + banners + "],""services"":[ " + Services + "],""packages"":[ " + Packages + "]     }, ""code"": 200 ,""message"": ""Succesfull"",""isSuccess"": true } ")
    End Function

    Private Function GetPackages() As String

        Dim rootUrlForAndroid As String = System.Configuration.ConfigurationManager.AppSettings("rootUrlForAndroid").ToString()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim countries as String = ""
        Dim selectString = String.Empty
        Dim areaId = 0
        Integer.tryParse(context.Request.Params("areaId"), areaId)
        conn.Open()




        If areaId = 0 then
            selectString = "SELECT sr.*,l.AreaId FROM (SELECT Services.*,ServiceRates.RetailPrice  FROM Services left join ServiceRates on Services.ServiceId = ServiceRates.ServiceId ) as sr left join  ServiceLocations l on sr.ServiceId=l.ServiceId  Where sr.IsPackage=1 AND ParentId=0 "
        Else
            selectString = "SELECT sr.*,l.AreaId FROM (SELECT Services.*,ServiceRates.RetailPrice  FROM Services left join ServiceRates on Services.ServiceId = ServiceRates.ServiceId ) as sr left join  ServiceLocations l on sr.ServiceId=l.ServiceId  Where sr.IsPackage=1 AND ParentId=0  AND  l.AreaId=" + context.Request.Params("areaId")
        End If



        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        Dim currentItemNumber as Integer = 1



        While reader.Read()

            Dim serviceTitle = String.Empty
            Dim serviceSubTitle = String.Empty
            Dim description = string.empty
            Dim ServiceType = string.empty
            Dim HomeImage = String.Empty
            Dim Active = String.Empty
            Dim Inactive = String.Empty



            if Not reader("BigIconOne") Is Nothing Then
                If Not String.isNullOrEmpty(reader("BigIconOne").ToString()) Then
                    HomeImage = rootUrlForAndroid + reader("BigIconOne").ToString()
                End If

            End If

            if Not reader("SmallIconTwo") Is Nothing Then
                If Not String.isNullOrEmpty(reader("SmallIconTwo").ToString()) Then
                    Inactive = rootUrlForAndroid + reader("SmallIconTwo").ToString()
                End If

            End If

            if Not reader("SmallIconOne") Is Nothing Then

                If Not String.isNullOrEmpty(reader("SmallIconOne").ToString()) Then
                    Active = rootUrlForAndroid + reader("SmallIconOne").ToString()
                End If

            End If





            If reader("IsPackage").ToString() = true Then
                ServiceType = "package"
            Else
                ServiceType = "service"
            End If

            if context.Request.Params("lang").Equals("en") then
                serviceTitle = reader("Title").ToString()
                serviceSubTitle = reader("SubTitle").ToString()
                description = reader("Description").ToString()
            Else If context.Request.Params("lang").Equals("ar") then
                serviceTitle = reader("ArTitle").ToString()
                serviceSubTitle = reader("ArSubTitle").ToString()
                description = reader("ArDescription").ToString()
            End If

            if currentItemNumber = 1 then

                countries += " { ""serviceId"" : " + reader("ServiceId").ToString() + ",""serviceType"" : """ + serviceType + """,""title"" : """ + serviceTitle + """,""homeImage"" : """ + HomeImage + """,""width"" : " + reader("BigIconWidth").ToString() + ",""height"" : " + reader("BigIconHeight").ToString() + ",""aspectRatio"" : 0,""inactiveIcon"" : """ + Inactive + """,""activeIcon"" : """ + Active + """,""serviceRate"" : " + IIF(reader("RetailPrice") IS Nothing, 0, reader("RetailPrice").ToString()).ToString() + ",""child"" : [" + GetChildsPackages(reader("ServiceId").ToString()) + "]}" '

            else
                countries += ", { ""serviceId"" : " + reader("ServiceId").ToString() + ",""serviceType"" : """ + serviceType + """,""title"" : """ + serviceTitle + """,""homeImage"" : """ + HomeImage + """,""width"" : " + reader("BigIconWidth").ToString() + ",""height"" : " + reader("BigIconHeight").ToString() + ",""aspectRatio"" : 0,""inactiveIcon"" : """ + Inactive + """,""activeIcon"" : """ + Active + """,""serviceRate"" : " + IIF(reader("RetailPrice") IS Nothing, 0, reader("RetailPrice").ToString()).ToString() + ",""child"" : [" + GetChildsPackages(reader("ServiceId").ToString()) + "]}" '
            End If
            currentItemNumber += 1
        End While

        reader.Close()
        conn.Close()
        Return countries
    End Function

    Private Function GetChildsPackages(s As String) As String
        Dim rootUrlForAndroid As String = System.Configuration.ConfigurationManager.AppSettings("rootUrlForAndroid").ToString()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim countries as String = ""
        Dim selectString = ""
        Dim areaId = 0

        Integer.tryParse(context.Request.Params("areaId"), areaId)
        conn.Open()


        If areaId = 0 then
            selectString = "SELECT sr.*,l.AreaId FROM (SELECT Services.*,ServiceRates.RetailPrice  FROM Services left join ServiceRates on Services.ServiceId = ServiceRates.ServiceId ) as sr left join  ServiceLocations l on sr.ServiceId=l.ServiceId  Where sr.IsPackage=1 AND sr.ParentId= "+s
        Else
            selectString = "SELECT sr.*,l.AreaId FROM (SELECT Services.*,ServiceRates.RetailPrice  FROM Services left join ServiceRates on Services.ServiceId = ServiceRates.ServiceId ) as sr left join  ServiceLocations l on sr.ServiceId=l.ServiceId  Where sr.IsPackage=1 AND sr.ParentId="+s+" AND  l.AreaId=" + areaId.ToString()
        End If




        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        Dim currentItemNumber as Integer = 1



        While reader.Read()

            Dim serviceTitle = String.Empty
            Dim serviceSubTitle = String.Empty
            Dim description = string.empty
            Dim ServiceType = string.empty
            Dim HomeImage = String.Empty
            Dim Active = String.Empty
            Dim Inactive = String.Empty



            if Not reader("BigIconOne") Is Nothing Then
                If Not String.isNullOrEmpty(reader("BigIconOne").ToString()) Then
                    HomeImage = rootUrlForAndroid + reader("BigIconOne").ToString()
                End If

            End If

            if Not reader("SmallIconTwo") Is Nothing Then
                If Not String.isNullOrEmpty(reader("SmallIconTwo").ToString()) Then
                    Inactive = rootUrlForAndroid + reader("SmallIconTwo").ToString()
                End If

            End If

            if Not reader("SmallIconOne") Is Nothing Then

                If Not String.isNullOrEmpty(reader("SmallIconOne").ToString()) Then
                    Active = rootUrlForAndroid + reader("SmallIconOne").ToString()
                End If

            End If


            'rootUrlForAndroid +  //in
            'rootUrlForAndroid + reader("SmallIconOne").ToString()





            if context.Request.Params("lang").Equals("en") then
                serviceTitle = reader("Title").ToString()
                serviceSubTitle = reader("SubTitle").ToString()
                description = reader("Description").ToString()
            Else If context.Request.Params("lang").Equals("ar") then
                serviceTitle = reader("ArTitle").ToString()
                serviceSubTitle = reader("ArSubTitle").ToString()
                description = reader("ArDescription").ToString()
            End If


            If reader("IsPackage").ToString() = true Then
                ServiceType = "package"
            Else
                ServiceType = "service"
            End If

      
            if currentItemNumber = 1 then
                countries += " { ""serviceId"" : " + reader("ServiceId").ToString() + ",""serviceType"" : """ + serviceType + """,""title"" : """ + serviceTitle + """,""homeImage"" : """ + HomeImage + """,""width"" : " + reader("BigIconWidth").ToString() + ",""height"" : " + reader("BigIconHeight").ToString() + ",""aspectRatio"" : 0,""inactiveIcon"" : """ + Inactive + """,""activeIcon"" : """ + Active + """,""serviceRate"" : " + IIF(reader("RetailPrice") IS Nothing, 0, reader("RetailPrice").ToString()).ToString() + ",""child"" : [" + GetChilds(reader("ServiceId").ToString()) + "]}" '
            else
                countries += ", { ""serviceId"" : " + reader("ServiceId").ToString() + ",""serviceType"" : """ + serviceType + """,""title"" : """ + serviceTitle + """,""homeImage"" : """ + HomeImage + """,""width"" : " + reader("BigIconWidth").ToString() + ",""height"" : " + reader("BigIconHeight").ToString() + ",""aspectRatio"" : 0,""inactiveIcon"" : """ + Inactive + """,""activeIcon"" : """ + Active + """,""serviceRate"" : " + IIF(reader("RetailPrice") IS Nothing, 0, reader("RetailPrice").ToString()).ToString() + ",""child"" : [" + GetChilds(reader("ServiceId").ToString()) + "]}" '
            End If
            currentItemNumber += 1
        End While

        reader.Close()
        conn.Close()
        Return countries
    End Function


    Private Function GetServices() As String
        Dim rootUrlForAndroid As String = System.Configuration.ConfigurationManager.AppSettings("rootUrlForAndroid").ToString()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim countries as String = ""
        Dim selectString = ""
        Dim areaId = 0

        Integer.tryParse(context.Request.Params("areaId"), areaId)
        conn.Open()


        If areaId = 0 then
            selectString = "SELECT sr.*,l.AreaId FROM (SELECT Services.*,ServiceRates.RetailPrice  FROM Services left join ServiceRates on Services.ServiceId = ServiceRates.ServiceId ) as sr left join  ServiceLocations l on sr.ServiceId=l.ServiceId  Where sr.IsPackage=0 AND sr.ParentId=0 "
        Else
            selectString = "SELECT sr.*,l.AreaId FROM (SELECT Services.*,ServiceRates.RetailPrice  FROM Services left join ServiceRates on Services.ServiceId = ServiceRates.ServiceId ) as sr left join  ServiceLocations l on sr.ServiceId=l.ServiceId  Where sr.IsPackage=0 AND sr.ParentId=0 AND  l.AreaId=" + areaId.ToString()
        End If




        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        Dim currentItemNumber as Integer = 1



        While reader.Read()

            Dim serviceTitle = String.Empty
            Dim serviceSubTitle = String.Empty
            Dim description = string.empty
            Dim ServiceType = string.empty
            Dim HomeImage = String.Empty
            Dim Active = String.Empty
            Dim Inactive = String.Empty



            if Not reader("BigIconOne") Is Nothing Then
                If Not String.isNullOrEmpty(reader("BigIconOne").ToString()) Then
                    HomeImage = rootUrlForAndroid + reader("BigIconOne").ToString()
                End If

            End If

            if Not reader("SmallIconTwo") Is Nothing Then
                If Not String.isNullOrEmpty(reader("SmallIconTwo").ToString()) Then
                    Inactive = rootUrlForAndroid + reader("SmallIconTwo").ToString()
                End If

            End If

            if Not reader("SmallIconOne") Is Nothing Then

                If Not String.isNullOrEmpty(reader("SmallIconOne").ToString()) Then
                    Active = rootUrlForAndroid + reader("SmallIconOne").ToString()
                End If

            End If


            'rootUrlForAndroid +  //in
            'rootUrlForAndroid + reader("SmallIconOne").ToString()





            if context.Request.Params("lang").Equals("en") then
                serviceTitle = reader("Title").ToString()
                serviceSubTitle = reader("SubTitle").ToString()
                description = reader("Description").ToString()
            Else If context.Request.Params("lang").Equals("ar") then
                serviceTitle = reader("ArTitle").ToString()
                serviceSubTitle = reader("ArSubTitle").ToString()
                description = reader("ArDescription").ToString()
            End If


            If reader("IsPackage").ToString() = true Then
                ServiceType = "package"
            Else
                ServiceType = "service"
            End If

      
            if currentItemNumber = 1 then
                countries += " { ""serviceId"" : " + reader("ServiceId").ToString() + ",""serviceType"" : """ + serviceType + """,""title"" : """ + serviceTitle + """,""homeImage"" : """ + HomeImage + """,""width"" : " + reader("BigIconWidth").ToString() + ",""height"" : " + reader("BigIconHeight").ToString() + ",""aspectRatio"" : 0,""inactiveIcon"" : """ + Inactive + """,""activeIcon"" : """ + Active + """,""serviceRate"" : " + IIF(reader("RetailPrice") IS Nothing, 0, reader("RetailPrice").ToString()).ToString() + ",""child"" : [" + GetChilds(reader("ServiceId").ToString()) + "]}" '
            else
                countries += ", { ""serviceId"" : " + reader("ServiceId").ToString() + ",""serviceType"" : """ + serviceType + """,""title"" : """ + serviceTitle + """,""homeImage"" : """ + HomeImage + """,""width"" : " + reader("BigIconWidth").ToString() + ",""height"" : " + reader("BigIconHeight").ToString() + ",""aspectRatio"" : 0,""inactiveIcon"" : """ + Inactive + """,""activeIcon"" : """ + Active + """,""serviceRate"" : " + IIF(reader("RetailPrice") IS Nothing, 0, reader("RetailPrice").ToString()).ToString() + ",""child"" : [" + GetChilds(reader("ServiceId").ToString()) + "]}" '
            End If
            currentItemNumber += 1
        End While

        reader.Close()
        conn.Close()
        Return countries
    End Function

    Private Function GetChilds(s As String) As string

        Dim rootUrlForAndroid As String = System.Configuration.ConfigurationManager.AppSettings("rootUrlForAndroid").ToString()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim countries as String = ""
        Dim selectString as String = ""
        conn.Open()
        Dim areaId = 0
        Integer.tryParse(context.Request.Params("areaId"), areaId)

        If areaId = 0 then
            selectString = "SELECT sr.*,l.AreaId FROM (SELECT Services.*,ServiceRates.RetailPrice  FROM Services left join ServiceRates on Services.ServiceId = ServiceRates.ServiceId ) as sr left join  ServiceLocations l on sr.ServiceId=l.ServiceId  Where sr.IsPackage=0  AND sr.ParentId=" + s
        Else
            selectString = "SELECT sr.*,l.AreaId FROM (SELECT Services.*,ServiceRates.RetailPrice  FROM Services left join ServiceRates on Services.ServiceId = ServiceRates.ServiceId ) as sr left join  ServiceLocations l on sr.ServiceId=l.ServiceId   Where sr.IsPackage=0 AND sr.ParentId=" + s + "AND  l.AreaId=" + context.Request.Params("areaId")
        End If




        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        Dim currentItemNumber as Integer = 1



        While reader.Read()

            Dim serviceTitle = String.Empty
            Dim serviceSubTitle = String.Empty
            Dim description = string.empty
            Dim ServiceType = string.empty
            Dim HomeImage = String.Empty
            Dim Active = String.Empty
            Dim Inactive = String.Empty




            if Not reader("BigIconOne") Is Nothing Then
                If Not String.isNullOrEmpty(reader("BigIconOne").ToString()) Then
                    HomeImage = rootUrlForAndroid + reader("BigIconOne").ToString()
                End If

            End If

            if Not reader("SmallIconTwo") Is Nothing Then
                If Not String.isNullOrEmpty(reader("SmallIconTwo").ToString()) Then
                    Inactive = rootUrlForAndroid + reader("SmallIconTwo").ToString()
                End If

            End If

            if Not reader("SmallIconOne") Is Nothing Then

                If Not String.isNullOrEmpty(reader("SmallIconOne").ToString()) Then
                    Active = rootUrlForAndroid + reader("SmallIconOne").ToString()
                End If

            End If


            If reader("IsPackage").ToString() = true Then
                ServiceType = "package"
            Else
                ServiceType = "service"
            End If


            if context.Request.Params("lang").Equals("en") then
                serviceTitle = reader("Title").ToString()
                serviceSubTitle = reader("SubTitle").ToString()
                description = reader("Description").ToString()
            Else If context.Request.Params("lang").Equals("ar") then
                serviceTitle = reader("ArTitle").ToString()
                serviceSubTitle = reader("ArSubTitle").ToString()
                description = reader("ArDescription").ToString()
            End If

            if currentItemNumber = 1 then
                countries += " { ""serviceId"" : " + reader("ServiceId").ToString() + ",""serviceType"" : """ + serviceType + """,""title"" : """ + serviceTitle + """,""homeImage"" : """ + HomeImage + """,""width"" : " + reader("BigIconWidth").ToString() + ",""height"" : " + reader("BigIconHeight").ToString() + ",""aspectRatio"" : 0,""inactiveIcon"" : """ + Inactive + """,""activeIcon"" : """ + Active + """,""serviceRate"" : " + IIF(reader("RetailPrice") IS Nothing, 0, reader("RetailPrice")).ToString() + ",""child"" : [" + GetSubChilds(reader("ServiceId").ToString()) + "]}" '
                
                
            else
                countries += ", { ""serviceId"" : " + reader("ServiceId").ToString() + ",""serviceType"" : """ + serviceType + """,""title"" : """ + serviceTitle + """,""homeImage"" : """ + HomeImage + """,""width"" : " + reader("BigIconWidth").ToString() + ",""height"" : " + reader("BigIconHeight").ToString() + ",""aspectRatio"" : 0,""inactiveIcon"" : """ + Inactive + """,""activeIcon"" : """ + Active + """,""serviceRate"" : " + IIF(reader("RetailPrice") IS Nothing, 0, reader("RetailPrice").ToString()).ToString() + ",""child"" : [" + GetSubChilds(reader("ServiceId").ToString()) + "]}" '
            End If
            currentItemNumber += 1
        End While

        reader.Close()
        conn.Close()
        Return countries
    End Function

    Private Function GetSubChilds(s As String) As String
        Dim rootUrlForAndroid As String = System.Configuration.ConfigurationManager.AppSettings("rootUrlForAndroid").ToString()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim countries as String = ""
        Dim selectString as String = ""

        conn.Open()

        Dim areaId = 0
        Integer.tryParse(context.Request.Params("areaId"), areaId)

        If areaId = 0 then
            selectString = "SELECT sr.*,l.AreaId FROM (SELECT Services.*,ServiceRates.RetailPrice  FROM Services left join ServiceRates on Services.ServiceId = ServiceRates.ServiceId ) as sr left join  ServiceLocations l on sr.ServiceId=l.ServiceId  Where sr.IsPackage=0  AND sr.ParentId=" + s
        Else
            selectString = "SELECT sr.*,l.AreaId FROM (SELECT Services.*,ServiceRates.RetailPrice  FROM Services left join ServiceRates on Services.ServiceId = ServiceRates.ServiceId ) as sr left join  ServiceLocations l on sr.ServiceId=l.ServiceId   Where sr.IsPackage=0 AND sr.ParentId=" + s + "AND  l.AreaId=" + context.Request.Params("areaId")
        End If

        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        Dim currentItemNumber as Integer = 1



        While reader.Read()

            Dim serviceTitle = String.Empty
            Dim serviceSubTitle = String.Empty
            Dim description = string.empty
            Dim ServiceType = string.empty
            Dim HomeImage = String.Empty
            Dim Active = String.Empty
            Dim Inactive = String.Empty



            if Not reader("BigIconOne") Is Nothing Then
                If Not String.isNullOrEmpty(reader("BigIconOne").ToString()) Then
                    HomeImage = rootUrlForAndroid + reader("BigIconOne").ToString()
                End If

            End If

            if Not reader("SmallIconTwo") Is Nothing Then
                If Not String.isNullOrEmpty(reader("SmallIconTwo").ToString()) Then
                    Inactive = rootUrlForAndroid + reader("SmallIconTwo").ToString()
                End If

            End If

            if Not reader("SmallIconOne") Is Nothing Then

                If Not String.isNullOrEmpty(reader("SmallIconOne").ToString()) Then
                    Active = rootUrlForAndroid + reader("SmallIconOne").ToString()
                End If

            End If



            If reader("IsPackage").ToString() = true Then
                ServiceType = "package"
            Else
                ServiceType = "service"
            End If

            if context.Request.Params("lang").Equals("en") then
                serviceTitle = reader("Title").ToString()
                serviceSubTitle = reader("SubTitle").ToString()
                description = reader("Description").ToString()
            Else If context.Request.Params("lang").Equals("ar") then
                serviceTitle = reader("ArTitle").ToString()
                serviceSubTitle = reader("ArSubTitle").ToString()
                description = reader("ArDescription").ToString()
            End If

            if currentItemNumber = 1 then
                countries += " { ""serviceId"" : " + reader("ServiceId").ToString() + ",""serviceType"" : """ + serviceType + """,""title"" : """ + serviceTitle + """,""homeImage"" : """ + HomeImage + """,""width"" : " + reader("BigIconWidth").ToString() + ",""height"" : " + reader("BigIconHeight").ToString() + ",""aspectRatio"" : 0,""inactiveIcon"" : """ + Inactive + """,""activeIcon"" : """ + Active + """,""serviceRate"" : " + IIF(reader("RetailPrice") IS Nothing, 0, reader("RetailPrice").ToString()).ToString() + ",""child"" : []}" '
                


            else
                countries += ", { ""serviceId"" : " + reader("ServiceId").ToString() + ",""serviceType"" : """ + serviceType + """,""title"" : """ + serviceTitle + """,""homeImage"" : """ + HomeImage + """,""width"" : " + reader("BigIconWidth").ToString() + ",""height"" : " + reader("BigIconHeight").ToString() + ",""aspectRatio"" : 0,""inactiveIcon"" : """ + Inactive + """,""activeIcon"" : """ + Active + """,""serviceRate"" : " + IIF(reader("RetailPrice") IS Nothing, 0, reader("RetailPrice").ToString()).ToString() + ",""child"" : []}" '
            End If
            currentItemNumber += 1
        End While

        reader.Close()
        conn.Close()
        Return countries
    End Function

    Private Function GetBanners() as String
        Dim rootUrlForAndroid As String = System.Configuration.ConfigurationManager.AppSettings("rootUrlForAndroid").ToString()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        Dim countries as String
        conn.Open()
        Dim selectString = "SELECT * FROM Banners "
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()
        Dim currentItemNumber as Integer = 1

        While reader.Read()

            Dim bannerTitle = String.Empty
            Dim BannerImage = String.Empty



            if Not reader("Image") Is Nothing Then
                If Not String.isNullOrEmpty(reader("Image").ToString()) Then
                    BannerImage = rootUrlForAndroid + reader("Image").ToString()
                End If

            End If


            if context.Request.Params("lang").Equals("en") then
                bannerTitle = reader("BannerTitle").ToString()
            Else If context.Request.Params("lang").Equals("ar") then
                bannerTitle = reader("ArBannerTitle").ToString()
            End If

            if currentItemNumber = 1 then
                countries += " { ""bannerId"" : " + reader("BannerId").ToString() + ",""bannerTitle"" : """ + bannerTitle + """,""bannerImage"" : """ + BannerImage + """}"
            else
                countries += " ,{ ""bannerId"" : " + reader("BannerId").ToString() + ",""bannerTitle"" : """ + bannerTitle + """,""bannerImage"" : """ + BannerImage + """}"
            End If
            currentItemNumber += 1
        End While

        reader.Close()
        conn.Close()
        Return countries
    End Function


    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class