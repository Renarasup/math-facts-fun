//
//  TestOptionsViewController.h
//  Math Facts Fun
//
//  Created by Jeff Williams on 11/8/15.
//  Copyright (c) 2015 Jeff Williams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Test.h"
#import "Test.h"
#import "TestViewController.h"
#import "MyAnimator.h"
#import <QuartzCore/QuartzCore.h>

@interface TestOptionsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISwitch *factSwitch;


@property (strong, nonatomic) IBOutlet UIButton *startBtn;
@property(nonatomic) int factorSwitchOnCount;
@property (strong, nonatomic) IBOutlet UILabel *factorsLbl;
@property (strong, nonatomic) IBOutlet UIButton *logoBtn;
@property (strong, nonatomic) IBOutlet UILabel *optionsLbl;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property(nonatomic, retain) NSString *operator;
@property(nonatomic, retain) Test *test;
@property (strong, nonatomic) IBOutlet UILabel *timerLbl;
@property (strong, nonatomic) IBOutlet UISlider *timerSlider;
@property (strong, nonatomic) IBOutlet UILabel *problemsLbl;
@property (strong, nonatomic) IBOutlet UISlider *problemsSlider;
@property(nonatomic, retain) NSMutableSet *factors;
@property(nonatomic, retain) NSArray *animatableObjects;
@property (strong, nonatomic) IBOutlet UIView *problemsView;
@property (strong, nonatomic) IBOutlet UIImageView *operationImg;


@end
