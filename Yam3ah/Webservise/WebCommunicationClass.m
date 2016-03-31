

#import "WebCommunicationClass.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Config.h"
#import "LetterProgressView.h"
#import "Utils.h"

@implementation WebCommunicationClass

@synthesize aCaller;

- (id)init {
    self = [super init];
    if (self)
	{
		AnAppDelegatObj=(DDAppDelegate *)[[UIApplication sharedApplication] delegate];
		
    }
    return self;
}
- (void)dealloc
{
//    NSLog(@"%s",__PRETTY_FUNCTION__);
    [aCaller release];
    aCaller = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark - User Defined Methods

-(void)getLatestProductList:(NSString*)strOffset
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:strOffset forKey:@"offset"];
    [self ASICallSyncToServerWithFunctionName:kGetLatestProductlist PostDataDictonery:aUserInfo];
}

-(void)getStateCityList
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [self ASICallSyncToServerWithFunctionName:kGetStateCityList PostDataDictonery:aUserInfo];
}

-(void)getCityProductList
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [self ASICallSyncToServerWithFunctionName:kGetCityProductList PostDataDictonery:aUserInfo];
}

-(void)getCategoryList
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [self ASICallSyncToServerWithFunctionName:kGetCategory PostDataDictonery:aUserInfo];
}

-(void)getCompanyList:(NSString*)categoryId
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:categoryId forKey:@"categoryid"];
    [self ASICallSyncToServerWithFunctionName:kGetCompanyList PostDataDictonery:aUserInfo];
}

-(void)getCompanyMenuList:(NSString*)companyId
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:companyId forKey:@"companyid"];
    [self ASICallSyncToServerWithFunctionName:kGetMenuList PostDataDictonery:aUserInfo];
}

-(void)getSearchProductList:(NSString*)keyword offset:(NSString*)offset
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:keyword forKey:@"search"];
    [aUserInfo setValue:offset forKey:@"offset"];
    [self ASICallSyncToServerWithFunctionName:kGetSearchProduct PostDataDictonery:aUserInfo];
}

-(void)save_order:(NSMutableDictionary *)orderDetail
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:orderDetail forKey:@"order"];
    [self ASICallSyncToServerWithFunctionName:kSaveOrder PostDataDictonery:aUserInfo];
}

-(void)checkOrderAvailablity:(NSMutableDictionary *)orderDetail
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:orderDetail forKey:@"order"];
    [self ASICallSyncToServerWithFunctionName:kCheckProductAvailability PostDataDictonery:aUserInfo];
}

-(void)getTermsCondition
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [self ASICallSyncToServerWithFunctionName:kGetTerms PostDataDictonery:aUserInfo];
}

-(void)getreports:(NSString*)strYear
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:strYear forKey:@"year"];
    [self ASICallSyncToServerWithFunctionName:getReports PostDataDictonery:aUserInfo];
}

-(void)user_login:(NSString*)strEmail strPassword:(NSString*)strPassword
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:strEmail forKey:@"email"];
    [aUserInfo setValue:strPassword forKey:@"password"];
    [self ASICallSyncToServerWithFunctionName:Login PostDataDictonery:aUserInfo];
}

-(void)user_add:(NSString*)strEmail strPassword:(NSString*)strPassword strFName:(NSString*)strFName strLName:(NSString*)strLName strPhone:(NSString*)strPhone
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:strEmail forKey:@"email"];
    [aUserInfo setValue:strPassword forKey:@"password"];
    [aUserInfo setValue:strFName forKey:@"first_name"];
    [aUserInfo setValue:strLName forKey:@"last_name"];
    [aUserInfo setValue:strPhone forKey:@"phone"];
    [self ASICallSyncToServerWithFunctionName:Registration PostDataDictonery:aUserInfo];
}

-(void)savedproperty:(NSString*)strUserId propertyId:(NSString*)strPropertyId;
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:strUserId forKey:@"user_id"];
    [aUserInfo setValue:strPropertyId forKey:@"property_id"];
    [self ASICallSyncToServerWithFunctionName:SavedProperty PostDataDictonery:aUserInfo];
}

