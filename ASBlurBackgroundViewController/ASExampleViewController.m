//
//  ASExampleViewController.m
//  ASBlurBackgroundViewController
//
//  Created by Hasan on 5/10/14.
//  Copyright (c) 2014 AssembleLabs. All rights reserved.
//

#import "ASExampleViewController.h"

@interface ASExampleViewController ()

@property (nonatomic, weak) IBOutlet UIImageView* bgImageView;

-(IBAction) tapBlur:(id)sender;

@end

@implementation ASExampleViewController

-(IBAction) tapBlur:(id)sender
{
    [super blurView:_bgImageView withCompletion:^{
        [UIView animateWithDuration:0.25f animations:^{
            [_bgImageView setAlpha:0];
        } completion:^(BOOL finished) {
            [_bgImageView removeFromSuperview];
        }];
    }];
}

@end
