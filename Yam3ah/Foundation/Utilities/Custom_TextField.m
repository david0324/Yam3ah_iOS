//
//  NCTextField_Oswald.m
//  CoffeeApp
//
//  Created by Sheetal on 1/16/15.
//  Copyright (c) 2015 Dotsquares. All rights reserved.
//

#import "Custom_TextField.h"

#import "Config.h"


@implementation Custom_TextField
@synthesize horizontalPadding, verticalPadding;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //This is user when create textfield by code
        self.verticalPadding = 10;
        self.horizontalPadding = 10;
        // Initialization code
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    //This is used when create textfield using XIB/NIB
    self.key_name = @"";
    self.verticalPadding = 0;
    self.horizontalPadding = 10;
    //    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    //    self.leftView = paddingView;
    //    self.leftViewMode = UITextFieldViewModeAlways;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
//    [self setValue:[UIColor darkGrayColor]
//                    forKeyPath:@"_placeholderLabel.textColor"];
    if (self.tag == 111)
    {
//        [self setClearButtonMode:UITextFieldViewModeNever];
        self.font = [UIFont fontWithName:@"Molengo-Regular" size:self.font.pointSize];
        return CGRectMake(bounds.origin.x + horizontalPadding, bounds.origin.y + verticalPadding, bounds.size.width - horizontalPadding*4, bounds.size.height - verticalPadding*2);
    }
    else if(self.tag == 222)
    {
        self.font = [UIFont fontWithName:KCustomFont size:self.font.pointSize];
    }
    else if(self.tag == 333)
    {
        self.font = [UIFont fontWithName:KCustomFont size:self.font.pointSize];
    }
    else if(self.tag == 444)
    {
        self.font = [UIFont fontWithName:KCustomFont size:self.font.pointSize];
    }
    else if(self.tag == 555)
    {
        self.font = [UIFont fontWithName:KCustomFont size:self.font.pointSize];
    }
    return CGRectMake(bounds.origin.x + 15, bounds.origin.y + verticalPadding, bounds.size.width - horizontalPadding*4, bounds.size.height - verticalPadding*2);
}
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}
@end
