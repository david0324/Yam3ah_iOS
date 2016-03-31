//
//  Utils.m
//  FogoChannel1
//
//  Created by I phone octal on 02/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (void) showAlertMessage:(NSString *)title Message:(NSString *)msg {
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];

	
}

+(UIImage*) resizeImage:(UIImage*) image size:(CGSize) size {
	if (image.size.width != size.width || image.size.height != size.height) {
		UIGraphicsBeginImageContext(size);
		CGRect imageRect = CGRectMake(0.0, 0.0, size.width, size.height);
		[image drawInRect:imageRect];
		image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
	}
	return image;
}

//DeviceTokenDetails 
static NSString *deviceDtls;
+(void)setDeviceDetails:(NSString *)deviceDetails{
	deviceDtls = [[NSString alloc]init ];
    deviceDtls = [deviceDetails copy];
}

+(NSString *)getDeviceDetails{
	return deviceDtls;
}

static NSMutableDictionary *userDtls;
+(void)setUserDetails:(NSMutableDictionary *)userDetails{
    userDtls = [[NSMutableDictionary alloc]init ];
    userDtls = [userDetails copy];
    
}

+(NSMutableDictionary *)getUserDetails{
    return userDtls;
    
}

@end
