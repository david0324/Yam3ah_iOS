//
//  CategoriesController.m
//  Yam3ah
//
//  Created by admin on 10/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "CategoriesController.h"
#import "CategoriesTVCell.h"
#import "BrandListViewController.h"
#import "WebCommunicationClass.h"
#import "Config.h"
#import "LetterProgressView.h"
#import "AppDelegate.h"
#import "NSString+HTML.h"
#import "AreaViewController.h"

@interface CategoriesController ()
@end

@implementation CategoriesController
@synthesize arrCategory;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    categoriesTblView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [LetterProgressView showHUDAddedTo:[App_Delegate window] animated:YES];
    WebCommunicationClass *obj_WebCommunicationClass=[[WebCommunicationClass alloc] init];
    [obj_WebCommunicationClass setACaller:self];
    [obj_WebCommunicationClass getCategoryList];
}

#pragma -mark server method
-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    [LetterProgressView DismissFromView:[App_Delegate window]];
    NSString *aStrResult=[[NSString alloc] initWithData:[aReq responseData] encoding:NSUTF8StringEncoding];
    NSLog(@"aStrResult=%@",aStrResult);
    if([MethoodName caseInsensitiveCompare:kGetCategory]==0)
    {
        [self.view endEditing:YES];
        NSError *jsonParsingError = nil;
        NSDictionary *aResultDictionery = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:[aReq responseData] options:0 error:&jsonParsingError]];
        NSLog(@"%@",aResultDictionery);
        if([[[aResultDictionery objectForKey:@"status"] objectForKey:@"status"] boolValue])
        {
            self.arrCategory=[aResultDictionery objectForKey:@"responseData"];
            [categoriesTblView reloadData];
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
    [LetterProgressView DismissFromView:[App_Delegate window]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrCategory count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier;
    
    CellIdentifier= @"CategoriesTVCell";
    
    CategoriesTVCell* cell = nil;
    cell = (CategoriesTVCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSString *nibNameOrNil= @"CategoriesTVCell";
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNameOrNil owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[CategoriesTVCell class]])
            {
                cell = (CategoriesTVCell*)currentObject;
                break;
            }
        }
        [cell.egoImageViewCategory setShowActivity:YES];
        [cell.egoImageViewCategory setImageURL:[NSURL URLWithString:[[self.arrCategory objectAtIndex:indexPath.row] objectForKey:@"category_url"]]];
        cell.lblCategoryName.text = [[[self.arrCategory objectAtIndex:indexPath.row] objectForKey:@"category_title"] stringByDecodingHTMLEntities];
    }
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BrandListViewController *obj = [[BrandListViewController alloc] initWithNibName:@"BrandListViewController" bundle:nil];
    obj.Category_id = [[self.arrCategory objectAtIndex:indexPath.row]valueForKey:@"category_id"];
    obj.strCompany = [[self.arrCategory objectAtIndex:indexPath.row]valueForKey:@"category_title"];
//  /*  if (indexPath.row==0)
//        obj.strCompany=@"Kitchen List";
//    else
//        obj.strCompany=@"Lifestyle List";*/
    [self.navigationController pushViewController:obj animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    AreaViewController *area = [[AreaViewController alloc] initWithNibName:@"AreaViewController" bundle:nil];
//        //obj.Category_id = [[self.arrCategory objectAtIndex:indexPath.row]valueForKey:@"category_id"];
//        area.strCompany = [[self.arrCategory objectAtIndex:indexPath.row]valueForKey:@"category_title"];
//      /*  if (indexPath.row==0)
//            obj.strCompany=@"Kitchen List";
//        else
//            obj.strCompany=@"Lifestyle List";*/
//    [self.navigationController pushViewController: area animated:YES];
}


-(IBAction)backBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
