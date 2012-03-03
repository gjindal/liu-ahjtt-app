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
#import "DocDetail.h"
#import "DocDetailHelper.h"
#import "UIAlertTableView.h"
#import "ContributeInfo.h"
#import "TreeViewController.h"
#import "CustomAlertView.h"

#define kAudioRecord    1024
#define kAudioPlay      1025

@implementation DocWriteDetailViewController
@synthesize fdTitle;
@synthesize fdKeyword;
@synthesize fdDocSource;
@synthesize contents;
@synthesize btRecorder;
@synthesize btCamera;
@synthesize btVideo;
@synthesize scrollView;
@synthesize keyboardShown;
@synthesize activeField;
@synthesize attachTable;
@synthesize attachArray;
@synthesize docType;
@synthesize transformType;
@synthesize request;
@synthesize btType;
@synthesize btLevel;
@synthesize btReceptor;
@synthesize menuType;
@synthesize levelArray;
@synthesize typeArray;
@synthesize alert;
@synthesize imgContentsBgd;
@synthesize dispatchedUsersID;
@synthesize dispatchedUsersName;
@synthesize docDetail = _docDetail;

@synthesize storeHelper = _storeHelper;


- (void)alertInfo:(NSString *)info withTitle:(NSString *)title{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:info
                                                       delegate:nil 
                                              cancelButtonTitle:@"关闭" 
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

-(IBAction) getPhoto {

    menuType = MENUTYPE_MEDIALIB;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选择照片", @"拍照", nil];
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
    [actionSheet release];
}

-(IBAction) getRecord {

    AudioRecorder *alertView = [[AudioRecorder alloc] initWithTitle:@"录音" message:@"\r\r\r\r\r\r\r\r" delegate:self cancelButtonTitle:nil otherButtonTitles:@"",@"退出", nil];
    alertView.tag = kAudioRecord;
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

-(void)saveDoc{
    
    if(_docDetail == nil) {
    
        _docDetail = [[DocDetail alloc] init];
    }
    
    //上传前验证必填项
    if( [fdTitle.text length]<1){
        [self alertInfo:@"标题不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    if( [fdKeyword.text length]<1){
        [self alertInfo:@"关键字不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    if( [contents.text length]<1){
        [self alertInfo:@"内容不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    if( [fdDocSource.text length]<1){
        [self alertInfo:@"稿源不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    if( [btType.titleLabel.text length]<1){
        [self alertInfo:@"类型不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    if([btLevel.titleLabel.text length]<1){
        [self alertInfo:@"审核级别不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    NSLog(@"%@===================%@",workflowInfo.opttype,btReceptor.titleLabel.text);
    if([btReceptor.titleLabel.text length]<1){
        [self alertInfo:@"接收人不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    
    _docDetail.title    = fdTitle.text;
    _docDetail.docType  = btType.titleLabel.text;
    _docDetail.key      = fdKeyword.text;
    _docDetail.source   = fdDocSource.text;
    _docDetail.level    = btLevel.titleLabel.text;
    _docDetail.recevicer= btReceptor.titleLabel.text;
    _docDetail.content  = contents.text;
    _docDetail.attachments = self.attachArray;
    
    DocDetailHelper *_docDetailHelper = [[DocDetailHelper alloc] init];
    BOOL result = NO;
    
    if(transformType == TYPE_ADD) {
    
       result = [_docDetailHelper writeToFile:_docDetail];
    }else if(transformType == TYPE_MODIFY) {
    
        result = [_docDetailHelper updateDoc:_docDetail];
    }
    
    [alert hideWaiting];
    
    [_docDetailHelper release];
    _docDetailHelper = nil;
    
    if(result == NO) {
    
        [self alertInfo:@"保存稿件失败!" withTitle:@"稿件保存"];
    }
}

-(void)submitForAudit{
    
    //上传前验证必填项
    if( [fdTitle.text length]<1){
        [self alertInfo:@"标题不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    if( [fdKeyword.text length]<1){
        [self alertInfo:@"关键字不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    if( [contents.text length]<1){
        [self alertInfo:@"内容不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    if( [fdDocSource.text length]<1){
        [self alertInfo:@"稿源不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    if( [btType.titleLabel.text length]<1){
        [self alertInfo:@"类型不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    if( (workflowInfo.opttype == nil)||[btLevel.titleLabel.text length]<1){
        [self alertInfo:@"审核级别不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    NSLog(@"%@===================%@",workflowInfo.opttype,btReceptor.titleLabel.text);
    if( [workflowInfo.opttype isEqualToString:@"1"]&&[btReceptor.titleLabel.text length]<1){
        [self alertInfo:@"接收人不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }

    NewsGatheringAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	
    NSString *url = [[NSString alloc] initWithFormat:@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!uploadFile.do?usercode=%@&password=%@&flowid=%@",appDelegate.username,appDelegate.password,contributeInfo.flowID];
    
    [request cancel];
    [request setRequestMethod:@"post"];    
	[self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]]];
    
	[request setTimeOutSeconds:20];
    
    [request setDelegate:self];
	[request setDidFailSelector:@selector(respnoseFailed:)];
	[request setDidFinishSelector:@selector(responseComplete:)];
    
    for (NSString *filePath in attachArray) {
        NSString *tmp = [NSString stringWithFormat:@"%@/%@",self.storeHelper.baseDirectory,filePath];
		[request setFile:tmp forKey:[NSString stringWithFormat:@"file",filePath]];
        break;
	}
	
	[request startAsynchronous];

}

-(void)shareToWB{
    
    [alert hideWaiting];

}

- (void)addDocDidFinished:(ContributeInfo *)contributeInfo1{
    if ([contributeInfo1.flag isEqualToString:@"200"]) {
        [self alertInfo:@"稿件上传成功" withTitle:nil];
    }
    else
    {
        [self alertInfo:@"稿件上传失败" withTitle:@"错误"];
    }
    
    [alert hideWaiting];
}

- (void)addDocForApproveDidFinished:(ContributeInfo *)contributeInfo1{
    if ([contributeInfo1.flag isEqualToString:@"200"]) {
        [self alertInfo:@"稿件上传成功" withTitle:nil];
        
        if(_docDetail != nil && transformType == TYPE_MODIFY) {
            
            DocDetailHelper *docDetailHelper = [[DocDetailHelper alloc] init];
            _docDetail.status = DOC_STATUS_SUMMITED;
            [docDetailHelper updateDoc:_docDetail];
            [docDetailHelper release];
        }
    }
    else
    {
        [self alertInfo:@"稿件上传失败" withTitle:@"错误"];
    }
   [alert hideWaiting];   
}

- (void)submitDocDidFinished:(ContributeInfo *)contributeInfo1{
    if ([contributeInfo1.flag isEqualToString:@"200"]) {
        [self alertInfo:@"稿件上传成功" withTitle:nil];
        
        if(_docDetail != nil && transformType == TYPE_MODIFY) {
            
            DocDetailHelper *docDetailHelper = [[DocDetailHelper alloc] init];
            _docDetail.status = DOC_STATUS_SUMMITED;
            [docDetailHelper updateDoc:_docDetail];
            [docDetailHelper release];
        }
    }
    else
    {
        [self alertInfo:@"稿件上传失败" withTitle:@"错误"];
    }
    [alert hideWaiting];
}

-( void )responseComplete:(ASIHTTPRequest *)theRequest{
    // 请求响应结束，返回 responseString
    NSString *responseString = [ request responseString ];
    
    NSLog(@"###########%@",responseString);
    
    //如果附件发送成功，则发送内容
    
    NSString *strLevel = [NSString stringWithFormat:@"%d",[levelArray indexOfObject:btLevel.titleLabel.text]+1];
    NSString *strType = [NSString stringWithFormat:@"%d",[typeArray indexOfObject:btType.titleLabel.text]+1];
    if ([workflowInfo.opttype isEqualToString:@"1"]) {
        
        [docRequest addDocForApproveWithTitle:fdTitle.text Keyword:fdKeyword.text Note:contents.text Source:fdDocSource.text Type:strType Level:strLevel FlowID:contributeInfo.flowID Receptuserid:dispatchedUsersID Status:workflowInfo.endStatus];
    }if ([workflowInfo.opttype isEqualToString:@"2"]) {
        [docRequest addDocWithTitle:fdTitle.text Keyword:fdKeyword.text Note:contents.text Source:fdDocSource.text Type:strType Level:strLevel FlowID:contributeInfo.flowID Status:workflowInfo.endStatus];
    }
    
}

-( void )respnoseFailed:(ASIHTTPRequest *)theRequest{
    // 请求响应失败，返回错误信息
    NSError *error = [ request error ];
    NSLog(@"#############%@",error);
    [self saveDoc];
    [alert alertInfo:@"提交失败，文稿被保存在本地." withTitle:@"错误"]; 
   
}

-(void)submitDoc{
    
    menuType = MENUTYPE_SUBMIT;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"提交目的" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存到本地",@"提交审核",nil];
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
    [actionSheet release];
}

#pragma -
#pragma UIAlertView Delegate.

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 0 && alertView.tag == kAudioRecord){ 
        [attachArray addObject:((AudioRecorder *)alertView).fileName];
//        self.attachArray = [NSArray arrayWithArray:[_storeHelper getSubFiles]];
        [self.attachTable reloadData];
    }
}

#pragma -
#pragma UIActionSheet Delegate.

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    UIImagePickerController *imgPickerCtrl = [[UIImagePickerController alloc] init];
    imgPickerCtrl.delegate = self;
    if (menuType == MENUTYPE_MEDIALIB) {
        
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
    if (menuType == MENUTYPE_SUBMIT) {
        [alert showWaitingWithTitle:@"提交中" andMessage:@"请等待....."];
        switch (buttonIndex) {
            case 0:
                [self saveDoc];
                break;
            case 1:
                [self submitForAudit];
                break;
            default:
                [alert hideWaiting];
                break;
        }
    }
}

-(IBAction)setLevel:(id)sender{
    
    alertType = ALERTTABLE_LEVEL;
    tmpCellString = [[NSString alloc] initWithString:@""];
    
    UIAlertTableView *alertTable = [[UIAlertTableView alloc] initWithTitle:@"选择审核级别"
															  message:nil
															 delegate:self
													cancelButtonTitle:@"取消"
													otherButtonTitles:@"完成", nil];
	alertTable.tableDelegate = self;
	alertTable.dataSource = self;
	alertTable.tableHeight = 120;
	[alertTable show];
	[alertTable release];
    
}

-(IBAction)setType:(id)sender{
    
    alertType = ALERTTABLE_DOCTYPE;
    
    tmpCellString = [[NSString alloc] initWithString:@""];
    
    UIAlertTableView *alertTable = [[UIAlertTableView alloc] initWithTitle:@"选择线索类型"
															  message:nil
															 delegate:self
													cancelButtonTitle:@"取消"
													otherButtonTitles:@"完成", nil];
	alertTable.tableDelegate = self;
	alertTable.dataSource = self;
	alertTable.tableHeight = 120;
	[alertTable show];
	[alertTable release];
    
}

-(IBAction)setReceptor:(id)sender{

    TreeViewController *treeViewCtrl = [[TreeViewController alloc] init];
    treeViewCtrl.delegate = self;
    [self.navigationController pushViewController:treeViewCtrl animated:YES];
    [treeViewCtrl release];

}

//通过代理方法获取组织结构中的选择的人员
- (void)passValue:(NSMutableArray *)value
{
    NSMutableArray *dispathedPersonInfo = value;
    int i = 0;
    for(UserInfo *userInfo in dispathedPersonInfo){
        if(i == 0){
            self.dispatchedUsersID = userInfo.userID;
            self.dispatchedUsersName = userInfo.userName;
        }else{
            self.dispatchedUsersName = [NSString stringWithFormat:@"%@,%@",self.dispatchedUsersName,userInfo.userName];
            self.dispatchedUsersID = [NSString stringWithFormat:@"%@,%@",self.dispatchedUsersID,userInfo.userID];
        }
        i++;
    }
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (alertType == ALERTTABLE_DOCTYPE) {
        return [typeArray count];
    }
    if (alertType == ALERTTABLE_LEVEL) {
        return [levelArray count]; 
    }else
    {
        return [self.attachArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if (alertType == ALERTTABLE_DOCTYPE) {
        cell.textLabel.text = [typeArray objectAtIndex:indexPath.row];
        NSUInteger row = [indexPath row];
        NSUInteger oldRow = [lastTypeIndexPath row];
        cell.textLabel.text = [typeArray objectAtIndex:row];
        cell.accessoryType = (row == oldRow && lastTypeIndexPath != nil) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
    else if (alertType == ALERTTABLE_LEVEL) {
        cell.textLabel.text = [levelArray objectAtIndex:indexPath.row];
        NSUInteger row = [indexPath row];
        NSUInteger oldRow = [lastLevelIndexPath row];
        cell.textLabel.text = [levelArray objectAtIndex:row];
        cell.accessoryType = (row == oldRow && lastLevelIndexPath != nil) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }else{
        cell.textLabel.text = [self.attachArray objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType =   UITableViewCellAccessoryDisclosureIndicator;
    
    }
    return cell;
}

- (void)getWorkflowDidFinished:(NSArray *)workflowArray{
    workflowInfo = [[workflowArray objectAtIndex:0] retain];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(alertView.tag == kAudioPlay || alertView.tag == kAudioRecord)
        return;
    
    if (buttonIndex == 1) {
        if (alertType == ALERTTABLE_DOCTYPE) {
            btType.titleLabel.text =  tmpCellString;         
        }else{
            btLevel.titleLabel.text = tmpCellString;
            docRequest.delegate = self;
           
            int l = [levelArray indexOfObject:tmpCellString]+1;
             NSLog(@"=====%d",l);
            [docRequest getWorkflowWithLevel:[NSString stringWithFormat:@"%d",l]];
        }
    }
    alertType = ALERTTABLE_OTHERS;
	printf("User Pressed Button %d\n",buttonIndex+1);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
	//NSInteger row=[indexPath row];
	
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	//NSLog(@"----hello----,%@",indexPath);
	return indexPath;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int newRow = [indexPath row];
	int oldRow = 0;
    if (alertType == ALERTTABLE_DOCTYPE) {
        oldRow = [lastTypeIndexPath row];
        if ((newRow == 0 && oldRow == 0) || (newRow != oldRow)){
            
            UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
            newCell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            UITableViewCell *oldCell = [tableView cellForRowAtIndexPath: lastTypeIndexPath]; 
            oldCell.accessoryType = UITableViewCellAccessoryNone;
            lastTypeIndexPath = [indexPath retain];	
            
            tmpCellString = newCell.textLabel.text;
        }
        
    }
    else if (alertType == ALERTTABLE_LEVEL)
    {
        oldRow = [lastLevelIndexPath row];
        if ((newRow == 0 && oldRow == 0) || (newRow != oldRow)){
            
            UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
            newCell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            UITableViewCell *oldCell = [tableView cellForRowAtIndexPath: lastLevelIndexPath]; 
            oldCell.accessoryType = UITableViewCellAccessoryNone;
            lastLevelIndexPath = [indexPath retain];	

            tmpCellString = newCell.textLabel.text;//[levelArray objectAtIndex:[indexPath row]];
            //newCell.textLabel.text;
        }
    
    }else{
    
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
                    
                    AudioPlayer *alertView = [[AudioPlayer alloc] initWithTitle:@"播放" message:@"\r\r\r\r\r\r\r\r" delegate:self cancelButtonTitle:nil otherButtonTitles:@"",@"退出", nil];
                    alertView.tag = kAudioPlay;
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
}

#pragma -
#pragma UIImagePickerController Delegate.

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    [picker dismissModalViewControllerAnimated:YES];
    NSMutableString *imageName = [[NSMutableString alloc] initWithCapacity:0] ;
    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [imageName appendFormat:@"Image_%@.jpeg",[df stringFromDate:[NSDate date]]];
    
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
        
        [imageName appendFormat:@"Image_%@.jpeg",[df stringFromDate:[NSDate date]]];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
                      
        //StorageHelper *helper = [[StorageHelper alloc] init];
        
//        [_storeHelper createFileWithName:imageName data:UIImagePNGRepresentation(image)];
        [_storeHelper createFileWithName:imageName data:UIImageJPEGRepresentation(image, 1.0)];
    }else if( CFStringCompare((CFStringRef) [info objectForKey:UIImagePickerControllerMediaType], kUTTypeMovie, 0) == kCFCompareEqualTo) {
        
        [imageName appendFormat:@"Video_%@.mp4",[df stringFromDate:[NSDate date]]];
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        //StorageHelper *helper = [[StorageHelper alloc] init];
        [_storeHelper createFileWithName:imageName data:[NSData dataWithContentsOfURL:videoURL]];
    }
    
    [self.attachArray  addObject:imageName];
    NSLog(@"%@", self.attachArray);
    [imageName release];
    imageName = nil;
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
    
    //取新闻类型
    NewsGatheringAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //array =[[NSMutableArray alloc] init];
    levelArray = appDelegate.levelArray;
    typeArray = appDelegate.typeArray;
    alertType = ALERTTABLE_OTHERS;
    
    if (docRequest == nil) {
        docRequest = [[DocRequest alloc] init];
    }
    docRequest.delegate = self;
    workflowInfo = [[WorkflowInfo alloc] init];

    
    [btType setTitle:[typeArray objectAtIndex:0] forState:UIControlStateNormal];
    [btLevel setTitle:[levelArray objectAtIndex:0] forState:UIControlStateNormal];
    [btReceptor setTitle:dispatchedUsersName forState:UIControlStateNormal];
    
    if(_docDetail != nil && transformType == TYPE_MODIFY) {
        
        fdTitle.text    = _docDetail.title;
        [btType setTitle:_docDetail.docType forState:UIControlStateNormal];
        fdKeyword.text      = _docDetail.key;
        fdDocSource.text   = _docDetail.source;
        [btLevel setTitle:_docDetail.level forState:UIControlStateNormal];
        [btReceptor setTitle:_docDetail.recevicer forState:UIControlStateNormal];
        contents.text  = _docDetail.content;
        
        if([attachArray count] > 0)
            [attachArray removeAllObjects];
        [attachArray addObjectsFromArray:_docDetail.attachments];
        [self.attachTable reloadData];
    }
    
    //初始时要获取流程
    docRequest.delegate = self;
    [docRequest getWorkflowWithLevel:[NSString stringWithFormat:@"%d",1]];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//[scrollView setFrame: CGRectMake(0.0f, 0.0f, 320.0f, 460.0f)];
	[scrollView setContentSize:CGSizeMake(320, 1200)];
	scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
	
	self.fdTitle.delegate = self;
	self.fdKeyword.delegate = self;
	self.fdDocSource.delegate = self;
    contents.delegate = self;
	
	keyboardShown = NO;  
    [self performSelector:@selector(registerForKeyboardNotifications)];  
	
	[imgContentsBgd setImage:[[UIImage imageNamed:@"form_textview.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0]];
	if(imgContentsBgd.image != nil)
	[self.contents setBackgroundColor:[UIColor clearColor]];
	

    _storeHelper = [[StorageHelper alloc] init];
    attachArray = [[NSMutableArray alloc] initWithCapacity:0];
    
	self.attachTable.delegate = self;
	self.attachTable.dataSource = self;
    
    alert = [[CustomAlertView alloc] init];
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    if (alertType == ALERTTABLE_LEVEL || alertType == ALERTTABLE_LEVEL) {
        return NO;
    }
    else{
        return YES;
    }
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (alertType == ALERTTABLE_LEVEL || alertType == ALERTTABLE_LEVEL) {
        return;
    }
    [self.attachTable beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        NSString *fileName = [attachArray objectAtIndex:indexPath.row];
        [_storeHelper deleteFileWithName:fileName];
        [attachArray removeObjectAtIndex:indexPath.row];
        if(transformType == TYPE_MODIFY && _docDetail != nil) {
        
            [_docDetail.attachments removeObjectAtIndex:indexPath.row];
            DocDetailHelper *_docDetailHelper = [[DocDetailHelper alloc] init];
            [_docDetailHelper updateDoc:_docDetail];
        }
    }
    [self.attachTable endUpdates];
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
    
    [alert release];
    [super dealloc];
}
@end
