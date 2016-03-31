//
//  AppDelegate.h
//  Yam3ah
//
//  Created by admin on 10/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "HomeViewController.h"
#import "CategoriesController.h"
#import "OrderViewController.h"
#import "CheckoutViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic,retain) NSString * myval;
@property (nonatomic, copy) NSString *myvalcopy;
@property (nonatomic, copy) NSString *myvalcopy1;
@property (nonatomic, assign) BOOL boolCartEmpty;
@property (nonatomic, assign) BOOL boolController;
@property (nonatomic,assign)BOOL boolStockFinish;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
+ (BOOL)checkNetwork;
+(AppDelegate*)sharedDelegate;


@end

