//
//  DocWriteDetailViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DocWriteDetailViewController : UIViewController {

	IBOutlet UITextField *fdTitle;
	IBOutlet UITextField *fdDocType;
	IBOutlet UITextField *fdKeyword;
	IBOutlet UITextField *fdDocSource;
	IBOutlet UITextView *contents;
	
	IBOutlet UIButton *btRecorder;
	IBOutlet UIButton *btCamera;
	IBOutlet UIButton *btVideo;
}

@property (nonatomic,retain)	IBOutlet UITextField *fdTitle;
@property (nonatomic,retain)	IBOutlet UITextField *fdDocType;
@property (nonatomic,retain)	IBOutlet UITextField *fdKeyword;
@property (nonatomic,retain)	IBOutlet UITextField *fdDocSource;
@property (nonatomic,retain)	IBOutlet UITextView *contents;

@property (nonatomic,retain)	IBOutlet UIButton *btRecorder;
@property (nonatomic,retain)	IBOutlet UIButton *btCamera;
@property (nonatomic,retain)	IBOutlet UIButton *btVideo;

@end
