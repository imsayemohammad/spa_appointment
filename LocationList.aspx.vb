
Imports System.Data.SqlClient

Partial Class LocationList
    Inherits System.Web.UI.Page










    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")

        If userID = 0 Then
            Response.Redirect("/login")
        End If

        If Not IsPostBack Then
            LoadLocations()
        End If

    End Sub

    Protected Sub SaveCountryData(sender As Object, e As EventArgs) Handles btnsubmit.Click




        If Not String.IsNullOrEmpty(LocationName.Text) Or Not String.IsNullOrEmpty(City.Text) Or Not String.IsNullOrEmpty(Zip.Text) Or Not String.IsNullOrEmpty(State.Text) Then


            Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

            conn.Open()



            Dim userID As Integer = Utility.IntegerData("SELECT TOP 1 UserId FROM UserLog_Data Where SessionId='" & System.Web.HttpContext.Current.Session.SessionID & "' Order By SessionId DESC")

            Dim M As Integer
            Dim selectString = ""
            Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)

            If Not String.IsNullOrEmpty(hidLocationId.Value) Then

                selectString = "UPDATE  [Areas] SET AreaName=@LocationName,ArAreaName=@ArabicLocationName,Phone=@Phone,Email=@Email, [Description]=@Description,City=@City,ZipCode=@ZipCode,State=@State,UpdatedBy=@CreateBy,UpdatedDate=GETDATE(),AreaStatus=@AreaStatus,Latitude=@Latitude,Longitude=@Longitude Where AreaId=@LocationId "
                cmd.Parameters.Add("LocationId", Data.SqlDbType.BigInt).Value = hidLocationId.Value
            Else

                selectString = "INSERT INTO [Areas] (AreaName,Phone,Email, [Description],City,ZipCode,State,CreateDate,CreatedBy,AreaStatus,ArAreaName,Latitude,Longitude) VALUES (@LocationName,@Phone,@Email, @Description,@City,@ZipCode,@State,getdate(),@CreateBy,@AreaStatus,@ArabicLocationName,@Latitude,@Longitude)"
            End If







            cmd.Parameters.Add("LocationName", Data.SqlDbType.NVarChar).Value = LocationName.Text
            cmd.Parameters.Add("Phone", Data.SqlDbType.NVarChar).Value = ContactNumber.Text
            cmd.Parameters.Add("Email", Data.SqlDbType.NVarChar).Value = ContactEmail.Text
            cmd.Parameters.Add("Description", Data.SqlDbType.NVarChar).Value = " "
            cmd.Parameters.Add("ArabicLocationName", Data.SqlDbType.NVarChar).Value = ArabicLocationName.Text

            cmd.Parameters.Add("City", Data.SqlDbType.NVarChar).Value = City.Text
            cmd.Parameters.Add("ZipCode", Data.SqlDbType.NVarChar).Value = Zip.Text
            cmd.Parameters.Add("State", Data.SqlDbType.NVarChar).Value = State.Text
            cmd.Parameters.Add("CreateBy", Data.SqlDbType.BigInt).Value = userID
            cmd.Parameters.Add("AreaStatus", Data.SqlDbType.Bit).Value = 1

            cmd.Parameters.Add("Latitude", Data.SqlDbType.Decimal).Value = txtLatitude.Text
            cmd.Parameters.Add("Longitude", Data.SqlDbType.Decimal).Value = txtLongitude.Text



            cmd.CommandText = selectString

            M = cmd.ExecuteNonQuery




            conn.Close()



            If M > 0 Then

                LoadLocations()
            End If
        End If





    End Sub









    Public Sub LoadLocations()

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        Dim literalString As String

        conn.Open()

        Dim selectString = "SELECT * FROM  Areas"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)

        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()



        While reader.Read()

            literalString += "<tr>"
            literalString += " <td><a href='#'>" + reader("AreaName").ToString() + "</a></td>"
            literalString += " <td><a href='#'>" + reader("Phone").ToString() + "</a></td>"
            literalString += " <td><a href='#'>" + reader("Email").ToString() + "</a></td>"
            literalString += " <td><a href='#'>" + reader("City").ToString() + "</a></td>"
            literalString += " <td><a href='#'>" + reader("State").ToString() + "</a></td>"
            literalString += " <td><a href='#'>" + reader("ZipCode").ToString() + "</a></td>"



            literalString += " <td> <a href='#' onclick='GetLocationById(" + reader("AreaId").ToString() + ")' data-toggle='modal' data-target='#addeditclientmodal'>  <img src='images/icons/ic-edit.png' /></a></a>|<a href='#' onclick='DeleteLocationById(" + reader("AreaId").ToString() + ")' >  <img src='images/icons/ic-delete.png' /></a></a></td> "

        End While

        reader.Close()
        conn.Close()

        ltrLocation.Text = literalString

    End Sub






    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteLocationById(ByVal LocationId As String)
        Dim M As Integer
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        Dim totalAreaPoints As Integer
        Dim totalAreaServices As Integer
        Dim totalZones As Integer
        Dim totalServiceLocations As Integer
        Dim totalStaffServiceLocations As Integer




        conn.Open()
        Dim selectString = "SELECT COUNT(AreaId) FROM AreaPoints WHERE AreaId=@s"
        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = LocationId
        totalAreaPoints = cmd.ExecuteScalar()
        conn.Close()

        conn.Open()
        selectString = " SELECT  COUNT(AreaId) FROM Zones WHERE AreaId=@s"
        cmd = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = LocationId
        totalAreaServices = cmd.ExecuteScalar()
        conn.Close()

        conn.Open()
        selectString = "SELECT COUNT(AreaId) FROM AreaServices WHERE AreaId=@s"
        cmd = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = LocationId
        totalZones = cmd.ExecuteScalar()
        conn.Close()


        conn.Open()
        selectString = "SELECT COUNT(AreaId) FROM ServiceLocations WHERE AreaId=@s"
        cmd = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = LocationId
        totalServiceLocations = cmd.ExecuteScalar()
        conn.Close()


        conn.Open()
        selectString = "SELECT COUNT(AreaId) FROM StaffServiceLocations WHERE AreaId=@s"
        cmd = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = LocationId
        totalStaffServiceLocations = cmd.ExecuteScalar()
        conn.Close()


        If totalAreaPoints = 0 And totalAreaServices = 0 And totalZones = 0 And totalServiceLocations = 0 And totalStaffServiceLocations = 0 Then
            conn.Open()

            selectString = "DELETE Areas Where AreaId=@s"
            cmd = New SqlCommand(selectString, conn)

            cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = LocationId
            M = cmd.ExecuteNonQuery()
            conn.Close()
            Return "Deleted Successfully"
        Else

            Dim returnString As String = "Can Not Delete Because this Area Has Been Used In "
            If Not totalAreaPoints = 0 Then
                returnString += totalAreaPoints.ToString() + "  Area Points "
            End If

            If Not totalAreaServices = 0 Then
                returnString += totalAreaServices.ToString() + " Area Services "

            End If

            If Not totalZones = 0 Then
                returnString += totalZones.ToString() + " Zones  "
            End If

            If Not totalServiceLocations = 0 Then
                returnString += totalServiceLocations.ToString() + " Service Locations "
            End If
            If Not totalStaffServiceLocations = 0 Then
                returnString += totalStaffServiceLocations.ToString() + " Staff Service Locations  "
            End If

            Return returnString
        End If







    End Function




    'GetLocationById
    <System.Web.Services.WebMethod()>
    Public Shared Function GetLocationById(LocationId As String)



        Dim location = New Location()
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)

        conn.Open()

        Dim selectString = "SELECT  top 1 * FROM Areas Where AreaId=@s"

        Dim cmd As SqlCommand = New SqlCommand(selectString, conn)
        cmd.Parameters.Add("@s", Data.SqlDbType.Int).Value = LocationId

        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()



        While reader.Read()


            location.LocationName = reader("AreaName").ToString()
            location.LocationId = reader("AreaId").ToString()
            location.Phone = reader("Phone").ToString()
            location.Email = reader("Email").ToString()
            location.City = reader("City").ToString()
            location.State = reader("State").ToString()
            location.ZipCode = reader("ZipCode").ToString()
            location.ArabicLocationName = reader("ArAreaName").ToString()
            location.Latitude = reader("Latitude").ToString()
            location.Longitude = reader("Longitude").ToString()

        End While

        reader.Close()
        conn.Close()

        Return location

    End Function


    Class Location
        Public Property LocationName() As String
        Public Property Phone() As String
        Public Property Email() As String
        Public Property City() As String
        Public Property State() As String
        Public Property ZipCode() As String
        Public Property LocationId() As String
        Public Property ArabicLocationName() As String

        Public Property Latitude() As String
        Public Property Longitude() As String
    End Class











End Class
