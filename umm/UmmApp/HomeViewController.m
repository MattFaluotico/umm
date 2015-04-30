//
//  HomeViewController.m
//  umm
//
//  Created by Matthew Faluotico on 4/30/15.
//  Copyright (c) 2015 MPF. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void) viewDidAppear:(BOOL)animated {
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(start) name:@"Start" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];    
    self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) start {
    [self performSegueWithIdentifier:@"CountersIn" sender:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
