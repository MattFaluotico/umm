//
//  FadeSegue.m
//  umm
//
//  Created by Matthew Faluotico on 4/30/15.
//  Copyright (c) 2015 MPF. All rights reserved.
//

#import "FadeSegue.h"
#import "UIImage+ImageEffects.h"

@implementation FadeSeguePush

- (void) perform {
    CATransition* transition = [CATransition animation];
    
    transition.duration = 0.15;
    transition.type = kCATransitionFade;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    UIViewController *destination = (UIViewController*) self.destinationViewController;
    UIViewController *source = (UIViewController*) self.sourceViewController;
    [self setBlurToDestination:destination fromSource:source];
    
    [[self.sourceViewController navigationController].view.layer addAnimation:transition forKey:kCATransition];
    [[self.sourceViewController navigationController] pushViewController:[self destinationViewController] animated:NO];
}

- (UIImage *) imagefromView: (UIView *) view {
    UIGraphicsBeginImageContext(view.bounds.size);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void) setBlurToDestination: (UIViewController *) destination fromSource: (UIViewController *) source {
    UIImage *backgroundImage = [self imagefromView:source.view];
    
    destination.view.backgroundColor = [UIColor clearColor];
    
    UIImageView* backView = [[UIImageView alloc] initWithFrame:source.view.frame];
    // Blur the image
    UIImage *blur = [backgroundImage applyBlurWithRadius:5 tintColor:[UIColor colorWithWhite:0 alpha:0.2]
                                   saturationDeltaFactor:1.3
                                               maskImage:nil];
    
    backView.image = blur;
    backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [destination.view addSubview:backView];
}

@end

@implementation FadeSeguePop

- (void) perform {
    
    CATransition* transition = [CATransition animation];
    
    transition.duration = 0.2;
    transition.type = kCATransitionFade;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [[self.sourceViewController navigationController].view.layer addAnimation:transition forKey:kCATransition];
    [[self.sourceViewController navigationController] pushViewController:[self destinationViewController] animated:NO];
}

@end