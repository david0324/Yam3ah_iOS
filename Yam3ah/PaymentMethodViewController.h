//
//  PaymentMethodViewController.h
//  Yam3ah
//
//  Created by sudhanshupareek on 12/05/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentMethodViewController : UIViewController
{
    UIButton *btnsender;
}
@property(nonatomic,retain) NSMutableDictionary *dictOrderdata;
- (IBAction)btnPaymentClick:(id)sender;




@end
