//
//  CategoriesTVCell.h
//  Yam3ah
//
//  Created by admin on 10/04/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "Custom_Lable.h"

@interface CategoriesTVCell : UITableViewCell
{

}
@property(nonatomic,strong)IBOutlet Custom_Lable *lblCategoryName;
@property(nonatomic,strong)IBOutlet EGOImageView *egoImageViewCategory;
@end