-(void)mySavedproperty:(NSString*)strUserId
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:strUserId forKey:@"user_id"];
    [self ASICallSyncToServerWithFunctionName:mySavedProperty PostDataDictonery:aUserInfo];
}

-(void)deleteSavedproperty:(NSString*)strUserId arrPropertyId:(NSMutableArray*)arrPropertyIds;
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:strUserId forKey:@"user_id"];
    [aUserInfo setValue:arrPropertyIds forKey:@"property_id"];
    [self ASICallSyncToServerWithFunctionName:deleteSavedProperty PostDataDictonery:aUserInfo];
}

-(void)Getaboutusdetail
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [self ASICallSyncToServerWithFunctionName:Getcontact PostDataDictonery:aUserInfo];
}
-(void)GetAasbanner
{
    //[MBProgressHUD showHUDAddedTo:[AppDelegate sharedDelegate].window animated:YES];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [self ASICallSyncToServerWithFunctionName:Getadvertisement PostDataDictonery:aUserInfo];
}
-(void)SendMail:(NSString*)to from:(NSString*)from subject:(NSString*)subject message:(NSString*)message propertyid:(NSString*)property_id;
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:to forKey:@"to"];
    [aUserInfo setValue:from forKey:@"from"];
    [aUserInfo setValue:subject forKey:@"subject"];
    [aUserInfo setValue:message forKey:@"message"];
    [aUserInfo setValue:property_id forKey:@"property_id"];
    [self ASICallSyncToServerWithFunctionName:Sendmail PostDataDictonery:aUserInfo];
}

-(void)GetSalesHistory:(NSString*)user_id  propertyid:(NSString*)property_id year:(NSString*)year
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:user_id forKey:@"user_id"];
    [aUserInfo setValue:property_id forKey:@"property_id"];
    [aUserInfo setValue:year forKey:@"date_sold"];
    [self ASICallSyncToServerWithFunctionName:GetSaleshistory PostDataDictonery:aUserInfo];
}
-(void)Getedit:(NSString*)user_id first_name:(NSString*)first_name last_name:(NSString*)last_name phone:(NSString*)phone password:(NSString*)password
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:user_id forKey:@"user_id"];
    [aUserInfo setValue:first_name forKey:@"first_name"];
     [aUserInfo setValue:last_name forKey:@"last_name"];
     [aUserInfo setValue:phone forKey:@"phone"];
     [aUserInfo setValue:password forKey:@"password"];
    
    [self ASICallSyncToServerWithFunctionName:Editprofile PostDataDictonery:aUserInfo];
}
-(void)ForgotPassword:(NSString*)email
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:email forKey:@"email"];
    [self ASICallSyncToServerWithFunctionName:Getforgot_password PostDataDictonery:aUserInfo];
}
-(void)user_Subscribe:(NSString*)strUserID strRecipt:(NSString*)strRecipt
{
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:strUserID forKey:@"user_id"];
    [aUserInfo setValue:strRecipt forKey:@"reciept_data"];
    [self ASICallSyncToServerWithFunctionName:Subscription PostDataDictonery:aUserInfo];
}
#pragma mark - Class Methods
+ (NSString *)urlEncodeValue:(NSString *)str
{
	NSString *result = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR("?=&+"), kCFStringEncodingUTF8);
	return [result autorelease];
}
+ (NSString *)urlDecodeValue:(NSString *)str
{
	//NSString *result = (NSString *) CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR("?=&+"), kCFStringEncodingUTF8);
	NSString *result = (NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)str,  CFSTR("?=&+"), kCFStringEncodingUTF8);
	return [result autorelease];
}


