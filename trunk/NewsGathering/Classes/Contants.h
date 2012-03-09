#import <Foundation/Foundation.h>

//
typedef enum {
    DOCTYPE_DRAFT,    // shows glow when pressed
    DOCTYPE_DELETED,
} DOCTYPE;

typedef enum {
    MENUTYPE_SUBMIT,
    MENUTYPE_MEDIALIB,
    MENUTYPE_VIDEO,
    MENUTYPE_WEIBO
}MENUTYPE;

typedef enum {
    ALERTTABLE_DOCTYPE,
    ALERTTABLE_LEVEL,
    ALERTTABLE_OTHERS
}ALERTTABLE_TYPE;

typedef enum {
    TYPE_ADD,
    TYPE_MODIFY
}TRANSFORM_TYPE;

#define kAttachID_Invalide @"-1"

#define kServer_URL [[NSUserDefaults standardUserDefaults] stringForKey:@"ServerURL"]

//login interface
#define kInterface_Login [NSString stringWithFormat:@"%@loginM!submit.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/loginM!submit.do"

// 线索接口.

#define kFlag_NewsClue_List     1
#define kFlag_NewsClue_Detail   2
#define kFlag_NewsClue_Add      3
#define kFlag_NewsClue_Update   4
#define kFlag_NewsClue_Delete   5
#define kFlag_NewsClue_Submit   6

#define kInterface_NewsClue_List    [NSString stringWithFormat:@"%@keysM!getKeysList.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/keysM!getKeysList.do"   // 查询线索列表接口
#define kInterface_NewsClue_Detail  [NSString stringWithFormat:@"%@keysM!getKeyDetail.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/keysM!getKeyDetail.do"  // 查询线索详情接口
#define kInterface_NewsClue_Add     [NSString stringWithFormat:@"%@keysM!addKey.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/keysM!addKey.do"        // 增加线索接口
#define kInterface_NewsClue_Update  [NSString stringWithFormat:@"%@keysM!updateKey.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/keysM!updateKey.do"     // 修改线索接口
#define kInterface_NewsClue_Delete  [NSString stringWithFormat:@"%@keysM!delKey.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/keysM!delKey.do"        // 删除线索接口
#define kInterface_NewsClue_Submit  [NSString stringWithFormat:@"%@keysM!updateStatus.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/keysM!updateStatus.do"  // 提交线索接口

// 线索派发接口.
#define kFlag_ClueDist_List     1
#define kFlag_ClueDist_Detail   2
#define kFlag_ClueDist_Dept     3
#define kFlag_ClueDist_User     4
#define kFlag_ClueDist_Submit   5

#define kInterface_ClueDist_Submit  [NSString stringWithFormat:@"%@dispatchM!sendToUser.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/dispatchM!sendToUser.do"    //线索派发接口
#define kInterface_ClueDist_List    [NSString stringWithFormat:@"%@dispatchM!getKeysList.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/dispatchM!getKeysList.do"   // 查询可派单线索列表接口
#define kInterface_ClueDist_Detail  [NSString stringWithFormat:@"%@dispatchM!getKeyDetail.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/dispatchM!getKeyDetail.do"  // 查询线索详情接口
#define kInterface_ClueDist_Dept    [NSString stringWithFormat:@"%@dispatchM!getDeptTree.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/dispatchM!getDeptTree.do"   // 派发线索接口1，获得管理的部门
#define kInterface_ClueDist_User    [NSString stringWithFormat:@"%@dispatchM!getDeptUsers.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/dispatchM!getDeptUsers.do"  // 派发线索接口2，获得有部门权限的用户

// 稿件接口.

