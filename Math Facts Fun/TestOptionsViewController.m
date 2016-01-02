//
//  TimeOptionsViewController.m
//  Math Facts Fun
//
//  Created by Jeff Williams on 11/8/15.
//  Copyright (c) 2015 Jeff Williams. All rights reserved.
//

#import "TestOptionsViewController.h"


@interface TestOptionsViewController ()

@end

@implementation TestOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.factors = [[NSMutableSet alloc]init];
    [self initAnimatableObjects];
    
    if ( [self.title isEqualToString:@"+"] || [self.title isEqualToString:@"-"] ) {
        if ( [self.title isEqualToString:@"-"] ) {
            self.operationImg.image = [UIImage imageNamed:@"minus.png"];
        }
    }
    else if ([self.title isEqualToString:@"x"] ) {
        self.operationImg.image = [UIImage imageNamed:@"multiply.png"];
    }
    else { self.operationImg.image = [UIImage imageNamed:@"divide.png"]; }
    
    for (int i = 1;i<=12;i++) {
        UIButton *btn = [self.view viewWithTag:i];
        btn.alpha = .3;
        btn.enabled = NO;
    }
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.problemsView.layer.cornerRadius = self.problemsView.frame.size.height/2;
    
    for (NSInteger i = 1; i <= 12; i++) {
        UIView *v = [self.view viewWithTag:i];
        v.layer.cornerRadius = v.frame.size.height/2;
    }

    
    [MyAnimator hide:self.animatableObjects];
    [MyAnimator popIn:self.animatableObjects duration:.3 interval:.03 delay:0 completion:^ {
        self.problemsView.layer.cornerRadius = self.problemsView.frame.size.height/2;
       
        for (NSInteger i = 1; i <= 12; i++) {
            UIView *v = [self.view viewWithTag:i];
            v.layer.cornerRadius = v.frame.size.height/2;
            
        }

    }];
    [MyAnimator move:self.logoBtn x:0 y:200 duration:.3 delay:.3 completion:nil];
    [MyAnimator move:self.optionsLbl x:0 y:200 duration:.3 delay:.5 completion:nil];
    [MyAnimator move:self.factorsLbl x:-400 y:0 duration:.35 delay:.5 completion:nil];
}



-(void)initAnimatableObjects {
    NSSortDescriptor *ascendingSort = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
    self.animatableObjects = [[self.view subviews] sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    self.logoBtn.center = CGPointMake(self.logoBtn.center.x, self.logoBtn.center.y - 200);
    self.optionsLbl.center = CGPointMake(self.optionsLbl.center.x, self.optionsLbl.center.y-200);
    self.factorsLbl.center = CGPointMake(self.factorsLbl.center.x + 400, self.factorsLbl.center.y);
}
- (IBAction)factSwitch:(id)sender{
    UISwitch *sw = (UISwitch*)sender;
    if (sw.on) {
        for (int i=1; i<=12;i++) {
            UIButton *btn = [self.view viewWithTag:i];
            btn.enabled = YES;
            btn.alpha = 1.0;
        }
    }
    else {
        for (int i=1;i<=12;i++) {
            UIButton *btn = [self.view viewWithTag:i];
            btn.alpha = .3;
            btn.enabled = NO;
        }
    }
}

-(IBAction)updateSliders:(id)sender {
    UISlider *this = (UISlider*)sender;
    if ( [sender tag]  == 100) {
      // update problems slider
        int value = this.value;
        int roundedNum = value % 10;
        if (roundedNum >= 5) {
            value = value - roundedNum + 10;
        }
        else value -= roundedNum;
        self.problemsLbl.text = [NSString stringWithFormat:@"%d",(int)value];
        self.problemsSlider.value = value;
        
    }
    else if ( [sender tag] == 200) {
        // update timer slider
       
        int roundedNum = (int)this.value % 30;
        if (roundedNum >=15) {
            this.value = this.value - roundedNum + 30;
        }
        else this.value -= roundedNum;
        
        int minutes = this.value/60;
        int seconds = (int)this.value % 60;
        if ((int)this.value == 0) {
            self.timerLbl.text = @"No Timer";
        }
        else {
            self.timerLbl.text = [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)factorPressed:(id)sender {
    
    int tag = (int)[sender tag];
    UIButton *btn = (UIButton*)sender;
    if ([self.factors containsObject:[NSNumber numberWithInt:tag]]) {
        // remove factor from set
        [self.factors removeObject:[NSNumber numberWithInt:tag]];
        btn.layer.borderColor = [UIColor clearColor].CGColor;
        btn.layer.borderWidth=0.0;
    }
    else {
        // add factor to set
        [self.factors addObject:[NSNumber numberWithInt:tag]];
        // change background color to darker
        btn.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5].CGColor;
        btn.layer.borderWidth = 3.0;
    }
}

#pragma mark - Navigation
-(IBAction)startBtn:(id)sender {
    [self performSegueWithIdentifier:@"testSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"testSegue"]) {
            TestViewController *tvc = (TestViewController*)[segue destinationViewController];
        Test *test = [[Test alloc] initWithProblems:self.problemsSlider.value andOperator:self.title andTime:self.timerSlider.value];
        if (self.factSwitch.on) {
            test.factors = [NSSet setWithSet:self.factors];
        }
        
        [test create];
        tvc.test = test;
    }
}


@end
