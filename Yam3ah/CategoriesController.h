//
//  CategoriesController.h
//  Yam3ah
//
//  Created by admin on 10/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoriesController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *categoriesTblView;
}
@property(nonatomic,strong)NSMutableArray *arrCategory;
-(IBAction)backBtnPressed:(id)sender;


@end