#define kFlag_Contri_List           1
#define kFlag_Contri_Detail         2
#define kFlag_Contri_Add            3
#define kFlag_Contri_Update         4
#define kFlag_Contri_Delete         5
#define kFlag_Contri_Submit         6
#define kFlag_Contri_Resume         7
#define kFlag_Contri_Remove         8
#define kFlag_Contri_AppList        9
#define kFlag_Contri_Approve        10
#define kFlag_Contri_Upload         11
#define kFlag_Contri_Download       12
#define kFlag_Contri_Add_Approve    13
#define KFlag_Contri_Get_Workflow   14
#define kFlag_Contri_Get_Cycle_List 15
#define kFlag_Contri_Get_Edit_List  16
#define kFlag_Contri_Get_App_Workflow   17
#define kFlag_Contri_Send_Weibo     18
#define kFlag_Contri_Approve_Status 19
#define KFlag_Contri_Delete_Attach  20
#define kFlag_Contri_Get_Complet_List   21

#define kInterface_Contri_List          [NSString stringWithFormat:@"%@contriM!getList_pass.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!getList_pass.do"        // 查询稿件列表接口
#define kInterface_Contri_Detail        [NSString stringWithFormat:@"%@contriM!getContriDetail.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!getContriDetail.do"     // 查询稿件详情接口
#define kInterface_Contri_Add           [NSString stringWithFormat:@"%@contriM!submit_pass.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!submit_pass.do"         // 增加稿件接口
#define kInterface_Contri_Update        [NSString stringWithFormat:@"%@contriM!update_pass.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!update_pass.do"         // 修改稿件接口
#define kInterface_Contri_Delete        [NSString stringWithFormat:@"%@contriM!removetocycle.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!removetocycle.do"       // 删除稿件到回收站接口
#define kInterface_Contri_Submit        [NSString stringWithFormat:@"%@contriM!submitApprove.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!submitApprove.do"       // 提交稿件接口
#define kInterface_Contri_Resume        [NSString stringWithFormat:@"%@contriM!rebackById.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!rebackById.do"          // 恢复回收站稿件接口
#define kInterface_Contri_Remove        [NSString stringWithFormat:@"%@contriM!removeById.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!removeById.do"          // 彻底删除回收站稿件接口
#define kInterface_Contri_AppList       [NSString stringWithFormat:@"%@contriM!getAppList_pass.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!getAppList_pass.do"     // 查询待审批稿件列表接口
#define kInterface_Contri_Approve       [NSString stringWithFormat:@"%@contriM!submitUpdateStatus.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!submitUpdateStatus.do"  // 稿件审核接口
#define kInterface_Contri_Upload        [NSString stringWithFormat:@"%@contriM!submitUpdateStatus.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!submitUpdateStatus.do"  // 附件上传接口
#define kInterface_Contri_Download      [NSString stringWithFormat:@"%@contriM!downloadFile.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!downloadFile.do"        // 附件下载接口
#define kInterface_Contri_Add_Approve   [NSString stringWithFormat:@"%@contriM!submitApprove.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!submitApprove.do"       // 
#define kInterface_Contri_Get_Workflow  [NSString stringWithFormat:@"%@contriM!getworkflowInit.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!getworkflowInit.do"
#define kInterface_Contri_Get_Cycle_List [NSString stringWithFormat:@"%@contriM!getCycleList_pass.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!getCycleList_pass.do"   // 获取回收站列表
#define kInterface_Contri_Get_Edit_List [NSString stringWithFormat:@"%@contriM!getEditCanopt.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!getEditCanopt.do"       // 获取可编辑状态的稿件列表
#define kInterface_Contri_Get_App_Workflow  [NSString stringWithFormat:@"%@contriM!getworkflowapp.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!getworkflowapp.do"
#define kInterface_Contri_Send_Weibo    [NSString stringWithFormat:@"%@contriM!sendWeibo.do", kServer_URL, nil]
//@"http://hfhuadi.vicp.cc:8080/editmobile/mobile/contriM!sendWeibo.do"
#define kInterface_Contri_Approve_Status [NSString stringWithFormat:@"%@contriM!submitApprovalStatus.do", kServer_URL, nil]
#define KInterface_Contri_Delete_Attach [NSString stringWithFormat:@"%@contriM!deleteFile.do", kServer_URL, nil]
#define KInterface_Contri_Get_Complet_List [NSString stringWithFormat:@"%@contriM!getCompletList.do", kServer_URL, nil]
