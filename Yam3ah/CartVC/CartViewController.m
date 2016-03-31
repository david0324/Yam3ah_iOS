//
//  SecondViewController.m
//  LocationPickerView-Demo
//
//  Created by Christopher Constable on 5/11/13.
//  Copyright (c) 2013 Christopher Constable. All rights reserved.
//

#import "CartViewController.h"
#import "CartTVCell.h"
#import "UIImage+ImageEffects.h"
#import "Global.h"
#import "Config.h"
#import "CheckoutViewController.h"
#import "AppDelegate.h"
#import "ThankyouViewController.h"
#import "Utils.h"

@interface CartViewController ()
{
    GlobalDataPersistence *GDP;
}
@property (nonatomic , retain) UIImage *image;

@end

@implementation CartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [txtSpecialrequest setPlaceholderText:@"Special Request"];
    //[txtSpecialrequest setText:@"Special Request"];
    [txtSpecialrequest setFont:[UIFont fontWithName:@"Optima-Regular" size:11]];
    [txtSpecialrequest setTextColor:[UIColor lightGrayColor]];
    
	// Do any additional setup after loading the view.
}
- (void)setUpdateValues
{
    if (GDP.arrCartItems.count)
    {
//        [aTableView setTableFooterView:tblHdr];
      //  self.shouldShowFooter = YES;
        [btnMessage setAlpha:0.0];
        tblHdr.hidden=NO;
    }
    else
    {
//        [aTableView setTableFooterView:nil];
        self.shouldShowFooter = NO;
        tblHdr.hidden=YES;

        [self showAnimation];
    }
    [aTableView reloadData];
    [lblTotItems setAttributedText: [Global getCartTotalQuantity]];
    [lblTotPrice setAttributedText: [Global getCartTotalPrice]];
}
- (void)viewWillAppear:(BOOL)animated
{
    GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
    
    if(GDP.arrCartItems.count)
        //self.shouldShowFooter = YES;
        tblHdr.hidden = NO;
    else
        tblHdr.hidden = YES;
    [aTableView reloadData];
    [self setUpdateValues];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)btnDeleteTapped:(UIButton *)sender
{
    UIAlertView *alert = KALERT_YN(@"Delete", @"Are you sure you want to delete?", self);
    [alert setTag:sender.tag];
    [alert show];
}
- (void)btnEditTapped:(UIButton *)sender
{
    btnSenderTag = sender;
    self.selecteCartItem = [GDP.arrCartItems objectAtIndex:sender.tag];
    [txtfQuantity setText:self.selecteCartItem.qty];
    [txtSpecialrequest setText:self.selecteCartItem.strSpecialrequest];
    [self.view addSubview:viewEditQuantity];
}

-(IBAction)increaseQuantity:(id)sender
{
    NSLog(@"GDP.arrCartItems =%@",GDP.arrCartItems);
    int i= [[txtfQuantity text] intValue];
    if (i>=[self.selecteCartItem.strProduct_quantity intValue])
    {
        [Utils showAlertMessage:@"Yam3ah" Message:kProductAvailability];
    }
    else
    {
        [txtfQuantity setText:[NSString stringWithFormat:@"%i",++i]];
    }
}

-(IBAction)decreaseQuantity:(id)sender
{
    int i= [[txtfQuantity text] intValue];
    
    if(i>1)
    {
        [txtfQuantity setText:[NSString stringWithFormat:@"%i",--i]];
    }
}

-(IBAction)BtnOk:(id)sender
{
    [viewEditQuantity removeFromSuperview];
    if ([self.selecteCartItem.qty integerValue] != [txtfQuantity.text integerValue])
    {
        self.selecteCartItem.qty = txtfQuantity.text;
       
        [aTableView reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateTabbar object:nil];
    }
    self.selecteCartItem.strSpecialrequest = txtSpecialrequest.text;
    [self setUpdateValues];
}

