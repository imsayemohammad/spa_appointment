Imports Microsoft.VisualBasic

Public Class Pager

    Private m_PresentPageNum As Integer = 1
    Private m_TotalNumOfPage As Integer = 2
    Private m_TotalPageNumToShow As Integer = 5
    Private m_urlToNavigateWithQStr As [String]
    Private _pagerString As [String] = ""

    ''' <summary>
    ''' 
    ''' </summary>
    ''' <value></value>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public ReadOnly Property GetPager() As [String]
        Get
            
            Return _pagerString
        End Get

    End Property

   


    ''' <summary>
    ''' This is a simple curcular pager. If you are at first page and press on prev, 
    ''' it will take you to the last page and vice verca. The current pager is generally 
    ''' get the middle position except it's nearer to the boundary which is determined 
    ''' by a number= Math.Floor(totalPageNumToShow/2)
    ''' </summary>
    ''' <param name="presentPageNum">present Page Number</param>
    ''' <param name="totalNumOfPage ">total Num Of Page  </param>
    ''' <param name="totalPageNumToShow">Give odd number of pages except 1 to get best paging</param>
    ''' <param name="urlToNavigateWithQStr">example of this variable: example.aspx?page=</param>
    ''' <remarks>If you get any bug, please tell me</remarks>
    Public Sub New(ByVal presentPageNum As Integer, ByVal totalNumOfPage As Integer, ByVal totalPageNumToShow As Integer, ByVal urlToNavigateWithQStr As String)

        PaginationMain(presentPageNum, totalNumOfPage, totalPageNumToShow, urlToNavigateWithQStr, "")

    End Sub
    Public Sub New(ByVal presentPageNum As Integer, ByVal totalNumOfPage As Integer, ByVal totalPageNumToShow As Integer, ByVal urlToNavigateWithQStr As String, ByVal anchorWord As String)

        PaginationMain(presentPageNum, totalNumOfPage, totalPageNumToShow, urlToNavigateWithQStr, anchorWord)

    End Sub

    Private Sub PaginationMain(ByVal presentPageNum As Integer, ByVal totalNumOfPage As Integer, ByVal totalPageNumToShow As Integer, ByVal urlToNavigateWithQStr As String, ByVal anchorWord As String)

        Dim i As Integer
        Dim loopStartNum, loopEndNum, presentNum, maxShownNum As Integer
        Dim pagerString As String = ""
        presentNum = presentPageNum
        maxShownNum = totalPageNumToShow
        Dim middleFactor As Integer = maxShownNum / 2
        pagerString = "<ul class=""unstyled"">"
        If totalNumOfPage <= totalPageNumToShow Then
            loopStartNum = 1
            loopEndNum = totalNumOfPage
            'pagerString = pagerString & "<div><a href=""" & urlToNavigateWithQStr & "1"">First</a></div>"
            pagerString = pagerString & "<li><a href=""" & urlToNavigateWithQStr & If(presentNum <= 1, totalNumOfPage, (presentNum - 1)) & If(anchorWord <> "", "#" & anchorWord, "") & """><</a></li>"
            For i = loopStartNum To loopEndNum
                If (i = presentNum) Then
                    pagerString = pagerString & "<li class=""active""><a href=""javascript:;"">" & i & "</a></li>"
                Else
                    pagerString = pagerString & "<li><a href=""" & urlToNavigateWithQStr & i & If(anchorWord <> "", "#" & anchorWord, "") & """>" & i & "</a></li>"
                End If
            Next
            pagerString = pagerString & "<li><a href=""" & urlToNavigateWithQStr & If(presentNum = totalNumOfPage, 1, (presentNum + 1)) & If(anchorWord <> "", "#" & anchorWord, "") & """>></a></li>"
            ' pagerString = pagerString & "<div><a href=""" & urlToNavigateWithQStr & totalNumOfPage & """>Last</a></div>"
        Else
            loopStartNum = If(presentNum <= (middleFactor + 1), 1, If(presentNum + middleFactor >= totalNumOfPage, totalNumOfPage - (maxShownNum - 1), presentNum - middleFactor))
            loopEndNum = If(presentNum <= (middleFactor + 1), maxShownNum, If(presentNum + middleFactor >= totalNumOfPage, totalNumOfPage, presentNum + middleFactor))
            loopEndNum = If(loopEndNum > totalNumOfPage, totalNumOfPage, loopEndNum)
            'pagerString = pagerString & "<div><a href=""" & urlToNavigateWithQStr & "1"">First</a></div>"
            pagerString = pagerString & "<li><a href=""" & urlToNavigateWithQStr & If(presentNum = 1, totalNumOfPage, (presentNum - 1)) & If(anchorWord <> "", "#" & anchorWord, "") & """><</a></li>"

            If loopStartNum > 1 Then
                'give .. at the beginning
                pagerString = pagerString & "<li><a  href=""" & urlToNavigateWithQStr & (loopStartNum - 1) & If(anchorWord <> "", "#" & anchorWord, "") & """>...</a></li>"
            End If

            For i = loopStartNum To loopEndNum
                If (i = presentNum) Then
                    pagerString = pagerString & "<li class=""active""><a href=""javascript:;"">" & i & "</a></li>"
                Else
                    pagerString = pagerString & "<li><a href=""" & urlToNavigateWithQStr & i & If(anchorWord <> "", "#" & anchorWord, "") & """>" & i & "</a></li>"
                End If
            Next
            'give ... at the end
            If totalNumOfPage > loopEndNum Then
                pagerString = pagerString & "<li><a  href=""" & urlToNavigateWithQStr & i & If(anchorWord <> "", "#" & anchorWord, "") & """>...</a></li>"
            End If
            pagerString = pagerString & "<li><a href=""" & urlToNavigateWithQStr & If(presentNum = totalNumOfPage, 1, (presentNum + 1)) & If(anchorWord <> "", "#" & anchorWord, "") & """>></a></li>"
            'pagerString = pagerString & "<div><a href=""" & urlToNavigateWithQStr & totalNumOfPage & """>Last</a></div>"
        End If

        _pagerString = pagerString & "</ul>"

    End Sub

    Public Overrides Function ToString() As String
        Return _pagerString
    End Function

End Class
