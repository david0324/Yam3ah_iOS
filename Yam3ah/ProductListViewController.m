//
//  ProductListViewController.m
//  Yam3ah
//
//  Created by admin on 10/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "ProductListViewController.h"
#import "ProductListTVCell.h"
#import "WebCommunicationClass.h"
#import "LetterProgressView.h"
#import "AppDelegate.h"
#import "Config.h"
#import "MenuViewController.h"

@interface ProductListViewController ()

@end

@implementation ProductListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    productListTblView.backgroundView = [[UIImageView alloc] initWithImage:
                              [UIImage imageNamed:@"bg_company.png"]];
    [self GetCompanyMenu];

}

-(void)GetCompanyMenu
{
    [LetterProgressView showHUDAddedTo:[App_Delegate window] animated:YES];
    WebCommunicationClass *obj_WebCommunicationClass=[[WebCommunicationClass alloc] init];
    [obj_WebCommunicationClass setACaller:self];
    [obj_WebCommunicationClass getCompanyMenuList:self.companyId];

}

#pragma -mark server method

-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    [LetterProgressView DismissFromView:[App_Delegate window]] ;
    NSString *aStrResult=[[NSString alloc] initWithData:[aReq responseData] encoding:NSUTF8StringEncoding];
    NSLog(@"aStrResult=%@",aStrResult);
    if([MethoodName caseInsensitiveCompare:kGetMenuList]==0)
    {
        [self.view endEditing:YES];
        NSError *jsonParsingError = nil;
        NSDictionary *aResultDictionery = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:[aReq responseData] options:0 error:&jsonParsingError]];
        NSLog(@"%@",aResultDictionery);
        if([[[aResultDictionery objectForKey:@"status"] objectForKey:@"status"] boolValue])
        {
            self.arrMenu=[aResultDictionery objectForKey:@"responseData"];
            NSLog(@"%@",self.arrMenu);
            [productListTblView reloadData];
            
           
          /*
              if (self.finishedCallback && self.arrMenu.count)
            {
                self.finishedCallback(self , YES);
            }
            else
            {
                self.finishedCallback(self , NO);
            }*/
            

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
    [LetterProgressView DismissFromView:[App_Delegate window]] ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrMenu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    CellIdentifier= @"ProductListTVCell";
    
    ProductListTVCell* cell = nil;
    cell = (ProductListTVCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSString *nibNameOrNil= @"ProductListTVCell";
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNameOrNil owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[ProductListTVCell class]])
            {
                cell = (ProductListTVCell*)currentObject;
                break;
            }
        }
        
        cell.imgMenu.layer.cornerRadius = (cell.imgMenu.frame.size.width) / 2;
        cell.imgMenu.layer.masksToBounds = YES;
        [cell.imgMenu setShowActivity:YES];
       // [cell.imgMenu setBackgroundColor:[UIColor redColor]];
        [cell.imgMenu setImageURL:[NSURL URLWithString:[[self.arrMenu objectAtIndex:indexPath.row] objectForKey:@"category_image"]]];
        cell.lblMenuname.text = [[self.arrMenu objectAtIndex:indexPath.row] objectForKey:@"com_cat_title"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([[[self.arrMenu objectAtIndex:indexPath.row]valueForKey:@"products"]count]>0) {
        MenuViewController *obj = [[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:Nil];
        obj.dictCategoryItems = [self.arrMenu objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"No records found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}


-(IBAction)backBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
