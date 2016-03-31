//
//  HomeTVCell.m
//  Yam3ah
//
//  Created by admin on 10/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "HomeTVCell.h"
//#import "EGOImageView.h"
#import "UIImageView+WebCache.h"

@implementation HomeTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
- (void)updatetableViewCell:(NSArray *)arrImages target:(id)hostView
{
    int count = 1;
    for (NSDictionary *aDict in arrImages)
    {
        if(count == 1)
        {
            [_egoViewProduct1 setHidden:NO];
            [_egoViewProduct1 sd_setImageWithURL:[NSURL URLWithString:[aDict objectForKey:@"feature_image_thumb"]]
                              placeholderImage:nil];
//            [_egoViewProduct1 setShowActivity:YES];
//            [_egoViewProduct1 setImageURL:[NSURL URLWithString:[aDict objectForKey:@"feature_image_thumb"]]];
        }
        if(count == 2)
        {
            [_egoViewProduct2 setHidden:NO];
            [_egoViewProduct2 sd_setImageWithURL:[NSURL URLWithString:[aDict objectForKey:@"feature_image_thumb"]]
                                placeholderImage:nil];
//            [_egoViewProduct2 setShowActivity:YES];
//            [_egoViewProduct2 setImageURL:[NSURL URLWithString:[aDict objectForKey:@"feature_image_thumb"]]];
        }
        if(count == 3)
        {
            [_egoViewProduct3 setHidden:NO];
            [_egoViewProduct3 sd_setImageWithURL:[NSURL URLWithString:[aDict objectForKey:@"feature_image_thumb"]]
                                placeholderImage:nil];
//            [_egoViewProduct3 setShowActivity:YES];
//            [_egoViewProduct3 setImageURL:[NSURL URLWithString:[aDict objectForKey:@"feature_image_thumb"]]];
        }
        count++;
        [_btn1 addTarget:hostView action:@selector(btnProductTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_btn2 addTarget:hostView action:@selector(btnProductTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_btn3 addTarget:hostView action:@selector(btnProductTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
}
@end
