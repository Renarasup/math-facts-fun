//
//  ResultsViewController.h
//  Math Cows
//
//  Created by Jeff Williams on 11/9/15.
//  Copyright (c) 2015 Jeff Williams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Test.h"
#import "AnswerTableViewCell.h"
#import "TestViewController.h"
#import "MyAnimator.h"

@interface ResultsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *resultsLbl;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *wrongResultsLbl;
@property (strong, nonatomic) IBOutlet UITableView *wrongAnswerTblView;
@property (nonatomic, retain) Test *test;
@property (strong, nonatomic) IBOutlet UILabel *correctLbl;
@property (strong, nonatomic) IBOutlet UILabel *wrongLbl;
@property (strong, nonatomic) IBOutlet UILabel *timeLbl;
@property (strong, nonatomic) IBOutlet UILabel *percentLbl;
@property (nonatomic, retain) NSArray *animatableObjects;

@end
