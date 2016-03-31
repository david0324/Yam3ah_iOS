//
//  CompanyDetailViewController.h
//  Yam3ah
//
//  Created by sudhanshupareek on 17/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "Custom_Lable.h"
#import "Custom_Button.h"

@interface CompanyDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tblComapanyDetail;
    IBOutlet Custom_Lable *lblCompanyname;
    IBOutlet EGOImageView *egoImageCompany;
    IBOutlet UILabel *lblTitle;
    IBOutlet UIButton *btnTitle;
}
@property(strong,nonatomic) NSMutableDictionary* dicCompanyDetail;
@property(strong,nonatomic) NSString *strCompany;

-(IBAction)btnMenuClick:(id)sender;
-(IBAction)backBtnPressed:(id)sender;

@end
