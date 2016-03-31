//
//  MenuViewController.h
//  CoffeeApp
//
//  Created by Sheetal on 1/27/15.
//  Copyright (c) 2015 Dotsquares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBadge.h"
#import "EGOImageView.h"
#import "Custom_Lable.h"

@interface MenuViewController : UIViewController<UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    CustomBadge *cartItemBadge;
    __weak IBOutlet UITableView *aTableView;
    __weak IBOutlet Custom_Lable *lblTitle;
    __weak IBOutlet UITableView *tblCartLIst;
    IBOutlet UIView *tblCartHdr;
    IBOutlet UIView *viewPopUp;
    
    __weak IBOutlet UILabel *lblCategoryName;
    __weak IBOutlet UILabel *lblPrice;
    __weak IBOutlet EGOImageView *imgItem;
    IBOutlet UITextView *txtSpecialrequest;
    NSMutableArray *arrPrice;
    IBOutlet UIButton *btnPrice;
    int intIndex;
    UIPickerView *pickerView;
    NSIndexPath *iPath;
    BOOL isBool;
}
@property (nonatomic , strong) NSMutableArray *arrItems;
@property(nonatomic,strong)NSMutableArray *arrItemTmp;
@property (nonatomic , retain) NSArray *arrAttributes;
@property (nonatomic , retain) NSDictionary *dictAttributeInfo;

@property(nonatomic,retain) NSMutableDictionary *dictCategoryItems;

//@property (nonatomic, copy) void (^finishedCallback)(MenuViewController *controller , BOOL isDataFound);

//PickerView
@property(nonatomic,strong)UIPickerView *pickerViewPrice;
@property(nonatomic,strong)NSString *strPrice;
@property(nonatomic,strong) IBOutlet UIView *viewPrice;
@property(nonatomic,strong) IBOutlet UIView *viewInsidePicker;

- (IBAction)btnOkClick:(id)sender;
- (IBAction)btnCancelclick:(id)sender;

-(IBAction)btnCancelClicked;
-(IBAction)btnDoneClicked;
-(IBAction)btnPriceClicked;

@end
