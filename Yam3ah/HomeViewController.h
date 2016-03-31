//
//  HomeViewController.h
//  Yam3ah
//
//  Created by admin on 10/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailViewController.h"
#import "CategoriesController.h"
#import "STableViewController.h"
#import "TableFooterView.h"

@interface HomeViewController : STableViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *productTblView;
    IBOutlet UISearchBar *txtFSearch;
    BOOL shouldShowFooter;
    IBOutlet UIScrollView *scrlViewProduct;
    dispatch_queue_t backgroundQueue;
    int intPlus;
    NSMutableDictionary *dictGroup;
    NSMutableArray *arrListGroup;
}
-(IBAction)catagoriesBtnPressed:(id)sender;
@property(nonatomic,strong)NSMutableArray *arrLatestProduct;
@property(nonatomic,strong)NSMutableArray *arrItemsList;
@end
