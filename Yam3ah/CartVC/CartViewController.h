//
//  SecondViewController.h
//  LocationPickerView-Demo
//
//  Created by Christopher Constable on 5/11/13.
//  Copyright (c) 2013 Christopher Constable. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartItemData.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "KTTextView.h"

@interface CartViewController : UIViewController <UITableViewDataSource, UITableViewDelegate ,UIAlertViewDelegate,UITextViewDelegate>
{
    __weak IBOutlet UITableView *aTableView;
    IBOutlet UIView *tblHdr;
    __weak IBOutlet UILabel *lblTotPrice;
    __weak IBOutlet UILabel *lblTotItems;
    IBOutlet TPKeyboardAvoidingScrollView *viewEditQuantity;
    __weak IBOutlet UITextField *txtfQuantity;
    __weak IBOutlet UIButton *btnMessage;
    __weak IBOutlet UIImageView *btnImageBlur;
     IBOutlet KTTextView *txtSpecialrequest;
    UIButton *btnSenderTag;
}
@property (nonatomic , assign) BOOL shouldShowFooter;
@property (nonatomic , retain) CartItemData *selecteCartItem;
@property (nonatomic , retain) NSArray *arrCartItems;
@end
