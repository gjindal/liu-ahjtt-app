//
//  ImagePlayViewController.m
//  NewsGathering
//
//  Created by XiguaZerg on 12-2-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImagePlayViewController.h"

@implementation ImagePlayViewController

@synthesize image = _image;
@synthesize imageName = _imageName;
@synthesize selectedImageName = _selectedImageName;
@synthesize showSelectButton;



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
        
         showSelectButton = NO;
    }
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    
    if(_image != nil) {
        
        self.view.backgroundColor = [UIColor blackColor];
        
        
        UIImageView *imageView = [self.view viewWithTag:1000001];
        if(imageView == nil)
        {
            imageView = [[UIImageView alloc] initWithImage:_image];
        imageView.frame = CGRectMake(0.0f, 0.0f, 320.0f, 460.0f);
        imageView.backgroundColor = [UIColor blackColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.tag = 1000001;
            [self.view addSubview:imageView];
            [imageView release];
        }else {
        
            imageView.image = _image;
        }
        //imageView.center = self.view.center;
        //
        
    }
    
    if(self.showSelectButton == YES) {
        
        UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];  
        temporaryBarButtonItem.title = @"选择";  
        temporaryBarButtonItem.target = self;  
        temporaryBarButtonItem.action = @selector(selectImage);  
        self.navigationItem.rightBarButtonItem = temporaryBarButtonItem;  
        [temporaryBarButtonItem release]; 
    }
}

- (void)selectImage {

    [_selectedImageName release];
    _selectedImageName = nil;
    
    if(_imageName != nil) 
        _selectedImageName = [_imageName copy];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {

    [_image release];
    _image = nil;
    
    [super dealloc];
}

@end
