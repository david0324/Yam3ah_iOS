//
//  Global.m
//  Letterz
//
//  Created by Sheetal on 26/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Global.h"
#import "CartItemData.h"
#import "NSAttributedString+Attributes.h"
#import "OHAttributedLabel.h"
#import "AppDelegate.h"
#import "Config.h"

@implementation Global

//+ (int)getHeightForText :(NSString*)text andWidth :(int)width {
//	
//	int height;
//	CGRect textSize = CGRectMake(0.0, 0.0, width, FLT_MAX);
//	UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:13];
//	
//	UILabel *lblHeight = [[UILabel alloc] init];
//	lblHeight.lineBreakMode = UILineBreakModeWordWrap;
//	lblHeight.numberOfLines = 0;
//	lblHeight.font = font;
//	lblHeight.text = text;
//	lblHeight.frame = [lblHeight textRectForBounds:textSize limitedToNumberOfLines:0];	
//	height = lblHeight.frame.size.height;
//	[lblHeight release];
//
//	return height;
//}
//
//+ (CGFloat) getCellHeight :(NSString*) string withfont :(UIFont*)font {
//	
//	
//	CGSize constraint;
//	constraint = CGSizeMake(CELL_CONTENT_WIDTH_PORTRAIT - (CELL_CONTENT_MARGIN * 2), 20000.0f);
//    
//    CGSize size = [string sizeWithFont:font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
//    
//    CGFloat height = MAX(size.height, CELL_CONTENT_HEIGHT);
//    
//    return height + (CELL_CONTENT_MARGIN * 2);
//}
//
//+ (void)resignSubviews :(UIView*)view
//{
//	for (id subview in [view subviews]) 
//	{
//		NSLog(@"%@",[subview description]);
//		if ([subview isKindOfClass:[UITextField class]]) {
//			[subview resignFirstResponder];
//		}
//		
//	}
//}
//#pragma mark set document attribute
//
//+(void)setSubDocumentsToNonBackedUp:(NSString*)itemURLSTR
//{
//    if([[[UIDevice currentDevice] systemVersion] floatValue]>=5.0)
//    {
//        NSURL *pathURL= [NSURL fileURLWithPath:itemURLSTR];
//        const char* filePath = [[pathURL path] fileSystemRepresentation];
//        const char* attrName = "com.apple.MobileBackup";
//        u_int8_t attrValue = 1;
//        setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
//    }
//}
//
//#pragma mark -
//+(void) saveImageToDocumentFolder:(UIImage *)image withName:(NSString *)ImageName
//{
//	NSData *data;
//	//data = UIImagePNGRepresentation(image);
//	data = UIImageJPEGRepresentation(image, 1.0);
//	
//	if (!data)
//		return;
//	
//	NSFileManager *fileManager = [NSFileManager defaultManager];
//	
//	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	NSString *documentsDirectory = [paths objectAtIndex:0];
//	
//	NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:ImageName];
//	if(![fileManager fileExistsAtPath:fullPath])
//		[fileManager createFileAtPath:fullPath contents:data attributes:nil];
//	
//    [Global setSubDocumentsToNonBackedUp:fullPath];
//    
//	[data writeToFile:fullPath atomically:YES];
//	
//}
//+ (NSString *)uniqueString{
//    CFUUIDRef uuid = CFUUIDCreate(NULL);
//    CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
//    CFRelease(uuid);
//    [(NSString *)uuidStr autorelease];
//    return (NSString *)uuidStr;
//} 
//
//
//+ (NSArray*) structuredIngredients:(NSArray*)arrIngredients {
//	
//	NSMutableArray *arrIngredientDic = [[[NSMutableArray alloc]init] autorelease];
//		
//	for (int count = 0;count< [arrIngredients count]; count ++ ) {
//		Ingredient *ingredient = [arrIngredients objectAtIndex:count ];
//		
//		NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:0];
//		
//		/* "IngredientName" : "Tomato", "Quantity": "4", "Unit": "pieces" */
//		if (ingredient.ingredientName) 
//			[parameters setObject:ingredient.ingredientName forKey:@"IngredientName"];
//		
//		if (ingredient.quantity) 
//			[parameters setObject:ingredient.quantity forKey:@"Quantity"];
//		
//		if (ingredient.unit) 
//			[parameters setObject:ingredient.unit forKey:@"Unit"];
//		else
//			[parameters setObject:@"" forKey:@"Unit"];
//		
//		[arrIngredientDic addObject:parameters];
//		[parameters release];
//		
//	}
//	
//	return [NSArray arrayWithArray: arrIngredientDic];
//}
//
//+ (NSArray*)sortArray:(NSArray*)toBeSorted keyForSorting:(NSString*)keyForSorting ascending:(BOOL)isAsc Number:(BOOL)isNumber {
//	
//	SEL sortSelector = nil;
//	sortSelector = (isNumber)?@selector(compare:):@selector(localizedCaseInsensitiveCompare:);
//	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:keyForSorting ascending:isAsc selector:sortSelector];
//	NSArray *desciptors = [NSArray arrayWithObject:sortDescriptor];
//	toBeSorted = [toBeSorted sortedArrayUsingDescriptors:desciptors];
//	[sortDescriptor release];
//	return toBeSorted;
//}
//
//Get/Set user name to defaults for showing it when
//next time login screen appears.
//+(void)SaveUserEmailToDefaults :(NSString*)email{
//	NSUserDefaults* userDefaults = [ NSUserDefaults standardUserDefaults];
//	[userDefaults setObject:email forKey:KEmailID];
//}
//
//+(BOOL)GetRememberMeFlag{
//	NSUserDefaults* userDefaults = [ NSUserDefaults standardUserDefaults];
//	return [userDefaults boolForKey:kRememberMe];
//}
//+(void)SaveRememberMeFlag:(BOOL)flag{
//	NSUserDefaults* userDefaults = [ NSUserDefaults standardUserDefaults];
//	[userDefaults setBool:flag forKey:kRememberMe];;
//}
//+(NSString*)GetUserPassword{
//	NSUserDefaults* userDefaults = [ NSUserDefaults standardUserDefaults];
//	return [userDefaults objectForKey:KPassword];
//}
//
//+(void)SaveUserPassword:(NSString*)password{
//	NSUserDefaults* userDefaults = [ NSUserDefaults standardUserDefaults];
//	[userDefaults setObject:password forKey:KPassword];
//}

