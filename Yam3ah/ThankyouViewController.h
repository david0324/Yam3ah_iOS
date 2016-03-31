//
//  ThankyouViewController.h
//  Yam3ah
//
//  Created by sudhanshupareek on 01/05/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThankyouViewController : UIViewController
{
    IBOutlet UITextView *txtViewOrder;
}
@property(nonatomic,strong)NSString *strOrderId;
@end
