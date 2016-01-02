//
//  OptionsViewController.m
//  MADS
//
//  Created by Jeff Williams on 11/8/15.
//  Copyright (c) 2015 Jeff Williams. All rights reserved.
//

#import "OptionsViewController.h"
#import "TestOptionsViewController.h"

@interface OptionsViewController ()

@end

@implementation OptionsViewController

-(void)PopAnimationFinished {
      [self performSegueWithIdentifier:@"optionsSegue" sender:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.popObjects = [[NSArray alloc] init];
    [self initAnimatableObjects];
    [MyAnimator hide:self.popObjects];
}

-(void)viewWillAppear:(BOOL)animated {
    [MyAnimator popIn:self.popObjects duration:.35 interval:.05 delay:0 completion:nil];
    [MyAnimator move:self.logo x:0 y:100 duration:.5 delay:.3 completion:nil];
    [MyAnimator move:self.bottomLbl x:0 y:-250 duration:.5 delay:.3 completion:nil];
}

- (IBAction)buttonPressed:(id)sender {
    switch ([sender tag]) {
        case 10:
            self.title = @"+";
            break;
        case 20:
            self.title = @"-";
           
            break;
        case 30:
            self.title = @"x";
           
            break;
        case 40:
            self.title = @"÷";
            break;
    }
    [self performSegueWithIdentifier:@"optionsSegue" sender:self];

}



-(void)initAnimatableObjects {
    self.popObjects = [[NSArray alloc] initWithObjects:self.plus, self.minus, self.multiply, self.divide,nil];
    self.logo.center = CGPointMake(self.logo.center.x, self.logo.center.y - 100);
    self.bottomLbl.center = CGPointMake(self.bottomLbl.center.x, self.bottomLbl.center.y+250);
}



- (BOOL)shouldAutorotate
{
    return NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [[segue destinationViewController] setTitle:self.title];
}


@end
