//
//  ProductDetailViewController.m
//  Yam3ah
//
//  Created by admin on 10/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "MenuProductDetailViewController.h"
#import "EGOImageView.h"
#import "Config.h"
#import "CartItemData.h"
#import "GlobalDataPersistence.h"
#import "AppDelegate.h"
#import "iToast.h"
#import "NSAttributedString+Attributes.h"
#import "CompanyDetailViewController.h"

@interface MenuProductDetailViewController ()

@end

@implementation MenuProductDetailViewController
@synthesize dictProductDetail;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"dictProductDetail=%@",dictProductDetail);
    lblProductName.text = [dictProductDetail objectForKey:@"product_name"];
    lblHeadingProductName.text = [dictProductDetail objectForKey:@"product_name"];
    lblPrice.text = [NSString stringWithFormat:@"%@ %@",[dictProductDetail objectForKey:@"product_price"],[dictProductDetail objectForKey:@"product_currency"]];
    [txtDescription setFont:[UIFont fontWithName:KCustomFont size:[[txtDescription font] pointSize]]];
    txtDescription.text = [dictProductDetail objectForKey:@"product_desc"];
   
    txtDescription.frame = CGRectMake(txtDescription.frame.origin.x, txtDescription.frame.origin.y, txtDescription.frame.size.width, txtDescription.frame.size.height+[self txtViewHeight:[dictProductDetail objectForKey:@"product_desc"] width:txtDescription.frame.size.width height:txtDescription.frame.size.height fontname:@"Optima" size:14.0]);
    
    if ([UIScreen mainScreen].applicationFrame.size.height < 480)
    {
        scrlViewMain.contentSize=CGSizeMake([UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height+50+[self txtViewHeight:[dictProductDetail objectForKey:@"product_desc"] width:txtDescription.frame.size.width height:txtDescription.frame.size.height fontname:@"Optima" size:14.0]);
    }
    else
    {
        scrlViewMain.contentSize=CGSizeMake([UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height+[self txtViewHeight:[dictProductDetail objectForKey:@"product_desc"] width:txtDescription.frame.size.width height:txtDescription.frame.size.height fontname:@"Optima" size:14.0]);
    }
    [self AddProductImages];
}


#pragma mark - Adding Product Images with pageControl
-(void)AddProductImages
{
    NSLog(@"dictProductDetail=%@",dictProductDetail);
    NSMutableArray *arr = [dictProductDetail objectForKey:@"product_image"];
    
    for (int i = 0; i < 1; i++) {
        CGRect frame;
        frame.origin.x = imgScrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = imgScrollView.frame.size;
        EGOImageView* imgView = [[EGOImageView alloc] init];
        imgView.frame = frame;
        [imgView setShowActivity:YES];
        [imgView setImageURL:[NSURL URLWithString:[[arr objectAtIndex:i] objectForKey:@"product_image_url"]]];
        imgView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                      UIViewAutoresizingFlexibleLeftMargin |
                                      UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleRightMargin);

        [imgScrollView addSubview:imgView];
    }
    imgPageCtrl.currentPage = 0;
    imgPageCtrl.numberOfPages = arr.count;
    imgScrollView.contentSize = CGSizeMake([UIScreen mainScreen].applicationFrame.size.width * arr.count, imgScrollView.frame.size.height);
}

#pragma mark - ScrollView Delegates
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = imgScrollView.frame.size.width;
    int page = floor((imgScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    imgPageCtrl.currentPage = page;
}

#pragma mark TextView Height
-(CGFloat)txtViewHeight:(NSString*)str width:(float)width height:(float)heightTmp fontname:(NSString*)strFontName size:(float)size
{
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
        [attributedString setFont:[UIFont fontWithName:@"Optima" size:14.0]];
        CGFloat height1 = [self textViewHeightForAttributedText:attributedString width:width height:heightTmp];
        height=0.0;
        if(height1>heightTmp)
        {
            height=height1-heightTmp;
        }
    }
    else
    {
        UITextView *txtViewHeight = [[UITextView alloc] init];
        txtViewHeight.frame = CGRectMake(0, 0, width, heightTmp);
        txtViewHeight.font = [UIFont fontWithName:@"Optima" size:14.0];
        txtViewHeight.text = str;
        [self.view addSubview:txtViewHeight];
        rect = txtViewHeight.frame;
        rect.size = txtViewHeight.contentSize;
        txtViewHeight.frame = rect;
        [txtViewHeight removeFromSuperview];
        if(rect.size.height>heightTmp)
            height=rect.size.height-heightTmp;
    }
    return height;
}


- (CGFloat)textViewHeightForAttributedText:(NSMutableAttributedString*)text  width:(float)width height:(float)heightTmp
{
    UITextView *txtSavedSearch = [[UITextView alloc] init];
    [txtSavedSearch setAttributedText:text];
    CGSize size = [txtSavedSearch sizeThatFits:CGSizeMake(width, heightTmp)];
    return size.height;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backBtnPressed:(id)sender;
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addtoCartBtnPressed:(id)sender
{
    [self addProductInCart];
}

-(void)addProductInCart
{
    NSLog(@"%@", dictProductDetail);
    
      [[[[[iToast makeText:NSLocalizedString(@"Item added to cart", @"Item added to cart")] setGravity:iToastGravityCenter] setUseShadow:YES] setDuration:iToastDurationShort] show];
    
  //  [[iToast makeText:NSLocalizedString(@"The activity has been successfully saved.", @"")] show];

    
    CartItemData *cartItem = [CartItemData new];
    [cartItem setMenu_id:[dictProductDetail objectForKey:@"product_id"]];
    [cartItem setStrCompany_id:[dictProductDetail objectForKey:@"company_id"]];
    [cartItem setAttr_id:@"0"];
    [cartItem setPrice:[dictProductDetail objectForKey:@"product_price"]];
    [cartItem setItem_image:[dictProductDetail objectForKey:@"feature_image"]];
    [cartItem setQty:@"1"];
    [cartItem setItem_name:[dictProductDetail objectForKey:@"product_name"]];
    [cartItem setItem_info:[NSString stringWithFormat:@"%@,%@",cartItem.menu_id,cartItem.Attr_id]];
    [self checkForExistingItem:cartItem];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateTabbar object:nil];
    NSLog(@"None Attribute");

}
- (void)checkForExistingItem:(CartItemData *)cartItem
{
    GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
    
    if (!GDP.arrCartItems)
    {
        GDP.arrCartItems = [NSMutableArray array];
    }
    
    BOOL isExist = NO;
    int count = 0;
    CartItemData *itemToUpdate = nil;
    for (CartItemData *aItem in GDP.arrCartItems)
    {
        if ([aItem.item_info isEqualToString:cartItem.item_info])
        {
            isExist = YES;
            itemToUpdate = aItem;
            break;
        }
        count = count + 1;
    }
    if (isExist)
    {
        //update quantity of the existing item
        itemToUpdate.qty = [NSString stringWithFormat:@"%d",[itemToUpdate.qty integerValue]+1];
        [GDP.arrCartItems replaceObjectAtIndex:count withObject:itemToUpdate];
    }
    else
    {
        //add new item.
        [GDP.arrCartItems addObject:cartItem];
    }
    NSLog(@"%@",GDP.arrCartItems);
}

- (IBAction)buyNowBtnPressed:(id)sender
{
    GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
    if (GDP.arrCartItems.count>0)
    {
        AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
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
        
        //[appDel.tabBarController setSelectedIndex:3];
    }
    else
    {
        UIAlertView *alert = KALERT(@"Notice!", @"Please add atleast one product into cart", nil);
        [alert show];
    }
}

@end
