//
//  ASBlurBackgroundViewController.h
//  ASMapView
//
//  Created by Hasan on 5/10/14.
//  Copyright (c) 2014 AssembleLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASBlurBackgroundViewController : UIViewController

-(void) blurView:(UIView*)backgroundView withCompletion:(void (^)())completion;

@end
