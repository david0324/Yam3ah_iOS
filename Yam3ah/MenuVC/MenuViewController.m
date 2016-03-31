//
//  MenuViewController.m
//  CoffeeApp
//
//  Created by Sheetal on 1/27/15.
//  Copyright (c) 2015 Dotsquares. All rights reserved.
//

#import "MenuViewController.h"
#import "Config.h"
#import "MenuItemTVCell.h"
#import "CartTVCell.h"
#import "AttributeTVCell.h"
#import "CartItemData.h"
#import "GlobalDataPersistence.h"
#import "iToast.h"
#import "WebCommunicationClass.h"
#import "Config.h"
#import "LetterProgressView.h"
#import "AppDelegate.h"
#import "Utils.h"
#import "MenuProductDetailViewController.h"

#define kSelectPrice @"selectprice"
@interface MenuViewController ()
{
    int senderbtntag;
}
@end

@implementation MenuViewController
@synthesize strPrice,pickerViewPrice;
@synthesize viewPrice,viewInsidePicker;
@synthesize arrItemTmp,arrItems;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSelectPrice];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    aTableView.backgroundView = [[UIImageView alloc] initWithImage:
                                    [UIImage imageNamed:@"bg_company.png"]];
    [self receiveNotification:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:kUpdateTabbar
                                               object:nil];
    
    cartItemBadge = [CustomBadge customBadgeWithString:@""
                                       withStringColor:[UIColor whiteColor]
                                        withInsetColor:kBadgeIconColor
                                        withBadgeFrame:YES
                                   withBadgeFrameColor:kBadgeIconColor
                                             withScale:0.6
                                           withShining:NO];
    [cartItemBadge setFrame:CGRectMake(267, 33, cartItemBadge.frame.size.width, cartItemBadge.frame.size.height)];
    
    [cartItemBadge setHidden:YES];
    [self.view addSubview:cartItemBadge];
    GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
    if (!GDP.arrCartItems)
    {
        GDP.arrCartItems = [NSMutableArray array];
    }
    [lblTitle setText:self.title];
    NSLog(@"%@",self.arrItems);
    
    //Kapil
    [lblTitle setText:[self.dictCategoryItems valueForKey:@"com_cat_title"]];
    self.arrItems = [[NSMutableArray alloc] init];
    self.arrItemTmp = [[NSMutableArray alloc] init];

    self.arrItems = [[self.dictCategoryItems valueForKey:@"products"] mutableCopy];
    self.arrItemTmp = [[self.dictCategoryItems valueForKey:@"products"] mutableCopy];

  
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateTabbar object:nil];
    // Do any additional setup after loading the view from its nib.
    
    arrPrice = [[NSMutableArray alloc] initWithObjects:@"-- All prices --",@"Under KD 25",@"KD 25 - KD 30",@"KD 30 - KD 45",@"Over KD 45", nil];
    strPrice = @"-- All prices --";
    if (![[NSUserDefaults standardUserDefaults] valueForKey:kSelectPrice])
        [btnPrice setTitle:strPrice forState:UIControlStateNormal];
    else
        [btnPrice setTitle:[[NSUserDefaults standardUserDefaults] valueForKey:kSelectPrice] forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([AppDelegate sharedDelegate].boolCartEmpty)
    {
        [AppDelegate sharedDelegate].boolCartEmpty = FALSE;
        [lblPrice setText:nil];
        cartItemBadge.alpha = 0.0;
        [cartItemBadge autoBadgeSizeWithString:@""];
        [cartItemBadge setHidden:YES];
        [self showAnimation];
    }
    [viewPopUp removeFromSuperview];
}

#pragma mark UIPickerview
-(IBAction)btnPriceClicked
{
    [viewPrice setFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height+20)];
    [viewInsidePicker setFrame:CGRectMake(0, [UIScreen mainScreen].applicationFrame.size.height-216-44+20, [UIScreen mainScreen].applicationFrame.size.width, 44)];
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].applicationFrame.size.height-216+20, 320, 216)];
    pickerView.backgroundColor = [UIColor whiteColor];
    [viewPrice addSubview:pickerView];
    pickerView.delegate=self;
    pickerView.dataSource=self;
    pickerView.showsSelectionIndicator = YES;
    [[AppDelegate sharedDelegate].window addSubview:viewPrice];
    [self loadPickerView];
    if (![[NSUserDefaults standardUserDefaults] valueForKey:kSelectPrice])
    {
        [pickerView selectRow:0 inComponent:0 animated:NO];
    }
    else
        [pickerView selectRow:[arrPrice indexOfObject:[[NSUserDefaults standardUserDefaults] valueForKey:kSelectPrice] ] inComponent:0 animated:NO];
}

