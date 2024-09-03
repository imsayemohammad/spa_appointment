<%@ WebHandler Language="VB" Class="Rating" %>

Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web

Public Class Rating : Implements IHttpHandler

    Dim context As HttpContext

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Me.context = context
        Dim json = Me.SaveRating()
        json = String.Format("{0}", json)
        context.Response.ContentType = "text/json"
        context.Response.Write(json)
    End Sub




    Private Function SaveRating() As String

        'ClientId,StaffId,ServiceId,ServiceRequestMasterId,Rating,Comment,ArComment
        'clientId,staffId,serviceId,serviceRequestMasterId,rating,comment,arComment



        If Not String.IsNullOrEmpty(context.Request.Params("clientId")) Or Not String.IsNullOrEmpty(context.Request.Params("staffId")) Or Not String.IsNullOrEmpty(context.Request.Params("serviceRequestMasterId")) Or Not String.IsNullOrEmpty(context.Request.Params("rating")) Then

            If RatingExists() = true Then
                Dim Result = UpdateRatings()
                Return Result
            Else

                Dim Result = SaveNewRating()
                Return Result
            End If



        End If


        'context.Response.Write("{ ""data"" : { ""ratingId"":""" + M.ToString() + """,""title"":""Saved Successfully"" }, ""code"": ""201"" ,""message"": ""Succesfully Inserted"",""isSuccess"": true } ")

    End Function

    Private Function RatingExists() As Boolean
        Dim M As String = ""
        Dim id as Integer = 0

        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()

        Dim selectString = ""
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)

        if context.Request.Params("ratingType").Equals("forClientRating") then
            selectString = "SELECT ClientRatingId FROM  ClientRatings WHERE ClientId=@ClientId AND StaffId=@StaffId AND ServiceId=@ServiceId AND ServiceRequestMasterId=@ServiceRequestMasterId "
        Else if context.Request.Params("ratingType").Equals("forStaffRating") then
            selectString = "SELECT StaffRatingId FROM  StaffRatings WHERE ClientId=@ClientId AND StaffId=@StaffId AND ServiceId=@ServiceId AND ServiceRequestMasterId=@ServiceRequestMasterId"
        End If


        cmd.Parameters.Add("ClientId", Data.SqlDbType.Bigint).Value = context.Request.Params("clientId")
        cmd.Parameters.Add("StaffId", Data.SqlDbType.Bigint).Value = context.Request.Params("staffId")
        cmd.Parameters.Add("ServiceId", Data.SqlDbType.Bigint).Value = context.Request.Params("serviceId")
        cmd.Parameters.Add("ServiceRequestMasterId", Data.SqlDbType.Bigint).Value = context.Request.Params("serviceRequestMasterId")


        cmd.CommandText = selectString

        Dim reader As Data.SqlClient.SqlDataReader = cmd.ExecuteReader()

        While reader.Read()
            if context.Request.Params("ratingType").Equals("forClientRating") then
                If Not reader("ClientRatingId") Is Nothing then
                    M = reader("ClientRatingId").ToString()
                End If

            Else if context.Request.Params("ratingType").Equals("forStaffRating") then
                If Not reader("StaffRatingId") Is Nothing then
                    M = reader("StaffRatingId").ToString()
                End If
            End If
        End While

        reader.Close()
        conn.Close()

        Integer.TryParse(M, Id)

        If Id = 0 then
            Return False
        Else
            Return True
        End If
    End Function

    Private Function UpdateRatings() As String
        Dim M As Integer = 0
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()

        Dim selectString = ""
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)


        if context.Request.Params("ratingType").Equals("forClientRating") then
            selectString = "UPDATE ClientRatings   SET ClientId=@ClientId,StaffId=@StaffId,ServiceId=@ServiceId,ServiceRequestMasterId=@ServiceRequestMasterId,Rating=@Rating,Comment=@Comment,ArComment=@ArComment,Status=1,UpdatedAt=GETDATE()  WHERE ClientId=@ClientId AND StaffId=@StaffId AND ServiceId=@ServiceId AND ServiceRequestMasterId=@ServiceRequestMasterId   "
        Else if context.Request.Params("ratingType").Equals("forStaffRating") then
            selectString = "UPDATE StaffRatings SET ClientId=@ClientId,StaffId=@StaffId,ServiceId=@ServiceId,ServiceRequestMasterId=@ServiceRequestMasterId,Rating=@Rating,Comment=@Comment,ArComment=@ArComment,Status=1,UpdatedAt=GETDATE()   WHERE ClientId=@ClientId AND StaffId=@StaffId AND ServiceId=@ServiceId AND ServiceRequestMasterId=@ServiceRequestMasterId  "
        End If


        'If context.Request.Params("lang").Equals("en") then
        cmd.Parameters.Add("Comment", Data.SqlDbType.NVARCHAR).Value = context.Request.Params("comment")
        cmd.Parameters.Add("ArComment", Data.SqlDbType.NVARCHAR).Value = DBNULL.VALUE
        ' Else If context.Request.Params("lang").Equals("ar") then
        'End IF



        cmd.Parameters.Add("ClientId", Data.SqlDbType.Bigint).Value = context.Request.Params("clientId")
        cmd.Parameters.Add("StaffId", Data.SqlDbType.Bigint).Value = context.Request.Params("staffId")
        cmd.Parameters.Add("ServiceId", Data.SqlDbType.Bigint).Value = context.Request.Params("serviceId")
        cmd.Parameters.Add("ServiceRequestMasterId", Data.SqlDbType.Bigint).Value = context.Request.Params("serviceRequestMasterId")
        cmd.Parameters.Add("Rating", Data.SqlDbType.NVARCHAR).Value = context.Request.Params("rating")

        ' cmd.Parameters.Add("@id", Data.SqlDbType.Int).Direction = ParameterDirection.Output

        cmd.CommandText = selectString
        M = cmd.ExecuteNonQuery()


        conn.Close()


        If M > 0 Then
            context.Response.Write("{ ""data"" : { ""title"":""Updated Successfully"" }, ""code"": 201 ,""message"": ""Succesfully Done"",""isSuccess"": true } ")
        else
            context.Response.Write("{ ""data"" : { ""title"":""Saved Successfully"" }, ""code"": 200 ,""message"": ""Operation Failed"",""isSuccess"": true } ")
        End If
    End Function

    Private Function SaveNewRating() as String

        Dim M As Integer = 0
        Dim conn As New Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString").ToString)
        conn.Open()

        Dim selectString = ""
        Dim cmd As Data.SqlClient.SqlCommand = New Data.SqlClient.SqlCommand(selectString, conn)


        if context.Request.Params("ratingType").Equals("forClientRating") then
            selectString = "INSERT INTO ClientRatings(ClientId,StaffId,ServiceId,ServiceRequestMasterId,Rating,Comment,ArComment,Status,UpdatedAt) VALUES (@ClientId,@StaffId,@ServiceId,@ServiceRequestMasterId,@Rating,@Comment,@ArComment,1,GETDATE()) SET @id = SCOPE_IDENTITY() "
        Else if context.Request.Params("ratingType").Equals("forStaffRating") then
            selectString = "INSERT INTO StaffRatings(ClientId,StaffId,ServiceId,ServiceRequestMasterId,Rating,Comment,ArComment,Status,UpdatedAt)  VALUES (@ClientId,@StaffId,@ServiceId,@ServiceRequestMasterId,@Rating,@Comment,@ArComment,1,GETDATE()) SET @id = SCOPE_IDENTITY()"
        End If


        'If context.Request.Params("lang").Equals("en") then
        cmd.Parameters.Add("Comment", Data.SqlDbType.NVARCHAR).Value = context.Request.Params("comment")
        cmd.Parameters.Add("ArComment", Data.SqlDbType.NVARCHAR).Value = DBNULL.VALUE
        ' Else If context.Request.Params("lang").Equals("ar") then
        'End IF



        cmd.Parameters.Add("ClientId", Data.SqlDbType.Bigint).Value = context.Request.Params("clientId")
        cmd.Parameters.Add("StaffId", Data.SqlDbType.Bigint).Value = context.Request.Params("staffId")
        cmd.Parameters.Add("ServiceId", Data.SqlDbType.Bigint).Value = context.Request.Params("serviceId")
        cmd.Parameters.Add("ServiceRequestMasterId", Data.SqlDbType.Bigint).Value = context.Request.Params("serviceRequestMasterId")
        cmd.Parameters.Add("Rating", Data.SqlDbType.NVARCHAR).Value = context.Request.Params("rating")

        cmd.Parameters.Add("@id", Data.SqlDbType.Int).Direction = ParameterDirection.Output

        cmd.CommandText = selectString
        cmd.ExecuteScalar()
        M = CInt(cmd.Parameters("@id").Value)
        conn.Close()


        If M > 0 Then
            context.Response.Write("{ ""data"" : { ""ratingId"":""" + M.ToString() + """,""title"":""Saved Successfully"" }, ""code"": 201 ,""message"": ""Succesfully Inserted"",""isSuccess"": true } ")
        else
            context.Response.Write("{ ""data"" : { ""ratingId"":""" + M.ToString() + """,""title"":""Saved Successfully"" }, ""code"": 200 ,""message"": ""Failed To  Inserted"",""isSuccess"": true } ")
        End If
    End Function


    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class