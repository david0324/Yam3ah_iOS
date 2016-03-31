//
//  CheckoutViewController.h
//  Yam3ah
//
//  Created by admin on 10/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "Custom_TextField.h"
#import "BSKeyboardControls.h"
#import "KTTextView.h"

@interface CheckoutViewController : UIViewController<UITextFieldDelegate,BSKeyboardControlsDelegate,UIScrollViewDelegate,UIWebViewDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    IBOutlet UITextField *txtFBlockNumber;
    IBOutlet UITextField *txtFStreetNumber;
    IBOutlet UITextField *txtFPhoneNo;
    IBOutlet UITextField *txtFEmail;
    IBOutlet UITextField *txtFAddressLineOne;
    IBOutlet UITextField *txtFAvenue;
    IBOutlet UITextField *txtFHouseNumber;
    IBOutlet UITextField *txtFFloorNumber;
    IBOutlet UITextField *txtFApartmentNumber;
    IBOutlet KTTextView *txtViewNote;
    IBOutlet TPKeyboardAvoidingScrollView *scrollViewCheckout;
    IBOutlet UITextView *txtVTerms;
    IBOutlet UIView *viewAgreement;
    IBOutlet UIButton *btnContinue;
    IBOutlet UIButton *btnCheck;
    BSKeyboardControls *keyboardControls;
    IBOutlet UIScrollView *scrlView;
    
    IBOutlet UIWebView *webTerms;
    
    NSMutableArray *arrArea;
    IBOutlet UIButton *btnArea;
    int intIndex;
    UIPickerView *pickerView;
    UITextField *currentTextField;
    BOOL boolArea;
}

- (IBAction)checkoutBtnPressed:(id)sender;
- (IBAction)cancelBtnPressed:(id)sender;
- (IBAction)continueBtnPressed:(id)sender;
- (IBAction)BtnCheckPressed:(id)sender;
- (IBAction)btnBackClicked;

-(IBAction)btnCancelClicked;
-(IBAction)btnDoneClicked;

//PickerView
@property(nonatomic,strong)UIPickerView *pickerViewArea;
@property(nonatomic,strong)NSString *strArea;
@property(nonatomic,strong)IBOutlet UIView *viewArea;
@property(nonatomic,strong)IBOutlet UIView *viewInsidePicker;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityLoader;
@end
