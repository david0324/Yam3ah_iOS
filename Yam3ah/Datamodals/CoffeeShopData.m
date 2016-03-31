//
//  CoffeeShopData.m
//  CoffeeApp
//
//  Created by Sheetal on 1/13/15.
//  Copyright (c) 2015 Dotsquares. All rights reserved.
//

#import "CoffeeShopData.h"

@implementation CoffeeShopData


@synthesize shop_id;
@synthesize user_id;
@synthesize name;
@synthesize owner_name;
@synthesize account_number;
@synthesize bank_name;
@synthesize opening_time;
@synthesize closing_time;
@synthesize city;
@synthesize country;
@synthesize state;
@synthesize postcode;
@synthesize latitude;
@synthesize longitude;
@synthesize image;
@synthesize address;
@synthesize coffee_shop_status;


-(id)initWithDictionary:(NSDictionary *)Dict
{
    self = [super init];
    if (self)
    {
        @try
        {
            for (NSString *aKey in Dict.allKeys)
            {
                if(![Dict valueForKeyIsNull:aKey])
                {
                    [self setValue:[Dict objectForKey:aKey] forKey:aKey];
                }
            }
        }
        @catch (NSException *exception)
        {
            NSLog(@"exception - %@",exception);
        }
        @finally
        {
            
        }
    }
    return self;
}

@end
