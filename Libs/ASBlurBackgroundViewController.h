//
//  ASBlurBackgroundViewController.h
//  ASMapView
//
//  Created by Hasan on 5/10/14.
//  Copyright (c) 2014 AssembleLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ASBlurBackgroundCompletion)();

@interface ASBlurBackgroundViewController : UIViewController

@property (nonatomic, copy) ASBlurBackgroundCompletion blurCompletion;

@end
