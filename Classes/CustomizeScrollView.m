//
//  CustomizeScrollView.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-3-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomizeScrollView.h"

@implementation CustomizeScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [super touchesBegan:touches withEvent:event];
    
    [self.nextResponder touchesBegan:touches withEvent:event];
}

@end
