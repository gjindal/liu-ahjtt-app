//
//  MainPanelViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-8.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsClueRequest.h"
#import "StorageHelper.h"


@interface MainPanelViewController : UIViewController<NewsClueRequestDelegate,UIAlertViewDelegate> {

	IBOutlet UIButton *newsClue;
	IBOutlet UIButton *newsAlloc;
	IBOutlet UIButton *docWrite;
	IBOutlet UIButton *docChange;
	IBOutlet UIButton *recycle;
    
    NewsClueRequest *newsclueRequest;
    StorageHelper *_storeHelper;
    

}

@property(nonatomic,retain)	IBOutlet UIButton *newsClue;
@property(nonatomic,retain) IBOutlet UIButton *newsAlloc;
@property(nonatomic,retain) IBOutlet UIButton *docWrite;
@property(nonatomic,retain) IBOutlet UIButton *docChange;
@property(nonatomic,retain) IBOutlet UIButton *recycle;

-(IBAction)quitMainPanel;
-(IBAction)gotoNewsClue;
-(IBAction)gotoNewsAlloc;
-(IBAction)gotoDocWrite;
-(IBAction)gotoDocChange;
-(IBAction)gotoRecycle;
-(IBAction)gotoFinishedDoc;
-(IBAction)gotoClearSystem;

- (void)back:(id)sender;



@end
