//
//  NewsClueSearchViewController.h
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewsClueSearchViewController : UIViewController {

	IBOutlet UIScrollView *scrollView;
	IBOutlet UITextField *startTime;
	IBOutlet UITextField *endTime;
	IBOutlet UITextField *newsTitle;
	IBOutlet UITextField *newsType;
	IBOutlet UITextField *newsStatus;
	IBOutlet UITextView *contents;
	IBOutlet UIButton *btConfirm;
	IBOutlet UIImageView *contentsBackground;
	
	float originalContentHeight;
}


@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UITextField *startTime;
@property(nonatomic,retain) IBOutlet UITextField *endTime;
@property(nonatomic,retain) IBOutlet UITextField *newsTitle;
@property(nonatomic,retain) IBOutlet UITextField *newsType;
@property(nonatomic,retain) IBOutlet UITextField *newsStatus;
@property(nonatomic,retain) IBOutlet UITextView *contents;
@property(nonatomic,retain) IBOutlet UIButton *btConfirm;
@property(nonatomic,retain) IBOutlet UIImageView *contentsBackground;

- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)scrollViewToCenterOfScreen:(UIView *)theView;
- (void)textViewDidBeginEditing: (UITextView *) textView;
- (void)confirm;

@end
