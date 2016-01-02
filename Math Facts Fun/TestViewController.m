//
//  TestViewController.m
//  MADS
//
//  Created by Jeff Williams on 11/9/15.
//  Copyright (c) 2015 Jeff Williams. All rights reserved.
//

#import "TestViewController.h"


@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animatableObjects = [[NSArray alloc] init];
    [self initAnimatableObjects];
    [MyAnimator hide:self.animatableObjects];
      self.test.delegate = self;
}

-(void)initAnimatableObjects {
    NSSortDescriptor *ascendingSort = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
    self.animatableObjects = [[self.view subviews] sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
}

-(void)viewDidAppear:(BOOL)animated {
    [MyAnimator popIn:self.animatableObjects duration:.35 interval:.03 delay:0 completion:nil];
    [self.test begin];
    [self updateLabels];
}

-(void)timerBlink {
    self.timerLbl.textColor = [UIColor redColor];
    [UIView animateWithDuration:.5 delay:0
            options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat
     |UIViewAnimationOptionCurveEaseInOut
            animations:^ {
                self.timerLbl.alpha = 0.5;
            }
            completion:^(BOOL finished) {
     }];
}
// TEST DELEGATE METHODS

-(void)updateTime:(float)time {
    int minutes = (int)self.test.timeRemaining/60;
    int seconds = (int)self.test.timeRemaining % 60;

    self.timerLbl.text = [NSString stringWithFormat:@"%d:%02d",minutes, seconds];
    
    if ( self.test.timeRemaining == 10.0) {
        
        [self timerBlink];
    }
}

-(void)finishToResultsPage {
      [self performSegueWithIdentifier:@"resultsSegue" sender:self];
}

-(void)finish {
    [self finishToResultsPage];
}
// ***************************************

-(void)doProblemAnimation {
    self.operatorLbl.transform = CGAffineTransformMakeScale(0.0,0.0);
    self.operatorLbl.center = CGPointMake(self.operatorLbl.center.x,-100);
    [MyAnimator popIn:self.operatorLbl duration:.2 delay:.1 completion:nil];
    
    self.operand1Lbl.transform = CGAffineTransformMakeScale(0.0,0.0);
    self.operand1Lbl.center = CGPointMake(self.operand1Lbl.center.x, -100);
    [MyAnimator popIn:self.operand1Lbl duration:.2 delay:.05 completion:nil];
    
    self.operand2Lbl.transform = CGAffineTransformMakeScale(0.0,0.0);
    self.operand2Lbl.center = CGPointMake(self.operand2Lbl.center.x, -100);
    [MyAnimator popIn:self.operand2Lbl duration:.2 delay:.15 completion:nil];
    
}

-(void)updateLabels {
    Problem *problem = [self.test getNextProblem];
    if (problem) {
        [self doProblemAnimation];
        self.answerLbl.text = @"";
        self.answerLbl.transform = CGAffineTransformMakeScale(1.0,1.0);
        self.answerLbl.textColor = [UIColor colorWithRed:33/255.0 green:159/255.0 blue:206/255.0 alpha:1.0];
        self.operatorLbl.text = [NSString stringWithFormat:@"%@",self.test.operator];
        self.operand1Lbl.text =[NSString stringWithFormat:@"%d",problem.operand1];
        self.operand2Lbl.text =[NSString stringWithFormat:@"%d",problem.operand2];

        self.correctLbl.text = [NSString stringWithFormat:@"%.0f", self.test.correctAnswers];
        self.wrongLbl.text = [NSString stringWithFormat:@"%d", self.test.wrongAnswers];
        self.problemNumberLbl.text = [NSString stringWithFormat:@"%d / %.0f", self.test.currentProblemNumber+1, self.test.totalProblems];
    }
    else {
        // no more problems, show results view controller
        [self.test end];
        [self finishToResultsPage];
    }
}

-(IBAction)keyDown:(id)sender {
    NSString *oldText = self.answerLbl.text;
    
    if ([sender tag] < 10 && [self.answerLbl.text length] < 4) {
        // a digit 0-9 was entered so add to label string
            
        self.answerLbl.text = [oldText stringByAppendingString:[NSString stringWithFormat:@"%d",(int)[sender tag]]];
    }
    // check how many digits correct answer has in it and only check correct answer if user has inputted that many digits
    else if ([sender tag] == 13 && [self.answerLbl.text length] > 0)
    {
        // enter key hit
        if ( [self.test checkAnswer:[self.answerLbl.text intValue]] && [self.answerLbl.text length] > 0) {
            // right answer
            
            self.view.userInteractionEnabled = NO;
            self.answerLbl.textColor = [UIColor greenColor];
            [UIView animateWithDuration:.1
                                  delay:0 options:UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        self.checkmark.alpha = 1.0;
                                
                        self.topCheckmarkImg.transform = CGAffineTransformMakeScale(1.2,1.2);
                    }
                    completion:^(BOOL finished) {
                        self.checkmark.alpha = 0.0;
                        self.view.userInteractionEnabled = YES;
                        [self updateLabels];
                        [UIView animateWithDuration:.1 animations:^{
                            self.topCheckmarkImg.transform = CGAffineTransformMakeScale(1.0,1.0);
                        }];
                    }];
            
        }
        else {
            // incorrect answer
            self.view.userInteractionEnabled = NO;
            self.answerLbl.textColor = [UIColor redColor];
            [UIView animateWithDuration:.1
                                  delay:0 options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 self.x.alpha = 1.0;
                                 self.topXImg.transform = CGAffineTransformMakeScale(1.2,1.2);

                             }
                             completion:^(BOOL finished) {
                                 self.x.alpha = 0.0;
                                 [UIView animateWithDuration:.1 animations:^{
                                     self.topXImg.transform = CGAffineTransformMakeScale(1.0,1.0);
                                 }];
                                 self.view.userInteractionEnabled = YES;
                                 [self updateLabels];
                             }];
        }
    }
    else if ([sender tag] == 12) {
        // backspace
        if ([self.answerLbl.text length] > 0) {
            self.answerLbl.text = [self.answerLbl.text substringToIndex:[self.answerLbl.text length] - 1];
        }
    }

    else if ([sender tag] == 11) {
        // clear key hit
        self.answerLbl.text = @"";
    }
}

             
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)homeBtn:(id)sender {
    [self.test end];
    [self performSegueWithIdentifier:@"homeSegue" sender:self];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ( [[segue identifier] isEqualToString:@"resultsSegue"]) {
        ResultsViewController *rvc = (ResultsViewController*)[segue destinationViewController];
        [rvc setTest:self.test];
    }
}


@end
