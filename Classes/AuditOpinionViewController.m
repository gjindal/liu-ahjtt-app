//
//  AuditOpinionViewController.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-3-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AuditOpinionViewController.h"

@implementation AuditOpinionViewController
@synthesize bEnableEdit;
@synthesize opinion;
@synthesize opinionTextView;


-(void) submitOpinion{
    opinion = [opinionTextView.text copy];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)back:(id)sender {  
    [self.navigationController popViewControllerAnimated:YES];  
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		// 下一个界面的返回按钮  
        UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];  
        temporaryBarButtonItem.title = @"返回";  
        temporaryBarButtonItem.target = self;  
        temporaryBarButtonItem.action = @selector(back:);  
        self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;  
        [temporaryBarButtonItem release]; 
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void) viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
	
	self.title= @"审核意见";
	self.navigationController.navigationBar.hidden=NO;
	
    if (bEnableEdit) {
        UIBarButtonItem *submitButton=[[UIBarButtonItem alloc]initWithTitle: @"提交" style:UIBarButtonItemStyleBordered target:self action:@selector(submitOpinion)];
        submitButton.style=UIBarButtonItemStylePlain;
        self.navigationItem.rightBarButtonItem=submitButton;
        [submitButton release];
        
        opinionTextView.editable = YES;
    }else{
        opinionTextView.editable = NO;
    }
    
    if (opinion == nil) {
        opinion = [[NSString alloc] initWithFormat:@""];
    }
    opinionTextView.text = opinion;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [opinionBkgd setImage:[[UIImage imageNamed:@"form_textview.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0]];
	if(opinionBkgd.image != nil)
		[self.opinionTextView setBackgroundColor:[UIColor clearColor]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
