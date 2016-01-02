//
//  MyAnimator.m
//  Math Facts Fun
//
//  Created by Jeff Williams on 11/19/15.
//  Copyright © 2015 Jeff Williams. All rights reserved.
//

#import "MyAnimator.h"


@implementation MyAnimator

+(void)hide:(NSArray*)views {
    for (int i=0; i < [views count];i++) {
        UIView *v = [views objectAtIndex:i];
        v.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    }
}

+(void)popIn:(NSArray *)animatableObjects duration:(float)duration interval:(float)interval delay:(float)delay completion:(PopCompletionBlock)completion {
        for (int i=0; i<[animatableObjects count];i++) {
            UIView *v = [animatableObjects objectAtIndex:i];
            [UIView animateWithDuration:duration
                                  delay:delay
                                options:0
                             animations:^{
                                 v.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
                               
                             }
                             completion:^(BOOL finished) {
                                 [UIView animateWithDuration:duration animations:^{
                                     v.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                                 }];
                                 if (completion) {
                                    completion();
                                 }
                             }];
            delay += interval;
       
    }
}

+(void)popIn:(UIView *)view duration:(float)duration delay:(float)delay completion:(PopCompletionBlock)completion {
    [UIView animateWithDuration:duration
                          delay:delay
     
                        options:0
                     animations:^{
                         view.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:duration animations:^{
                             view.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                         }];
                         if (completion) { completion(); }
                     }];

}

+(void)popOut:(NSArray*)animatableObjects duration:(float)duration delay:(float)delay interval:(float)interval completion:(PopCompletionBlock)completion {

    for (NSInteger i=[animatableObjects count]-1;i>=0;i--) {
        UIView *v = [animatableObjects objectAtIndex:i];
        [UIView animateWithDuration:duration delay:delay
                            options:0
                         animations:^{
                             v.alpha = 0.0f;
                             
                         }
                         completion:^(BOOL finished) {
                             if (i==0) {
                                 // last animation completed
                                 if (completion) {
                                     completion();
                                 }
                                 
                             }
                             
                         }];
        delay += interval;
     }
        
}

+(void)popOut:(UIView *)view duration:(float)duration delay:(float)delay completion:(PopCompletionBlock)completion {
    [UIView animateWithDuration:duration delay:delay
                        options:0
                     animations:^{
                         view.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                        // last animation completed
                             if (completion) {
                                 completion();
                             }
                     }];
}

+(void)move:(UIView *)view x:(float)x y:(float)y duration:(float)duration delay:(float)delay completion:(PopCompletionBlock)completion {
    [UIView animateWithDuration:duration
                          delay:delay
         usingSpringWithDamping:.5
          initialSpringVelocity:1.0
                        options:0
                     animations:^{
                         view.center = CGPointMake(view.center.x + x, view.center.y + y);
                     }
                     completion:^(BOOL finished) {
                        if (completion) {
                           
                            completion(); }
                        
                     }];

}
@end
