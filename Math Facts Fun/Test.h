//
//  Test.h
//  Math Cows
//
//  Created by Jeff Williams on 11/9/15.
//  Copyright (c) 2015 Jeff Williams. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Problem:NSObject

@property (nonatomic) int operand1;
@property (nonatomic) int operand2;
@property (nonatomic) int correctAnswer;
@property (nonatomic) int studentAnswer;
@property (nonatomic, retain) NSString *operator;

-(id)initWithOperator:(NSString*)operator andFactors:(NSSet*)factors;

@end




@protocol TestDelegate

-(void)updateTime:(float)time;
-(void)finish;

@end



@interface Test : NSObject

@property(nonatomic) float initialTime;
@property(nonatomic) float timeRemaining;
@property  NSMutableArray *problemArray;
@property(nonatomic) int currentProblemNumber;
@property(nonatomic) float totalProblems;
@property(nonatomic) float correctAnswers;
@property(nonatomic) int wrongAnswers;
@property(nonatomic, retain) NSSet *factors;
@property(nonatomic, retain) NSString *operator;
@property(weak,nonatomic) id delegate;
@property(nonatomic, retain) NSMutableArray *wrongAnswerArray;
@property(nonatomic, retain) NSTimer *timer;
@property(nonatomic) float percentageScore;

-(void)create;
-(Problem*)getNextProblem;
-(BOOL)checkAnswer:(int)answer;
-(void)begin;
-(void)end;
-(id)initWithProblems:(float)problems andOperator:(NSString*)operator andTime:(float)time;
-(id)initWithTest:(Test*)test;
@end
