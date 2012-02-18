//
//  DocWriteDetailViewController.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DocWriteDetailViewController.h"
#import "AudioRecorder.h"
#import "AudioPlayer.h"
#import "StorageHelper.h"
#import "NetRequest.h"
#import "NewsGatheringAppDelegate.h"
#import "ImagePlayViewController.h"

#define kMediaType_Image @"Image"
#define kMediaType_Video @"Video"
#define kMediaType_Audio @"Audio"

@implementation DocWriteDetailViewController
@synthesize fdTitle,fdDocType,fdKeyword,fdDocSource,
			contents,btRecorder,btCamera,btVideo,
			scrollView,keyboardShown,activeField,
			attachTable,attachArray,docType;


-(IBAction) getPhoto {

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选择照片", @"拍照", nil];
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
    [actionSheet release];
}

-(IBAction) getRecord {

    AudioRecorder *alertView = [[AudioRecorder alloc] initWithTitle:@"录音" message:@"\r\r\r\r\r\r" delegate:self cancelButtonTitle:nil otherButtonTitles:@"",@"退出", nil];
    alertView.cancelButtonIndex = 1;
    alertView.delegate = self;
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"microphone 1.png"]];
    imgView.frame =CGRectMake(80.0f, 45.0f, imgView.frame.size.width, imgView.frame.size.height);
    [alertView addSubview:imgView];
    [imgView release];
    
    UIView *subView = [alertView viewWithTag:1];
    if(subView != nil) {
        
        UILabel *theTitle = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 127, 44)];
        theTitle.text = @"开始";
        theTitle.tag = 101;
        [theTitle setTextColor:[UIColor whiteColor]];
        [theTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        [theTitle setBackgroundColor:[UIColor clearColor]];             
        [theTitle setTextAlignment:UITextAlignmentCenter];
        [subView addSubview:theTitle];
    }

//    for (UIView *subView in alertView.subviews) {
//        if(subView.tag == 1)
//        {
//            [subView setBackgroundColor:[UIColor redColor]];
//            if([subView respondsToSelector:@selector(setTitle:)]) {
//                
//                [subView performSelector:@selector(setTitle:) withObject:@"xxxxx"];
//            }
//        }
//    }
    
    [alertView show];
    [alertView release];
    
}

-(IBAction) getVideo {

    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *videoCtrl = [[UIImagePickerController alloc] init];
        videoCtrl.delegate = self;
        videoCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
        videoCtrl.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        [self presentModalViewController:videoCtrl animated:YES];
        [videoCtrl release];
    }

}

-(void)submitDoc{
  
    /*
    8080/editmobile/mobile/contriM!submit_pass.do稿件内容接口地址，
     参数userid用户编号，
     pwd加密密码，
     title标题，
     type稿件类型（字典表配置），
     keyword关键字，
     source稿源，
     note内容，
     level稿件审批流程（字典表配置），
     flowid稿件与附件关联表，要求上传时候能有对应的处理。
     */
    
    NewsGatheringAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	
	//appDelegate.networkActivityIndicatorVisible = YES;
    
    
	NSString *post = [[NSString alloc] initWithFormat:@"&userid=%@&pwd=%@&title=%@&type=%@&keyword=%@&source=%@&note=%@&level=%@&flowid=%@",appDelegate.username,appDelegate.password,fdTitle.text,fdDocType.text,fdKeyword.text,fdDocSource.text,contents.text,@"2",@"1234567890123456"];
    NSString *url = [[NSString alloc] initWithFormat:@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!submit_pass.do"];
    
	NSData *returnData = [NetRequest PostData:url withRequestString:post];    

    NSString *result = [[NSString alloc] initWithData:returnData
											 encoding:NSUTF8StringEncoding];
	NSLog(@"Result = %@",result);
    // appDelegate.networkActivityIndicatorVisible = NO;
	[post release]; 
    [url release];
	return returnData;

    
}

#pragma -
#pragma UIAlertView Delegate.

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 0){ 
    
        self.attachArray = [NSArray arrayWithArray:[_storeHelper getSubFiles]];
        [self.attachTable reloadData];
    }
}

