//
//  CounterButton.h
//  umm
//
//  Created by Matthew Faluotico on 4/30/15.
//  Copyright (c) 2015 MPF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CounterButton : UIView

@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UILabel *word;

- (id) initWithColor: (UIColor *) color andWord: (NSString *) word ;

@end
