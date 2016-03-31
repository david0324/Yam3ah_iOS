//
//  CheckoutViewController.m
//  Yam3ah
//
//  Created by admin on 10/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "CheckoutViewController.h"
#import "Config.h"
#import "GlobalDataPersistence.h"
#import "CartItemData.h"
#import "WebCommunicationClass.h"
#import "MBProgressHUD.h"
#import "Config-1.h"
#import "AppDelegate.h"
#import "ThankyouViewController.h"
#import "DHValidation.h"
#import "Utils.h"
#import "PaymentMethodViewController.h"

#define kOrderInfo @"orderInfo"
#define kSelectArea @"selectarea"

@interface CheckoutViewController ()
@end

@implementation CheckoutViewController
@synthesize viewArea,viewInsidePicker;

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self SetTextFieldPlaceholderColor];
    [scrollViewCheckout setContentSize:CGSizeMake(scrollViewCheckout.frame.size.width, scrollViewCheckout.frame.size.height+100+30)];
    [self addKeyboardControls];
    webTerms.delegate = self;

}

-(void)viewWillAppear:(BOOL)animated
{
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(receiveTestNotification:)
//                                                 name:@"TestNotification"
//                                               object:nil];
    [txtViewNote setPlaceholderText:@"Notes"];
    [txtViewNote setPlaceholderColor:[UIColor whiteColor]];
    txtViewNote.textColor = [UIColor colorWithRed:64/255.0 green:191/255.0 blue:184/255.0 alpha:1.0];
    [scrlView setContentSize:CGSizeMake([UIScreen mainScreen].applicationFrame.size.width, 600)];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSelectArea];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
   
    WebCommunicationClass *aCommunication = [[WebCommunicationClass alloc] init];
    [aCommunication setACaller:self];
    [aCommunication getCityProductList];
}


- (void) receiveTestNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
//    if ([[notification name] isEqualToString:@"TestNotification"])
//    {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Notice !" message:@"Please try again your transaction get failed " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"", nil];
//        [alert show];
//    }
        //NSLog (@"Successfully received the test notification!");
}


-(void)SetTextFieldPlaceholderColor
{
    NSArray *txtFArray = [NSArray arrayWithObjects:txtFEmail,txtFPhoneNo,txtFAddressLineOne,txtFBlockNumber,txtFStreetNumber,txtFAvenue,txtFHouseNumber,txtFFloorNumber,txtFApartmentNumber, nil];
    for (Custom_TextField *txtF in txtFArray)
    {
        [txtF setValue:[UIColor whiteColor]
                        forKeyPath:@"_placeholderLabel.textColor"];
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (IBAction)btnBackClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Check out Pressed
- (IBAction)checkoutBtnPressed:(id)sender
{
   GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
    if (GDP.arrCartItems.count >0) {
           
    
    if ([self loginValidationTxtFields])
    {
        [btnContinue setEnabled:FALSE];
        NSLog(@"validation passed");
      
        [txtVTerms setFont:[UIFont fontWithName:KCustomFont size:[[txtVTerms font] pointSize]]];
        
        viewAgreement.frame = CGRectMake(0, self.view.frame.size.height, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height);
        
        [self.view addSubview:viewAgreement];
        
        [UIView animateWithDuration:0.5
                              delay:0.1
                            options: UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             viewAgreement.frame = CGRectMake(0,5, self.view.frame.size.width, viewAgreement.frame.size.height);
                         }
                         completion:^(BOOL finished)
         {
             
         }];
    }
        [self getTermsCondition];

        
    }
    else
    {
        UIAlertView *alert = KALERT(@"Notice!", @"Your cart is empty.", nil);
        [alert show];
        
    }
}

-(void)getTermsCondition
{
    WebCommunicationClass *aCommunication = [[WebCommunicationClass alloc] init];
    [aCommunication setACaller:self];
    [aCommunication getTermsCondition];
}

- (IBAction)cancelBtnPressed:(id)sender
{
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         viewAgreement.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, viewAgreement.frame.size.height);
                     }
                     completion:^(BOOL finished)
     {
            [viewAgreement removeFromSuperview];

     }];
    
    [btnCheck setImage:[UIImage imageNamed:@"checkbox_unselected.png"] forState:UIControlStateNormal];
    
}

