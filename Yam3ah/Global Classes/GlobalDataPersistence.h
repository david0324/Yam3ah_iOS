//
//  GlobalDataPersistence.h
//  FingerOlympic
//
//  Created by RahulSharma on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GlobalDataPersistence : NSObject
{
    
}

/** The user latitude. */
@property (nonatomic, strong) NSString *userLatitude;

/** The user longitude. */
@property (nonatomic, strong) NSString *userLongitude;

/* End here */


@property (nonatomic, assign) BOOL isLoading;

@property (nonatomic , retain) UINavigationController *currentNavigationController;

@property (nonatomic , retain) NSMutableArray *arrCoffeeShop;

@property (nonatomic , retain) NSMutableArray *arrCartItems;

@property (nonatomic , retain) NSString *selectedShopID;

@property (nonatomic , retain) NSString *prevShopID;


+ (GlobalDataPersistence *)sharedGlobalDataPersistence;

@end
