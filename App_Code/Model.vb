Imports Microsoft.VisualBasic

Public Class Model
    Public Property clientid As String
    Public Property FirstName As String
    Public Property LastName As String
    Public Property dob As String
    Public Property gender As String
    Public Property Phone As String
    Public Property Telephone As String
    Public Property Email As String
    Public Property Notes As String
    Public Property refsource As String
    Public Property bookings As String
    Public Property Notification As String
    Public Property address As String
    Public Property city As String
    Public Property state As String
    Public Property zipcode As String
    Public Property suburb As String
    Public Property latitude As String
    Public Property longitude As String

    Public Property startdate As String
    Public Property enddate As String
    Public Property description As String
    Public Property Locations As String
    Public Property locationid As String
    Public Property closeddatesid As String

    Public Property whid As String
    Public Property staffid As String
    Public Property shiftstart As String
    Public Property shiftend As String
    Public Property day As String
    Public Property repeats As String
    Public Property timeduration As String
    Public Property totamount As Decimal
    Public Property retailprice As Decimal
End Class
Public Class StaffModel
    Public Property StaffId As String
    Public Property FirstName As String
    Public Property LastName As String
    Public Property Phone As String
    Public Property Email As String
    Public Property Notes As String
    Public Property StartDate As String
    Public Property EndDate As String
    Public Property Permission As String
End Class
Public Class ServiceGroupModel
    Public Property ServiceId As String
    Public Property Title As String
    Public Property Description As String
    Public Property ArTitle As String
    Public Property ArDescription As String
    Public Property ParentId As String
    Public Property Color As String
    Public Property IsPackage As String

    Public Property BigIconOne As String
    Public Property BigIconTwo As String
    Public Property SmallIconOne As String
    Public Property SmallIconTwo As String


End Class

Public Class ServiceModel
    Public Property ServiceId As String
    Public Property Title As String
    Public Property Description As String
    Public Property ArTitle As String
    Public Property ArDescription As String
    Public Property ParentId As String
    Public Property Color As String
    Public Property RequiredMins As String
    Public Property PriceType As String
    Public Property AvailableFor As String
    Public Property Tax As String
    Public Property IsEnableCommission As String
    Public Property IsExtraTimeNeeded As String
    Public Property ExtraMins As String
    Public Property SpecialPrice As String
    Public Property RetailPrice As String
    Public Property ProductCommision As String
    Public Property ServiceCommision As String
    Public Property VoucherCommision As String
    Public Property Locations As String
    Public Property hdnParentID As String

    
End Class

Public Class ServiceItemModel
    Public Property ServiceId As String
    Public Property Title As String
    Public Property ShortDescription As String
    Public Property Qty As Decimal
    Public Property PricePerItem As Decimal
    Public Property ItemTotal As Decimal


End Class
Public Class Service
    Public Property ServiceId As String
    'Public Property Servicename As String
    Public Property Starttime As String
    Public Property Duration As String
    Public Property StaffId As String
    Public Property Servicerate As String

End Class

