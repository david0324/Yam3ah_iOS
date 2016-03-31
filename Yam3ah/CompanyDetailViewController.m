//
//  CompanyDetailViewController.m
//  Yam3ah
//
//  Created by sudhanshupareek on 17/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "CompanyDetailViewController.h"
#import "CompanyDetailTVCell.h"
#import "ProductListViewController.h"
#import "Config.h"

@interface CompanyDetailViewController ()
{
    NSMutableArray *arrComapnyDetails;
}

@end

@implementation CompanyDetailViewController
@synthesize dicCompanyDetail;
@synthesize strCompany;

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
    lblTitle.text = strCompany;
    if ([strCompany isEqualToString:@"Kitchen"])
    {
        [btnTitle setBackgroundImage:[UIImage imageNamed:@"menu_btn.png"] forState:UIControlStateNormal];
    }
    else
    {
        [btnTitle setBackgroundImage:[UIImage imageNamed:@"product_btn.png"] forState:UIControlStateNormal];

    }
    [self LoadData];
}

-(void)LoadData
{
    NSLog(@"%@",self.dicCompanyDetail);
    egoImageCompany.layer.cornerRadius = egoImageCompany.frame.size.width/2;
    egoImageCompany.layer.masksToBounds = YES;
    [egoImageCompany setShowActivity:YES];
    [egoImageCompany setImageURL:[NSURL URLWithString:[self.dicCompanyDetail valueForKey:@"company_image"]]];
    [lblCompanyname setText:[self.dicCompanyDetail valueForKey:@"company_name"]];
    
    //Create a custom array to manage the company details
  
    arrComapnyDetails = [NSMutableArray array];
    
    NSMutableDictionary *dictDesc = [NSMutableDictionary dictionary];
    
    [dictDesc setObject:@"Description" forKey:@"detailKey"];
    [dictDesc setObject:[dicCompanyDetail objectForKey:@"company_desc"] forKey:@"detailValue"];
    
    [arrComapnyDetails addObject:dictDesc];
    NSMutableDictionary *dictAddress = [NSMutableDictionary dictionary];
    
    [dictAddress setObject:@"Address" forKey:@"detailKey"];
    [dictAddress setObject:[dicCompanyDetail objectForKey:@"company_address"] forKey:@"detailValue"];
    
    [arrComapnyDetails addObject:dictAddress];
    
    
    NSMutableDictionary *dictContactDetails = [NSMutableDictionary dictionary];
    
    [dictContactDetails setObject:@"Phone Number" forKey:@"detailKey"];
    [dictContactDetails setObject:[dicCompanyDetail objectForKey:@"company_phone"] forKey:@"detailValue"];
    
    [arrComapnyDetails addObject:dictContactDetails];
    
    [tblComapanyDetail reloadData];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrComapnyDetails.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier;
    
    CellIdentifier= @"CompanyDetailTVCell";
    
    CompanyDetailTVCell* cell = nil;
    cell = (CompanyDetailTVCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSString *nibNameOrNil= @"CompanyDetailTVCell";
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibNameOrNil owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[CompanyDetailTVCell class]])
            {
                cell = (CompanyDetailTVCell*)currentObject;
                break;
            }
        }
        
    }
    NSMutableDictionary *dictDetail = [arrComapnyDetails objectAtIndex:indexPath.row];

    CGFloat commonHeight = 26.0f;
    CGSize maximumLabelSize = CGSizeMake(304, FLT_MAX);
    CGSize expectedLabelSize;
    
    NSString *strText = [dictDetail objectForKey:@"detailValue"];
    
    expectedLabelSize = [strText sizeWithFont:[UIFont fontWithName:KCustomFont size:12]
                            constrainedToSize:maximumLabelSize
                                lineBreakMode:NSLineBreakByWordWrapping];
    commonHeight = expectedLabelSize.height;
    
    [cell.lblDescription setFrame:CGRectMake(cell.lblDescription.frame.origin.x,cell.lblDescription.frame.origin.y, cell.lblDescription.frame.size.width,commonHeight)];
    
    cell.lblDescription.text = strText;
    

    cell.lblTitle.text = [dictDetail objectForKey:@"detailKey"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dictDetail = [arrComapnyDetails objectAtIndex:indexPath.row];
//    NSString *strText = @"cdsocis oishnc scosnc scosicnsc osicns coisnc socinsc osicnso cinsc osinc socinsc osicnso cisnco scnisicsn cosicnso cinsco scncxviodnvi vxcnviocuvnx viuvohibv dvsivun vdiovndvo disnv dvodcvicjhod vidjvd ovdivjnvo dvidnvd ovidvjhn dovdijv dovidjvd ovidjv odji oidvjdv dvodiv jd ov dovidjv oijv dovijd vod ojv dovjuv odjijv odivjd vodv doiju dvdovijd oijv dovidjhv doijd ovidv dovij oivjdv odvjd ocvjudo vdjviduvyuh uwegvy udfbvy ucybdc usybc sucysb csucs ucsbcus cbsyc sbc sucyb uybgv uby fuyvb duvbd vudbvd vudyvgb9uc hsocuhs sihjbs vubydbv duvb vudsbv udsvd";
//
    return [self DetailsCellHeight:[dictDetail objectForKey:@"detailValue"]];
}


#pragma mark - ChatBox Heights

-(CGFloat)DetailsCellHeight :(NSString *)DetailText
{
    CGFloat lRetval = 26.0f;
    CGSize maximumLabelSize = CGSizeMake(304, FLT_MAX);
    CGSize expectedLabelSize;
    
    expectedLabelSize = [DetailText sizeWithFont:[UIFont fontWithName:KCustomFont size:12]
                                     constrainedToSize:maximumLabelSize
                                         lineBreakMode:NSLineBreakByWordWrapping];
    lRetval = expectedLabelSize.height;
    
    return lRetval+37.0;
}


- (IBAction)btnMenuClick:(id)sender {
    ProductListViewController *controller = [[ProductListViewController alloc]initWithNibName:@"ProductListViewController" bundle:Nil];
    controller.companyId = [self.dicCompanyDetail valueForKey:@"company_id"];
    
//    [controller setFinishedCallback:^(ProductListViewController *controller, BOOL isDatafound) {
//        if (isDatafound) {
//            [self.navigationController pushViewController:controller animated:YES];
//        }
//        else
//        {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"No records found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            [alertView show];
//        }
//    }];
    
    //[controller GetCompanyMenu];
    
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

-(IBAction)backBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
