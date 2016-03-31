//
//  AreaViewController.h
//  Yam3ah
//
//  Created by kapilgoyal on 04/06/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *tblArea;
}
@property(nonatomic,strong)NSMutableArray *arrAreas;
@property(nonatomic,strong)NSString *strCompany;
-(IBAction)btnBackClicked;
@end
