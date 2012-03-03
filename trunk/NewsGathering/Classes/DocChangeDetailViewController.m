//
//  DocChangeDetailViewController.m
//  NewsGathering
//
//  Created by 刘 学雁 on 12-2-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DocChangeDetailViewController.h"
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


@implementation DocChangeDetailViewController

@synthesize keyboardShown;
@synthesize activeField;
@synthesize attachArray;

@synthesize scrollView;
@synthesize imgContentsBgd;
@synthesize imgMessageBgd;

@synthesize fdTitle;
@synthesize fdKeyword;
@synthesize fdSource;
@synthesize btType;
@synthesize btLevel;
@synthesize contents;
@synthesize attachTable;
@synthesize btRecorder;
@synthesize btCamera;
@synthesize btVideo;
@synthesize lblMessage;
@synthesize txtMessage;

@synthesize contributeInfo;
@synthesize docRequest;
@synthesize dispatchedArray;
@synthesize dispatchedUsersID;
@synthesize dispatchedUsersName;
@synthesize typeArray;
@synthesize levelArray;
@synthesize lastTypeIndexPath;
@synthesize lastLevelIndexPath;
@synthesize request;


//////////

#pragma mark - 
#pragma mark Submit Action
-(void) saveDoc{
    
    //上传前验证必填项
    if( [fdTitle.text length]<1){
        [alert alertInfo:@"标题不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    if( [fdKeyword.text length]<1){
        [alert alertInfo:@"关键字不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    if( [contents.text length]<1){
        [alert alertInfo:@"内容不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    if( [fdSource.text length]<1){
        [alert alertInfo:@"稿源不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    if( [btType.titleLabel.text length]<1){
        [alert alertInfo:@"类型不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    if( (workflowInfo.opttype == nil)||[btLevel.titleLabel.text length]<1){
        [alert alertInfo:@"审核级别不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    NSLog(@"%@===================%@",workflowInfo.opttype,btReceptor.titleLabel.text);
    if( [workflowInfo.opttype isEqualToString:@"1"]&&[btReceptor.titleLabel.text length]<1){
        [alert alertInfo:@"接收人不能为空" withTitle:@"错误"];
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
    
    StorageHelper *helper = [[StorageHelper alloc] init];
    for (NSString *filePath in attachArray) {
        NSString *tmp = [NSString stringWithFormat:@"%@/%@",helper.baseDirectory,filePath];
		[request setFile:tmp forKey:[NSString stringWithFormat:@"file",filePath]];
        break;
	}
	[helper release];
	[request startAsynchronous];

    [alert hideWaiting];
}

-(void) sendWeiboDidFinished:(ContributeInfo *)contributeInfo1{

    if ([contributeInfo1.flag isEqualToString:@"200"]) {
        [alert alertInfo:@"分享成功" withTitle:nil];
    }else{
        [alert alertInfo:@"分享失败" withTitle:nil];
    }
}

-(void) shareToWB{
    [docRequest sendWeiboWithType:contributeInfo.type Note:contributeInfo.note FilePath:@""];
}

-(void) approveDidFinished:(ContributeInfo *)contributeInfo1{
    [alert hideWaiting];
    if ([contributeInfo1.flag isEqualToString:@"200"]) {
        [alert alertInfo:@"审核成功" withTitle:nil];
    }else{
        [alert alertInfo:@"审核失败" withTitle:nil];
    }
}

-(void) passAudit{
  	[docRequest approveWithConid:contributeInfo.conid Attitude:txtMessage.text Status:workflowInfo.endStatus];
}
-(void) goBack{
    [docRequest approveWithConid:contributeInfo.conid Attitude:txtMessage.text Status:workflowInfo.endStatus];
}

-(void)submitDoc{
    
    menuType = MENUTYPE_SUBMIT;
    if (enableAudit) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"提交目的" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"通过",@"打回",nil];
        actionSheet.delegate = self;
        [actionSheet showInView:self.view];
        [actionSheet release];
    }else if(enableShare){
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"提交目的" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享到微博",nil];
        actionSheet.delegate = self;
        [actionSheet showInView:self.view];
        [actionSheet release];
    }else if(enableEdit){
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"提交目的" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存修改",nil];
        actionSheet.delegate = self;
        [actionSheet showInView:self.view];
        [actionSheet release];
    }
}


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
                if (enableEdit) {
                    [self saveDoc];
                }else if([contributeInfo.status isEqualToString:@"99"]){
                    [self shareToWB];
                }else{
                    [self passAudit];
                }
                break;
            case 2:
                [self goBack];
                break;
            case 3:
                //[alert hideWaiting];
                break;
            default:
                break;
        }
    }
}



#pragma mark - 
#pragma mark Click media Action
-(IBAction) getPhoto {
    
    menuType = MENUTYPE_MEDIALIB;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选择照片", @"拍照", nil];
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
    [actionSheet release];
}

-(IBAction) getRecord {
    
    AudioRecorder *alertView = [[AudioRecorder alloc] initWithTitle:@"录音" message:@"\r\r\r\r\r\r\r\r" delegate:self cancelButtonTitle:nil otherButtonTitles:@"",@"退出", nil];
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


- (void)back:(id)sender {  
    [self.navigationController popViewControllerAnimated:YES];  
}

-(void)initForm{
    
    NSString *strType = [typeArray objectAtIndex:[contributeInfo.type intValue]];
    NSString *strLevel = [levelArray objectAtIndex:[contributeInfo.level intValue]];
    [btLevel setTitle:strLevel forState:UIControlStateNormal];
    [btType setTitle:strType forState:UIControlStateNormal];
    fdTitle.text = contributeInfo.title;
    contents.text = contributeInfo.note;
    txtMessage.text = [contributeInfo.attitudeList objectAtIndex:0];
    fdSource.text = contributeInfo.source;
    fdKeyword.text = contributeInfo.keyword;
   // btReceptor setTitle:contributeInfo. forState:<#(UIControlState)#>
    
    if (enableEdit) {
        btType.enabled = YES;
        btLevel.enabled = YES;
        fdSource.enabled = YES;
        contents.editable = YES;
        fdTitle.enabled = YES;
        fdKeyword.enabled = YES;
        btRecorder.enabled = YES;
        btVideo.enabled = YES;
        btCamera.enabled = YES;
        txtMessage.hidden = NO;
        txtMessage.editable = NO;
    }else{
        btType.enabled = NO;
        btLevel.enabled = NO;
        fdSource.enabled = NO;
        contents.editable = NO;
        fdTitle.enabled = NO;
        fdKeyword.enabled = NO;
        
        btRecorder.enabled = NO;
        btVideo.enabled = NO;
        btCamera.enabled = NO;
        if ([contributeInfo.status isEqualToString:@"4"]) {
            txtMessage.hidden = NO;
            txtMessage.editable = YES;
        }else{
            txtMessage.hidden = YES;
            txtMessage.editable = NO;
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
        cell.textLabel.text = ((AttLsInfo *)[self.attachArray objectAtIndex:indexPath.row]).fileName;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType =   UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)getWorkflowDidFinished:(NSArray *)workflowArray{
    workflowInfo = [[workflowArray objectAtIndex:0] retain];
}

- (void)getAppWorkflowDidFinished:(NSArray *)workflowArray{
    workflowInfoArray = [[NSArray alloc] initWithArray:workflowArray];
    for (WorkflowInfo *flowInfo in workflowInfoArray) {
        if ([flowInfo.endStatus isEqualToString:@"3"]) {
            enableEdit = YES;
        }
        if ([flowInfo.endStatus isEqualToString:@"4"]) {
            enableAudit = YES;
        }
        if ([flowInfo.endStatus isEqualToString:@"5"]) {
            enableShare = YES;
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if (alertType == ALERTTABLE_DOCTYPE) {
            btType.titleLabel.text =  tmpCellString;         
        }else{
            btLevel.titleLabel.text = tmpCellString;
            docRequest.delegate = self;
            
            int l = [levelArray indexOfObject:tmpCellString]+1;
            NSLog(@"=====%d",l);
            [docRequest getAppWorkflowWithLevel:[NSString stringWithFormat:@"%d",l] Status:contributeInfo.status];
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
            
            attachIndex = indexPath.row;
            fileName = [cell.textLabel.text copy];
            //如果这个file有有效的id，说明是网络上的文件，需要下载才能看到，否则直截打开
            NSString *attachID = ((AttLsInfo *)[attachArray objectAtIndex:attachIndex]).attLsID;
            if(![attachID isEqualToString:kAttachID_Invalide]){
                [alert showWaitingWithTitle:@"文件加载中" andMessage:@"请等待..."];
                [docRequest beginDownloadWithID:attachID andFileName:fileName];
            }else{
                [self showMediaWithFile:fileName];                
            }
        }
        
    }
    
}

-(void) showMediaWithFile:(NSString *) fileName1{

    NSString *fileType = [fileName substringWithRange:NSMakeRange(0, 5)];
    NSData *data = [_storeHelper readFileWithName:fileName1];
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
            
            NSString *filePath = [_storeHelper.baseDirectory stringByAppendingFormat:@"/%@", fileName1];
            MPMoviePlayerViewController *videoPlayCtrl = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:filePath]];
            //videoPlayCtrl.view.frame = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
            //[self.navigationController pushViewController:videoPlayCtrl animated:YES];
            [self presentMoviePlayerViewControllerAnimated:videoPlayCtrl];
            [videoPlayCtrl release];
            
        }else if([fileType isEqualToString:kMediaType_Audio]) {
            
            AudioPlayer *alertView = [[AudioPlayer alloc] initWithTitle:@"播放" message:@"\r\r\r\r\r\r\r\r" delegate:self cancelButtonTitle:nil otherButtonTitles:@"",@"退出", nil];
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

-(void)getEditListDidFinished:(NSArray *)workflowArray{
    
    for(WorkflowInfo *flowInfo in workflowArray){
        if ([contributeInfo.level isEqualToString:flowInfo.begStatus]) {
            enableEdit = YES;
        }
        else{
            enableEdit = NO;
        }
    }
}

-(void) downloadDidFinished:(BOOL)isSuccess{

    if (isSuccess) {
        [alert hideWaiting];
        //[alert alertInfo:@"下载成功" withTitle:nil];
        
        [self showMediaWithFile:fileName]; 
    }else{
        [alert hideWaiting];
        [alert alertInfo:@"下载失败" withTitle:@"错误"];
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
    
    AttLsInfo *attlsInfo = [[AttLsInfo alloc] init];
    attlsInfo.fileName = imageName;
    attlsInfo.attLsID = kAttachID_Invalide;
    [(NSMutableArray *)self.attachArray addObject:attlsInfo];
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
    //    [self setAttachArray:[_storeHelper getSubFiles]];
    //[(NSMutableArray *)self.attachArray addObject:imageName];
    [imageName release];
    imageName = nil;
    [self.attachTable reloadData];
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
	
	self.title= @"稿件管理";
	self.navigationController.navigationBar.hidden=NO;
	
    if (![contributeInfo.status isEqualToString:@"3"]){
        
        UIBarButtonItem *passButton=[[UIBarButtonItem alloc]initWithTitle: @"提交" style:UIBarButtonItemStyleBordered target:self action:@selector(submitDoc)];
        passButton.style=UIBarButtonItemStylePlain;
        self.navigationItem.rightBarButtonItem=passButton;
        [passButton release];
    }
    
    alertType = ALERTTABLE_OTHERS;
    [self initForm];
	
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	[scrollView setContentSize:CGSizeMake(320, 1200)];
	scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
	
	self.fdTitle.delegate = self;
	self.fdKeyword.delegate = self;
	self.fdSource.delegate = self;
    self.contents.delegate = self;
    self.txtMessage.delegate = self;
	
	keyboardShown = NO;  
    [self performSelector:@selector(registerForKeyboardNotifications)];  
	
	[imgContentsBgd setImage:[[UIImage imageNamed:@"form_textview.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0]];
	if(imgContentsBgd.image != nil)
		[self.contents setBackgroundColor:[UIColor clearColor]];
	
	[imgMessageBgd setImage:[[UIImage imageNamed:@"form_textview.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0]];
	if(imgMessageBgd.image != nil)
		[self.txtMessage setBackgroundColor:[UIColor clearColor]];
	
	self.attachArray = [[NSMutableArray alloc] initWithArray:contributeInfo.attLsList];
    
    NewsGatheringAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.levelArray = appDelegate.levelArray;
    self.typeArray = appDelegate.typeArray;
	
	self.attachTable.delegate = self;
	self.attachTable.dataSource = self;
    
    alert = [[CustomAlertView alloc] init];
    docRequest = [[DocRequest alloc] init];
    docRequest.delegate = self;
    _storeHelper = [[StorageHelper alloc] init];
    
    //查询是否可修改
    enableEdit = YES;
    [docRequest getEditListWithLevel:contributeInfo.level];
    
    //获取下一步操作状态
    int l = [levelArray indexOfObject:contributeInfo.level];
    [docRequest getAppWorkflowWithLevel:[NSString stringWithFormat:@"%d",l] Status:contributeInfo.status];
}


#pragma mark - UITextField Delegate  
-(void)textFieldDidBeginEditing:(UITextField *)textField  
{  
    activeField = textField;  
}  

-(void)textFieldDidEndEditing:(UITextField *)textField  
{  
    activeField = nil;  
}  

-(BOOL)textFieldShouldReturn:(UITextField *)textField  
{  
    [textField resignFirstResponder];  
    return YES;  
}  

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scroll detected");
}

// 触摸屏幕并拖拽画面，再松开，最后停止时，触发该函数
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"scrollViewDidEndDragging  -  End of Scrolling.");
}

// 滚动停止时，触发该函数

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating  -   End of Scrolling.");
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndScrollingAnimation  -   End of Scrolling.");
}

// Call this method somewhere in your view controller setup code.  
- (void)registerForKeyboardNotifications  
{  
    [[NSNotificationCenter defaultCenter] addObserver:self  
                                             selector:@selector(keyboardWasShown:)  
                                                 name:UIKeyboardDidShowNotification object:nil];  
	
    [[NSNotificationCenter defaultCenter] addObserver:self  
                                             selector:@selector(keyboardWasHidden:)  
                                                 name:UIKeyboardDidHideNotification object:nil];  
}  
// Called when the UIKeyboardDidShowNotification is sent.  
- (void)keyboardWasShown:(NSNotification*)aNotification  
{  
    NSLog(@"-------");  
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
    CGRect textFieldRect = [activeField frame];  
    [scrollView scrollRectToVisible:textFieldRect animated:YES];  
	
    oldContentOffsetValue = [scrollView contentOffset].y;  
	
	
    CGFloat value = (activeField.frame.origin.y+scrollView.frame.origin.y+activeField.frame.size.height - self.view.frame.size.height + keyboardSize.height)+2.0f;  
    if (value > 0) {  
        [scrollView setContentOffset:CGPointMake(0, value) animated:YES];  
        isNeedSetOffset = YES;  
    }  
	
	
    keyboardShown = YES;  
}  


// Called when the UIKeyboardDidHideNotification is sent  
- (void)keyboardWasHidden:(NSNotification*)aNotification  
{  
	
    NSDictionary* info = [aNotification userInfo];  
	
    // Get the size of the keyboard.  
    NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];  
    CGSize keyboardSize = [aValue CGRectValue].size;  
	
    // Reset the height of the scroll view to its original value  
    CGRect viewFrame = [scrollView frame];  
    viewFrame.size.height += keyboardSize.height;  
    scrollView.frame = viewFrame;  
	
    if (isNeedSetOffset) {  
        [scrollView setContentOffset:CGPointMake(0, oldContentOffsetValue) animated:YES];  
    }  
	
    isNeedSetOffset = NO;  
	
    keyboardShown = NO;  
}  
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

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