- (IBAction)continueBtnPressed:(id)sender
{
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         viewAgreement.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, viewAgreement.frame.size.height);
                     }
                     completion:^(BOOL finished)
     {
         [viewAgreement removeFromSuperview];
         
         
         
         UIImage* checkImage = [UIImage imageNamed:@"checkbox_selected.png"];
         NSData *checkImageData = UIImagePNGRepresentation(checkImage);
         
         UIImage* curremtImage = btnCheck.currentImage;
         NSData *currentImageData = UIImagePNGRepresentation(curremtImage);
         
         if ([checkImageData isEqualToData:currentImageData])
         {
             [btnContinue setEnabled:FALSE];
             [btnCheck setImage:[UIImage imageNamed:@"checkbox_unselected.png"] forState:UIControlStateNormal];
         }
         else
         {
             [btnContinue setEnabled:TRUE];
             [btnCheck setImage:[UIImage imageNamed:@"checkbox_selected.png"] forState:UIControlStateNormal];
         }
         [self openPayPalDailog];
     }];
}

- (IBAction)BtnCheckPressed:(id)sender
{
    UIImage* checkImage = [UIImage imageNamed:@"checkbox_selected.png"];
    NSData *checkImageData = UIImagePNGRepresentation(checkImage);
    
    UIImage* curremtImage = btnCheck.currentImage;
    NSData *currentImageData = UIImagePNGRepresentation(curremtImage);
    if ([checkImageData isEqualToData:currentImageData])
    {
        [btnContinue setEnabled:FALSE];
        [btnCheck setImage:[UIImage imageNamed:@"checkbox_unselected.png"] forState:UIControlStateNormal];
    }
    else
    {
        [btnContinue setEnabled:TRUE];
        [btnCheck setImage:[UIImage imageNamed:@"checkbox_selected.png"] forState:UIControlStateNormal];
    }
}


