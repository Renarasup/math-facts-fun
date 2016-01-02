//
//  AnswerTableViewCell.h
//  Math Facts Fun
//
//  Created by Jeff Williams on 11/15/15.
//  Copyright © 2015 Jeff Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *correctAnswerLbl;
@property (strong, nonatomic) IBOutlet UILabel *studentAnswerLbl;
@property (strong, nonatomic) IBOutlet UILabel *problemLbl;

@end