-(void)loadPickerView
{
    [viewPrice setFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height)];
}

-(void)pickerViewDown
{
    [viewPrice setFrame:CGRectMake(0, [UIScreen mainScreen].applicationFrame.size.height+20,[UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height)];
}


-(IBAction)btnCancelClicked
{
    [viewPrice setFrame:CGRectMake(0, [UIScreen mainScreen].applicationFrame.size.height+20,[UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height)];
    [btnPrice setTitle:[[NSUserDefaults standardUserDefaults] valueForKey:kSelectPrice] forState:UIControlStateNormal];
}

-(IBAction)btnDoneClicked
{
    [btnPrice setTitle:strPrice forState:UIControlStateNormal];
    [self pickerViewDown];
    if (intIndex==0) {
        [self filterByPrice:0 to:0];
    }
    else if (intIndex==1) {
        [self filterByPrice:0 to:24];
    }
    else if (intIndex==2) {
        [self filterByPrice:25 to:30];
    }
    else if (intIndex==3) {
        [self filterByPrice:30 to:45];
    }
    else if (intIndex==4) {
        [self filterByPrice:46 to:46];
    }
    
    strPrice = btnPrice.titleLabel.text;
    [[NSUserDefaults standardUserDefaults] setValue:btnPrice.titleLabel.text forKey:kSelectPrice];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [aTableView reloadData];
}

-(NSMutableArray*)filterByPrice:(int)from to:(int)to
{
    [self.arrItems removeAllObjects];
    for (int i=0; i<[self.arrItemTmp count]; i++)
    {
        if (from==0 && to==0)
        {
            [arrItems addObject:[self.arrItemTmp objectAtIndex:i]];
        }
        else if(from==0 && to<25)
        {
            if ([[[self.arrItemTmp objectAtIndex:i] objectForKey:@"product_price"] intValue]==from && [[[self.arrItemTmp objectAtIndex:i] objectForKey:@"product_price"] intValue]<to)
            {
                [arrItems addObject:[self.arrItemTmp objectAtIndex:i]];
            }
        }
        else if(from>=25 && to<=30)
        {
            if ([[[self.arrItemTmp objectAtIndex:i] objectForKey:@"product_price"] intValue]>=from && [[[self.arrItemTmp objectAtIndex:i] objectForKey:@"product_price"] intValue]<=to)
            {
                [arrItems addObject:[self.arrItemTmp objectAtIndex:i]];
            }
        }
        else if(from>=30 && to<=45)
        {
            if ([[[self.arrItemTmp objectAtIndex:i] objectForKey:@"product_price"] intValue]>=from && [[[self.arrItemTmp objectAtIndex:i] objectForKey:@"product_price"] intValue]<=to)
            {
                [arrItems addObject:[self.arrItemTmp objectAtIndex:i]];
            }
        }
        else if(from>45 && to>45)
        {
            if ([[[self.arrItemTmp objectAtIndex:i] objectForKey:@"product_price"] intValue]>from && [[[self.arrItemTmp objectAtIndex:i] objectForKey:@"product_price"] intValue]>to)
            {
                [arrItems addObject:[self.arrItemTmp objectAtIndex:i]];
            }
        }
    }
    return self.arrItems;
}

#pragma mark UIPickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [arrPrice count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [arrPrice objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    strPrice= [arrPrice objectAtIndex:row];
    intIndex = row;
    [btnPrice setTitle:strPrice forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBAction methods
- (IBAction)btnBack:(id)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [aTableView setDelegate:nil];
    [aTableView setDataSource:nil];
    aTableView = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnRemovePopUp:(id)sender
{
    [viewPopUp removeFromSuperview];
}
- (IBAction)btnCartTapped:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateTabbar object:[NSDictionary dictionaryWithObject:@"1" forKey:kUpdateTabbar]];
}
#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (tableView == aTableView)
//    {
//        return self.arrItems.count;
//    }
//    else if (tableView == tblCartLIst)
//    {
//        return self.arrAttributes.count;
//    }
//    return 0;
    return [self.arrItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == aTableView)
    {
        static NSString *CellIdentifier = @"MenuItemTVCell";
        MenuItemTVCell* cell = nil;
        cell = (MenuItemTVCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MenuItemTVCell" owner:nil options:nil];
            
            for(id currentObject in topLevelObjects)
            {
                if([currentObject isKindOfClass:[MenuItemTVCell class]])
                {
                    cell = (MenuItemTVCell *)currentObject;
                }
            }
        }
        NSDictionary *aDict = [self.arrItems objectAtIndex:indexPath.row];
    
        @try
        {
            NSString *item_price = [NSString stringWithFormat:@"%@",[aDict objectForKey:@"product_price"]];
            [cell.lblPrice setText:[NSString stringWithFormat:@"%.2f%@",[item_price floatValue],[aDict objectForKey:@"product_currency"]]];
        }
        @catch (NSException *exception)
        {
            NSLog(@"menuviewcontroller = %@",[exception description]);
        }
        @finally
        {
            
        }
        NSString *item_name = [NSString stringWithFormat:@"%@",[aDict objectForKey:@"product_name"]];
        [cell.lblItemName setText:[item_name uppercaseString]];
        
        cell.lblQuantity.text = [aDict objectForKey:@"product_quantity"];

        cell.lblItemDescription.text = [aDict objectForKey:@"product_desc"];
        [cell.imgItem setShowActivity:YES];
        //[cell.imgItem setImageURL:[NSURL URLWithString:[[[aDict objectForKey:@"product_image"] objectAtIndex:0]valueForKey:@"product_image_url"]]];
        
        [cell.imgItem setImageURL:[NSURL URLWithString:[[self.arrItems objectAtIndex:indexPath.row] objectForKey:@"product_feature_image"]]];
        
        [cell.btnAddToCart setTag:indexPath.row];
        [cell.btnAddToCart addTarget:self action:@selector(btnAddToCartClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.lblPrice setClipsToBounds:YES];
        
        cell.btnProduct.tag=indexPath.row;
        [cell.btnProduct addTarget:self action:@selector(btnProductDetail:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    else if (tableView == tblCartLIst)
    {
        static NSString *CellIdentifier = @"AttributeTVCell";
        AttributeTVCell* cell = nil;
        cell = (AttributeTVCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"AttributeTVCell" owner:nil options:nil];
            
            for(id currentObject in topLevelObjects)
            {
                if([currentObject isKindOfClass:[AttributeTVCell class]])
                {
                    cell = (AttributeTVCell *)currentObject;
                }
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *aDict = [self.arrAttributes objectAtIndex:indexPath.row];
        [[cell.btnPlus layer] setCornerRadius:15.0];
        [cell.lblAttrName setText:[NSString stringWithFormat:@"%@",[[aDict objectForKey:@"Attr_name"] capitalizedString]]];
        [cell.lblAttrPrice setText:[NSString stringWithFormat:@"KD%@",[aDict objectForKey:@"Attr_price"]]];
        return cell;
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   /* if (aTableView == tableView)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        self.dictAttributeInfo = [NSDictionary dictionaryWithDictionary:[self.arrItems objectAtIndex:indexPath.row]];
        NSLog(@"%@",self.dictAttributeInfo);
        self.arrAttributes = nil;
        self.arrAttributes = [NSArray arrayWithArray:[self.dictAttributeInfo objectForKey:@"Attribute"]];
        
        NSArray *arrAttr = [NSArray arrayWithArray:self.arrAttributes];
        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"Attr_price"  ascending:YES];
        self.arrAttributes=[arrAttr sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
        
        if (self.arrAttributes.count)
        {
            NSLog(@"Attribute");
            [[imgItem layer] setCornerRadius:8.0];
            [imgItem setImageURL:[NSURL URLWithString:[self.dictAttributeInfo objectForKey:@"item_image"]]];
            UIImage *backgroundImage = [UIImage imageNamed:@"popup_box.png"];
            UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:backgroundImage];
            tblCartLIst.backgroundView=backgroundImageView;
            [lblCategoryName setText:[self.dictAttributeInfo objectForKey:@"item_name"]];
            [viewPopUp setFrame:CGRectMake(aTableView.frame.origin.x, aTableView.frame.origin.y, aTableView.frame.size.width, aTableView.frame.size.height+2)];
            [self.view addSubview:viewPopUp];
            [tblCartLIst setTableHeaderView:tblCartHdr];
            [tblCartLIst reloadData];
        }
        else
        {
            
       /*  GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];

            if ([GDP.prevShopID intValue]<=0 || [GDP.prevShopID intValue]==[GDP.selectedShopID intValue] || GDP.arrCartItems.count==0)
            {
                [self addProductInCart];
                GDP.prevShopID=GDP.selectedShopID;
            }
            else
            {
                UIAlertView *alert = KALERT_YN(@"Notice!", @"Changing coffee shop will remove all items from cart.\nAre you sure you want to proceed?", self);
//                [alert setTag:[aShop.shop_id integerValue]];
                [alert show];
            }
            
        //}
    }
    /*else if (tableView == tblCartLIst)
    {
        GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
        if ([GDP.prevShopID intValue]<=0 || [GDP.prevShopID intValue]==[GDP.selectedShopID intValue]  || GDP.arrCartItems.count==0)
        {
            [self addAttributedProductedInCart:indexPath];
            GDP.prevShopID=GDP.selectedShopID;
        }
        else
        {
            UIAlertView *alert = KALERT_YN(@"Notice!", @"Changing coffee shop will remove all items from cart.\nAre you sure you want to proceed?", self);
            //                [alert setTag:[aShop.shop_id integerValue]];
            [alert show];
        }
    }*/
    MenuProductDetailViewController *product = [[MenuProductDetailViewController alloc] initWithNibName:@"MenuProductDetailViewController" bundle:nil];
    product.dictProductDetail = [self.arrItems objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:product animated:YES];
}


-(void)btnAddToCartClicked:(UIButton*)sender
{
//    UIButton *btn = sender;
//    
//    self.dictAttributeInfo = [NSDictionary dictionaryWithDictionary:[self.arrItems objectAtIndex:btn.tag]];
//    NSLog(@"%@",self.dictAttributeInfo);
//    GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
//    
//    if ([GDP.prevShopID intValue]<=0 || [GDP.prevShopID intValue]==[GDP.selectedShopID intValue] || GDP.arrCartItems.count==0)
//    {
//        [self addProductInCart];
//        GDP.prevShopID=GDP.selectedShopID;
//    }
//    else
//    {
//        UIAlertView *alert = KALERT_YN(@"Notice!", @"Changing coffee shop will remove all items from cart.\nAre you sure you want to proceed?", self);
//        //                [alert setTag:[aShop.shop_id integerValue]];
//        [alert show];
//    }
   
    /*
    [viewPopUp setFrame:CGRectMake(aTableView.frame.origin.x, aTableView.frame.origin.y, aTableView.frame.size.width, aTableView.frame.size.height+2)];
    UIButton *btn = sender;
    senderbtntag = btn.tag;
    [self.view addSubview:viewPopUp];
    [txtSpecialrequest setText:@""];*/

    UIButton *btn = sender;
    senderbtntag = btn.tag;
    
    if([[[self.arrItems objectAtIndex:btn.tag] objectForKey:@"product_quantity"] isEqualToString:@"0"])
    {
        [Utils showAlertMessage:@"Yam3ah" Message:@"This product is not available in stock"];
    }
    else
    {
        [self myCartClick:btn.tag];
    }
}

-(void)myCartClick:(int)intTag
{
    self.dictAttributeInfo = [NSDictionary dictionaryWithDictionary:[self.arrItems objectAtIndex:senderbtntag]];
    NSLog(@"%@",self.dictAttributeInfo);
    GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
    
    if ([GDP.prevShopID intValue]<=0 || [GDP.prevShopID intValue]==[GDP.selectedShopID intValue] || GDP.arrCartItems.count==0)
    {
        [self addProductInCart:intTag];
        GDP.prevShopID=GDP.selectedShopID;
    }
    else
    {
        UIAlertView *alert = KALERT_YN(@"Notice!", @"Changing coffee shop will remove all items from cart.\nAre you sure you want to proceed?", self);
        //                [alert setTag:[aShop.shop_id integerValue]];
        [alert show];
    }
}

#pragma mark - Add Products
-(void)addProductInCart:(int)intTag
{
    NSLog(@"%@",self.dictAttributeInfo);
    
    // Add product id in the cart directly
    CartItemData *cartItem = [CartItemData new];
    [cartItem setMenu_id:[self.dictAttributeInfo objectForKey:@"product_id"]];
    [cartItem setStrCompany_id:[self.dictAttributeInfo objectForKey:@"company_id"]];
    [cartItem setAttr_id:@"0"];
    [cartItem setPrice:[self.dictAttributeInfo objectForKey:@"product_price"]];
    [cartItem setItem_image:[self.dictAttributeInfo objectForKey:@"product_feature_thumb"]];
    [cartItem setQty:@"1"];
    [cartItem setItem_name:[self.dictAttributeInfo objectForKey:@"product_name"]];
    [cartItem setStrCurrency:[self.dictAttributeInfo objectForKey:@"product_currency"]];
    [cartItem setStrProduct_quantity:[self.dictAttributeInfo objectForKey:@"product_quantity"]];
    [cartItem setStrSpecialrequest:@""];

    [cartItem setItem_info:[NSString stringWithFormat:@"%@,%@",cartItem.menu_id,cartItem.Attr_id]];
    
    [self checkForExistingItem:cartItem index:intTag];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateTabbar object:nil];
    NSLog(@"None Attribute");
    [txtSpecialrequest setText:@""];
    [viewPopUp removeFromSuperview];
}

- (BOOL)checkForExistingItem:(CartItemData *)cartItem index:(int)intTag
{
    GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
    BOOL isExist = NO;
    int count = 0;
    CartItemData *itemToUpdate = nil;
    //NSString *strallspecial;
    
    for (CartItemData *aItem in GDP.arrCartItems)
    {
        if ([aItem.item_info isEqualToString:cartItem.item_info])
        {
            isExist = YES;
            itemToUpdate = aItem;
            //  strallspecial = aItem.strSpecialrequest;
            break;
        }
        count = count + 1;
    }
    if (isExist)
    {
        //update quantity of the existing item
        //itemToUpdate.strSpecialrequest = [NSString stringWithFormat:@"%@%@%@",strallspecial,@",",cartItem.strSpecialrequest];
        itemToUpdate.qty = [NSString stringWithFormat:@"%d",[itemToUpdate.qty integerValue]+1];
        if ([itemToUpdate.qty integerValue]>[[[self.arrItems objectAtIndex:senderbtntag] objectForKey:@"product_quantity"] integerValue])
        {
            itemToUpdate.qty = [NSString stringWithFormat:@"%d",[itemToUpdate.qty integerValue]-1];
            [Utils showAlertMessage:@"Yam3ah" Message:kProductAvailability];
            isBool = FALSE;
            return isBool;
        }
        else
        {
            [[[[[iToast makeText:NSLocalizedString(@"Item added to cart", @"Item added to cart")] setGravity:iToastGravityCenter] setUseShadow:YES] setDuration:iToastDurationShort] show];
            itemToUpdate.strSpecialrequest = cartItem.strSpecialrequest;
            [GDP.arrCartItems replaceObjectAtIndex:count withObject:itemToUpdate];
            isBool = TRUE;
            return isBool;
        }
    }
    else
    {
        //add new item.
        [[[[[iToast makeText:NSLocalizedString(@"Item added to cart", @"Item added to cart")] setGravity:iToastGravityCenter] setUseShadow:YES] setDuration:iToastDurationShort] show];
        [GDP.arrCartItems addObject:cartItem];
        isBool = TRUE;
        return isBool;
    }
    return isBool;
}



-(void)addAttributedProductedInCart:(NSIndexPath *)indexPath
{
    //add attr id as product in the cart
    [[[[[iToast makeText:NSLocalizedString(@"Item added to cart", @"Item added to cart")] setGravity:iToastGravityCenter] setUseShadow:YES] setDuration:iToastDurationShort] show];    
    NSDictionary *aDict = [self.arrAttributes objectAtIndex:indexPath.row];
    CartItemData *cartItem = [CartItemData new];
    [cartItem setMenu_id:[self.dictAttributeInfo objectForKey:@"id"]];
    [cartItem setAttr_id:[aDict objectForKey:@"Attr_id"]];
    [cartItem setPrice:[aDict objectForKey:@"Attr_price"]];
    [cartItem setItem_image:[self.dictAttributeInfo objectForKey:@"item_image"]];
    [cartItem setItem_name:[NSString stringWithFormat:@"%@ (%@)",[self.dictAttributeInfo objectForKey:@"item_name"],[aDict objectForKey:@"Attr_name"]]];
    [cartItem setQty:@"1"];
    [cartItem setItem_info:[NSString stringWithFormat:@"%@,%@",cartItem.menu_id,cartItem.Attr_id]];
 //   [self checkForExistingItem:cartItem];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateTabbar object:nil];
}

-(void)btnProductDetail:(UIButton*)sender
{
    MenuProductDetailViewController *product = [[MenuProductDetailViewController alloc] initWithNibName:@"MenuProductDetailViewController" bundle:nil];
    product.dictProductDetail = [self.arrItems objectAtIndex:[sender tag]];
    [self.navigationController pushViewController:product animated:YES];
}


#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
    if (buttonIndex == 1)
    {
        [GDP.arrCartItems removeAllObjects];
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateTabbar object:nil];
        GDP.prevShopID = GDP.selectedShopID;
    }
}

#pragma mark UITableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == aTableView)
    {
        return 86.0;
    }
    else if (tableView == tblCartLIst)
    {
        return 44;
    }
    return 0;
}

#pragma mark - Animation
- (void) receiveNotification:(NSNotification *) notification
{
    CGFloat itemPrice = 0.0;
    int quantity = 0;
    GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
    for (CartItemData *aItem in GDP.arrCartItems)
    {
        itemPrice = itemPrice + ([aItem.qty integerValue] * [aItem.price floatValue]);
    }
    for (CartItemData *aItem in GDP.arrCartItems)
    {
        quantity = quantity + [aItem.qty integerValue];
    }
    if (itemPrice > 0)
    {
        cartItemBadge.alpha = 0.0;
        [cartItemBadge autoBadgeSizeWithString:[NSString stringWithFormat:@"%lu",(unsigned long)quantity]];
        [cartItemBadge setHidden:NO];
        [self showAnimation];
    }
    else
    {
        [cartItemBadge setHidden:YES];
    }
    if (quantity > 0)
    {
        [lblPrice setText:[NSString stringWithFormat:@"%.2f KD",itemPrice]];
    }
    else
    {
        [lblPrice setText:nil];
    }
    
}
- (void)showAnimation
{
    [UIView animateWithDuration:0.2 animations:
     ^(void){
         cartItemBadge.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1f, 1.1f);
         cartItemBadge.alpha = 0.5;
     }
                     completion:^(BOOL finished){
                         [self bounceOutAnimationStoped];
                     }];
}
- (void)bounceOutAnimationStoped
{
    
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         cartItemBadge.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9, 0.9);
         cartItemBadge.alpha = 0.8;
     }
                     completion:^(BOOL finished){
                         [self bounceInAnimationStoped];
                     }];
}
- (void)bounceInAnimationStoped
{
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         cartItemBadge.transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
         cartItemBadge.alpha = 1.0;
     }
                     completion:^(BOOL finished)
    {
                     }];
}
- (void)hideBadge
{
    cartItemBadge.alpha = 0;
    cartItemBadge.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.6, 0.6);
}

- (IBAction)btnOkClick:(id)sender
{
    txtSpecialrequest.text = [txtSpecialrequest.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if(txtSpecialrequest.text == NULL || [txtSpecialrequest.text length] == 0)
    {
        [Utils showAlertMessage:KMessageTitle Message:@"Please enter special request"];
        [txtSpecialrequest becomeFirstResponder];
    }
    else
        [self myCartClick:senderbtntag];
}

- (IBAction)btnCancelclick:(id)sender {
    // [txtSpecialrequest setText:@""];
    //[viewPopUp removeFromSuperview];
    
    [self myCartClick:senderbtntag];
}

#pragma mark UITextView Delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
