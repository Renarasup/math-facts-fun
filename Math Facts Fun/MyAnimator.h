//
//  MyAnimator.h
//  Math Facts Fun
//
//  Created by Jeff Williams on 11/19/15.
//  Copyright © 2015 Jeff Williams. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UiKit.h>

typedef void(^PopCompletionBlock)(void);

@interface MyAnimator : NSObject

+(void)popIn:(NSArray*)animatableObjects duration:(float)duration interval:(float)interval delay:(float)delay completion:(PopCompletionBlock)completion;
+(void)popIn:(UIView *)view duration:(float)duration delay:(float)delay completion:(PopCompletionBlock)completion;

+(void)popOut:(NSArray*)animatableObjects duration:(float)duration delay:(float)delay interval:(float)interval completion:(PopCompletionBlock)completion;
+(void)popOut:(UIView *)view duration:(float)duration delay:(float)delay completion:(PopCompletionBlock)completion;

+(void)move:(UIView*)animatedView x:(float)x y:(float)y duration:(float)duration delay:(float)delay completion:(PopCompletionBlock)completion;
+(void)hide:(NSArray*)views;

@end
