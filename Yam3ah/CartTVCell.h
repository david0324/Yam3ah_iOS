//
//  CartTVCell.h
//  CoffeeApp
//
//  Created by Sheetal on 1/26/15.
//  Copyright (c) 2015 Dotsquares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Custom_Lable.h"
#import "Custom_Button.h"
#import "EGOImageView.h"

@interface CartTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet Custom_Lable *lblItemName;
@property (weak, nonatomic) IBOutlet Custom_Lable *lblQuantity;
@property (weak, nonatomic) IBOutlet Custom_Lable *lblPrice;
@property (weak, nonatomic) IBOutlet EGOImageView *imgItem;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@property (weak, nonatomic) IBOutlet UIView *viewImg;

@end
