//
//  keypad.m
//  Math Cows
//
//  Created by Jeff Williams on 11/9/15.
//  Copyright (c) 2015 Jeff Williams. All rights reserved.
//

#import "Keypad.h"

@implementation Keypad



-(IBAction)buttonDown:(id)sender {
    
    self.value = (int)[sender tag];
    [self.delegate keyDown:sender];
    
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])){

         [[[NSBundle mainBundle] loadNibNamed:@"Keypad"
                                        owner:self
                                      options:nil] objectAtIndex:0];
        [self addSubview:self.view];
      
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
