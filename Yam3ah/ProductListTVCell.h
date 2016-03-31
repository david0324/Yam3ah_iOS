//
//  ProductListTVCell.h
//  Yam3ah
//
//  Created by admin on 10/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "Custom_Lable.h"

@interface ProductListTVCell : UITableViewCell

@property (strong, nonatomic) IBOutlet Custom_Lable *lblMenuname;
@property (strong, nonatomic) IBOutlet EGOImageView *imgMenu;

@end
