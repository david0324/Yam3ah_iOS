//
//  AreaViewController.m
//  Yam3ah
//
//  Created by kapilgoyal on 04/06/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "AreaViewController.h"
#import "BrandListViewController.h"

@interface AreaViewController ()
@end

@implementation AreaViewController
@synthesize arrAreas,strCompany;

- (void)viewDidLoad
{
    [super viewDidLoad];
  //  tblArea.backgroundView = [[UIImageView alloc] initWithImage:
   //                                 [UIImage imageNamed:@"bg_company.png"]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [MBProgressHUD showHUDAddedTo:[AppDelegate sharedDelegate].window animated:YES];
    WebCommunicationClass *obj_WebCommunicationClass=[[WebCommunicationClass alloc] init];
    [obj_WebCommunicationClass setACaller:self];
    [obj_WebCommunicationClass getStateCityList];
}

-(IBAction)btnBackClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView Delegates
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    view.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];

    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 11, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *string =[[arrAreas objectAtIndex:section] objectForKey:@"state"];
    /* Section header is in 0th index... */
    [label setText:string];
    label.font = [UIFont fontWithName:@"Optima" size:15.0];
    label.textColor = [UIColor blackColor];
    [view addSubview:label];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView  // Default is 1 if not implemented
{
    if ([self.arrAreas count]>0)
        return [arrAreas count];
    else
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arrCity = [[arrAreas objectAtIndex:section] objectForKey:@"city"];
    if ([arrCity count]>0)
    {
        NSLog(@"arrcity=%@",arrCity);
        return [arrCity count];
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
    }
    cell.textLabel.text = [[[[self.arrAreas objectAtIndex:[indexPath section]] objectForKey:@"city"] objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    cell.textLabel.font = [UIFont fontWithName:@"Optima" size:13.0];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tblArea deselectRowAtIndexPath:indexPath animated:YES];
    BrandListViewController *brand = [[BrandListViewController alloc] initWithNibName:@"BrandListViewController" bundle:nil];
    brand.city_id = [[[[self.arrAreas objectAtIndex:[indexPath section]] objectForKey:@"city"] objectAtIndex:indexPath.row] objectForKey:@"id"];
    brand.strCompany = strCompany;
    [self.navigationController pushViewController:brand animated:YES];
}

#pragma -mark server method
-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    [MBProgressHUD hideAllHUDsForView:[AppDelegate sharedDelegate].window animated:YES];
    NSString *aStrResult=[[NSString alloc] initWithData:[aReq responseData] encoding:NSUTF8StringEncoding];
    NSLog(@"aStrResult=%@",aStrResult);
    if([MethoodName caseInsensitiveCompare:kGetStateCityList]==0)
    {
        [self.view endEditing:YES];
        NSError *jsonParsingError = nil;
        NSDictionary *aResultDictionery = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:[aReq responseData] options:0 error:&jsonParsingError]];
        NSLog(@"%@",aResultDictionery);
        if([[[aResultDictionery objectForKey:@"status"] objectForKey:@"status"] boolValue])
        {
            self.arrAreas=[[aResultDictionery objectForKey:@"responseData"] objectForKey:@"area"];
            [tblArea reloadData];
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
    [MBProgressHUD hideAllHUDsForView:[AppDelegate sharedDelegate].window animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
