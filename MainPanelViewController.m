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
#import "DocChangeListViewController.h"
#import "RecycleListViewController.h"
#import "NewsGatheringAppDelegate.h"
#import "NetRequest.h"
#import "Contants.h"

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
    
    [self.view setBackgroundColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"panel_background320.png"]]];
	
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
	NewsAllocListViewController *viewCtrl = [[NewsAllocListViewController alloc] initWithNibName:@"NewsAllocListViewController" bundle:nil] ;

	[self.navigationController pushViewController:viewCtrl animated:YES];
	[viewCtrl release];
}


-(IBAction)gotoDocWrite{
	DocWriteListViewController *viewCtrl = [[DocWriteListViewController alloc] initWithNibName:@"DocWriteListViewController" bundle:nil] ;
	[self.navigationController pushViewController:viewCtrl animated:YES];
	[viewCtrl release];
}


-(IBAction)gotoDocChange{
	DocChangeListViewController *viewCtrl = [[DocChangeListViewController alloc] initWithNibName:@"DocChangeListViewController" bundle:nil] ;
    viewCtrl.docChangeType = DOCCHANGE_TYPE_UNFINISH;
	[self.navigationController pushViewController:viewCtrl animated:YES];
    [viewCtrl release];
}

-(IBAction)gotoFinishedDoc{
	DocChangeListViewController *viewCtrl = [[DocChangeListViewController alloc] initWithNibName:@"DocChangeListViewController" bundle:nil] ;
    viewCtrl.docChangeType = DOCCHANGE_TYPE_FINISHED;
	[self.navigationController pushViewController:viewCtrl animated:YES];
    [viewCtrl release];
}

-(IBAction)gotoRecycle{
	RecycleListViewController *viewCtrl = [[RecycleListViewController alloc] initWithNibName:@"RecycleListViewController" bundle:nil] ;
	[self.navigationController pushViewController:viewCtrl animated:YES];
    [viewCtrl release];
}

-(IBAction)gotoClearSystem{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"该操作将删除所有附件\n一旦删除将无法恢复，您确定继续？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertView show];
    [alertView release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        _storeHelper = [[StorageHelper alloc] init];
        for (NSString *fileName in [_storeHelper getSubFiles]) {
            NSLog(@"------%@",fileName);
            [_storeHelper deleteFileWithName:fileName];
        }
    }
}

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
