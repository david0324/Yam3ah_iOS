//
//  LetterProgressView.h
//  Scoo Talks
//
//  Created by Sheetal on 4/21/15.
//  Copyright (c) 2015 Dotsquares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "M13ProgressViewLetterpress.h"

@interface LetterProgressView : UIView

@property (nonatomic, retain) IBOutlet M13ProgressViewLetterpress *progressView;

+ (LetterProgressView *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;
+ (void)DismissFromView:(UIView*)view;
@end