- (IBAction)btnProceedCheckout:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateTabbar object:[NSDictionary dictionaryWithObject:@"2" forKey:kUpdateTabbar]];
    
    if ([AppDelegate sharedDelegate].boolController)
    {
        [AppDelegate sharedDelegate].boolController = FALSE;
        NSArray *Arrcontroller=[[AppDelegate sharedDelegate].tabBarController viewControllers];
        UINavigationController *ViewControlTmp=[Arrcontroller objectAtIndex:3];
        Arrcontroller=[ViewControlTmp viewControllers];
        
        if([Arrcontroller count]>1)
        {
            [ViewControlTmp popToViewController:[Arrcontroller objectAtIndex:0] animated:YES];
//            for (int i=0; i<[Arrcontroller count]; i++)
//            {
//                if ([[Arrcontroller objectAtIndex:i] isKindOfClass:[ThankyouViewController class]])
//                {
//                    UIViewController *viewControl = [Arrcontroller objectAtIndex:i];
//                    [viewControl.navigationController popToRootViewControllerAnimated:YES];
//                }
//            }
            
        }
    }
    else
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.tabBarController.selectedIndex = 3;

    }
    
//    CheckoutViewController *checkOut = [[CheckoutViewController alloc] initWithNibName:@"CheckoutViewController" bundle:nil];
//    [self.navigationController pushViewController:checkOut animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [GDP.arrCartItems removeObjectAtIndex:alertView.tag];
        [aTableView reloadData];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateTabbar object:nil];
        
        if (GDP.arrCartItems.count)
        {
//            [aTableView setTableFooterView:tblHdr];
//            self.shouldShowFooter = YES;
            tblHdr.hidden=NO;
        }
        else
        {
            [self showAnimation];
//            self.shouldShowFooter = NO;
            tblHdr.hidden=YES;
//            [aTableView setTableFooterView:nil];
            
        }
        [aTableView reloadData];
        [self setUpdateValues];
    }
}
- (void)showAnimation
{
    [UIView animateWithDuration:0.2 animations:
     ^(void){
         btnMessage.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1f, 1.1f);
         btnMessage.alpha = 0.5;
     }
                     completion:^(BOOL finished){
                         [self bounceOutAnimationStoped];
                     }];
}
- (void)bounceOutAnimationStoped
{
    
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         btnMessage.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9, 0.9);
         btnMessage.alpha = 0.8;
     }
                     completion:^(BOOL finished){
                         [self bounceInAnimationStoped];
                     }];
}
- (void)bounceInAnimationStoped
{
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         btnMessage.transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
         btnMessage.alpha = 1.0;
     }
                     completion:^(BOOL finished){
                     }];
}
- (void)hideBadge
{
    btnMessage.alpha = 0;
    btnMessage.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.6, 0.6);
}
#pragma mark - UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 89;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return GDP.arrCartItems.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartItemData *aItem = [GDP.arrCartItems objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"CartTVCell";
    CartTVCell* cell = nil;
    cell = (CartTVCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CartTVCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[CartTVCell class]])
            {
                cell = (CartTVCell*)currentObject;
                break;
            }
        }
    }
    cell.backgroundColor = kClearColor;
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    [cell.imgItem setImageURL:[NSURL URLWithString:aItem.item_image]];
    
    [[cell.viewImg layer] setCornerRadius:5.0];
    cell.viewImg.layer.masksToBounds = YES;
    
    [cell.lblItemName setText:aItem.item_name];
    [cell.lblQuantity setText:aItem.qty];
    [cell.lblPrice setText:aItem.price];
    
    [cell.btnDelete addTarget:self action:@selector(btnDeleteTapped:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnDelete setTag:indexPath.row];
    [cell.btnEdit addTarget:self action:@selector(btnEditTapped:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnEdit setTag:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/*
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(self.shouldShowFooter)
        return tblHdr;
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(self.shouldShowFooter)
        return tblHdr.frame.size.height;
    return 0.0;
}*/

#pragma mark -
#pragma mark sd

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


/*

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView.textColor == [UIColor lightGrayColor]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(textView.text.length == 0){
        textView.textColor = [UIColor lightGrayColor];
        textView.text = @"Special Request";
        [textView resignFirstResponder];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(textView.text.length == 0){
            textView.textColor = [UIColor lightGrayColor];
            textView.text = @"Special Request";
            [textView resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}
 */

@end
