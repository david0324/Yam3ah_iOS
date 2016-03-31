//
//  ProductDetailViewController.h
//  Yam3ah
//
//  Created by admin on 10/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Custom_Lable.h"
#import "Custom_Button.h"

@interface ProductDetailViewController : UIViewController<UIScrollViewDelegate>
{
    IBOutlet UIScrollView *imgScrollView;
    IBOutlet UIPageControl *imgPageCtrl;
    IBOutlet Custom_Lable *lblPrice;
    IBOutlet Custom_Lable *lblProductName;
    IBOutlet Custom_Lable *lblHeadingProductName;
    IBOutlet UITextView *txtDescription;
    IBOutlet UIScrollView *scrlViewMain;
    float height;
    CGRect rect;
    IBOutlet UIButton *btnGotoCompany;
    BOOL isBool;

}
@property(nonatomic,strong)NSMutableDictionary *dictProductDetail;
-(IBAction)backBtnPressed:(id)sender;
-(IBAction)btnCompanyClicked;
@end
