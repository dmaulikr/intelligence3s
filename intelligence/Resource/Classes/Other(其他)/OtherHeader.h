//
//  OtherHeader.h
//  智能风场管理
//
//  Created by 光耀 on 16/7/21.
//  Copyright © 2016年  刘向东. All rights reserved.
//

#ifndef OtherHeader_h
#define OtherHeader_h

#import "MBProgressHUD.h"
#import "MBProgressHUD+Add.h"
#import "SVProgressHUD.h"


#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

/**
 *  HUD自动隐藏文字
 *
 */
#define HUDNormal(msg) {MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];\
hud.mode = MBProgressHUDModeText;\
hud.removeFromSuperViewOnHide = YES;\
hud.margin = 15;\
hud.minShowTime = 1;\
hud.detailsLabelText = msg;\
hud.animationType = MBProgressHUDAnimationFade;\
hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15];\
[hud hide:YES];\
}
/**
 *  HUD自动隐藏菊花
 *
 */
#define HUDJuHua(msg) {MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];\
hud.mode = MBProgressHUDModeIndeterminate;\
hud.minShowTime=1;\
hud.detailsLabelText= msg;\
hud.animationType = MBProgressHUDAnimationFade;\
hud.detailsLabelFont = [UIFont systemFontOfSize:15];\
[hud hide:YES];\
}
/**
 *  HUD菊花不自动隐藏
 *
 */
#define HUDJuHuaNoStop(msg)    {MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];\
hud.detailsLabelText = msg;\
hud.animationType = MBProgressHUDAnimationFade;\
hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15];\
hud.mode = MBProgressHUDModeIndeterminate;}

/**
 *  HUD不自动隐藏
 *
 */
#define HUDNoStop(msg)    {MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];\
hud.detailsLabelText = msg;\
hud.animationType = MBProgressHUDAnimationFade;\
hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15];\
hud.margin = 15;\
hud.mode = MBProgressHUDModeText;}


/**
 *  HUD隐藏
 *
 */
#define HUDStop [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

//SVHUD 配置
#define HUDSetting { \
[SVProgressHUD setBackgroundColor:rgba(0, 0, 0, .7f)]; \
[SVProgressHUD setForegroundColor:[UIColor whiteColor]]; \
[SVProgressHUD setFont:[UIFont systemFontOfSize:15.0f]]; \
[SVProgressHUD setRingThickness:2.5f]; \
[SVProgressHUD setCornerRadius:4.0f]; \
[SVProgressHUD setDuration:1.5]; \
}
/**
 *  SVHUD 展示 默认隐藏
 *
 */
#define SVHUD_Normal(meg)   { \
HUDSetting;\
[SVProgressHUD showWithStatus:meg];\
[SVProgressHUD dismissAfterDelay:1];\
}
/**
 *  SVHUD 展示 默认不隐藏
 *
 */
#define SVHUD_NO_Stop(meg) { \
HUDSetting \
[SVProgressHUD showWithStatus:meg];\
}
/**
 *  SVHUD 隐藏
 *
 */
#define SVHUD_Stop [SVProgressHUD dismiss];


/**
 *  SVHUD 请求失败失败
 */
#define SVHUD_ERROR(msg) { \
HUDSetting \
[SVProgressHUD showErrorWithStatus:msg]; \
}
/**
 *  SVHUD 请求成功
 */
#define SVHUD_SUCCESS(msg) { \
HUDSetting \
[SVProgressHUD showSuccessWithStatus:msg]; \
}

/**
 *  SVHUD 提示
 */
#define SVHUD_HINT(msg) { \
HUDSetting \
[SVProgressHUD showInfoWithStatus:msg]; \
}
#define SVHUD_PROGRESS(progress,msg) { \
HUDSetting \
[SVProgressHUD showProgress:progress status:msg maskType:SVProgressHUDMaskTypeNone]; \
}
//本地存储的密码key
#define PASSWORLDINUSERDEFAULT @"passwrd"
#define USERDEFAULT [NSUserDefaults standardUserDefaults]
#define ALERT_MSG(title,msg)\
{\
UIAlertView *_alert=[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]; \
_alert.transform=CGAffineTransformMakeTranslation(0, 80); \
[_alert show]; \
}




#endif /* OtherHeader_h */
