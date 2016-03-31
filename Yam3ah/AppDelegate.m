//
//  AppDelegate.m
//  Yam3ah
//
//  Created by admin on 10/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "Config.h"
#import "MBProgressHUD.h"
#import "CartViewController.h"
#import "CheckoutViewController.h"
#import "GlobalDataPersistence.h"
#import "ThankyouViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize tabBarController,myval,myvalcopy,myvalcopy1;
@synthesize boolCartEmpty,boolController,boolStockFinish;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    myval = @"a";
    myvalcopy = myval;
    myvalcopy1 = myvalcopy;
    
    NSLog(@"%@",myval);
    
    NSLog(@"%@",myvalcopy);
    NSLog(@"%@",myvalcopy1);
    
    [self AddTabbar];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)AddTabbar
{
    //Tabbar Item1
    UINavigationController *nc1 = [[UINavigationController alloc] init];
    [nc1.navigationBar setTintColor:[UIColor blackColor]];
    UIViewController *viewController1 = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    nc1.navigationBar.hidden=YES;
    nc1.viewControllers = [NSArray arrayWithObjects:viewController1, nil];
    
    //Tabbar Item 2
    UINavigationController *nc2 = [[UINavigationController alloc] init];
    [nc2.navigationBar setTintColor:[UIColor blackColor]];
    UIViewController *viewController2 = [[CategoriesController alloc] initWithNibName:@"CategoriesController" bundle:nil];
    nc2.navigationBar.hidden=YES;
    nc2.viewControllers = [NSArray arrayWithObjects:viewController2, nil];
    
    //Tabbar Item 3
    UINavigationController *nc3 = [[UINavigationController alloc] init];
    [nc3.navigationBar setTintColor:[UIColor blackColor]];
    UIViewController *viewController3 = [[CartViewController alloc] initWithNibName:@"CartViewController" bundle:nil];
    nc3.navigationBar.hidden=YES;
    nc3.viewControllers = [NSArray arrayWithObjects:viewController3, nil];
    
    
    //Tabbar Item 4
    UINavigationController *nc4 = [[UINavigationController alloc] init];
    [nc4.navigationBar setTintColor:[UIColor blackColor]];
    UIViewController *viewController4 = [[CheckoutViewController alloc] initWithNibName:@"CheckoutViewController" bundle:nil];
    nc4.navigationBar.hidden=YES;
    nc4.viewControllers = [NSArray arrayWithObjects:viewController4, nil];
    
    
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.delegate = self;
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:nc1,nc2,nc3,nc4,nil];
    
    UITabBar *tabBar = self.tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    
    tabBarItem1.selectedImage = [[UIImage imageNamed:@"tab_1_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem1.image = [[UIImage imageNamed:@"tab_1_unselected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    tabBarItem1.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    
    //    tabBarItem1.title = @"Home";
    
    tabBarItem2.selectedImage = [[UIImage imageNamed:@"tab_2_selected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem2.image = [[UIImage imageNamed:@"tab_2_unseleted.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem2.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    
    //    tabBarItem2.title = @"Category";
    
    tabBarItem3.selectedImage = [[UIImage imageNamed:@"tab_3_selected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem3.image = [[UIImage imageNamed:@"tab_3_unseleted.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem3.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    
    
    //    tabBarItem3.title = @"Cart";
    
    tabBarItem4.selectedImage = [[UIImage imageNamed:@"tab_4_selected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem4.image = [[UIImage imageNamed:@"tab_4_unselected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    tabBarItem4.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    
    //    tabBarItem4.title = @"Checkout";
    
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if ([AppDelegate sharedDelegate].boolStockFinish)
    {
        [AppDelegate sharedDelegate].boolStockFinish = FALSE;
        if ([self.tabBarController selectedIndex]==1)
        {
            NSArray *Arrcontroller=[[AppDelegate sharedDelegate].tabBarController viewControllers];
            UINavigationController *ViewControlTmp=[Arrcontroller objectAtIndex:1];
            Arrcontroller=[ViewControlTmp viewControllers];
            
            if([Arrcontroller count]>1)
            {
                [ViewControlTmp popToViewController:[Arrcontroller objectAtIndex:0] animated:YES];
            }
        }
       
    }
}

#pragma mark Singleton
+(AppDelegate*)sharedDelegate
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "dotsquares.Yam3ah" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Yam3ah" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Yam3ah.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Network Methods
+ (BOOL)checkNetwork
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        [MBProgressHUD hideHUDForView:[App_Delegate window] animated:YES];
        UIAlertView *alert = KALERT(@"Notice!", @"Check network connection", nil);
        [alert show];
        
        return NO;
    }
    return YES;
}

#pragma mark - UITabBarController Delegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    GlobalDataPersistence *GDP = [GlobalDataPersistence sharedGlobalDataPersistence];
    NSUInteger indexOfTab = [tabBarController.viewControllers indexOfObject:viewController];
    
    if (indexOfTab == 3 && (!GDP.arrCartItems || GDP.arrCartItems.count == 0))
    {
        UIAlertView *alert = KALERT(@"Notice!", @"Your cart is empty. Add item to cart.", nil);
        [alert show];
        return NO;
    }
    else if (indexOfTab == 3 && (GDP.arrCartItems >0))
    {
        if ([AppDelegate sharedDelegate].boolController) {
            
        
        NSArray *Arrcontroller=[[AppDelegate sharedDelegate].tabBarController viewControllers];
        UINavigationController *ViewControlTmp=[Arrcontroller objectAtIndex:3];
        Arrcontroller=[ViewControlTmp viewControllers];
        NSLog(@"%@",Arrcontroller);
            
            for (UIViewController *vc in Arrcontroller) {
                if ([vc isKindOfClass:[ThankyouViewController class]]) {
                      [ViewControlTmp popToViewController:[Arrcontroller objectAtIndex:0] animated:YES];
                }
            }
            
            
            
            
            
           // if([Arrcontroller count]>1)
            //{
           // [ViewControlTmp popToViewController:[Arrcontroller objectAtIndex:0] animated:YES];
            
           // }
        }
    }
    
    /*
    if ([AppDelegate sharedDelegate].boolController)
    {
        [AppDelegate sharedDelegate].boolController = FALSE;
        NSArray *Arrcontroller=[[AppDelegate sharedDelegate].tabBarController viewControllers];
        UINavigationController *ViewControlTmp=[Arrcontroller objectAtIndex:3];
        Arrcontroller=[ViewControlTmp viewControllers];
        
        if([Arrcontroller count]>1)
        {
            [ViewControlTmp popToViewController:[Arrcontroller objectAtIndex:0] animated:YES];
            
        }
    }
    else
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.tabBarController.selectedIndex = 3;
        
    }
*/
    
    
    
   // GDP.currentNavigationController = (UINavigationController *)viewController;
    
   // [self.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%lu.png",indexOfTab+1]]];
    
    return YES;
}


@end
