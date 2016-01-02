//
//  keypad.h
//  Math Cows
//
//  Created by Jeff Williams on 11/9/15.
//  Copyright (c) 2015 Jeff Williams. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol KeypadDelegate

@optional

-(void)keyDown:(id)sender;

@end

@interface Keypad : UIView


@property (strong, nonatomic) IBOutlet UIView *view;
@property (nonatomic) UIColor *color;
@property (nonatomic) int value;
@property (nonatomic, weak) id delegate;
@end
