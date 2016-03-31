//
//  ProductListViewController.h
//  Yam3ah
//
//  Created by admin on 10/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *productListTblView;
}

-(IBAction)backBtnPressed:(id)sender;
@property(nonatomic,strong)NSString* companyId;
@property(strong,nonatomic) NSMutableArray* arrMenu;

@property (nonatomic, copy) void (^finishedCallback)(ProductListViewController *controller , BOOL isDataFound);

-(void)GetCompanyMenu;

@end
