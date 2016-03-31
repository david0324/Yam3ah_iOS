//
//  HomeTVCell.h
//  Yam3ah
//
//  Created by admin on 10/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "EGOImageButton.h"
#import "Custom_Lable.h"


@interface HomeTVCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *egoViewProduct1;
@property (strong, nonatomic) IBOutlet UIImageView *egoViewProduct2;
@property (strong, nonatomic) IBOutlet UIImageView *egoViewProduct3;

@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UIButton *btn3;

@property (strong, nonatomic) IBOutlet UIView *viewImages;

- (void)updatetableViewCell:(NSArray *)arrImages target:(id)hostView;
@end
