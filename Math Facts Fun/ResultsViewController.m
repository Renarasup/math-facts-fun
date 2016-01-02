//
//  ResultsViewController.m
//  Math Cows
//
//  Created by Jeff Williams on 11/9/15.
//  Copyright (c) 2015 Jeff Williams. All rights reserved.
//

#import "ResultsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ResultsViewController ()

@end

@implementation ResultsViewController


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.test.wrongAnswers;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"myCell";
    AnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[AnswerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
   
    Problem *problem = [self.test.wrongAnswerArray objectAtIndex:indexPath.row];
    
    cell.problemLbl.text = [NSString stringWithFormat:@"%d  %@  %d", problem.operand1, problem.operator, problem.operand2];
    cell.studentAnswerLbl.text = [NSString stringWithFormat:@"%d", problem.studentAnswer];
    cell.correctAnswerLbl.text = [NSString stringWithFormat:@"%d", problem.correctAnswer];
   
    return cell;
}

-(void)celebrate {
    UILabel *perfectLbl = [[UILabel alloc] init];
    perfectLbl.frame = CGRectMake(0, self.view.frame.size.height/2, 400,100);
    [self.view addSubview:perfectLbl];
    perfectLbl.transform = CGAffineTransformMakeRotation(-.2f);
    CAEmitterLayer *el = [[CAEmitterLayer alloc] init];
    el.emitterPosition = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    el.emitterSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    el.emitterShape = kCAEmitterLayerCircle;
    
    CAEmitterCell* star = [CAEmitterCell emitterCell];
    star.birthRate = 10;
    star.lifetime = 3.0;
    star.lifetimeRange = 1.4f;
    star.velocity = 100.0f;
  
    star.alphaRange = .3f;
    star.scaleRange=.5;
    star.spin = 1.0;
    star.spinRange= .5;
    star.emissionRange = self.view.frame.size.height;
    star.contents = (id)[[UIImage imageNamed:@"star.png"] CGImage];
    [star setName:@"star"];
    
    // add the cell to the layer and we're done
    el.emitterCells = [NSArray arrayWithObject:star];
    [self.view.layer addSublayer:el];
}
-(void)showResults {
    
    self.percentLbl.text = [NSString stringWithFormat:@"%.0f%%", self.test.percentageScore];
    
    [UIView animateWithDuration:.35
                          delay:.8
                        options:UIViewAnimationOptionAutoreverse
                     animations:^ {
                                self.percentLbl.transform = CGAffineTransformMakeScale(1.1,1.1); }
                     completion:nil
     
    ];
    if (self.test.percentageScore == 100.0) {
        [self celebrate];
    }
    else if (self.test.wrongAnswers > 0) {
          self.wrongResultsLbl.text = [NSString stringWithFormat:@"You answered %d problem(s) incorrectly",self.test.wrongAnswers];
    }
    if (self.test.initialTime !=0) {
        int timeUsed = self.test.initialTime - self.test.timeRemaining;
        int minutes = timeUsed/60;
        int seconds = timeUsed % 60;
        self.timeLbl.text = [NSString stringWithFormat:@"%d:%02d", minutes, seconds];

   
    }
    else self.timeLbl.text = @"--";
    self.correctLbl.text = [NSString stringWithFormat:@"%.0f", self.test.correctAnswers];
    self.wrongLbl.text = [NSString stringWithFormat:@"%d", self.test.wrongAnswers];
    
    self.resultsLbl.text = [NSString stringWithFormat:@"You completed %d out of %d problems.",( (int)self.test.correctAnswers + (int)self.test.wrongAnswers ), (int)self.test.totalProblems];
  
    
}

-(IBAction)homeBtn:(id)sender {
    [self performSegueWithIdentifier:@"homeSegue" sender:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAnimatableObjects];
    [MyAnimator hide:self.animatableObjects];
    
    self.wrongResultsLbl.text = @"";
    self.wrongAnswerTblView.delegate = self;
    self.wrongAnswerTblView.dataSource = self;
    self.wrongAnswerTblView.scrollEnabled = NO;
    
   
    [self showResults];
}

-(void)viewDidAppear:(BOOL)animated {
    [MyAnimator popIn:self.animatableObjects duration:.3 interval:.03 delay:0 completion:nil];
     self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height  + self.wrongAnswerTblView.contentSize.height - self.wrongAnswerTblView.frame.origin.y/2);
    
}

-(void)initAnimatableObjects {
    NSSortDescriptor *ascendingSort = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
    self.animatableObjects = [[self.view subviews] sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"testSegue"]) {
        TestViewController *tvc = (TestViewController*)[segue destinationViewController];
        tvc.test = [[Test alloc] initWithTest:self.test];
    }
}


@end
