
#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "Config-1.h"
//#import "NSString+URLEncoding.h" 
@class UserInfo;
@class DDAppDelegate;

@interface WebCommunicationClass : NSObject {

	DDAppDelegate *AnAppDelegatObj;
	NSString *MethoodName;
	id aCaller;
	
}

@property(nonatomic,retain)	id aCaller;
@property(nonatomic,assign)	BOOL isCancelAllRequest;



//Knight Frank Functions
-(void)getLatestProductList:(NSString*)strOffset;
-(void)getStateCityList;
-(void)getCityProductList;

-(void)getCategoryList;
-(void)getCompanyList:(NSString*)categoryId;
-(void)getCompanyMenuList:(NSString*)companyId;
-(void)getSearchProductList:(NSString*)keyword offset:(NSString*)offset;
-(void)save_order:(NSMutableDictionary *)orderDetail;
-(void)getTermsCondition;
-(void)checkOrderAvailablity:(NSMutableDictionary *)orderDetail;


-(void)getreports:(NSString*)strYear;
-(void)user_login:(NSString*)strEmail strPassword:(NSString*)strPassword;
-(void)user_add:(NSString*)strEmail strPassword:(NSString*)strPassword strFName:(NSString*)strFName strLName:(NSString*)strLName strPhone:(NSString*)strPhone;
-(void)savedproperty:(NSString*)strUserId propertyId:(NSString*)strPropertyId;
-(void)mySavedproperty:(NSString*)strUserId;
-(void)deleteSavedproperty:(NSString*)strUserId arrPropertyId:(NSMutableArray*)arrPropertyIds;
-(void)Getaboutusdetail;
-(void)GetAasbanner;
-(void)SendMail:(NSString*)to from:(NSString*)from subject:(NSString*)subject message:(NSString*)message propertyid:(NSString*)property_id;
-(void)GetSalesHistory:(NSString*)user_id  propertyid:(NSString*)property_id year:(NSString*)year;
-(void)Getedit:(NSString*)user_id first_name:(NSString*)first_name last_name:(NSString*)last_name phone:(NSString*)phone password:(NSString*)password;
-(void)ForgotPassword:(NSString*)email;
-(void)user_Subscribe:(NSString*)strUserID strRecipt:(NSString*)strRecipt;
@end


@protocol WebCommunicationClassDelegate
-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj;
-(void) dataDownloadFail:(ASIHTTPRequest*)aReq  withMethood:(NSString *)MethoodName;



@end
