//
//  MenuItemTVCell.h
//  CoffeeApp
//
//  Created by Sheetal on 1/16/15.
//  Copyright (c) 2015 Dotsquares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface MenuItemTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet EGOImageView *imgItem;
@property (weak, nonatomic) IBOutlet UIButton *btnAddToCart;
@property (weak, nonatomic) IBOutlet UILabel *lblItemName;
@property (weak,nonatomic)  IBOutlet UIButton *btnProduct;
@property (weak, nonatomic) IBOutlet UILabel *lblItemDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblAvailbity;
@property (weak, nonatomic) IBOutlet UILabel *lblQuantity;

@end
