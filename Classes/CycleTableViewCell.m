//
//  CycleTableViewCell.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-3-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CycleTableViewCell.h"

@implementation CycleTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)willTransitionToState:(UITableViewCellStateMask)state {
    
    [super willTransitionToState:state];
    
//    if ((state & UITableViewCellStateShowingDeleteConfirmationMask) == UITableViewCellStateShowingDeleteConfirmationMask) {
//        
//        for (UIView *subview in self.subviews) {
//            
//            if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationControl"]) {             
//                
//                subview.hidden = YES;
//                subview.alpha = 0.0;
//            }
//        }
//    }
}

- (void)didTransitionToState:(UITableViewCellStateMask)state {
    
    [super didTransitionToState:state];
    
//    if (state == UITableViewCellStateShowingDeleteConfirmationMask || state == UITableViewCellStateDefaultMask) {
//        for (UIView *subview in self.subviews) {
//            
//            if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationControl"]) {
//                
//                UIView *deleteButtonView = (UIView *)[subview.subviews objectAtIndex:0];
//                CGRect f = deleteButtonView.frame;
//                f.origin.x -= 20;
//                deleteButtonView.frame = f;
//                
//                subview.hidden = NO;
//                
//                [UIView beginAnimations:@"anim" context:nil];
//                subview.alpha = 1.0;
//                [UIView commitAnimations];
//            }
//        }
//    }
}


@end
