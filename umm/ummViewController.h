//
//  ummViewController.h
//  umm
//
//  Created by Matthew Faluotico on 8/28/14.
//  Copyright (c) 2014 MPF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ummViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *endButton;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void) postpone;

- (void) populate;

@end
