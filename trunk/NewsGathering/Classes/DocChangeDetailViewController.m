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
#import "DocDetail.h"
#import "DocDetailHelper.h"
#import "UIAlertTableView.h"
#import "ContributeInfo.h"
#import "TreeViewController.h"
#import "CustomAlertView.h"
#import "Contants.h"


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
@synthesize receptorArray;
@synthesize typeArray;
@synthesize levelArray;
@synthesize lastTypeIndexPath;
@synthesize lastLevelIndexPath;
@synthesize request;
@synthesize nextReceptorUserName;
@synthesize nextReceptorUserID;


@synthesize storeHelper = _storeHelper;


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
    //if( (workflowInfo.opttype == nil)||[btLevel.titleLabel.text length]<1){
    //    [alert alertInfo:@"审核级别不能为空" withTitle:@"错误"];
    ///    [alert hideWaiting];
    //    return;
    //}
   // NSLog(@"%@===================%@",workflowInfo.opttype,btReceptor.titleLabel.text);
   // if( [workflowInfo.opttype isEqualToString:@"1"]&&[btReceptor.titleLabel.text length]<1){
   //     [alert alertInfo:@"接收人不能为空" withTitle:@"错误"];
   //     [alert hideWaiting];
   //     return;
   // }
    
    [alert showWaitingWithTitle:@"提交中" andMessage:@"请等待....."];
    NewsGatheringAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

    NSString *url = [[NSString alloc] initWithFormat:@"%@contriM!uploadFile.do?usercode=%@&password=%@&flowid=%@",kServer_URL,appDelegate.username,appDelegate.password,contributeInfo.flowID];
    
    [request cancel];
    [request setRequestMethod:@"post"];    
	[self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]]];
    
	[request setTimeOutSeconds:20];
    
    [request setDelegate:self];
	[request setDidFailSelector:@selector(respnoseFailed:)];
	[request setDidFinishSelector:@selector(responseComplete:)];
    
    BOOL isExistFiles = NO;
    for (AttLsInfo *filePath in attachArray) {
        if (![filePath.attLsID isEqualToString:kAttachID_Invalide]) {
            continue;
        }
        NSString *tmp = [NSString stringWithFormat:@"%@/%@",self.storeHelper.baseDirectory,filePath.fileName];
		[request setFile:tmp forKey:[NSString stringWithFormat:@"file",filePath]];
        isExistFiles = YES;
	}
    if (!isExistFiles) {
        [self sendContents];
        return;
    }
    
	[request startAsynchronous];
}

- (void)submitDocDidFinished:(ContributeInfo *)contributeInfo1{
    if ([contributeInfo1.flag isEqualToString:@"200"]) {
        [alert alertInfo:@"稿件修改成功" withTitle:nil];
    }
    else
    {
        [alert alertInfo:@"稿件修改失败" withTitle:@"错误"];
    }
    [alert hideWaiting];
}

