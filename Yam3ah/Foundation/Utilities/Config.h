

#define KALERT(TITLE,MSG,DELEGATE) [[UIAlertView alloc]initWithTitle:TITLE message:MSG delegate:DELEGATE cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]

#define KALERT_YN(TITLE,MSG,DELEGATE) [[UIAlertView alloc]initWithTitle:TITLE message:MSG delegate:DELEGATE cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil]

#define App_Delegate (AppDelegate*)[UIApplication sharedApplication].delegate


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

//#define APP_ManageObject ((AppDelegate*)iTicket_AppDelegate).managedObjectContext

#define whiteCharacterSet [NSCharacterSet whitespaceAndNewlineCharacterSet]

#define kParseAppKey                    @"LtAYczzZ7RDLxHlbkiVTWWrQMSm7bVIIJKsjPCPL"
#define kParseClientKey                 @"HPy5yNLk5618sCVSh6oxlGJXZcjL3ZtNjVO1XAxV"

#define AppDeviceToken @"Device_token"

#define kAppOffWhite [UIColor colorWithRed:(226.0/255.0) green:(221.0/255.0) blue:(203.0/255.0) alpha:1.0]
#define kBadgeIconColor [UIColor colorWithRed:(219.0/255.0) green:(21.0/255.0) blue:(3.0/255.0) alpha:1.0]

#define kUpdateTabbar @"kUpdateTabBar"
#define kProductAvailability @"You have exceed quantity for this product availability"

#define ServerAdd @"http://ds211.projectstatus.co.uk/alyam3ah/webservicenew/index.php/"
//#define ServerAdd @"https://www.yam3ah.com/webservicenew/index.php/"
//#define ServerAdd @"http://192.168.2.11/alyam3ah/webservicenew/index.php"

#define kGetLatestProductlist @"getLatestProductWithProductDetail"
#define kGetCategory @"category"
#define kGetStateCityList @"getStateCityList"
#define kGetCityProductList @"getCityProductList"

#define kGetCompanyList @"getCategoryCompany"
#define kGetMenuList @"getCompanyCategoryProduct"
#define kGetSearchProduct @"getSearchProductWithDetail"

#define kSaveOrder @"saveProductOrder"
#define kGetTerms @"gettermcondition"

#define kCheckProductAvailability @"checkOrderProductAvailablity"


#define kScreen16Color [UIColor colorWithRed:139.0f/255.0f green:161.0f/255.0f blue:86.0f/255.0f alpha:1.0f]
#define kScreen15Color [UIColor colorWithRed:161.0f/255.0f green:186.0f/255.0f blue:101.0f/255.0f alpha:1.0f]
#define kScreen14Color [UIColor colorWithRed:187.0f/255.0f green:206.0f/255.0f blue:149.0f/255.0f alpha:1.0f]
#define kPanColor [UIColor colorWithRed:214.0f/255.0f green:225.0f/255.0f blue:196.0f/255.0f alpha:1.0f]
#define kRejectionColor [UIColor colorWithRed:203.0f/255.0f green:88.0f/255.0f blue:72.0f/255.0f alpha:1.0f]

#define kClearColor [UIColor clearColor]

#define OswaldBold @"Oswald-Bold"
#define OswaldLight @"Oswald-Light"
#define OswaldRegular @"Oswald-Regular"

#define KMessageTitle @"Yam3ah"

#define KCustomFont @"Molengo-Regular"


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
