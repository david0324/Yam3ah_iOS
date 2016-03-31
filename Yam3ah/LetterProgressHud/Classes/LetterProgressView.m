//
//  LetterProgressView.m
//  Scoo Talks
//
//  Created by Sheetal on 4/21/15.
//  Copyright (c) 2015 Dotsquares. All rights reserved.
//

#import "LetterProgressView.h"

@implementation LetterProgressView


-(void)ShowInView:(UIView *)view
{
    [view addSubview:self];
    [self setFrame:view.bounds];
    [self animateProgress:self];
}

+ (LetterProgressView *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated
{
    LetterProgressView *hudView = nil;
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LetterProgressView" owner:nil options:nil];
    
    for(id currentObject in topLevelObjects)
    {
        if([currentObject isKindOfClass:[LetterProgressView class]])
        {
            hudView = (LetterProgressView*)currentObject;
            break;
        }
    }
    [hudView ShowInView:view];
    return hudView;
}

+ (void)DismissFromView:(UIView*)view
{
    for (UIView* v in view.subviews)
    {
        if ([v isKindOfClass:[LetterProgressView class]])
        {
            [v removeFromSuperview];
        }
    }
}

- (void)gridPointsXChanged:(id)sender
{
    UIStepper *stepper = sender;
    CGPoint temp = _progressView.numberOfGridPoints;
    temp.x = stepper.value;
    _progressView.numberOfGridPoints = temp;
}

- (void)gridPointsYChanged:(id)sender
{
    UIStepper *stepper = sender;
    CGPoint temp = _progressView.numberOfGridPoints;
    temp.y = stepper.value;
    _progressView.numberOfGridPoints = temp;
}

- (void)pointShapeChanged:(id)sender
{
    UISegmentedControl *segemented = sender;
    if (segemented.selectedSegmentIndex == 0) {
        _progressView.pointShape = M13ProgressViewLetterpressPointShapeCircle;
        _progressView.pointSpacing = 0.0;
    } else {
        _progressView.pointShape = M13ProgressViewLetterpressPointShapeSquare;
        _progressView.pointSpacing = .15;
    }
}

- (void)notchSizeXChanged:(id)sender
{
    UIStepper *stepper = sender;
    CGSize temp = _progressView.notchSize;
    temp.width = stepper.value;
    _progressView.notchSize = temp;
}

- (void)notchSizeYChanged:(id)sender
{
    UIStepper *stepper = sender;
    CGSize temp = _progressView.notchSize;
    temp.height = stepper.value;
    _progressView.notchSize = temp;
}

- (void)progressChanged:(id)sender
{
}

- (void)animateProgress:(id)sender
{
    //Disable other controls
    
    [self performSelector:@selector(setQuarter) withObject:Nil afterDelay:1];
}

- (void)setQuarter
{
    [_progressView setProgress:.25 animated:YES];
    [self performSelector:@selector(setTwoThirds) withObject:nil afterDelay:1];
}

- (void)setTwoThirds
{
    [_progressView setProgress:.66 animated:YES];
    [self performSelector:@selector(setThreeQuarters) withObject:nil afterDelay:1];
}

- (void)setThreeQuarters
{
    [_progressView setProgress:.75 animated:YES];
    [self performSelector:@selector(setOne) withObject:nil afterDelay:1];
}

- (void)setOne
{
    [_progressView setProgress:1.0 animated:YES];
    [self performSelector:@selector(setComplete) withObject:nil afterDelay:1];
}

- (void)setComplete
{
    [_progressView performAction:M13ProgressViewActionSuccess animated:YES];
    [self performSelector:@selector(reset) withObject:nil afterDelay:1];
}

- (void)reset
{
    [_progressView setProgress:0.0 animated:YES];
    [self performSelector:@selector(setQuarter) withObject:nil afterDelay:1];

    //Enable other controls
}
@end
