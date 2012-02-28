//
//  NewsGatheringViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-5.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoginParserHelperDelegate.h"
#import "LoginParserHelper.h"

@interface NewsGatheringViewController : UIViewController<UITextFieldDelegate, LoginParserHelperDelegate> {

	UIButton *btLogin;
	UITextField *fdUsername;
	UITextField *fdUserpassword;
    LoginParserHelper *_loginParserHelper;
	
    IBOutlet UIButton *rememberOrNot;
	BOOL isRemember;
    NSMutableArray *loginData;
    NSMutableArray *saveData;
    
	
}

@property(nonatomic,retain)IBOutlet UITextField *fdUsername;
@property(nonatomic,retain)IBOutlet UITextField *fdUserpassword;
@property(nonatomic,retain)UIButton *rememberOrNot;

-(IBAction) loginSystem:(id)sender;
-(IBAction) remPressed;
-(void) saveLoginInfo;

-(NSData *) login:(NSString *)username andpassword:(NSString *)password;

@end

