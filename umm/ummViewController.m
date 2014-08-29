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
@property BOOL timerIsRunning;
@property NSTimer *timer;
@property NSInteger seconds;

@end

@implementation ummViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = 5;


    self.addButton.layer.cornerRadius = self.addButton.frame.size.width / 2.0;
    self.addButton.backgroundColor = [UIColor colorWithRed:0.24 green:0 blue:1 alpha:1];
    [self.addButton setTintColor:[UIColor whiteColor]];
    [self.addButton setTitle:@"umm" forState:UIControlStateNormal];
    self.addButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    self.endButton.layer.cornerRadius = self.endButton.frame.size.width / 2.0;
    self.endButton.backgroundColor = [UIColor colorWithRed:0.59 green:0 blue:0 alpha:1];
    
    [self.addButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self.addButton addTarget:self action:@selector(animateCounterButtonPush) forControlEvents:UIControlEventTouchDown];
    
    [self.endButton addTarget:self action:@selector(endTimer) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"debut_light.png"]];
    self.countLabel.text = [NSString stringWithFormat:@"%i", self.runningTotal];
    if (!self.timerIsRunning) {
        self.endButton.alpha = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Events

- (void) add {
    
    if (self.runningTotal == 0) {
        [self animateTimerButtonIn];
        self.seconds = 0;
        self.timerIsRunning = YES;
        [self timerStart];
    }
    
    if (!self.timerIsRunning) {
        self.seconds = 0;
        self.runningTotal = 0;
        self.timerIsRunning = YES;
        [self timerStart];
    }
    
    self.runningTotal++;
    self.countLabel.text = [NSString stringWithFormat:@"%li", (long)self.runningTotal];
    [self animateCountIncrease];
    
    // slightly shrink the button,
    // but pop the addition
}

- (void) endTimer {
    self.timerIsRunning = NO;
    [self animateTimerButtonOut];
    [self.timer invalidate];
}

- (void) populate {
    
    self.timerIsRunning = YES;
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats: YES];
    self.seconds = [[NSDate date] timeIntervalSinceDate:[[NSUserDefaults standardUserDefaults] objectForKey:@"startTime"]];
    self.runningTotal = [[NSUserDefaults standardUserDefaults] integerForKey:@"total"];
    
    self.endButton.alpha = 1;
}

- (void) postpone {
    
    NSLog(@"hold up...");
    
    [[NSUserDefaults standardUserDefaults] setInteger:self.runningTotal forKey:@"total"];
    [[NSUserDefaults standardUserDefaults] setBool:self.timerIsRunning forKey:@"timerIsRunning"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) timerStart {
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats: YES];
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"startTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) updateTimer {
    int hours, minutes, seconds;
    self.seconds++;
    hours = self.seconds / 3600;
    minutes = (self.seconds % 3600) / 60;
    seconds = (self.seconds %3600) % 60;
    self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
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
