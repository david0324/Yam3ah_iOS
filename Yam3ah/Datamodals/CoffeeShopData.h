//
//  CoffeeShopData.h
//  CoffeeApp
//
//  Created by Sheetal on 1/13/15.
//  Copyright (c) 2015 Dotsquares. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoffeeShopData : NSObject

@property(retain,nonatomic) NSString *shop_id;
@property(retain,nonatomic) NSString *user_id;
@property(retain,nonatomic) NSString *name;
@property(retain,nonatomic) NSString *owner_name;
@property(retain,nonatomic) NSString *account_number;
@property(retain,nonatomic) NSString *bank_name;
@property(retain,nonatomic) NSString *opening_time;
@property(retain,nonatomic) NSString *closing_time;
@property(retain,nonatomic) NSString *city;
@property(retain,nonatomic) NSString *country;
@property(retain,nonatomic) NSString *state;
@property(retain,nonatomic) NSString *postcode;
@property(retain,nonatomic) NSString *latitude;
@property(retain,nonatomic) NSString *longitude;
@property(retain,nonatomic) NSString *image;
@property(retain,nonatomic) NSString *address;
@property(retain,nonatomic) NSString *coffee_shop_status;




-(id)initWithDictionary:(NSDictionary *)Dict;

@end
