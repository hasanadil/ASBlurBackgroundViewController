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

-(void) blurView:(UIView*)backgroundView withCompletion:(void (^)())completion
{
    CGRect backgroundViewBounds = [backgroundView bounds];
    UIImage* backgroundViewImage = [self imageFromView:backgroundView];
    CIImage* backgroundViewCIImage = [CIImage imageWithCGImage:backgroundViewImage.CGImage];
    
    __weak typeof(self) me = self;
    [self.bgQueue addOperationWithBlock:^{
        
        CIFilter* blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
        [blurFilter setValue:backgroundViewCIImage forKey:kCIInputImageKey];
        [blurFilter setValue:[NSNumber numberWithFloat:5.0f] forKey:@"inputRadius"];
        CIImage* blurResult = [blurFilter valueForKey:kCIOutputImageKey];
        
        CIContext* context = [CIContext contextWithOptions:nil];
        CGImageRef backgroundViewBlurImageRef = [context createCGImage:blurResult fromRect:backgroundViewBounds];
        UIImage* backgroundViewBlurImage = [[UIImage alloc] initWithCGImage:backgroundViewBlurImageRef];
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            UIImageView* blurImageView = [[UIImageView alloc] initWithImage:backgroundViewBlurImage];
            [blurImageView setFrame:CGRectMake(0, 0, backgroundViewBounds.size.width, backgroundViewBounds.size.height)];
            [[blurImageView layer] setOpacity:0];
            
            [me.view addSubview:blurImageView];
            [me.view sendSubviewToBack:blurImageView];
            
            [UIView animateWithDuration:0.25f animations:^(void){
                 [[blurImageView layer] setOpacity:1];
            }];
            
            if (completion) {
                completion();
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
