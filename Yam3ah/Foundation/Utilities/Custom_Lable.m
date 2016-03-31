//
//  Lable_Oswald.m
//  CoffeeApp
//
//  Created by Sheetal on 1/16/15.
//  Copyright (c) 2015 Dotsquares. All rights reserved.
//
//  OpenSans-Light
//  OpenSans
//  OpenSans-Bold
#import "Custom_Lable.h"
#import "Config.h"

@implementation Custom_Lable



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    if (self.tag == 111) 
    {
        [self setFont:[UIFont fontWithName:KCustomFont size:self.font.pointSize]];
    }
    else if (self.tag == 222)
    {
        [self setFont:[UIFont fontWithName:KCustomFont size:self.font.pointSize]];
    }
    else if (self.tag == 333)
    {
        [self setFont:[UIFont fontWithName:KCustomFont size:self.font.pointSize]];
    }
    else if (self.tag == 444)
    {
        [self setFont:[UIFont fontWithName:KCustomFont size:self.font.pointSize]];
    }
    else if (self.tag == 555)
    {
        [self setFont:[UIFont fontWithName:KCustomFont size:self.font.pointSize]];
    }
}
@end
