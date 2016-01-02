//
//  OptionsViewController.h
//  Math Cows
//
//  Created by Jeff Williams on 11/8/15.
//  Copyright (c) 2015 Jeff Williams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAnimator.h"

@interface OptionsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *logo;
@property (strong, nonatomic) IBOutlet UILabel *bottomLbl;
@property(nonatomic, retain) NSArray *popObjects;
@property (strong, nonatomic) IBOutlet UIButton *plus;
@property (strong, nonatomic) IBOutlet UIButton *minus;
@property (strong, nonatomic) IBOutlet UIButton *multiply;
@property (strong, nonatomic) IBOutlet UIButton *divide;

@end
