//
//  NewsGatheringAppDelegate.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-5.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "NewsGatheringAppDelegate.h"
#import "NewsGatheringViewController.h"
#import "Contants.h"
#import "Version.h"
#import "AudioRecorder.h"

@implementation NewsGatheringAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize username,password;
@synthesize loginSuccessInfo;
@synthesize levelArray;
@synthesize typeArray;
@synthesize strDeviceToken;
@synthesize payload;
@synthesize certificate;
@synthesize deptArray;
@synthesize recorder = _recorder;
@synthesize loginId;
@synthesize ftpInfo;

/*
- (id)init 
{ 
    self = [super init]; 
    if(self != nil) 
    { 
        //self.strDeviceToken = @"e6a4bcfd dc918434 d994a317 beea57cf a08cd0f2 c88d6a74 993c1b7f f877d500";  
        self.payload = @"{\"aps\":{\"alert\":\"You got a new message!\",\"badge\":5,\"sound\":\"beep.wav\"},\"acme1\":\"bar\",\"acme2\":42}";
        self.certificate = [[NSBundle mainBundle] pathForResource:@"aps_developement" ofType:@"cer"];
    }
    return self;
}*/
#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
        
    application.applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];

    // Add the view controller's view to the window and display.
	viewController = [[NewsGatheringViewController alloc] initWithNibName:@"NewsGatheringViewController" bundle:nil];

	navController = [[UINavigationController alloc] initWithRootViewController:viewController]; 
	[window addSubview:navController.view];
	
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
    
    // 读取方法
//    NSString *tryTime = [[NSUserDefaults standardUserDefaults] stringForKey:@"TryTimes"];
//    NSString *serverURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"ServerURL"];
    //61.190.37.2
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *appDefaults = [NSDictionary
                                 dictionaryWithObjects:[NSArray arrayWithObjects:@"http://61.190.37.2:8086/editmobile/mobile/", nil] 
                                               forKeys:[NSArray arrayWithObjects:@"ServerURL", nil]];
    [defaults registerDefaults:appDefaults];
    [defaults synchronize];
    
    
    //create upgrade checker thread
	//if connection is available now,start it,otherwise do nothing
	upgradeChecker = [[UpgradeChecker alloc] init];
    [upgradeChecker start];

    return YES;
}

-(void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSString*token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    
    token = [token stringByReplacingOccurrencesOfString:@" "withString:@""];
    
    //UIAlertView *tempAlert= [[UIAlertView alloc] initWithTitle:@"" message:token delegate:nil cancelButtonTitle:@"ok" ////otherButtonTitles:nil, nil];
   // [tempAlert show];
    NSLog(@"My token is:%@",deviceToken);
    strDeviceToken = [[NSString alloc] initWithFormat:@"%@",token];
}

-(void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"Failed to get token, error:%@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    
    NSLog(@"收到推送消息 ： %@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
    if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]!=NULL) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"推送通知"
                                                        message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]
                                                       delegate:self
                                              cancelButtonTitle:@"关闭"
                                              otherButtonTitles:@"更新状态",nil];
        alert.tag = kNotificationTag;
        [alert show];
        [alert release];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
    
    if(_recorder != nil) {
    
        [_recorder pause];
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
    
    if(_recorder != nil) {
    
        [_recorder resume];
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    /*
    NSLog(@"UPGRADE ALERT VIEW==========");
    
    if (alertView.tag == kUpgrageAlertTag) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            NSURL *url = [NSURL URLWithString:[verionDict objectForKey:@"AppStore"]];
            [self openURL:url];

        }
    }else if(alertView.tag == kNotificationTag){
        
    }
*/
	[alertView release];
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
	[navController release];
    [viewController release];
    [window release];
    if(_recorder != nil) {
    
        [_recorder release];
        _recorder = nil;
    }
    [super dealloc];
}


@end
