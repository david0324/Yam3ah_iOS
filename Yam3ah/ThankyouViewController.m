//
//  ThankyouViewController.m
//  Yam3ah
//
//  Created by sudhanshupareek on 01/05/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "ThankyouViewController.h"

@interface ThankyouViewController ()
@end

@implementation ThankyouViewController
@synthesize strOrderId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    txtViewOrder.text = [NSString stringWithFormat:@"Your order has been placed\n Your order id is: %@",strOrderId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
