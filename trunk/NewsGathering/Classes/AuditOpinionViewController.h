//
//  AuditOpinionViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-3-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuditOpinionViewController : UIViewController{

    IBOutlet UITextView *opinionTextView;
    IBOutlet UIImageView *opinionBkgd;
    NSString *opinion;
    BOOL bEnableEdit;

}

@property(nonatomic,retain) IBOutlet UITextView *opinionTextView;
@property(nonatomic,retain) NSString *opinion;
@property(nonatomic) BOOL bEnableEdit;


@end
