//
//  NCButton_Oswald.m
//  CoffeeApp
//
//  Created by Sheetal on 1/16/15.
//  Copyright (c) 2015 Dotsquares. All rights reserved.
//

#import "Custom_Button.h"
#import "Config.h"

@implementation Custom_Button

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    if (self.tag == 111)
    {
        [self.titleLabel setFont:[UIFont fontWithName:KCustomFont size:self.titleLabel.font.pointSize]];
    }
    else if (self.tag == 222)
    {
        [self.titleLabel setFont:[UIFont fontWithName:KCustomFont size:self.titleLabel.font.pointSize]];
    }
    else if (self.tag == 333)
    {
        [self.titleLabel setFont:[UIFont fontWithName:KCustomFont size:self.titleLabel.font.pointSize]];
    }
    else if(self.tag == 444)
    {
        [self.titleLabel setFont:[UIFont fontWithName:KCustomFont size:self.titleLabel.font.pointSize]];
    }
    else if(self.tag == 555)
    {
        [self.titleLabel setFont:[UIFont fontWithName:@"Molengo-Regular" size:self.titleLabel.font.pointSize]];
    }
    
}

@end
