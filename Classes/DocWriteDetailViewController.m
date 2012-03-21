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
#define kAlert_Back     1026
#define kAlert_Upload   1027

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
@synthesize ftpUploadFile;
@synthesize detailFromClue;

@synthesize storeHelper = _storeHelper;


- (void)alertInfo:(NSString *)info withTitle:(NSString *)title{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:info
                                                       delegate:nil 
                                              cancelButtonTitle:@"关闭" 
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

- (void)hideKeyboard{

    for (UIView *subView in scrollView.subviews) {
        if([subView isKindOfClass:[UITextView class]]) {
            
            [subView resignFirstResponder];
        }
        
        if([subView isKindOfClass:[UITextField class]]) {
            
            [subView resignFirstResponder];
        }
    }
}

-(IBAction) getPhoto {
    
    [self hideKeyboard];
    
    menuType = MENUTYPE_MEDIALIB;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选择照片", @"拍照", nil];
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
    [actionSheet release];
}

-(IBAction) getRecord {

    [self hideKeyboard];
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
    
    [alertView show];
    [alertView release];
    
}

-(IBAction) getVideo {
    [self hideKeyboard];
    menuType = MENUTYPE_VIDEO;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选择视频", @"拍摄", nil];
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
    [actionSheet release];

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
    _docDetail.title    = fdTitle.text;
    _docDetail.docType  = btType.titleLabel.text;
    _docDetail.key      = fdKeyword.text;
    _docDetail.source   = fdDocSource.text;
    _docDetail.level    = btLevel.titleLabel.text;
    _docDetail.recevicer= btReceptor.titleLabel.text;
    _docDetail.receptorid= dispatchedUsersID;
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
    else
    {
        [self alertInfo:@"保存稿件成功!" withTitle:@"稿件保存"];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)submitForAudit{
    
    if ((_docDetail != nil)&&([_docDetail.status isEqualToString:DOC_STATUS_SUMMITED])) {
        [self alertInfo:@"文档已经提交，不能再提交。" withTitle:@"提醒"];
        [alert hideWaiting];
        return;
    }
    
    //上传前验证必填项
    if( [fdTitle.text length]<1){
        [self alertInfo:@"标题不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    if( [fdTitle.text length]>300){
        [self alertInfo:@"标题过长" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
   /* if( [fdKeyword.text length]<1){
        [self alertInfo:@"关键字不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }*/
    if( [fdKeyword.text length]>300){
        [self alertInfo:@"关键字过长" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    if( [contents.text length]<1){
        [self alertInfo:@"内容不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
    if( [contents.text length]>2000){
        [self alertInfo:@"内容过长" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }
   /* if( [fdDocSource.text length]<1){
        [self alertInfo:@"稿源不能为空" withTitle:@"错误"];
        [alert hideWaiting];
        return;
    }*/
    if( [fdDocSource.text length]>300){
        [self alertInfo:@"稿源过长" withTitle:@"错误"];
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
    if (workflowInfo.endStatus == nil || [workflowInfo.endStatus length]<1) {
        [self alertInfo:@"请重新设置审核级别" withTitle:@"错误"];
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
	
    if (_docDetail == nil) {
        _docDetail = [[DocDetail alloc] init];
    }
    contributeInfo.flowID = [_docDetail.UUID copy];
    if ([attachArray count]<1) {

        NSString *strLevel;
        for(DirtInfo *info in levelArray){
            if([info.dic_value isEqualToString:btLevel.titleLabel.text]){
                strLevel = info.dic_type;
            }
        }
        NSString *strType = [NSString stringWithFormat:@"%d",[typeArray indexOfObject:btType.titleLabel.text]+1];
        if ([workflowInfo.opttype isEqualToString:@"1"]) {
            
            if ([dispatchedUsersID length]<1) {
                dispatchedUsersID = _docDetail.receptorid;
            }
            [docRequest addDocForApproveWithTitle:fdTitle.text Keyword:fdKeyword.text Note:contents.text Source:fdDocSource.text Type:strType Level:strLevel FlowID:contributeInfo.flowID Receptuserid:dispatchedUsersID Status:@"4" ConID:@""];
        }if ([workflowInfo.opttype isEqualToString:@"2"]) {
            [docRequest addDocWithTitle:fdTitle.text Keyword:fdKeyword.text Note:contents.text Source:fdDocSource.text Type:strType Level:strLevel FlowID:contributeInfo.flowID Status:@"99" ConID:@""];
        }
    }else{
        
        //计数，等文件上传完成后，再传文本
        fileCount = 0;
        NSString *fileName = [attachArray objectAtIndex:fileCount];
        NSString *tmp = [NSString stringWithFormat:@"%@/%@",self.storeHelper.baseDirectory,fileName];
        nTransTimes = 0;//第一次，可以重试1次
        NewsGatheringAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        ftpUploadFile = [[FTPUploadFile alloc] initWithLocalPath:tmp withServer:appDelegate.ftpInfo.ftpURL withName:appDelegate.ftpInfo.ftpUsername withPass:appDelegate.ftpInfo.ftpPassword];
        ftpUploadFile.delegate = self;
        [ftpUploadFile performSelectorOnMainThread:@selector(start) withObject:nil waitUntilDone:NO];
    }

}

-(void)shareToWB{
    
    [alert hideWaiting];

}

- (void)addDocDidFinished:(ContributeInfo *)contributeInfo1{
    if ([contributeInfo1.flag isEqualToString:@"200"]) {
        [self alertInfo:@"稿件上传成功" withTitle:nil];
        
        if(_docDetail != nil && transformType == TYPE_MODIFY) {
            
            DocDetailHelper *docDetailHelper = [[DocDetailHelper alloc] init];
            _docDetail.status = DOC_STATUS_SUMMITED;
            [docDetailHelper updateDoc:_docDetail];
            [docDetailHelper release];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
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
        }else{
            //删除所有的临时文件
            for(NSString *fileTmp in attachArray){
                [_storeHelper deleteFileWithName:fileTmp];
            }
        }
    }
    else
    {
        [self alertInfo:@"稿件上传失败" withTitle:@"错误"];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self alertInfo:@"稿件上传失败" withTitle:@"错误"];
    }
    [alert hideWaiting];
}

- (void) sendFileStoped:(FTP_ERROR)ftpError{
     NSLog(@"Send File stop");
    [alert hideWaiting];
    if (ftpError == FTP_ERROR_STOPCMD) {
        [self saveDoc];
        [alert alertInfo:[NSString stringWithFormat:@"%@\n被终止上传。",[attachArray objectAtIndex:fileCount]] withTitle:@"提醒"];
    }else  if (ftpError == FTP_ERROR_NO) {//说明文件已经存在，不需要进行传输,给一个假200继续下一个文件传输
        ContributeInfo *contriTemp = [[ContributeInfo alloc] init];
        contriTemp.flag = @"200";
        [self uploadFileDidFinished:contriTemp];
    }else{//出现错误
        if(nTransTimes > 1){
        [self saveDoc];
        [alert alertInfo:[NSString stringWithFormat:@"%@\n在上传时失败。",[attachArray objectAtIndex:fileCount]] withTitle:@"错误"];
        }else
        {
            nTransTimes++;
            NSString *fileName = [attachArray objectAtIndex:fileCount];
            NSString *tmp = [NSString stringWithFormat:@"%@/%@",self.storeHelper.baseDirectory,fileName];
            NewsGatheringAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            ftpUploadFile = [[FTPUploadFile alloc] initWithLocalPath:tmp withServer:appDelegate.ftpInfo.ftpURL withName:appDelegate.ftpInfo.ftpUsername withPass:appDelegate.ftpInfo.ftpPassword];
            ftpUploadFile.delegate = self;
            [ftpUploadFile performSelectorOnMainThread:@selector(start) withObject:nil waitUntilDone:NO];
        }

    }
}

- (void) tempSendFileFinished:(NSString *)filename1{
    NSLog(@"%@ has been sent",filename1);
    [docRequest uploadFileWithFlowID:contributeInfo.flowID FileName:filename1];
}

- (void) sendFileDidfinished{
    NSString *fileName1 = [attachArray objectAtIndex:fileCount];
    NSLog(@"xxxxxxx%@", fileName1);
    [self performSelectorOnMainThread:@selector(tempSendFileFinished:) withObject:fileName1 waitUntilDone:NO];
}

- (void)addDocAPPWithReceptuserID:(NSString *)receptuserID {

    NSString *strLevel;
    for(DirtInfo *info in levelArray){
        if([info.dic_value isEqualToString:btLevel.titleLabel.text]){
            strLevel = info.dic_type;
        }
    }
    NSString *strType = [NSString stringWithFormat:@"%d",[typeArray indexOfObject:btType.titleLabel.text]+1];
    [docRequest addDocForApproveWithTitle:fdTitle.text Keyword:fdKeyword.text Note:contents.text Source:fdDocSource.text Type:strType Level:strLevel FlowID:contributeInfo.flowID Receptuserid:dispatchedUsersID Status:@"4" ConID:@""];
}

- (void)addDoc {

    NSString *strLevel;
    for(DirtInfo *info in levelArray){
        if([info.dic_value isEqualToString:btLevel.titleLabel.text]){
            strLevel = info.dic_type;
        }
    }
    NSString *strType = [NSString stringWithFormat:@"%d",[typeArray indexOfObject:btType.titleLabel.text]+1];
    [docRequest addDocWithTitle:fdTitle.text Keyword:fdKeyword.text Note:contents.text Source:fdDocSource.text Type:strType Level:strLevel FlowID:contributeInfo.flowID Status:@"99" ConID:@""];
}

- (void) uploadFileDidFinished:(ContributeInfo *)contributeInfo1{
    
    if ([contributeInfo1.flag isEqualToString:@"200"]) {
    
        NSLog(@"Send File end");
        //fileCount--;//等待所有文件发送完成
        fileCount++;
        
        //文件传送完成，准备发送文本
        if (fileCount > [attachArray count]-1) {
//            NSString *strLevel;
//            for(DirtInfo *info in levelArray){
//                if([info.dic_value isEqualToString:btLevel.titleLabel.text]){
//                    strLevel = info.dic_type;
//                }
//            }
//            NSString *strType = [NSString stringWithFormat:@"%d",[typeArray indexOfObject:btType.titleLabel.text]+1];
//            if(docRequest != nil) {
//                [docRequest release];
//                docRequest = nil;
//                docRequest = [[DocRequest alloc] init];
//                docRequest.delegate = self;
//            }
            if ([workflowInfo.opttype isEqualToString:@"1"]) {
                
                if ([dispatchedUsersID length]<1) {
                    dispatchedUsersID = _docDetail.receptorid;
                }
                [self performSelectorOnMainThread:@selector(addDocAPPWithReceptuserID:) withObject:dispatchedUsersID waitUntilDone:NO];
//                [docRequest addDocForApproveWithTitle:fdTitle.text Keyword:fdKeyword.text Note:contents.text Source:fdDocSource.text Type:strType Level:strLevel FlowID:contributeInfo.flowID Receptuserid:dispatchedUsersID Status:@"4" ConID:@""];
            }if ([workflowInfo.opttype isEqualToString:@"2"]) {
                [self performSelectorOnMainThread:@selector(addDoc) withObject:nil waitUntilDone:NO];
//                [docRequest addDocWithTitle:fdTitle.text Keyword:fdKeyword.text Note:contents.text Source:fdDocSource.text Type:strType Level:strLevel FlowID:contributeInfo.flowID Status:@"99" ConID:@""];
            }
        }else{//否则，就请求发送下一个文件
            
            NSString *fileName = [attachArray objectAtIndex:fileCount];
            NSString *tmp = [NSString stringWithFormat:@"%@/%@",self.storeHelper.baseDirectory,fileName];
            nTransTimes = 0;
            
            NewsGatheringAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            ftpUploadFile = [[FTPUploadFile alloc] initWithLocalPath:tmp withServer:appDelegate.ftpInfo.ftpURL withName:appDelegate.ftpInfo.ftpUsername withPass:appDelegate.ftpInfo.ftpPassword];
            ftpUploadFile.delegate = self;
            [ftpUploadFile performSelectorOnMainThread:@selector(start) withObject:nil waitUntilDone:NO];
        }


    
    }else{
        [alert hideWaiting];
        [alert alertInfo:@"与服务器链接错误。" withTitle:@"错误"];
        return;
    }

}

-( void )responseComplete:(ASIHTTPRequest *)theRequest{
    // 请求响应结束，返回 responseString
    NSString *responseString = [ request responseString ];
    
    NSLog(@"###########%@",responseString);
    
    
    //fileCount--;//等待所有文件发送完成
    fileCount++;
    NewsGatheringAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (fileCount < [attachArray count]) {
        
        NSString *url = [[NSString alloc] initWithFormat:@"%@contriM!uploadFile.do?usercode=%@&password=%@&flowid=%@",kServer_URL,appDelegate.username,appDelegate.password,contributeInfo.flowID];
        
        [request cancel];
        [request setRequestMethod:@"post"];    
        [self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]]];
        
        [request setTimeOutSeconds:20];
        
        [request setDelegate:self];
        [request setDidFailSelector:@selector(respnoseFailed:)];
        [request setDidFinishSelector:@selector(responseComplete:)];
        
        NSString *filePath = [attachArray objectAtIndex:fileCount];    
        NSString *tmp = [NSString stringWithFormat:@"%@/%@",self.storeHelper.baseDirectory,filePath];
        [request setFile:tmp forKey:[NSString stringWithFormat:@"file",filePath]];
        [request startAsynchronous];
        return;
    }

    NSString *strLevel;
    for(DirtInfo *info in levelArray){
        if([info.dic_value isEqualToString:btLevel.titleLabel.text]){
            strLevel = info.dic_type;
        }
    }
    NSString *strType = [NSString stringWithFormat:@"%d",[typeArray indexOfObject:btType.titleLabel.text]+1];
    if ([workflowInfo.opttype isEqualToString:@"1"]) {
        
        if ([dispatchedUsersID length]<1) {
            dispatchedUsersID = _docDetail.receptorid;
        }
        [docRequest addDocForApproveWithTitle:fdTitle.text Keyword:fdKeyword.text Note:contents.text Source:fdDocSource.text Type:strType Level:strLevel FlowID:contributeInfo.flowID Receptuserid:dispatchedUsersID Status:@"4" ConID:@""];
    }if ([workflowInfo.opttype isEqualToString:@"2"]) {
        [docRequest addDocWithTitle:fdTitle.text Keyword:fdKeyword.text Note:contents.text Source:fdDocSource.text Type:strType Level:strLevel FlowID:contributeInfo.flowID Status:@"99" ConID:@""];
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
    [self hideKeyboard];
    
    menuType = MENUTYPE_SUBMIT;
    NSString *strSubmit = @"提交审核";
    if ([workflowInfo.opttype isEqualToString:@"2"]) {
        strSubmit = @"提交完成";
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"提交目的" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存到本地",strSubmit,nil];
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
    [actionSheet release];
}

#pragma -
#pragma UIAlertView Delegate.

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 0 && alertView.tag == kAudioRecord){ 
        [attachArray addObject:((AudioRecorder *)alertView).fileName];
//        self.attachArray = [NSArray arrayWithArray:[_storeHelper getSubFiles]];
        
        if(transformType == TYPE_MODIFY && _docDetail != nil) {
            
            [_docDetail.attachments addObject:((AudioRecorder *)alertView).fileName];
            DocDetailHelper *_docDetailHelper = [[DocDetailHelper alloc] init];
            [_docDetailHelper updateDoc:_docDetail];
        }
        
        [self.attachTable reloadData];
    }
    
    
    if(alertView.tag == kAudioPlay || alertView.tag == kAudioRecord)
        return;
    
    if (alertView.tag == kAlert_Upload) {
        if (buttonIndex == 0) {
            
            [ftpUploadFile stopWithStatus:@""];
            if(ftpUploadFile.delegate == self) {
                if (nTransTimes <2) {
                   [self sendFileStoped:FTP_ERROR_STOPCMD];                 
                }
            }
            //ftpUploadFile.bStop = YES;
        }
        alertType = ALERTTABLE_OTHERS;
        return;
    }
    
    if (alertView.tag == kAlert_Back) {
        if (buttonIndex == 1){
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }else{
            return;
        }
    }
    
    if (buttonIndex == 1) {
        if ((tmpCellString == nil) || [tmpCellString length]<1) {
            return;
        }
        if (alertType == ALERTTABLE_DOCTYPE) {
            [btType setTitle:tmpCellString forState:UIControlStateNormal];         
        }else if(alertType == ALERTTABLE_LEVEL){
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

#pragma -
#pragma UIActionSheet Delegate.

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

    if (menuType == MENUTYPE_MEDIALIB) {
        UIImagePickerController *imgPickerCtrl = [[UIImagePickerController alloc] init];
        [imgPickerCtrl setSourceType:UIImagePickerControllerCameraCaptureModePhoto];
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
                [alert showWaitingWithTitle:@"存储中" andMessage:@"请等待....."];
                [self saveDoc];
                break;
            case 1:
                [alert transFileAlertWithInfo:@"文件上传中" andTitle:@"请等待....."];
                alert.uploadAlertView.delegate = self;
                alert.uploadAlertView.tag = kAlert_Upload;
                [self submitForAudit];
                break;
            default:
                break;
        }
    }
}

-(IBAction)setLevel:(id)sender{
    
    [self hideKeyboard];
    
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
    [self hideKeyboard];
    
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

    [self hideKeyboard];
    if ([workflowInfo.endStatus isEqualToString:@"99"]) {
        [alert alertInfo:@"快讯不需要接收人" withTitle:@"提醒"];
        return;
    }
    TreeViewController *treeViewCtrl = [[TreeViewController alloc] init];
    treeViewCtrl.bMultiSelect = NO;
    treeViewCtrl.delegate = self;
    treeViewCtrl.titleText = [[NSString alloc] initWithFormat:@"选择接收人"];
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (alertType == ALERTTABLE_DOCTYPE) {
        
        if([cell.textLabel.text isEqualToString:btType.titleLabel.text]) {
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            lastTypeIndexPath = [indexPath retain];
        }
    }else if(alertType == ALERTTABLE_LEVEL) {
    
        if([cell.textLabel.text isEqualToString:btLevel.titleLabel.text]) {
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            lastLevelIndexPath = [indexPath retain];
        }
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
       /* if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            tmpCellString = [typeArray objectAtIndex:row];
        }*/
    }
    else if (alertType == ALERTTABLE_LEVEL) {
        cell.textLabel.text = ((DirtInfo *)[levelArray objectAtIndex:indexPath.row]).dic_value;
        NSUInteger row = [indexPath row];
        NSUInteger oldRow = [lastLevelIndexPath row];
        cell.textLabel.text = ((DirtInfo *)[levelArray objectAtIndex:indexPath.row]).dic_value;
        cell.accessoryType = (row == oldRow && lastLevelIndexPath != nil) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        /*if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            tmpCellString =  ((DirtInfo *)[levelArray objectAtIndex:indexPath.row]).dic_value;
        }*/
        
    }else{
        cell.textLabel.text = [self.attachArray objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType =   UITableViewCellAccessoryDisclosureIndicator;
    
    }
    
    NSLog(@"-----%@",tmpCellString);
    return cell;
}

- (void)getWorkflowDidFinished:(NSArray *)workflowArray{
    workFlowArray = [[NSMutableArray alloc] initWithArray:workflowArray];
    for(workflowInfo in workFlowArray){
        if (![workflowInfo.endStatus isEqualToString:@"3"]) {
            [workflowInfo.endStatus retain];
            break;
        }
        else{
            continue;
        }
    }
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
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSDictionary *fileatt = [fileManager attributesOfItemAtPath:[_storeHelper.baseDirectory stringByAppendingPathComponent:fileName] error:nil];
            NSLog(@"=====%@",fileatt);
            NSLog(@"data length=======%fKB",([data length])/1024.0);
            
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
    NewsGatheringAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [picker dismissModalViewControllerAnimated:YES];
    NSMutableString *imageName = [[NSMutableString alloc] initWithCapacity:0] ;
    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
    [df setDateFormat:@"yyyy-MM-dd_HH:mm:ss"];
    [imageName appendFormat:@"Image_%@_%@.jpeg",appDelegate.loginId,[df stringFromDate:[NSDate date]]];
    
    [(NSMutableArray *)self.attachArray addObject:imageName];
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
    
    NewsGatheringAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
                                                                                                                                                                                                                                                                                                                     
    [picker dismissModalViewControllerAnimated:YES];
    NSMutableString *imageName = [[NSMutableString alloc] initWithCapacity:0] ;
    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
    [df setDateFormat:@"yyyy-MM-dd_HH:mm:ss"];
    if (CFStringCompare((CFStringRef) [info objectForKey:UIImagePickerControllerMediaType], kUTTypeImage, 0) == kCFCompareEqualTo) {
        
        [imageName appendFormat:@"Image_%@_%@.jpeg",appDelegate.loginId,[df stringFromDate:[NSDate date]]];
        UIImage *image = [self scaleAndRotateImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
                      
        //StorageHelper *helper = [[StorageHelper alloc] init];
        
//        [_storeHelper createFileWithName:imageName data:UIImagePNGRepresentation(image)];
        [_storeHelper createFileWithName:imageName data:UIImageJPEGRepresentation(image, 0.1)];
    }else if( CFStringCompare((CFStringRef) [info objectForKey:UIImagePickerControllerMediaType], kUTTypeMovie, 0) == kCFCompareEqualTo) {
        
        [imageName appendFormat:@"Video_%@_%@.mov",appDelegate.loginId,[df stringFromDate:[NSDate date]]];
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        //StorageHelper *helper = [[StorageHelper alloc] init];
        [_storeHelper createFileWithName:imageName data:[NSData dataWithContentsOfURL:videoURL]];
    }
    
    [self.attachArray  addObject:imageName];
    
    if(transformType == TYPE_MODIFY && _docDetail != nil) {
    
        [_docDetail.attachments addObject:imageName];
        
        DocDetailHelper *_docDetailHelper = [[DocDetailHelper alloc] init];
        [_docDetailHelper updateDoc:_docDetail];
    }
    
    [imageName release];
    imageName = nil;
    [self.attachTable reloadData];
}


- (void)back:(id)sender {  
    UIAlertView* alert1 = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                     message:@"正在编辑中，确定退出吗？"
                                                    delegate:self
                                           cancelButtonTitle:@"否"
                                           otherButtonTitles:@"是",nil];
    alert1.tag = kAlert_Back;
    [alert1 show];
    [alert1 release]; 
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		// 下一个界面的返回按钮  
      /*  UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];  
        temporaryBarButtonItem.title = @"返回";  
        temporaryBarButtonItem.target = self;  
        temporaryBarButtonItem.action = @selector(back);  
        self.navigationItem.backBarButtonItem = temporaryBarButtonItem;  
        [temporaryBarButtonItem release]; 
        
        //self.navigationController.navigationBar.delegate =self;*/
    }
   // [self.navigationController.navigationBar setDelegate:self];
    
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
    
    [btReceptor setTitle:dispatchedUsersName forState:UIControlStateNormal];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//[scrollView setFrame: CGRectMake(0.0f, 0.0f, 320.0f, 460.0f)];
	[scrollView setContentSize:CGSizeMake(320, 900)];
	scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
	
	self.fdTitle.delegate = self;
	self.fdKeyword.delegate = self;
	self.fdDocSource.delegate = self;
    contents.delegate = self;

    bEnableFill = YES;
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
    contributeInfo = [[ContributeInfo alloc] init];
    
    
    //////////////
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
        
    

    [btLevel setTitle:((DirtInfo *)[levelArray objectAtIndex:0]).dic_value forState:UIControlStateNormal];
    [btReceptor setTitle:dispatchedUsersName forState:UIControlStateNormal];
    
    if (detailFromClue != nil) {//从线索带过来的
        [btType setTitle:detailFromClue.docType forState:UIControlStateNormal];
        fdKeyword.text = detailFromClue.key;
        fdTitle.text = detailFromClue.title;
        contents.text = detailFromClue.content;
        [docRequest getWorkflowWithLevel:[NSString stringWithFormat:@"%d",3]];
    }else{
        
        [btType setTitle:[typeArray objectAtIndex:0] forState:UIControlStateNormal];
        if(_docDetail != nil && transformType == TYPE_MODIFY && bEnableFill) {
            bEnableFill = NO;
            fdTitle.text    = _docDetail.title;
            [btType setTitle:_docDetail.docType forState:UIControlStateNormal];
            fdKeyword.text      = _docDetail.key;
            fdDocSource.text   = _docDetail.source;
            [btLevel setTitle:_docDetail.level forState:UIControlStateNormal];
            NSLog(@"-----%@",_docDetail.recevicer);
            [btReceptor setTitle:_docDetail.recevicer forState:UIControlStateNormal];
            dispatchedUsersName = _docDetail.recevicer;
            dispatchedUsersID = _docDetail.receptorid;
            contents.text  = _docDetail.content;
            
            if([attachArray count] > 0)
                [attachArray removeAllObjects];
            [attachArray addObjectsFromArray:_docDetail.attachments];
            [self.attachTable reloadData];
            
            //初始时要获取流程
            docRequest.delegate = self;
            for(DirtInfo *info in levelArray)
            {
                if([info.dic_value isEqualToString:_docDetail.level])
                {
                    [docRequest getWorkflowWithLevel:info.dic_type];
                    break;
                }
            }
            
        }else{
            //初始时要获取流程
            docRequest.delegate = self;
            [docRequest getWorkflowWithLevel:[NSString stringWithFormat:@"%d",3]];
        }
    }
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)] autorelease]; 
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
