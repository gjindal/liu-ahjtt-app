//
//  NewsGatheringViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-5.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsGatheringViewController : UIViewController<UITextFieldDelegate> {

	UIButton *btLogin;
	UITextField *fdUsername;
	UITextField *fdUserpassword;
	IBOutlet UIButton *rememberOrNot;
	BOOL isRemember;
	
}

@property(nonatomic,retain)IBOutlet UITextField *fdUsername;
@property(nonatomic,retain)IBOutlet UITextField *fdUserpassword;
@property(nonatomic,retain)UIButton *rememberOrNot;

-(IBAction) loginSystem:(id)sender;
-(IBAction)remPressed;

-(NSData *) login:(NSString *)username andpassword:(NSString *)password;

@end