#pragma -
#pragma UIActionSheet Delegate.

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    UIImagePickerController *imgPickerCtrl = [[UIImagePickerController alloc] init];
    imgPickerCtrl.delegate = self;
    switch (buttonIndex) {
        case 0:
            
            [self presentModalViewController:imgPickerCtrl animated:YES];
            //[self.navigationController pushViewController:imgPickerCtrl animated:YES];
            [imgPickerCtrl release];
            break;
        
        case 1:
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                imgPickerCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
                imgPickerCtrl.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
                [self presentModalViewController:imgPickerCtrl animated:YES];
                [imgPickerCtrl release];
            }
            
            break;
            
        default:
            break;
    }
}

#pragma -
#pragma UIImagePickerController Delegate.

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    [picker dismissModalViewControllerAnimated:YES];
    NSMutableString *imageName = [[NSMutableString alloc] initWithCapacity:0] ;
    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [imageName appendFormat:@"Image_%@",[df stringFromDate:[NSDate date]]];
    
    [(NSMutableArray *)self.attachArray addObject:imageName];
    [imageName release];
    [self.attachTable reloadData];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
                                                                                                                                                                                                                                                                                                                     
    [picker dismissModalViewControllerAnimated:YES];
    NSMutableString *imageName = [[NSMutableString alloc] initWithCapacity:0] ;
    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if (CFStringCompare((CFStringRef) [info objectForKey:UIImagePickerControllerMediaType], kUTTypeImage, 0) == kCFCompareEqualTo) {
    
        [imageName appendFormat:@"Image_%@",[df stringFromDate:[NSDate date]]];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
                      
        //StorageHelper *helper = [[StorageHelper alloc] init];
        
        [_storeHelper createFileWithName:imageName data:UIImagePNGRepresentation(image)];
    }else if( CFStringCompare((CFStringRef) [info objectForKey:UIImagePickerControllerMediaType], kUTTypeMovie, 0) == kCFCompareEqualTo) {
        
        [imageName appendFormat:@"Video_%@.mp4",[df stringFromDate:[NSDate date]]];
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        //StorageHelper *helper = [[StorageHelper alloc] init];
        [_storeHelper createFileWithName:imageName data:[NSData dataWithContentsOfURL:videoURL]];
    }
    [self setAttachArray:[_storeHelper getSubFiles]];
    //[(NSMutableArray *)self.attachArray addObject:imageName];
    [imageName release];
    [self.attachTable reloadData];
}

