//
//  BrandListViewController.m
//  Yam3ah
//
//  Created by admin on 10/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "BrandListViewController.h"
#import "BrandTVCell.h"
#import "ProductListViewController.h"
#import "WebCommunicationClass.h"
#import "LetterProgressView.h"
#import "AppDelegate.h"
#import "Config.h"
#import "CompanyDetailViewController.h"


@interface BrandListViewController ()

@end

@implementation BrandListViewController
@synthesize arrCompany,Category_id,strCompany;
@synthesize city_id;

- (void)viewDidLoad {
    [super viewDidLoad];
    lblCompany.text= [NSString stringWithFormat:@"%@ %@",strCompany,@"List"];
    NSLog(@"city_id=%@",city_id);
    brandsTblView.backgroundView = [[UIImageView alloc] initWithImage:
                                     [UIImage imageNamed:@"bg_company.png"]];
    [self getCompanies];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


-(void)getCompanies
{
   [LetterProgressView showHUDAddedTo:[App_Delegate window] animated:YES];
    WebCommunicationClass *obj_WebCommunicationClass=[[WebCommunicationClass alloc] init];
    [obj_WebCommunicationClass setACaller:self];
    [obj_WebCommunicationClass getCompanyList:Category_id];
}

#pragma -mark server method
-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
   [LetterProgressView DismissFromView:[App_Delegate window]] ;
    NSString *aStrResult=[[NSString alloc] initWithData:[aReq responseData] encoding:NSUTF8StringEncoding];
    NSLog(@"aStrResult=%@",aStrResult);
    if([MethoodName caseInsensitiveCompare:kGetCompanyList]==0)
    {
        [self.view endEditing:YES];
        NSError *jsonParsingError = nil;
        NSDictionary *aResultDictionery = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:[aReq responseData] options:0 error:&jsonParsingError]];
        NSLog(@"%@",aResultDictionery);
        if([[[aResultDictionery objectForKey:@"status"] objectForKey:@"status"] boolValue])
        {
            arrCompany=[aResultDictionery objectForKey:@"responseData"];
            [brandsTblView reloadData];
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


#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrCompany count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier;
    
    CellIdentifier= @"BrandTVCell";
    
    BrandTVCell* cell = nil;
    cell = (BrandTVCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSString *nibNameOrNil= @"BrandTVCell";
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNameOrNil owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[BrandTVCell class]])
            {
                cell = (BrandTVCell*)currentObject;
                break;
            }
        }
        cell.imgCompany.layer.cornerRadius = (cell.imgCompany.frame.size.width) / 2;
        cell.imgCompany.layer.masksToBounds = YES;
        [cell.imgCompany setShowActivity:YES];
        [cell.imgCompany setImageURL:[NSURL URLWithString:[[self.arrCompany objectAtIndex:indexPath.row] objectForKey:@"company_image"]]];
        cell.lblCompanyname.text = [[self.arrCompany objectAtIndex:indexPath.row] objectForKey:@"company_name"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CompanyDetailViewController *obj = [[CompanyDetailViewController alloc] initWithNibName:@"CompanyDetailViewController" bundle:Nil];
    obj.dicCompanyDetail = [self.arrCompany objectAtIndex:indexPath.row];
    obj.strCompany = [NSString stringWithFormat:@"%@",strCompany];
    [self.navigationController pushViewController:obj animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(IBAction)backBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
