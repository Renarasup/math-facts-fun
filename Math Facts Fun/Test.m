//
//  Test.m
//  Math Cows
//
//  Created by Jeff Williams on 11/9/15.
//  Copyright (c) 2015 Jeff Williams. All rights reserved.
//

#import "Test.h"
#import <math.h>

@implementation Problem


-(id)initWithOperator:(NSString*)operator andFactors:(NSSet*)factors {
    if (self=[super init]) {
        self.operator = operator;
        if ( [factors count] == 0 ) {
            self.operand1 = arc4random() % 13;
            self.operand2 = arc4random() % 12 + 1;
        }
        else {
            // calculate operands based  on the factors
            NSArray *operandArray = [[NSArray alloc] init];
            operandArray = [factors allObjects];
            int random = arc4random() % [operandArray count];
            int randomPlacement = arc4random() % 2;
            if ([self.operator isEqualToString:@"÷"]) {
                self.operand2 = [[operandArray objectAtIndex:random] intValue];
                self.operand1 = arc4random() % 12 + 1;

            }
            else if ([self.operator isEqualToString:@"-"] ) {
                self.operand2 = [[operandArray objectAtIndex:random] intValue];
                self.operand1 = arc4random() % 13 + self.operand2;
            }
            
            else {
                if (randomPlacement) {
                    self.operand1 = [[operandArray objectAtIndex:random] intValue];
                    self.operand2 = arc4random() % 13;
                }
                else {
                    self.operand1 = arc4random() % 13;
                    self.operand2 = [[operandArray objectAtIndex:random] intValue];
                }
            }
            
        }
        if ( [operator isEqualToString:@"+"]) {
            self.correctAnswer = self.operand1 + self.operand2;
        }
        else if ([operator isEqualToString:@"-"]) {
            if (self.operand1 < self.operand2) {
                int temp = self.operand2;
                self.operand2 = self.operand1;
                self.operand1 = temp;
            }
            self.correctAnswer = self.operand1 - self.operand2;
        }
        else if ([operator isEqualToString:@"x"]) {
            self.correctAnswer = self.operand1 * self.operand2;
        }
        // ÷ symbol is alt + ? key
        else if ([operator isEqualToString:@"÷"]) {
            int dividend = self.operand1 * self.operand2;
            self.operand1 = dividend;
            self.correctAnswer = self.operand1/self.operand2;
        }
    }
    return self;
}
    
@end


@implementation Test

-(id)initWithTest:(Test*)test {
    if (self = [super init]) {
        self.currentProblemNumber = -1;
        if (test.factors) {
             self.factors = [[NSSet alloc] initWithSet:test.factors];
        }
        self.problemArray = [[NSMutableArray alloc] init];
        self.totalProblems = test.totalProblems;
        self.operator = test.operator;
        self.correctAnswers = 0;
        self.wrongAnswers = 0;
        self.wrongAnswerArray = [[NSMutableArray alloc] init];
        if (test.initialTime == 0) {
            self.timer = nil;
            self.timeRemaining = 0;
            self.timer = nil;
        }
        self.initialTime = test.initialTime;
        
       
        self.timeRemaining = test.initialTime;
        [self create];
       
    }
    return self;
}

-(id)initWithProblems:(float)problems andOperator:(NSString*)operator andTime:(float)time {
    if (self=[super init]) {
        if (time) {
         self.initialTime = time;
         self.timeRemaining = time;
        }
        self.currentProblemNumber = -1;
        self.totalProblems = problems;
        self.operator = operator;
        self.problemArray = [[NSMutableArray alloc] init];
        self.correctAnswers = 0;
        self.wrongAnswers = 0;
        self.wrongAnswerArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(BOOL)checkAnswer:(int)answer {
    Problem *problem = [self.problemArray objectAtIndex:self.currentProblemNumber];
    problem.studentAnswer = answer;

    if ( answer == problem.correctAnswer ) {
        self.correctAnswers++;
        return YES;
    }
    else {
        self.wrongAnswers++;
        [self.wrongAnswerArray addObject:problem];
        return NO;
    }
}


-(Problem*)getNextProblem {
    self.currentProblemNumber++;
    if (self.currentProblemNumber < self.totalProblems) {
        return [self.problemArray objectAtIndex:self.currentProblemNumber];
    }
    else return nil;
   
}

-(void)create {
    for (int i=0; i < self.totalProblems; i++ ) {
        Problem *problem = [[Problem alloc] initWithOperator:self.operator andFactors:self.factors];
        [self.problemArray addObject:problem];
    }
}



-(void)updateTime {
    self.timeRemaining--;
    if (self.timeRemaining > 0) {
        [self.delegate updateTime:self.timeRemaining];
    }
    else {
        [self end];
        [self.delegate finish];
    }
}
-(void)begin {
    // start timer
    if (self.initialTime > 0) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    }
}
-(void)end {
    // stop timer
    [self.timer invalidate];
    self.timer = nil;
    
    // calculate percentage
    self.percentageScore = (self.correctAnswers/self.totalProblems)  * 100;
    
  
   
}
@end
