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
//    self.addButton.backgroundColor = [UIColor colorWithRed:0.24 green:0 blue:1 alpha:1];
    [self.addButton setTintColor:[UIColor whiteColor]];
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
        [self resetEndButton];
        [self animateTimerButtonIn];
        self.seconds = 0;
        self.timerIsRunning = YES;
        [self timerStart];
    }
    
    if (!self.timerIsRunning) {
        [self resetEndButton];
        [self animateTimerButtonIn];
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
    

    if (self.timerIsRunning) {
        
        NSLog(@"Timer is running");

        self.timerIsRunning = NO;
        [self animateTimerButtonToShareButton];
        [self.timer invalidate];
        self.timer = nil;
    } else {
        [self share];
    }
    
}

- (void) populate {
    
    self.timerIsRunning = YES;
//    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats: YES];
    self.seconds = [[NSDate date] timeIntervalSinceDate:[[NSUserDefaults standardUserDefaults] objectForKey:@"startTime"]];
    self.runningTotal = [[NSUserDefaults standardUserDefaults] integerForKey:@"total"];
    
    self.endButton.alpha = 1;
}

- (void) postpone {
    
    NSLog(@"hold up...");
    
    [self.timer invalidate];
    self.timer = nil;
    
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
    
    NSLog(@"%@", self.timer);
    
    int hours, minutes, seconds;
    self.seconds++;
    hours = self.seconds / 3600;
    minutes = (self.seconds % 3600) / 60;
    seconds = (self.seconds %3600) % 60;
    self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
}

- (void) resetEndButton {
    
    CGRect size = self.endButton.frame;
    size.size = CGSizeMake(40, 40);
    self.endButton.frame = size;
    self.endButton.layer.cornerRadius = 20;
    self.endButton.backgroundColor = [UIColor colorWithRed:0.59 green:0 blue:0 alpha:1];
    [self.endButton setTitle:@"X" forState:UIControlStateNormal];
    self.endButton.alpha = 0;

}

- (void) share {

    MFMailComposeViewController *mailcomposer = [[MFMailComposeViewController alloc] init];
    mailcomposer.mailComposeDelegate = self;
    [mailcomposer setSubject:@"Just so you know..."];
    [mailcomposer setMessageBody:[self messageBody] isHTML:NO];
    [self presentViewController:mailcomposer animated:YES completion:^{
        [self resetEndButton];
    }];
    
}

- (NSString*) messageBody {
    NSString *message = @"";
    
    message = [NSString stringWithFormat:@"You said 'umm' %li times in", (long)self.runningTotal ];
    
    int hours, minutes, seconds;
    self.seconds++;
    hours = self.seconds / 3600;
    minutes = (self.seconds % 3600) / 60;
    seconds = (self.seconds %3600) % 60;
    
    if (hours == 0) {
        
        if (minutes == 0) {
           message = [NSString stringWithFormat:@"%@ %2d seconds", message, seconds];
        } else {
            message = [NSString stringWithFormat:@"%@ %2d minutes and %2d seconds",message,minutes, seconds];
        }
        
    } else if (minutes == 0) {
       message = [NSString stringWithFormat:@"%@ %2d seconds", message, seconds];
    } else {
       message = [NSString stringWithFormat:@"%@ %2d hours, %2d minutes, and %2d seconds", message, hours, minutes, seconds];
    }
    
    
    return message;
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

- (void) animateTimerButtonToShareButton {
    
//    [self.addButton setTitle:@"start" forState:UIControlStateNormal];
    
    POPSpringAnimation *bounds = [POPSpringAnimation animation];
    bounds.property = [POPAnimatableProperty propertyWithName:kPOPViewBounds];
    bounds.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 90, 40)];
    [self.endButton pop_addAnimation:bounds forKey:@"bounds"];
    
    POPBasicAnimation *color = [POPBasicAnimation animation];
    color.property = [POPAnimatableProperty propertyWithName:kPOPViewBackgroundColor];
    color.toValue = [UIColor colorWithRed:0.17 green:0.73 blue:0.23 alpha:1];
    [self.endButton pop_addAnimation:color forKey:@"color"];
    
    POPSpringAnimation *corners = [POPSpringAnimation animation];
    corners.property = [POPAnimatableProperty propertyWithName:kPOPLayerCornerRadius];
    corners.toValue = @(0);
    [self.endButton.layer pop_addAnimation:corners forKey:@"corners"];
    
    [self performSelector:@selector(setEndButtonText) withObject:nil afterDelay:0.3];
    
    

}

#pragma Mark - Selectors and Delegates

- (void) setEndButtonText {
    
        [self.endButton setTitle:@"Tell Them" forState:UIControlStateNormal];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
