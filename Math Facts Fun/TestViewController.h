//
//  TestViewController.h
//  MADS
//
//  Created by Jeff Williams on 11/9/15.
//  Copyright (c) 2015 Jeff Williams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Test.h"
#import "Keypad.h"
#import "ResultsViewController.h"
#import "OptionsViewController.h"
#import "MyAnimator.h"

@interface TestViewController : UIViewController <TestDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *checkmark;
@property (strong, nonatomic) IBOutlet UILabel *operand1Lbl;
@property (strong, nonatomic) IBOutlet UILabel *operand2Lbl;
@property (strong, nonatomic) IBOutlet UILabel *answerLbl;
@property (strong, nonatomic) IBOutlet UILabel *correctLbl;
@property (strong, nonatomic) IBOutlet UILabel *wrongLbl;
@property (strong, nonatomic) IBOutlet UILabel *operatorLbl;
@property(nonatomic, retain) Test *test;
@property (strong, nonatomic) IBOutlet UILabel *timerLbl;
@property (strong, nonatomic) IBOutlet UIImageView *x;
@property (strong, nonatomic) IBOutlet UILabel *problemNumberLbl;
@property (strong, nonatomic) IBOutlet UIImageView *topCheckmarkImg;
@property (strong, nonatomic) IBOutlet UIImageView *topXImg;
@property(nonatomic, retain) NSArray *animatableObjects;
@end
