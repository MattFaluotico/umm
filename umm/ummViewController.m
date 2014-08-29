//
//  ummViewController.m
//  umm
//
//  Created by Matthew Faluotico on 8/28/14.
//  Copyright (c) 2014 MPF. All rights reserved.
//

#import "ummViewController.h"
#import <pop/POP.h>

@interface ummViewController ()

@property NSInteger runningTotal;

@end

@implementation ummViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.runningTotal = [[NSUserDefaults standardUserDefaults] integerForKey:@"total"];
    NSLog(@"%i", self.runningTotal);
    
    self.addButton.layer.cornerRadius = self.addButton.frame.size.width / 2.0;
    self.addButton.backgroundColor = [UIColor colorWithRed:0.24 green:0 blue:1 alpha:1];
    [self.addButton setTintColor:[UIColor whiteColor]];
    [self.addButton setTitle:@"+" forState:UIControlStateNormal];
    self.addButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    self.endButton.layer.cornerRadius = self.endButton.frame.size.width / 2.0;
    self.endButton.backgroundColor = [UIColor colorWithRed:0.59 green:0 blue:0 alpha:1];
    
    [self.addButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self.addButton addTarget:self action:@selector(animateCounterButtonPush) forControlEvents:UIControlEventTouchDown];
    
    [self.endButton addTarget:self action:@selector(endTimer) forControlEvents:UIControlEventTouchUpInside];
    
    self.countLabel.text = [NSString stringWithFormat:@"%i", self.runningTotal];
    self.endButton.alpha = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Events

- (void) add {
    
    if (self.runningTotal == 0) {
        [self animateTimerButtonIn];
    }
    
    self.runningTotal++;
    self.countLabel.text = [NSString stringWithFormat:@"%i", self.runningTotal];
    [self animateCountIncrease];
    
    // slightly shrink the button,
    // but pop the addition
}

- (void) endTimer {
    [self animateTimerButtonOut];
}

- (void) viewDidDisappear:(BOOL)animated {
    [[NSUserDefaults standardUserDefaults] setInteger:self.runningTotal forKey:@"sum"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - POP Animation

- (void) animateCountIncrease {
    POPSpringAnimation *anim = [POPSpringAnimation animation];
    anim.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
    anim.fromValue  = [NSValue valueWithCGSize:CGSizeMake(0.0, 0.0f)];
    anim.toValue  = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];//@(0.0f);
    anim.springBounciness = 20.0f;
    anim.springSpeed = 20.0f;

    [self.countLabel pop_addAnimation:anim forKey:@"pop"];
}

- (void) animateCounterButtonPush {
    POPSpringAnimation *anim = [POPSpringAnimation animation];
    anim.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
    anim.fromValue  = [NSValue valueWithCGSize:CGSizeMake(0.95, 0.95)];
    anim.toValue  = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];//@(0.0f);
    anim.springBounciness = 20.0f;
    anim.springSpeed = 20.0f;
    [self.addButton pop_addAnimation:anim forKey:@"pop"];
}

- (void) animateTimerButtonIn {
    POPSpringAnimation *anim = [POPSpringAnimation animation];
    anim.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
    anim.fromValue =[NSValue valueWithCGSize:CGSizeMake(0, 0)];
    anim.toValue =[NSValue valueWithCGSize:CGSizeMake(1, 1)];
    anim.springBounciness = 20.0f;
    anim.springSpeed = 20.0f;
    POPSpringAnimation *al = [POPSpringAnimation animation];
    al.property = [POPAnimatableProperty propertyWithName:kPOPViewAlpha];
    al.fromValue =[NSValue valueWithCGSize:CGSizeMake(0, 0)];
    al.toValue =[NSValue valueWithCGSize:CGSizeMake(1, 1)];
    al.springBounciness = 20.0f;
    al.springSpeed = 20.0f;
    [self.endButton pop_addAnimation:anim forKey:@"pop"];
    [self.endButton pop_addAnimation:al forKey:@"pop2"];
}

- (void) animateTimerButtonOut {
    POPSpringAnimation *anim = [POPSpringAnimation animation];
    anim.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
    anim.fromValue =[NSValue valueWithCGSize:CGSizeMake(1.1, 1.1)];
    anim.toValue =[NSValue valueWithCGSize:CGSizeMake(0, 0)];
    anim.springBounciness = 20.0f;
    anim.springSpeed = 10.0f;
    POPSpringAnimation *al = [POPSpringAnimation animation];
    al.property = [POPAnimatableProperty propertyWithName:kPOPViewAlpha];
    al.fromValue =[NSValue valueWithCGSize:CGSizeMake(1, 1)];
    al.toValue =[NSValue valueWithCGSize:CGSizeMake(0, 0)];
    al.springBounciness = 20.0f;
    al.springSpeed = 20.0f;
    [self.endButton pop_addAnimation:anim forKey:@"pop"];
    [self.endButton pop_addAnimation:al forKey:@"pop2"];
}


@end
