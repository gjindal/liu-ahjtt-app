//
//  NewsGatheringAppDelegate.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-5.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsGatheringViewController;

@interface NewsGatheringAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    NewsGatheringViewController *viewController;
	UINavigationController *navController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet NewsGatheringViewController *viewController;



@end

