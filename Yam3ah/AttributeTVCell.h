//
//  AttributeTVCell.h
//  CoffeeApp
//
//  Created by Sheetal on 1/27/15.
//  Copyright (c) 2015 Dotsquares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Custom_Button.h"
#import "Custom_Lable.h"

@interface AttributeTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnPlus;
@property (weak, nonatomic) IBOutlet Custom_Lable *lblAttrName;
@property (weak, nonatomic) IBOutlet Custom_Lable *lblAttrPrice;

@end