//+(NSString*)GetUserEmailFromDefaults{
//	NSString* email = nil;
//	NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
//	email = [userDefaults objectForKey:KEmailID];
//	return email;
//}
//+(GlobalDataPersistence *)restartGlobalDataPersistence
//{
//	GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
//    NSString *username = [[NSString alloc]initWithString:GDP.username];
//    
//    [GlobalDataPersistence resetGlobalDataPersistence];
//    
//    GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
//    [GDP setUsername:username];
//    
//    return GDP;
//}
+ (void)roundCornersRadius:(UIView *)subView byRoundingCorners:(UIRectCorner)corners
{
//    UIBezierPath *maskPathTop = [UIBezierPath bezierPathWithRoundedRect:subView.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(8.0f, 8.0f)];
//    
//    CAShapeLayer *maskLayerTop = [[CAShapeLayer alloc] init];
//    maskLayerTop.frame = subView.bounds;
//    maskLayerTop.path = maskPathTop.CGPath;
//    subView.layer.mask = maskLayerTop;
//    subView.clipsToBounds = YES;
}
+ (void)AnimateView:(UIView *)subview onHostViewController:(UIViewController *)controller
{
    [controller.view setUserInteractionEnabled:NO];
    AppDelegate *app = App_Delegate;
    [subview setAlpha:0.0];
    [subview setFrame:app.window.frame];
    subview.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.1, 0.1);
    
    [app.window addSubview:subview];
    
    [UIView animateWithDuration:.3 animations:
     ^(void){
         subview.transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
         subview.alpha = 1.0;
     }
    completion:^(BOOL finished)
     {
         [controller.view setUserInteractionEnabled:YES];
    }];
}

