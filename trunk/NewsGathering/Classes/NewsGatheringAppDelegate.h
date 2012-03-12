//
//  NewsGatheringAppDelegate.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-5.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import "LoginSuccessInfo.h"
#import "UpgradeChecker.h"

#define kUpgrageAlertTag	10
#define kNotificationTag    20


@class NewsGatheringAppDelegate;
@class AudioRecorder;

@class NewsGatheringViewController;
@class UpgradeChecker;

@interface NewsGatheringAppDelegate : NSObject <UIApplicationDelegate,UIAlertViewDelegate> {
    UIWindow *window;
    NewsGatheringViewController *viewController;
	UINavigationController *navController;
    
    NSString *username;
    NSString *password;
    
    LoginSuccessInfo *loginSuccessInfo;
    NSString *loginId;
    
    NSMutableArray *deptArray;
    NSMutableArray *levelArray;
    NSMutableArray *typeArray;
    NSString *strDeviceToken;
    NSString *payload;
    
    NSString *certificate;
    
    UpgradeChecker	*upgradeChecker;
	NSDictionary	*verionDict;
    
    AudioRecorder   *_recorder;
    int alertType;
    
    FTPInfo *ftpInfo;
    
}

@property (nonatomic, retain) FTPInfo *ftpInfo;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet NewsGatheringViewController *viewController;

@property (nonatomic, retain) NSString *loginId;
@property (nonatomic, retain) NSString *certificate;
@property (nonatomic ,retain) NSString *payload;
@property (nonatomic, retain) NSString *strDeviceToken;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSMutableArray *levelArray;
@property (nonatomic, retain) NSMutableArray *typeArray;
@property (nonatomic, retain) NSMutableArray *deptArray;
@property (nonatomic, retain) LoginSuccessInfo *loginSuccessInfo;

@property (nonatomic, retain) AudioRecorder     *recorder;

- (void) checkUpgrade:(NSTimer *) timer;



@end

