//
//  ToolbarNavViewController.m
//  umm
//
//  Created by Matthew Faluotico on 4/30/15.
//  Copyright (c) 2015 MPF. All rights reserved.
//

#import "ToolbarNavViewController.h"

@interface ToolbarNavViewController ()

@end

@implementation ToolbarNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.progressButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Talk to timer

- (void) buttonPressed {
    
}

- (void) start {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Start" object:nil];
}

- (void) stop {
    
}

#pragma mark - Animations

- (void) startToStop {
    
}

- (void) stopToStart {
    
}

@end
