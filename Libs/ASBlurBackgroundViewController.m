//
//  ASBlurBackgroundViewController.m
//  ASMapView
//
//  Created by Hasan on 5/10/14.
//  Copyright (c) 2014 AssembleLabs. All rights reserved.
//

#import "ASBlurBackgroundViewController.h"

@interface ASBlurBackgroundViewController ()

@property (nonatomic, strong) NSOperationQueue* bgQueue;

-(UIImage*) imageFromView:(UIView*)targetView;

@end

@implementation ASBlurBackgroundViewController

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _bgQueue = [[NSOperationQueue alloc] init];
    }
    return self;    
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _bgQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIViewController* backgroundController = [self parentViewController];
    if (!backgroundController) {
        backgroundController = self;
    }
    UIView* backgroundView = [backgroundController view];
    CGRect backgroundViewBounds = [backgroundView bounds];
    UIImage* backgroundViewImage = [self imageFromView:backgroundView];
    
    __weak typeof(self) me = self;
    [self.bgQueue addOperationWithBlock:^{
        
        CIImage* backgroudnViewCIImage = [CIImage imageWithCGImage:backgroundViewImage.CGImage];
        
        CIFilter* blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
        [blurFilter setValue:backgroudnViewCIImage forKey:kCIInputImageKey];
        [blurFilter setValue:[NSNumber numberWithFloat:5.0f] forKey:@"inputRadius"];
        CIImage* blurResult = [blurFilter valueForKey:kCIOutputImageKey];
        
        CIContext* context = [CIContext contextWithOptions:nil];
        CGImageRef backgroundViewBlurImageRef = [context createCGImage:blurResult fromRect:backgroundViewBounds];
        UIImage* backgroundViewBlurImage = [[UIImage alloc] initWithCGImage:backgroundViewBlurImageRef];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            UIImageView* screenBlurImageView = [[UIImageView alloc] initWithImage:backgroundViewBlurImage];
            [screenBlurImageView setFrame:CGRectMake(0, 0, backgroundViewBounds.size.width, backgroundViewBounds.size.height)];
            [[screenBlurImageView layer] setOpacity:0];
            
            [me.view addSubview:screenBlurImageView];
            [me.view sendSubviewToBack:screenBlurImageView];
            
            [UIView animateWithDuration:0.25f animations:^(void){
                [[screenBlurImageView layer] setOpacity:1];
            }];
            
            if (_blurCompletion) {
                _blurCompletion();
            }
        }];
    }];
}

-(UIImage*) imageFromView:(UIView*)targetView
{
    UIGraphicsBeginImageContext(targetView.bounds.size);
    [targetView drawViewHierarchyInRect:targetView.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
