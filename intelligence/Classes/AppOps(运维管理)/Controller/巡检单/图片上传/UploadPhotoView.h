//
//  UploadPhotoView.h
//  SettingControllerDemo
//
//  Created by  on 16/4/21.
//  Copyright © 2016年  All rights reserved.
//

#import <UIKit/UIKit.h>
@class UploadPhotoView;

@protocol UploadPhotoViewDelegate <NSObject>

- (void)UploadPhotoViewBtnPhotoClick:(UploadPhotoView *)photoView ishavePhoto:(BOOL)ishavePhoto;
- (void)UploadPhotoViewBtnDeleteClick:(UploadPhotoView *)photoView;

@end

@interface UploadPhotoView : UIView

@property (nonatomic, strong) UIButton *btnPhoto;
@property (nonatomic, strong) UIButton *btnDelete;
@property (nonatomic, assign) id <UploadPhotoViewDelegate> delegate;


/** 判断是否显示删除红色小按钮*/
- (void)judgeHideBtnDelegate;
@end
