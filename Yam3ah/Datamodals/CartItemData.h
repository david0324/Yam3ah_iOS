//
//  CartItemData.h
//  CoffeeApp
//
//  Created by Sheetal on 1/27/15.
//  Copyright (c) 2015 Dotsquares. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartItemData : NSObject

@property(retain,nonatomic) NSString *menu_id;
@property(retain,nonatomic) NSString *qty;
@property(retain,nonatomic) NSString *Attr_id;
@property(retain,nonatomic) NSString *price;
@property(retain,nonatomic) NSString *item_image;
@property(retain,nonatomic) NSString *item_name;
@property(retain,nonatomic) NSString *item_info;
@property(retain,nonatomic) NSString *strCompany_id;
@property(retain,nonatomic) NSString *strCompany_Category_id;
@property(retain,nonatomic) NSString *strCurrency;
@property(retain,nonatomic) NSString *strSpecialrequest;
@property(retain,nonatomic) NSString *strProduct_quantity;

@end