+ (void)RemoveView:(UIView *)subview
{
    [UIView animateWithDuration:.3 animations:
     ^(void){
         subview.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.1, 0.1);
         subview.alpha = 0.0;
     }
                     completion:^(BOOL finished)
                    {
                        [subview removeFromSuperview];
                     }];
}
+ (NSMutableAttributedString *)getCartTotalQuantity
{
    NSMutableAttributedString* textqty = nil;
    int quantity = 0;
    
    GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
    for (CartItemData *aItem in GDP.arrCartItems)
    {
        quantity = quantity + [aItem.qty integerValue];
    }
    
    NSString *qty = [NSString stringWithFormat:@"Total Items : %d",quantity];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0)
    {
   
        
        textqty = [NSMutableAttributedString attributedStringWithString:qty];
        [textqty setFont:[UIFont systemFontOfSize:12]];
        [textqty setTextColor:[UIColor grayColor]];
        [textqty setTextColor:[UIColor colorWithRed:51.0/255.0 green:211.0/255.0 blue:194.0/255.0 alpha:1.0] range:NSMakeRange(13,qty.length-13)];
        
    }
    else
    {
        
        textqty = [[NSMutableAttributedString alloc]
         initWithAttributedString: [[NSAttributedString alloc] initWithString:qty]];
        
        [textqty addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorWithRed:51.0/255.0 green:211.0/255.0 blue:194.0/255.0 alpha:1.0]
                        range:NSMakeRange(13,qty.length-13)];
    }
    return textqty;
    
}
+ (NSMutableAttributedString *)getCartTotalPrice
{
    NSMutableAttributedString* attrStr = nil;
    CGFloat itemPrice = 0.0;
    
    GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
    NSString *currency;
    for (CartItemData *aItem in GDP.arrCartItems)
    {
        itemPrice = itemPrice + ([aItem.qty integerValue] * [aItem.price floatValue]);
        currency = aItem.strCurrency;
    }
    
    if (currency == nil || currency == (id)[NSNull null]) {
        currency = @"KD";
    }
    
    
    NSString *price = [NSString stringWithFormat:@"Total Price : %.2f%@",itemPrice,currency];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0)
    {
        attrStr = [NSMutableAttributedString attributedStringWithString:price];
        [attrStr setFont:[UIFont systemFontOfSize:12]];
        [attrStr setTextColor:[UIColor grayColor]];
        [attrStr setTextColor:[UIColor colorWithRed:51.0/255.0 green:211.0/255.0 blue:194.0/255.0 alpha:1.0] range:NSMakeRange(13,price.length-13)];
  
        
    }
    else
    {
        attrStr = [[NSMutableAttributedString alloc]
         initWithAttributedString: [[NSAttributedString alloc] initWithString:price]];
        
        [attrStr addAttribute:NSForegroundColorAttributeName
                     value:[UIColor colorWithRed:51.0/255.0 green:211.0/255.0 blue:194.0/255.0 alpha:1.0]
                     range:NSMakeRange(13,price.length-13)];
    }
    return attrStr;
}
//+(NSString*)convertToTimeString:(NSString*)strTime{
//	NSString* timeString = nil;
//	if ([[strTime stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0) {
//		NSArray *arrCookingTime = [strTime componentsSeparatedByString:@":"];
//		
//		if([arrCookingTime count] > 0){
//			
//			if([[arrCookingTime objectAtIndex:0] isEqualToString:@"00"] && ![[arrCookingTime objectAtIndex:1] isEqualToString:@"00"])
//				timeString = [NSString stringWithFormat:@"%@ min.",[arrCookingTime objectAtIndex:1]];
//			
//			else if(![[arrCookingTime objectAtIndex:0] isEqualToString:@"00"] && [[arrCookingTime objectAtIndex:1] isEqualToString:@"00"])
//				timeString = [NSString stringWithFormat:@"%@ hrs.",[arrCookingTime objectAtIndex:0]];
//			
//			else if(![[arrCookingTime objectAtIndex:0] isEqualToString:@"00"] && ![[arrCookingTime objectAtIndex:1] isEqualToString:@"00"])
//				timeString = [NSString stringWithFormat:@"%@ hrs. %@ min.",[arrCookingTime objectAtIndex:0],[arrCookingTime objectAtIndex:1]];			
//		}		
//	}
//	return  timeString;
//}
//
//#pragma mark App Purchase Status
//
//+(BOOL)GetAppPurchaseStatus{
//	BOOL status = NO;
//	NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
//	status = [userDefaults boolForKey:kAppPurchasedStatus];
//	return status;
//}
//+(void)SetAppPurchaseStatus:(BOOL)status{
//	NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
//	[userDefaults setBool:status forKey:kAppPurchasedStatus];
//}


@end
