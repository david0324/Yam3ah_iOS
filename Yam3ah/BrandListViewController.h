//
//  BrandListViewController.h
//  Yam3ah
//
//  Created by admin on 10/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrandListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *brandsTblView;
    IBOutlet UILabel *lblCompany;
}
@property(nonatomic,strong)NSMutableArray *arrCompany;
@property(nonatomic,strong) NSString* Category_id;
@property(nonatomic,strong) NSString* city_id;

@property(nonatomic,strong)NSString *strCompany;
-(IBAction)backBtnPressed:(id)sender;

@end
