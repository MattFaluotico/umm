//
//  CounterButton.m
//  umm
//
//  Created by Matthew Faluotico on 4/30/15.
//  Copyright (c) 2015 MPF. All rights reserved.
//

#import "CounterButton.h"

@implementation CounterButton

- (id) initWithColor: (UIColor *) color andWord: (NSString *) word {
    
    NSArray *theView =  [[NSBundle mainBundle] loadNibNamed:@"CounterButton" owner:self options:nil];
    self = [theView objectAtIndex:0];
    
//    self = [super initWithFrame:CGRectMake(0, 0, 160, 160)];
    self.count.backgroundColor = color;
    self.count.layer.cornerRadius = self.count.frame.size.width / 2.0;
    self.count.clipsToBounds = YES;
    self.word.textColor = color;
    self.word.text = word;
    self.count.text = @"0";
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

@end