- (void)addDocDidFinished:(ContributeInfo *)contributeInfo1{
    if ([contributeInfo1.flag isEqualToString:@"200"]) {
        [alert hideWaiting];
        [alert alertInfo:@"稿件上传成功" withTitle:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [alert alertInfo:@"稿件上传失败" withTitle:@"错误"];
    }
    
    [alert hideWaiting];
}

- (void)addDocForApproveDidFinished:(ContributeInfo *)contributeInfo1{
    if ([contributeInfo1.flag isEqualToString:@"200"]) {
        [alert alertInfo:@"稿件上传成功" withTitle:nil];
        [alert hideWaiting];   
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [alert alertInfo:@"稿件上传失败" withTitle:@"错误"];
    }
    [alert hideWaiting];  
}

-(void) sendContents{

    NSString *strLevel;
    for(DirtInfo *info in levelArray){
        if ([info.dic_value isEqualToString:btLevel.titleLabel.text]) {
            strLevel = [info.dic_type retain];
            break;
        }else
            continue;
    }
    
    //NSString *strLevel = [NSString stringWithFormat:@"%d",[levelArray indexOfObject:btLevel.titleLabel.text]+1];
    NSString *strType = [NSString stringWithFormat:@"%d",[typeArray indexOfObject:btType.titleLabel.text]+1];
    /*if ([workflowInfo.opttype isEqualToString:@"1"]) {
     [docRequest addDocForApproveWithTitle:fdTitle.text Keyword:fdKeyword.text Note:contents.text Source:fdSource.text Type:strType Level:strLevel FlowID:contributeInfo.flowID Receptuserid:nil Status:workflowInfo.endStatus ConID:contributeInfo.conid];
     }if ([workflowInfo.opttype isEqualToString:@"2"]) {*/
    NSLog(@"***************%@",workflowInfo.endStatus);
    [docRequest addDocWithTitle:fdTitle.text Keyword:fdKeyword.text Note:contents.text Source:fdSource.text Type:strType Level:strLevel FlowID:contributeInfo.flowID Status:@"4" ConID:contributeInfo.conid];
    //}
    

}

-( void )responseComplete:(ASIHTTPRequest *)theRequest{
    // 请求响应结束，返回 responseString
    NSString *responseString = [ request responseString ];
    
    NSLog(@"###########%@",responseString);
    
    //如果附件发送成功，则发送内容
    [self sendContents];
}

-( void )respnoseFailed:(ASIHTTPRequest *)theRequest{
    // 请求响应失败，返回错误信息
    NSError *error = [ request error ];
    NSLog(@"#############%@",error);
    [alert alertInfo:@"提交失败." withTitle:@"错误"]; 
    [alert hideWaiting];

}

-(void) sendWeiboDidFinished:(ContributeInfo *)contributeInfo1{
    [alert hideWaiting];
    if ([contributeInfo1.flag isEqualToString:@"200"]) {
        [alert alertInfo:@"分享成功" withTitle:nil];
        [self.navigationController popViewControllerAnimated:YES]; 
    }else{
        [alert alertInfo:@"分享失败" withTitle:nil];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) shareToWB{
    //[alert showWaitingWithTitle:@"提交中" andMessage:@"请等待....."];
    menuType = MENUTYPE_WEIBO;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"博文类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"文字微博",@"图文微博",nil];
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
    [actionSheet release];

}

-(void) approveDidFinished:(ContributeInfo *)contributeInfo1{
    [alert hideWaiting];
    if ([contributeInfo1.flag isEqualToString:@"200"]) {
        if ([nextStatus isEqualToString:@"99"]) {
            [alert alertInfo:@"审核成功" withTitle:nil];
        }else
        {
          [alert alertInfo:@"打回成功" withTitle:nil];
        }
      
        [self.navigationController popViewControllerAnimated:YES]; 
    }else{
        if ([nextStatus isEqualToString:@"99"]) {
             [alert alertInfo:@"审核失败" withTitle:nil];
        }else
        {
            [alert alertInfo:@"打回失败" withTitle:nil];
        }
    }
}

- (void)approveStatusDidFinished:(ContributeInfo *)contributeInfo1 {
    NSLog(@"======%@",contributeInfo1.flag);
    
    [alert hideWaiting];
    if ([contributeInfo1.flag isEqualToString:@"200"]) {
        if ([nextStatus isEqualToString:@"99"]) 
            [alert alertInfo:@"操作成功" withTitle:nil];

        
        [self.navigationController popViewControllerAnimated:YES]; 
    }else{
        if ([nextStatus isEqualToString:@"99"]) {
            [alert alertInfo:@"审核失败" withTitle:nil];
        }else
        {
            [alert alertInfo:@"打回失败" withTitle:nil];
        }
    }
    
}

-(void) passAudit{
    for (WorkflowInfo *flowInfo in workflowInfoArray) {
        NSLog(@"%@", flowInfo.endStatus);
        if ([flowInfo.endStatus isEqualToString:@"99"] ) {
            [alert showWaitingWithTitle:@"提交中" andMessage:@"请等待....."];
            nextStatus = flowInfo.endStatus;
            [docRequest approveWithConid:contributeInfo.conid Attitude:opinionViewController.opinion Status:@"99" LogID:((WorkLog *)[contributeInfo.workLogList objectAtIndex:0]).logID];
            break;
        }
        if ([contributeInfo.status isEqualToString:@"4"] && ([contributeInfo.level isEqualToString:@"3"])) {
            if((nextReceptorUserID == nil) || ([nextReceptorUserID length]<1)){
                [alert alertInfo:@"二级审核需要选择下一审核人" withTitle:@"提醒"];
                break;
               }
        }
        if ([flowInfo.endStatus intValue]<6 ) {
            continue;
        }else{
            [alert showWaitingWithTitle:@"提交中" andMessage:@"请等待....."];
            WorkLog *workLog = [contributeInfo.workLogList objectAtIndex:0];
            [docRequest ApproveStatusWithLogID:workLog.logID Status:flowInfo.endStatus Attitude:opinionViewController.opinion  Conid:contributeInfo.conid RecuseuserID:nextReceptorUserID];
            nextStatus = flowInfo.endStatus;
            break;
        }
    }
}

-(void) goBack{

    if ([contributeInfo.status isEqualToString:@"4"]) {
        nextStatus = @"5";
    }else{
        for (WorkflowInfo *flowInfo in workflowInfoArray) {
            if([flowInfo.endStatus intValue] < [contributeInfo.status intValue])
            {
                nextStatus = [flowInfo.endStatus retain];
                break;
            }else{
                continue;
            }
        }
    }
    
    WorkLog *workLog = [contributeInfo.workLogList objectAtIndex:0];
    if ([opinionViewController.opinion length] < 1) {
        [alert alertInfo:@"请填写审核意见" withTitle:@"注意"];
        if (opinionViewController == nil) {
            opinionViewController = [[AuditOpinionViewController alloc] init];
            opinionViewController.bEnableEdit = YES;
        }
        [self.navigationController pushViewController:opinionViewController animated:YES];
        return;
    }
    [alert showWaitingWithTitle:@"提交中" andMessage:@"请等待....."];
    NSLog(@"=======%@",opinionViewController.opinion);
    [docRequest ApproveStatusWithLogID:workLog.logID Status:nextStatus Attitude:opinionViewController.opinion  Conid:contributeInfo.conid RecuseuserID:workLog.userID];
}

-(void)submitDoc{
    menuType = MENUTYPE_SUBMIT;
    if (enableAudit) {
        enableEdit = NO;
        enableShare = NO;
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"提交目的" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"通过",@"打回",nil];
        actionSheet.delegate = self;
        [actionSheet showInView:self.view];
        [actionSheet release];
    }else if([contributeInfo.status isEqualToString:@"99"] ){
        enableAudit = NO;
        enableEdit = NO;
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"提交目的" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享到微博",nil];
        actionSheet.delegate = self;
        [actionSheet showInView:self.view];
        [actionSheet release];
    }else if(enableEdit){
        enableAudit = NO;
        enableShare = NO;
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"提交目的" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"提交审核",nil];
        actionSheet.delegate = self;
        [actionSheet showInView:self.view];
        [actionSheet release];
    }else{
        [alert alertInfo:@"当前状态您只能浏览." withTitle:@"提醒"];
    }
        
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (menuType == MENUTYPE_VIDEO) {
        
        UIImagePickerController *imgPickerCtrl = [[UIImagePickerController alloc] init];
        imgPickerCtrl.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        imgPickerCtrl.delegate = self;
        switch (buttonIndex) {
            case 0:
                [self presentModalViewController:imgPickerCtrl animated:YES];
                //[self.navigationController pushViewController:imgPickerCtrl animated:YES];
                [imgPickerCtrl release];
                break;
                
            case 1:
                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    
                    UIImagePickerController *videoCtrl = [[UIImagePickerController alloc] init];
                    videoCtrl.delegate = self;
                    videoCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
                    videoCtrl.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
                    videoCtrl.videoQuality = UIImagePickerControllerQualityTypeLow;
                    videoCtrl.videoMaximumDuration = DBL_MAX;
                    [self presentModalViewController:videoCtrl animated:YES];
                    [videoCtrl release];
                }
                
                break;
                
            default:
                break;
        }
    }

    
    if (menuType == MENUTYPE_WEIBO) {
        switch (buttonIndex) {
            case 0: //文字
                [docRequest sendWeiboWithType:@"1" Note:contributeInfo.note FilePath:@""];
                break;
            case 1://图文
                if ((imagePlayCtrl.selectedImageName == nil) || ([imagePlayCtrl.selectedImageName length]<1)) {
                    [alert alertInfo:@"请选择图片" withTitle:@"提醒"];
                    return;
                }else{
                    for(AttLsInfo *info in attachArray)
                    {
                        if([info.fileName isEqualToString:imagePlayCtrl.selectedImageName]){
                            [docRequest sendWeiboWithType:@"2" Note:contributeInfo.note FilePath:info.attLsID];
                            break;
                        }
                    }
                }
                break;
            default:
                break;
        }
    }
    
    if (menuType == MENUTYPE_MEDIALIB) {
        
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
    if (menuType == MENUTYPE_SUBMIT) {
        switch (buttonIndex) {
            case 0:
                if (enableEdit) {
                    [self saveDoc];
                }else if(enableShare){
                    [self shareToWB];
                }else{
                    [self passAudit];
                }
                break;
            case 1:
                if (enableEdit) {
                    break;
                }
                if (enableShare) {
                    break;
                }else{
                    [self goBack];
                }
                break;
            default:
                [alert hideWaiting];
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
    
    menuType = MENUTYPE_VIDEO;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选择视频", @"拍摄", nil];
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
    [actionSheet release];
    
}


- (void)back:(id)sender {  
    [self.navigationController popViewControllerAnimated:YES];  
}

-(void)initForm{
    
    NSString *strType = [typeArray objectAtIndex:[contributeInfo.type intValue]-1];
    
    NSString *strLevel;
    for(DirtInfo *info in levelArray){
        if([info.dic_type isEqualToString:contributeInfo.level]){
            strLevel = info.dic_value;
        }
    }
    //NSString *strLevel = [levelArray objectAtIndex:[contributeInfo.level intValue]-1];
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

-(IBAction)setNextReceptor:(id)sender{
    
    if ([contributeInfo.status isEqualToString:@"5"]) {
        [alert alertInfo:@"当前稿件不能增加审核人" withTitle:@"提醒"];
        return;
    }
    //如果不是多级审批就不能增加审核人
    NSString *tmpLevel;
    for(DirtInfo *info in levelArray){
        if ([info.dic_value isEqualToString:btLevel.titleLabel.text]) {
            tmpLevel = info.dic_type;
            break;
        }
    }
    if(![tmpLevel isEqualToString:@"3"]){
        [alert alertInfo:@"当前稿件不能增加审核人" withTitle:@"提醒"];
        return;
    }
    
    TreeViewController *treeViewCtrl = [[TreeViewController alloc] init];
    treeViewCtrl.delegate = self;
    treeViewCtrl.titleText = @"下一个审核人";
    [self.navigationController pushViewController:treeViewCtrl animated:YES];
    [treeViewCtrl release];
    
}

-(IBAction)writeOpinion:(id)sender{
    
    opinionViewController = [[AuditOpinionViewController alloc] init];
    if ([contributeInfo.attitudeList count]<1 || 
        ([contributeInfo.attitudeList objectAtIndex:0] == nil) ||
        ([(NSString *)[contributeInfo.attitudeList objectAtIndex:0] length]<1)) {
        opinionViewController.opinion = @"";
    }else{
        opinionViewController.opinion = [contributeInfo.attitudeList objectAtIndex:0] ;
    }
    if (enableEdit) {
        opinionViewController.bEnableEdit = NO;
    }else if (enableShare) {
        opinionViewController.bEnableEdit = NO;
    }else{
        opinionViewController.bEnableEdit = YES;
    }
    [self.navigationController pushViewController:opinionViewController animated:YES];

}

//通过代理方法获取组织结构中的选择的人员
- (void)passValue:(NSMutableArray *)value
{
    NSMutableArray *dispathedPersonInfo = value;
    int i = 0;
    for(UserInfo *userInfo in dispathedPersonInfo){
        if(i == 0){
            self.nextReceptorUserID = userInfo.userID;
            self.nextReceptorUserName = userInfo.userName;
        }else{
            self.nextReceptorUserName = [NSString stringWithFormat:@"%@,%@",self.nextReceptorUserName,userInfo.userName];
            self.nextReceptorUserID = [NSString stringWithFormat:@"%@,%@",self.nextReceptorUserID,userInfo.userID];
        }
        i++;
    }
    //[btReceptor setTitle:receptorUsersName forState:UIControlStateNormal];
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
        NSUInteger row = [indexPath row];
        NSUInteger oldRow = [lastLevelIndexPath row];
        cell.textLabel.text = ((DirtInfo *)[levelArray objectAtIndex:indexPath.row]).dic_value;
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
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if (alertType == ALERTTABLE_DOCTYPE) {
            [btType setTitle:tmpCellString forState:UIControlStateNormal];         
        }else{
            [btLevel setTitle:tmpCellString forState:UIControlStateNormal];
            docRequest.delegate = self;
            
            for (DirtInfo *info in levelArray) {
                if ([info.dic_value isEqualToString:tmpCellString]) {
                    [docRequest getWorkflowWithLevel:info.dic_type];
                    break;
                }
            }
            
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
            NSLog(@"FILE ID IS %@",attachID);
            
            NSString *filePath = [_storeHelper.baseDirectory stringByAppendingFormat:@"/%@", fileName];
            NSFileManager *fileManager = [[NSFileManager alloc] init];
            if ([fileManager fileExistsAtPath:filePath]) {
                [self showMediaWithFile:fileName]; 
            }else if(![attachID isEqualToString:kAttachID_Invalide]){
                [alert showWaitingWithTitle:@"文件加载中" andMessage:@"请等待..."];
                [docRequest beginDownloadWithID:attachID andFileName:fileName];
            }/*else{
                [self showMediaWithFile:fileName];                
            }*/
            [fileManager release];
        }
        
    }
    
}

-(void) deleteAttachDidFinished:(ContributeInfo *)contributeInfo1{

    if([contributeInfo1.flag isEqualToString:@"200"]){
        [alert alertInfo:@"附件删除成功" withTitle:@""];
        [attachArray removeObjectAtIndex:attachIndex];
    }else
    {
        [alert alertInfo:@"附件删除失败" withTitle:@"错误"];
    }
    
    [self.attachTable endUpdates]; 

}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (alertType == ALERTTABLE_LEVEL || alertType == ALERTTABLE_LEVEL) {
        return;
    }
    if(!enableEdit){
        [alert alertInfo:@"当前您不能删除该附件." withTitle:@"提醒"];
        return;
    }
    [self.attachTable beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        AttLsInfo *attsInfo = [attachArray objectAtIndex:indexPath.row];
        if ([attsInfo.attLsID isEqualToString:kAttachID_Invalide]) {
            [_storeHelper deleteFileWithName:fileName];
            [attachArray removeObjectAtIndex:indexPath.row];
        }else
        {
            NSLog(@"======================%@",attsInfo.attLsID);
            attachIndex = indexPath.row;
            [docRequest deleteAttachWithID:attsInfo.attLsID];
        }

    }
    [self.attachTable endUpdates];  
}


-(void) showMediaWithFile:(NSString *) fileName1{

    NSString *fileType = [fileName substringWithRange:NSMakeRange(0, 5)];
    NSData *data = [_storeHelper readFileWithName:fileName1];
    if(data != nil) {
        if([fileType isEqualToString:kMediaType_Image]) {
            
            UIImage *image = [[UIImage alloc] initWithData:data];
            imagePlayCtrl.image = image;
            imagePlayCtrl.showSelectButton = YES;
            imagePlayCtrl.imageName = fileName1;
            //[self presentModalViewController:imagePlayCtrl animated:YES];
            [self.navigationController pushViewController:imagePlayCtrl animated:YES];
            [image release];
            
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
    /*
    for(WorkflowInfo *flowInfo in workflowArray){
        if ([contributeInfo.level isEqualToString:flowInfo.begStatus]) {
            enableEdit = YES;
        }
        else{
            enableEdit = NO;
        }
    }*/
}

-(void) downloadDidFinished:(BOOL)isSuccess{

    if (isSuccess) {
        [alert hideWaiting];
        //[alert alertInfo:@"下载成功" withTitle:nil];
        
        [self showMediaWithFile:fileName]; 
        [_storeHelper deleteFileWithName:fileName];
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

- (UIImage *)scaleAndRotateImage:(UIImage *)image {
    int kMaxResolution = 640; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissModalViewControllerAnimated:YES];
    NSMutableString *imageName = [[NSMutableString alloc] initWithCapacity:0] ;
    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if (CFStringCompare((CFStringRef) [info objectForKey:UIImagePickerControllerMediaType], kUTTypeImage, 0) == kCFCompareEqualTo) {
        
        [imageName appendFormat:@"Image_%@.jpeg",[df stringFromDate:[NSDate date]]];
//        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *image = [self scaleAndRotateImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
        //StorageHelper *helper = [[StorageHelper alloc] init];
        
        //        [_storeHelper createFileWithName:imageName data:UIImagePNGRepresentation(image)];
        [_storeHelper createFileWithName:imageName data:UIImageJPEGRepresentation(image, 0.1)];
    }else if( CFStringCompare((CFStringRef) [info objectForKey:UIImagePickerControllerMediaType], kUTTypeMovie, 0) == kCFCompareEqualTo) {
        
        [imageName appendFormat:@"Video_%@.mp4",[df stringFromDate:[NSDate date]]];
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        //StorageHelper *helper = [[StorageHelper alloc] init];
        [_storeHelper createFileWithName:imageName data:[NSData dataWithContentsOfURL:videoURL]];
    }
    
    AttLsInfo *attlsInfo = [[AttLsInfo alloc] init];
    attlsInfo.fileName = [[NSString alloc] initWithString:imageName];
    attlsInfo.attLsID = [NSString stringWithFormat:@"%@", kAttachID_Invalide];
    [self.attachArray  addObject:attlsInfo];
    //NSLog(@"%@", self.attachArray);
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
        self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;  
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
    
    if (alert == nil) {
        alert = [[CustomAlertView alloc] init];
    }

    //设置意见值
    NSString *opinion;
    if(opinionViewController.opinion != nil)
    {
        if ([opinionViewController.opinion length]<1) {
            opinion = @"";
        }else{
            opinion = [[NSString alloc] initWithString:opinionViewController.opinion];   
        }
    }
    else{
        NSString *tmp = [contributeInfo.attitudeList objectAtIndex:0];
        if ([contributeInfo.attitudeList count]>0 &&(tmp != nil &&[tmp length]>1) ) {
            opinion = [[NSString alloc] initWithString:[contributeInfo.attitudeList objectAtIndex:0]];
        }else{
            opinion = [[NSString alloc] initWithString:@""];
        }
    }
    
    if ([opinion isEqualToString:@"null"]) {
         [btOpinion setTitle:@"无" forState:UIControlStateNormal];
    }else{
        int length = [opinion length];
    
        if (length < 1) {
            [btOpinion setTitle:@"无" forState:UIControlStateNormal];
        }else{
            [btOpinion setTitle:opinion forState:UIControlStateNormal];
        }
    }
    
    //设置下一审核人
    [btNextReceptor setTitle:nextReceptorUserName forState:UIControlStateNormal];
    
    alertType = ALERTTABLE_OTHERS;

	
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    alert = [[CustomAlertView alloc] init];
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
    
    if ([contributeInfo.status isEqualToString:@"3"] || [contributeInfo.status isEqualToString:@"5"]) {
        enableAudit = NO;
        enableShare = NO;
        enableEdit = YES;
    }else if([contributeInfo.status isEqualToString:@"99"]){
        enableAudit = NO;
        enableShare = YES;
        enableEdit = NO;
    }else {
        enableAudit = YES;
        enableShare = NO;
        enableEdit = NO;
    }

    WorkLog *info = (WorkLog *)[contributeInfo.workLogList objectAtIndex:0];
    if ([info.recuseuserID isEqualToString: appDelegate.loginId]) {
        enableAudit = YES;
    }else{
        enableAudit = NO;
    }
    //查询是否可修改
    //[docRequest getEditListWithLevel:contributeInfo.level];
    
    //获取下一步操作状态
    //int l = [levelArray indexOfObject:contributeInfo.level];
    //NSLog(@"==========++++++=======%@",contributeInfo.level);
    //[docRequest getAppWorkflowWithLevel:[NSString stringWithFormat:@"%@",contributeInfo.level] Status:contributeInfo.status];
    nextStatus = [[NSString alloc] init];
    NSLog(@"+++++++++++status = %@",contributeInfo.status);
    NSLog(@"-----------level = %@",contributeInfo.level);
    
    [docRequest getAppWorkflowWithLevel:contributeInfo.level Status:contributeInfo.status];
    
    [self initForm];
    
    imagePlayCtrl = [[ImagePlayViewController alloc] init];
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

}

// 触摸屏幕并拖拽画面，再松开，最后停止时，触发该函数
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

}

// 滚动停止时，触发该函数

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UIView *subView in scrollView.subviews) {
        if([subView isKindOfClass:[UITextView class]]) {
            
            [subView resignFirstResponder];
        }
        
        if([subView isKindOfClass:[UITextField class]]) {
            
            [subView resignFirstResponder];
        }
    }
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
    if (opinionViewController != nil) {
        [opinionViewController release];
        opinionViewController = nil;
    }
    
    [super dealloc];
}



@end
