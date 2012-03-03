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

@class NewsGatheringViewController;


@interface NewsGatheringAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    NewsGatheringViewController *viewController;
	UINavigationController *navController;
    
    NSString *username;
    NSString *password;
    
    LoginSuccessInfo *loginSuccessInfo;
    
    NSMutableArray *levelArray;
    NSMutableArray *typeArray;
    NSString *strDeviceToken;
    NSString *payload;
    
    NSString *certificate;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet NewsGatheringViewController *viewController;

@property (nonatomic, retain) NSString *certificate;
@property (nonatomic ,retain) NSString *payload;
@property (nonatomic, retain) NSString *strDeviceToken;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSMutableArray *levelArray;
@property (nonatomic, retain) NSMutableArray *typeArray;
@property (nonatomic, retain) LoginSuccessInfo *loginSuccessInfo;



@end

