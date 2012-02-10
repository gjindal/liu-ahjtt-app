//
//  MainPanelViewController.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-8.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MainPanelViewController.h"
#import "NewsGatheringViewController.h"
#import "NewsCLueListViewController.h"
#import "NewsAllocListViewController.h"
#import "DocWriteListViewController.h"

#import <QuartzCore/QuartzCore.h>

@implementation MainPanelViewController
@synthesize newsClue,newsAlloc,docWrite,docChange,recycle;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		// 下一个界面的返回按钮  
        UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];  
        temporaryBarButtonItem.title = @"返回";  
        temporaryBarButtonItem.target = self;  
        temporaryBarButtonItem.action = @selector(back:);  
        self.navigationItem.backBarButtonItem = temporaryBarButtonItem;  
        [temporaryBarButtonItem release]; 
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.title=@"移动采编系统" ;
	[self.navigationItem setHidesBackButton:TRUE animated:NO];
	self.navigationController.navigationBar.hidden=NO;
	//self.navigationController.navigationBar.tintColor=NAVGATION_BAR_COLOR;
	
	UIBarButtonItem *quitButton=[[UIBarButtonItem alloc]initWithTitle: @"退出" style:UIBarButtonItemStyleBordered target:self action:@selector(quitMainPanel)];
	quitButton.style=UIBarButtonItemStylePlain;
	//	  UIBarButtonItemStylePlain,    // shows glow when pressed
	//    UIBarButtonItemStyleBordered,
	//    UIBarButtonItemStyleDone,
	self.navigationItem.rightBarButtonItem=quitButton;
	[quitButton release];
	
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(IBAction)quitMainPanel{
	
	NewsGatheringViewController *viewCtrl = [[NewsGatheringViewController alloc] initWithNibName:@"NewsGatheringViewController" bundle:nil];
	
	CATransition *transition = [CATransition animation];
	transition.duration = 1.0f;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
	transition.type = @"cube";
	transition.subtype = kCATransitionFromLeft;
	transition.delegate = self;
	[self.navigationController.view.layer addAnimation:transition forKey:nil];
	
	[self.navigationController pushViewController:viewCtrl animated:NO];
	[viewCtrl release];
}

-(IBAction)gotoNewsClue{

	NewsCLueListViewController *viewCtrl = [[NewsCLueListViewController alloc] initWithNibName:@"NewsCLueListViewController" bundle:nil] ;

	[self.navigationController pushViewController:viewCtrl animated:YES];
	[viewCtrl release];
}
-(IBAction)gotoNewsAlloc{
	NewsAllocListViewController *viewCtrl = [[NewsAllocListViewController alloc] initWithNibName:@"NewsCLueListViewController" bundle:nil] ;

	[self.navigationController pushViewController:viewCtrl animated:YES];
	[viewCtrl release];
}
-(IBAction)gotoDocWrite{
	DocWriteListViewController *viewCtrl = [[DocWriteListViewController alloc] initWithNibName:@"NewsCLueListViewController" bundle:nil] ;
	[self.navigationController pushViewController:viewCtrl animated:YES];
	[viewCtrl release];
}
-(IBAction)gotoDocChange{}
-(IBAction)gotoRecycle{}

- (void)back:(id)sender {  
    [self.navigationController popViewControllerAnimated:YES];  
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
