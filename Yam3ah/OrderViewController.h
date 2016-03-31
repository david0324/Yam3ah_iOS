//
//  OrderViewController.h
//  Yam3ah
//
//  Created by admin on 10/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewController : UIViewController<UIWebViewDelegate>
{
     IBOutlet UIWebView *uipaymentview;
}
@property(nonatomic,retain) NSMutableDictionary *dictOrderdata;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityLoader;

@end