-(void)ASICallSyncToServerWithFunctionName:(NSString *)FunctionName PostDataDictonery :(NSMutableDictionary *)Dictionery
{
    
    if ([AppDelegate checkNetwork])
    {
        [self retain];
        NSString *JsonString=nil;
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:Dictionery
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        
        if (! jsonData) {
            NSLog(@"Got an error: %@", error);
        }
        else
        {
            JsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            
            NSLog(@"FunctionName-->> %@",FunctionName);
            NSLog(@"requestjson-->> %@",JsonString);
            
            MethoodName=FunctionName;
            NSString *urlString = [NSString stringWithFormat:@"%@",ServerAdd];
            NSLog(@"ServerAdd-->> %@",urlString);
            NSURL *aUrl=[[[NSURL alloc]initWithString:urlString]autorelease];
            
            ASIFormDataRequest *anASIReq = [ASIFormDataRequest requestWithURL:aUrl];
            
            anASIReq.methodName=FunctionName;
            
            

            [anASIReq setPostValue:FunctionName forKey:@"action"];
            [anASIReq setPostValue:JsonString forKey:@"json"];
            
          
            
            anASIReq.delegate = self;
            anASIReq.didFailSelector = @selector(dataDownloadFail:);
            anASIReq.didFinishSelector = @selector(dataDidFinishDowloading:);
            anASIReq.requestMethod = @"POST";
            
            [JsonString release];
            [anASIReq startAsynchronous];
        }
    }
//    else
//    {
//        //[SVProgressHUD dismiss];
//    }
}

#pragma mark - Response Methods
-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq
{
    NSString *aStrResult=[[[NSString alloc] initWithData:[aReq responseData] encoding:NSUTF8StringEncoding] autorelease];
    NSLog( @"%@",aStrResult);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSArray *arrMethodNames = [NSArray arrayWithObjects:
                               kGetLatestProductlist,kGetCategory,kGetCompanyList,kGetMenuList,kGetSearchProduct,kSaveOrder,kGetTerms,getReports,Login,Registration,SavedProperty,mySavedProperty,deleteSavedProperty,Getcontact,Getadvertisement,Sendmail,GetSaleshistory,Getforgot_password,Editprofile,Subscription,kGetStateCityList,kGetCityProductList,kCheckProductAvailability,
                               nil];

    if ([arrMethodNames containsObject:MethoodName])
    {
        [self navigateWithData:aReq];
		return;
    }
}

-(void) dataDownloadFail:(ASIHTTPRequest*)aReq
{
   [LetterProgressView DismissFromView:[App_Delegate window]];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   // if([aCaller respondsToSelector:@selector(dataDownloadFail:withMethood:)])
    {
        //[aCaller dataDownloadFail:aReq withMethood:aReq.methodName];
        
        NSLog(@"DATA DOWNLOAD Error--%@",aReq.error);
        [Utils showAlertMessage:KMessageTitle Message:[NSString stringWithFormat:[aReq.error localizedDescription]]];
    }
}

#pragma mark - Navigation methods
- (void)navigateWithData:(ASIHTTPRequest*)aReq
{
    //[SVProgressHUD dismiss];
//    AppDelegate *AppDel = App_Delegate;
//    NSLog(@"%@",AppDel.navigation.viewControllers);
    
    //if([[AppDel.currentTabBarNavigation.viewControllers lastObject] isEqual:self.aCaller])
   // {
        [self.aCaller dataDidFinishDowloading:aReq withMethood:MethoodName withOBJ:self];
   // }
  //  else
  //  {
   //     [self removeWebComm:self];
   // }
    
    [aCaller release];
    aCaller = nil;
    
}
//- (UINavigationController *)getCurrentNavigation:(MainViewController *)mainController
//{
////    if ([mainController.aDetailView.NavReport.view isEqual:mainController.aDetailView]) {
////        
////    }
//}
-(void)removeWebComm:(WebCommunicationClass*)webComm
{
    @try {
        if (webComm) {
            
            [webComm setACaller:nil];
            [webComm release];
            webComm = nil;
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception : %@ %s",exception.description,__PRETTY_FUNCTION__);
    }
    @finally {
        
    }
    
}
@end
