

#define KALERT(TITLE,MSG,DELEGATE) [[UIAlertView alloc]initWithTitle:TITLE message:MSG delegate:DELEGATE cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]

#define KALERT_YN(TITLE,MSG,DELEGATE) [[UIAlertView alloc]initWithTitle:TITLE message:MSG delegate:DELEGATE cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil]

#define App_Delegate (AppDelegate*)[UIApplication sharedApplication].delegate

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


//#define APP_ManageObject ((AppDelegate*)iTicket_AppDelegate).managedObjectContext

#define whiteCharacterSet [NSCharacterSet whitespaceAndNewlineCharacterSet]
#define AppName  @"MySafe"

#define kParseAppKey                    @"LtAYczzZ7RDLxHlbkiVTWWrQMSm7bVIIJKsjPCPL"
#define kParseClientKey                 @"HPy5yNLk5618sCVSh6oxlGJXZcjL3ZtNjVO1XAxV"

#define AppDeviceToken @"Device_token"

#define iOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//#define ServerAdd @"http://ds211.projectstatus.co.uk/knight_frank_app/webservices/"
//#define ServerAdd @"http://192.168.2.11/asbestos/webservices/" //local url
//#define ServerAdd @"http://www.kfadmin.com.au/webservices/" //demo url
//#define ServerAdd @"http://carpark-management.co.uk/mobile-app/users/"  //live url

#define GetArea @"getarea"
#define GetSearchResult @"getsearchresults"
#define getReports @"getreports"
#define Login @"user_login"
#define Registration @"user_add"
#define SavedProperty @"saved_property"
#define mySavedProperty @"mysaved_property"
#define deleteSavedProperty @"delete_saved_property"
#define Getcontact @"getpages"
#define Getadvertisement @"getadvertisement"
#define Sendmail @"send_email"
#define GetSaleshistory @"sale_history"
#define Getforgot_password @"forgot_password"
#define Editprofile @"myprofile"
#define Subscription @"update_user_reciept"
#define SubscriptionProductID @"com.KnightFrank.com.inapprage.12monthlyrageface"

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define SALES_ANALYSIS_PENDING @"Sales Analysis Pending. Non release at this stage may be due to settlement timing and/or confidentiality issues. Updates will follow."

typedef enum companyType
{
    DDProducersFarmers = 1,
    DDRoasters,
    DDExporters,
    DDImporters,
    DDPersonal,
    DDQualityControlers
}CompanyTypes;