#pragma mark - Validation
-(BOOL)Validation
{
    NSArray *txtFArray = [NSArray arrayWithObjects:txtFEmail,txtFPhoneNo,txtFAddressLineOne, nil];
    BOOL isIn = FALSE;
    for (UITextField *txtF in txtFArray)
    {
        NSString *actualText = [txtF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

        if (actualText.length>0)
        {
            isIn = FALSE;
            [txtF becomeFirstResponder];
        }
        else
        {
            isIn = TRUE;
            break;
        }
    }
    
    if (isIn)
    {
        [self setAlertWithTitle:@"Notice!" message:@"Fields can't be empty" tag:0];
        return FALSE;
    }
    else if(![self Emailvalidate:txtFEmail.text])
    {
        [txtFEmail becomeFirstResponder];
        [self setAlertWithTitle:@"Notice!" message:@"Invalid email id" tag:0];
        return FALSE;

    }
    else
    {
        return TRUE;
    }
}


- (void)openPayPalDailog
{
    NSMutableDictionary *dictOrder = [NSMutableDictionary dictionary];
    
   // [dictOrder setObject:txtFFirstname.text forKey:@"first_name"];
  //  [dictOrder setObject:txtFLastname.text  forKey:@"last_name"];
    
    [dictOrder setObject:txtFEmail.text     forKey:@"email_id"];
    [dictOrder setObject:txtFPhoneNo.text     forKey:@"contact_number"];
    [dictOrder setObject:txtFAddressLineOne.text      forKey:@"address_line1"];
    
    [dictOrder setObject:txtFBlockNumber.text       forKey:@"block_number"];
    [dictOrder setObject:txtFStreetNumber.text      forKey:@"street_number"];
    [dictOrder setObject:txtFAvenue.text            forKey:@"avenue"];
    [dictOrder setObject:txtFHouseNumber.text       forKey:@"house_building_number"];
    [dictOrder setObject:txtFFloorNumber.text       forKey:@"floor_number"];
    [dictOrder setObject:txtFApartmentNumber.text   forKey:@"apartment_number"];
    [dictOrder setObject:txtViewNote.text           forKey:@"note"];
    //[dictOrder setObject:txtFAddressLineTwo.text      forKey:@"address_line2"];
    //[dictOrder setObject:txtFCity.text      forKey:@"city"];
    //[dictOrder setObject:txtFState.text      forKey:@"state"];
    //[dictOrder setObject:txtFPostalCode.text      forKey:@"postal_code"];

  
    GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
    CGFloat itemPrice = 0.0;

    for (CartItemData *aItem in GDP.arrCartItems)
    {
        itemPrice = itemPrice + ([aItem.qty integerValue] * [aItem.price floatValue]);
    }
    [dictOrder setObject:[NSString stringWithFormat:@"%f",itemPrice] forKey:@"total_order_cost"];
    [[NSUserDefaults standardUserDefaults] setObject:dictOrder forKey:kOrderInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
     NSMutableArray *arrMenu = [NSMutableArray array];
    
    for (CartItemData *aItem in GDP.arrCartItems)
    {
        NSMutableDictionary *dictItem = [NSMutableDictionary dictionary];
        [dictItem setObject:aItem.menu_id   forKey:@"product_id"];
        [dictItem setObject:aItem.qty       forKey:@"product_qty"];
        [dictItem setObject:aItem.price     forKey:@"product_price"];
        [dictItem setObject:aItem.strCompany_id forKey:@"company_id"];
        if([aItem.strSpecialrequest length] <=0)
        {
            aItem.strSpecialrequest = @"";
        }
        [dictItem setObject:aItem.strSpecialrequest forKey:@"special_req"];

        [arrMenu addObject:dictItem];
    }
    
    [dictOrder setObject:arrMenu forKey:@"menus"];
    
    
    
    if ([arrMenu count])
    {
        PaymentMethodViewController *objorder = [[PaymentMethodViewController alloc]initWithNibName:@"PaymentMethodViewController" bundle:nil];
        objorder.dictOrderdata = dictOrder;
        [self.navigationController pushViewController:objorder animated:YES];
              
        
       /* [MBProgressHUD showHUDAddedTo:[App_Delegate window] animated:YES];
        WebCommunicationClass *aCommunication = [[WebCommunicationClass alloc] init];
        [aCommunication setACaller:self];
        [aCommunication save_order:dictOrder];*/
    }
    else
    {
        UIAlertView *alert = KALERT(@"Notice!", @"Your cart is empty.", nil);
        [alert show];
    }
    
}

-(void)commonValidation
{
    
}

- (BOOL)loginValidationTxtFields
{
    txtFEmail.text = [txtFEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    txtFPhoneNo.text=[txtFPhoneNo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    txtFAddressLineOne.text=[txtFAddressLineOne.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    txtFBlockNumber.text = [txtFBlockNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    txtFStreetNumber.text=[txtFStreetNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    txtFAvenue.text=[txtFAvenue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    txtFFloorNumber.text=[txtFFloorNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    txtFHouseNumber.text=[txtFHouseNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    txtFApartmentNumber.text=[txtFApartmentNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    txtViewNote.text=[txtViewNote.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    DHValidation *aValidation = [[DHValidation alloc]init];
    BOOL flag = [aValidation validateEmail:txtFEmail.text];
    
   if ([txtFEmail.text length]>0)
   {
       if (!flag) {
           [Utils showAlertMessage:KMessageTitle Message:@"Please enter valid email address"];
           [txtFEmail becomeFirstResponder];
           return false;
       }
       else if(txtFPhoneNo.text == NULL || [txtFPhoneNo.text length] == 0)
       {
           [Utils showAlertMessage:KMessageTitle Message:@"Please enter contact no."];
           [txtFPhoneNo becomeFirstResponder];
           return false ;
       }
       else if(txtFAddressLineOne.text == NULL || [txtFAddressLineOne.text length] == 0)
       {
           [Utils showAlertMessage:KMessageTitle Message:@"Please enter address"];
           [txtFAddressLineOne becomeFirstResponder];
           return false ;
       }
       else if(txtFBlockNumber.text == NULL || [txtFBlockNumber.text length] == 0)
       {
           [Utils showAlertMessage:KMessageTitle Message:@"Please enter block number"];
           [txtFBlockNumber becomeFirstResponder];
           return false ;
       }
       else if(txtFStreetNumber.text == NULL || [txtFStreetNumber.text length] == 0)
       {
           [Utils showAlertMessage:KMessageTitle Message:@"Please enter street number"];
           [txtFStreetNumber becomeFirstResponder];
           return false ;
       }
       else if(txtFHouseNumber.text == NULL || [txtFHouseNumber.text length] == 0)
       {
           [Utils showAlertMessage:KMessageTitle Message:@"Please enter house number"];
           [txtFHouseNumber becomeFirstResponder];
           return false ;
       }
       else
       {
           return true;
       }
    }
    
//   else if(txtFEmail.text == NULL || [txtFEmail.text length] == 0)
//   {
//       [Utils showAlertMessage:KMessageTitle Message:@"Please enter email "];
//       [txtFEmail becomeFirstResponder];
//       return false ;
//   }
    else if(txtFPhoneNo.text == NULL || [txtFPhoneNo.text length] == 0)
    {
        [Utils showAlertMessage:KMessageTitle Message:@"Please enter contact no."];
        [txtFPhoneNo becomeFirstResponder];
        return false ;
    }
    else if(txtFAddressLineOne.text == NULL || [txtFAddressLineOne.text length] == 0)
    {
        [Utils showAlertMessage:KMessageTitle Message:@"Please enter address"];
        [txtFAddressLineOne becomeFirstResponder];
        return false ;
    }
    else if(txtFBlockNumber.text == NULL || [txtFBlockNumber.text length] == 0)
    {
        [Utils showAlertMessage:KMessageTitle Message:@"Please enter block number"];
        [txtFBlockNumber becomeFirstResponder];
        return false ;
    }
    else if(txtFStreetNumber.text == NULL || [txtFStreetNumber.text length] == 0)
    {
        [Utils showAlertMessage:KMessageTitle Message:@"Please enter street number"];
        [txtFStreetNumber becomeFirstResponder];
        return false ;
    }
    else if(txtFHouseNumber.text == NULL || [txtFHouseNumber.text length] == 0)
    {
        [Utils showAlertMessage:KMessageTitle Message:@"Please enter house number"];
        [txtFHouseNumber becomeFirstResponder];
        return false ;
    }
    else
    {
        return true;
    }
}

-(void)setAlertWithTitle :(NSString *)title message:(NSString *)message tag:(NSInteger)tag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(BOOL) Emailvalidate:(NSString *)tempMail
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:tempMail];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 40;
}


#pragma mark BsKeyBoardContrrols delegate
-(void)addKeyboardControls
{
    // Initialize the keyboard controls
    keyboardControls = [[BSKeyboardControls alloc] init];
    
    // Set the delegate of the keyboard controls
    keyboardControls.delegate = self;
    
    // Add all text fields you want to be able to skip between to the keyboard controls
    // The order of thise text fields are important. The order is used when pressing "Previous" or "Next"
    
    keyboardControls.textFields = [NSArray arrayWithObjects:txtFEmail,txtFPhoneNo,txtFAddressLineOne,txtFBlockNumber,txtFStreetNumber,txtFAvenue,txtFHouseNumber,txtFFloorNumber,txtFApartmentNumber,txtViewNote,nil];
    
    
    // Set the style of the bar. Default is UIBarStyleBlackTranslucent.
   // keyboardControls.barStyle = UIBarStyleBlackTranslucent;
    
    // Set the tint color of the "Previous" and "Next" button. Default is black.
    keyboardControls.previousNextTintColor = [UIColor blackColor];
    
    // Set the tint color of the done button. Default is a color which looks a lot like the original blue color for a "Done" butotn
    keyboardControls.doneTintColor = [UIColor colorWithRed:34.0/255.0 green:164.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    // Set title for the "Previous" button. Default is "Previous".
    keyboardControls.previousTitle = @"Previous";
    
    // Set title for the "Next button". Default is "Next".
    keyboardControls.nextTitle = @"Next";
    
    // Add the keyboard control as accessory view for all of the text fields
    // Also set the delegate of all the text fields to self
    for (id textField in keyboardControls.textFields)
    {
        if ([textField isKindOfClass:[UITextField class]])
        {
            ((UITextField *) textField).inputAccessoryView = keyboardControls;
            ((UITextField *) textField).delegate = self;
        }
        if ([textField isKindOfClass:[UITextView class]])
        {
            ((UITextView *) textField).inputAccessoryView = keyboardControls;
            ((UITextView *) textField).delegate = self;
        }
    }
}

-(void)scrollViewToCenterOfScreen:(UIView *)theView
{
    CGFloat viewCenterY = theView.center.y;
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    CGFloat availableHeight = applicationFrame.size.height - 390; // Remove area covered by keyboard
    
    CGFloat y = viewCenterY - availableHeight / 2.0;
    if (y < 0) {
        y = 0;
    }
    [scrlView setContentOffset:CGPointMake(0, y) animated:YES];

}

- (void)keyboardControlsDonePressed:(BSKeyboardControls *)controls
{
    [controls.activeTextField resignFirstResponder];
    [scrlView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)keyboardControlsPreviousNextPressed:(BSKeyboardControls *)controls withDirection:(KeyboardControlsDirection)direction andActiveTextField:(id)textField
{
    [textField becomeFirstResponder];
    [self scrollViewToCenterOfScreen:textField];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        [self scrollViewToCenterOfScreen:txtFEmail];
    }
    
}

#pragma mark UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"%@",[textField description]);
    if(textField == txtFAddressLineOne)
    {
        [currentTextField resignFirstResponder];

        if (!boolArea)
        {
            boolArea = TRUE;
            txtFAddressLineOne.text = [arrArea objectAtIndex:0];
        }
        [self.viewArea setFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height+20)];
        [self.viewInsidePicker setFrame:CGRectMake(0, [UIScreen mainScreen].applicationFrame.size.height-216-44+20, [UIScreen mainScreen].applicationFrame.size.width, 44)];
        pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].applicationFrame.size.height-216+20, 320, 216)];
        pickerView.backgroundColor = [UIColor whiteColor];
        [self.viewArea addSubview:pickerView];
        pickerView.delegate=self;
        pickerView.dataSource=self;
        pickerView.showsSelectionIndicator = YES;
        [[AppDelegate sharedDelegate].window addSubview:self.viewArea];
        [self loadPickerView];
        if (![[NSUserDefaults standardUserDefaults] valueForKey:kSelectArea])
        {
            [pickerView selectRow:0 inComponent:0 animated:NO];
        }
        else
            [pickerView selectRow:[arrArea indexOfObject:[[NSUserDefaults standardUserDefaults] valueForKey:kSelectArea] ] inComponent:0 animated:NO];
        
        [self loadPickerView];
        currentTextField = textField;
        return NO;
    }
    else
    {
        [self pickerViewDown];
        if ([keyboardControls.textFields containsObject:textField])
            keyboardControls.activeTextField = textField;
        [self scrollViewToCenterOfScreen:textField];
        currentTextField = textField;
        return YES;
    }
}

#pragma mark - UITextField Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
   // [controls.activeTextField resignFirstResponder];
    [scrlView setContentOffset:CGPointMake(0, 0) animated:YES];
    return YES;
}

#pragma mark UITextview delegate
#pragma mark -
#pragma mark sd

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    [textField setBackground:[UIImage imageNamed:@"text-field-selected.png"]];
//}
//
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    [textField setBackground:[UIImage imageNamed:@"text-field-unselected.png"]];
//
//}

-(void)loadPickerView
{
    [self.viewArea setFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height)];
}

-(void)pickerViewDown
{
    [self.viewArea setFrame:CGRectMake(0, [UIScreen mainScreen].applicationFrame.size.height+20,[UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height)];
}


-(IBAction)btnCancelClicked
{
    [self.viewArea setFrame:CGRectMake(0, [UIScreen mainScreen].applicationFrame.size.height+20,[UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height)];
    txtFAddressLineOne.text = [[NSUserDefaults standardUserDefaults] valueForKey:kSelectArea] ;
    [scrlView setContentOffset:CGPointMake(0, 0) animated:YES];
}


-(IBAction)btnDoneClicked
{
    [self pickerViewDown];
    txtFAddressLineOne.text = self.strArea;
    self.strArea  = txtFAddressLineOne.text;
    [[NSUserDefaults standardUserDefaults] setValue:txtFAddressLineOne.text forKey:kSelectArea];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [scrlView setContentOffset:CGPointMake(0, 0) animated:YES];
}


#pragma mark UIPickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [arrArea count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [arrArea objectAtIndex:row] ;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    self.strArea= [arrArea objectAtIndex:row] ;
    intIndex = row;
    txtFAddressLineOne.text = self.strArea;
}


#pragma -mark server method
-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    [MBProgressHUD hideAllHUDsForView:[App_Delegate window] animated:YES];
    NSString *aStrResult=[[NSString alloc] initWithData:[aReq responseData] encoding:NSUTF8StringEncoding];
    NSLog(@"aStrResult=%@",aStrResult);
    if([MethoodName caseInsensitiveCompare:kSaveOrder]==0)
    {
        [self.view endEditing:YES];
        NSError *jsonParsingError = nil;
        NSDictionary *aResultDictionery = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:[aReq responseData] options:0 error:&jsonParsingError]];
        NSLog(@"%@",aResultDictionery);
        if([[[aResultDictionery objectForKey:@"status"] objectForKey:@"status"] boolValue])
        {
            GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
            [GDP.arrCartItems removeAllObjects];
            GDP = nil;
            [AppDelegate sharedDelegate].boolCartEmpty = TRUE;
            [AppDelegate sharedDelegate].boolController = TRUE;
            
            ThankyouViewController *obj = [[ThankyouViewController alloc]initWithNibName:@"ThankyouViewController" bundle:nil];
            obj.strOrderId = [[aResultDictionery objectForKey:@"responseData"] objectForKey:@"order_id"];
            [self.navigationController pushViewController:obj animated:YES];
        }
        else
        {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[[aResultDictionery objectForKey:@"status"]valueForKey:@"status_message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else if([MethoodName caseInsensitiveCompare:kGetTerms]==0)
    {
        [self.view endEditing:YES];
        NSError *jsonParsingError = nil;
        NSDictionary *aResultDictionery = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:[aReq responseData] options:0 error:&jsonParsingError]];
        NSLog(@"%@",aResultDictionery);
        if ([[[aResultDictionery objectForKey:@"status"] objectForKey:@"status"] boolValue]) {
            NSString *strResponse = [[aResultDictionery objectForKey:@"responseData"] objectForKey:@"description"];
            strResponse = [strResponse stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
            strResponse =   [strResponse stringByReplacingOccurrencesOfString:@"&amp;nbsp;" withString:@" "];
            strResponse =   [strResponse stringByReplacingOccurrencesOfString:@"&amp;quot;" withString:@"\""];
            strResponse =   [strResponse stringByReplacingOccurrencesOfString:@"&amp;zwnj;" withString:@"می‌خواهم"];
            [webTerms loadHTMLString:[NSString stringWithFormat:@"<div style='text-align:left; font-size:14px;font-family:Optima;color:FFFFFF;'>%@",strResponse] baseURL:nil];
        }
    }
    else if ([MethoodName caseInsensitiveCompare:kGetCityProductList]==0)
    {
        [self.view endEditing:YES];
        NSError *jsonParsingError = nil;
        NSDictionary *aResultDictionery = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:[aReq responseData] options:0 error:&jsonParsingError]];
        NSLog(@"%@",aResultDictionery);
        if([[[aResultDictionery objectForKey:@"status"] objectForKey:@"status"] boolValue])
        {
            arrArea = [[NSMutableArray alloc] init];
            NSMutableArray *arr = [aResultDictionery objectForKey:@"responseData"];
            for (int i=0; i<[arr count]; i++)
            {
                [arrArea addObject:[[arr objectAtIndex:i] objectForKey:@"area_name"]];
            }
            self.strArea = [arrArea objectAtIndex:0];
       
        }
        else
        {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[[aResultDictionery objectForKey:@"status"]valueForKey:@"status_message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
        }

    }
}

-(void) dataDownloadFail:(ASIHTTPRequest*)aReq  withMethood:(NSString *)MethoodName
{
    [MBProgressHUD hideAllHUDsForView:[App_Delegate window] animated:YES];
}


#pragma mark UIWebview Delegate
//- (void)webViewDidStartLoad:(UIWebView *)webView{
//    [self.activityLoader startAnimating];
//}
//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    [self.activityLoader stopAnimating];
//}
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    [self.activityLoader stopAnimating];
//    [self.navigationController popViewControllerAnimated:YES];
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Notice !" message:@"Please try again your transaction get failed " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"", nil];
//    [alert show];
//}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityLoader startAnimating];
}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityLoader stopAnimating];
   
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityLoader stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