-(void)recoverDoc{

}

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	self.title= @"稿件撰写";
	self.navigationController.navigationBar.hidden=NO;
	
    UIBarButtonItem *submitButton;
    if (docType == DOCTYPE_DELETED) {
        submitButton=[[UIBarButtonItem alloc]initWithTitle: @"恢复" style:UIBarButtonItemStyleBordered target:self action:@selector(recoverDoc)];
    }
    else{
        submitButton=[[UIBarButtonItem alloc]initWithTitle: @"提交" style:UIBarButtonItemStyleBordered target:self action:@selector(submitDoc)];
    }
	submitButton.style=UIBarButtonItemStylePlain;
	self.navigationItem.rightBarButtonItem=submitButton;
	[submitButton release];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//[scrollView setFrame: CGRectMake(0.0f, 0.0f, 320.0f, 460.0f)];
	[scrollView setContentSize:CGSizeMake(320, 1200)];
	scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
	
	self.fdTitle.delegate = self;
	self.fdDocType.delegate = self;
	self.fdKeyword.delegate = self;
	self.fdDocSource.delegate = self;
    contents.delegate = self;
	
	keyboardShown = NO;  
    [self performSelector:@selector(registerForKeyboardNotifications)];  
	
	[imgContentsBgd setImage:[[UIImage imageNamed:@"form_textview.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0]];
	if(imgContentsBgd.image != nil)
	[self.contents setBackgroundColor:[UIColor clearColor]];
	

    _storeHelper = [[StorageHelper alloc] init];
    self.attachArray = [NSArray arrayWithArray:[_storeHelper getSubFiles]];
	self.attachTable.delegate = self;
	self.attachTable.dataSource = self;
    
    //[self.scrollView addSubview:attachTable];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    //NSLog(@"%@", [self.attachArray count]);
    
    return [self.attachArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.textLabel.text = [self.attachArray objectAtIndex:indexPath.row];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.accessoryType =   UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    //NSLog(@"%@", indexPath.row);
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(cell != nil) {
        
        NSString *fileName = cell.textLabel.text;
        NSString *fileType = [fileName substringWithRange:NSMakeRange(0, 5)];
        
        NSData *data = [_storeHelper readFileWithName:fileName];
        if(data != nil) {
            
            if([fileType isEqualToString:kMediaType_Image]) {
            
                UIImage *image = [[UIImage alloc] initWithData:data];
                ImagePlayViewController *imagePlayCtrl = [[ImagePlayViewController alloc] init];
                //imagePlayCtrl.view.frame = CGRectMake(0.0f, 20.0f, 320.0f, 460.0f);
                imagePlayCtrl.image = image;
                //[self presentModalViewController:imagePlayCtrl animated:YES];
                [self.navigationController pushViewController:imagePlayCtrl animated:YES];
                [image release];
                [imagePlayCtrl release];
                
            }else if([fileType isEqualToString:kMediaType_Video]) {
            
                NSString *filePath = [_storeHelper.baseDirectory stringByAppendingFormat:@"/%@", fileName];
                MPMoviePlayerViewController *videoPlayCtrl = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:filePath]];
                //videoPlayCtrl.view.frame = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
                //[self.navigationController pushViewController:videoPlayCtrl animated:YES];
                [self presentMoviePlayerViewControllerAnimated:videoPlayCtrl];
                [videoPlayCtrl release];
                
            }else if([fileType isEqualToString:kMediaType_Audio]) {
            
                AudioPlayer *alertView = [[AudioPlayer alloc] initWithTitle:@"播放" message:@"\r\r\r\r\r\r" delegate:self cancelButtonTitle:nil otherButtonTitles:@"",@"退出", nil];
                alertView.cancelButtonIndex = 1;
                alertView.audioData = data;
                //alertView.delegate = self;
                
                UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"microphone 1.png"]];
                imgView.frame =CGRectMake(80.0f, 45.0f, imgView.frame.size.width, imgView.frame.size.height);
                [alertView addSubview:imgView];
                [imgView release];
                
                UIView *subView = [alertView viewWithTag:1];
                if(subView != nil) {
                    
                    UILabel *theTitle = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 127, 44)];
                    theTitle.text = @"开始";
                    theTitle.tag = 101;
                    [theTitle setTextColor:[UIColor whiteColor]];
                    [theTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
                    [theTitle setBackgroundColor:[UIColor clearColor]];             
                    [theTitle setTextAlignment:UITextAlignmentCenter];
                    [subView addSubview:theTitle];
                }
                
                [alertView show];
                [alertView release];
            }
        }
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    //    else if (editingStyle == UITableViewCellEditingStyleInsert) {
    //        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //    }   
}

#pragma mark - UITextField Delegate  
-(void)textFieldDidBeginEditing:(UITextField *)textField {  
    
    isTextView = NO;
    activeField = textField;  
}  

-(void)textFieldDidEndEditing:(UITextField *)textField {  
    activeField = nil;  
}  

-(BOOL)textFieldShouldReturn:(UITextField *)textField {  
    [textField resignFirstResponder];  
    return YES;  
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    [activeView release];
    activeView = nil;
    isTextView = YES;
    activeView = [textView retain];
    return YES;
}

// Call this method somewhere in your view controller setup code.  
- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasHidden:)
                                                 name:UIKeyboardDidHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification {
    if (keyboardShown)
        return;
    
    NSDictionary* info = [aNotification userInfo];
    
    // Get the size of the keyboard.
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    
    // Resize the scroll view (which is the root view of the window)
    CGRect viewFrame = [scrollView frame];
    viewFrame.size.height -= keyboardSize.height;
    scrollView.frame = viewFrame;
    
    // Scroll the active text field into view.
    if(isTextView) {
        
        CGRect textFieldRect = [activeView frame];
        [scrollView scrollRectToVisible:textFieldRect animated:YES];
    }else {
        CGRect textFieldRect = [activeField frame];
        [scrollView scrollRectToVisible:textFieldRect animated:YES];
    }

    keyboardShown = YES;
}

// Called when the UIKeyboardDidHideNotification is sent
- (void)keyboardWasHidden:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    
    // Get the size of the keyboard.
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    
    // Reset the height of the scroll view to its original value
    CGRect viewFrame = [scrollView frame];
    viewFrame.size.height += keyboardSize.height;
    scrollView.frame = viewFrame;
    
    keyboardShown = NO;
}

- (void)dealloc {
    
    [super dealloc];
}
@end
