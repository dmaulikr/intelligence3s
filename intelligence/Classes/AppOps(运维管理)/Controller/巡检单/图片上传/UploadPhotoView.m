//
//  UploadPhotoView.m
//  SettingControllerDemo
//
//  Created by  on 16/4/21.
//  Copyright © 2016年  All rights reserved.
//

#import "UploadPhotoView.h"


@implementation UploadPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _btnPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnPhoto.layer.cornerRadius = 5;
    _btnPhoto.layer.masksToBounds = YES;
    _btnPhoto.frame = CGRectMake(5, 5, self.width - 10, self.height - 10);
    [_btnPhoto setBackgroundImage:[UIImage imageNamed:@"button_addphoto"] forState:UIControlStateNormal];
    [_btnPhoto addTarget:self action:@selector(btnPhotoClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnPhoto];
    
    _btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnDelete.frame = CGRectMake(_btnPhoto.x_X + _btnPhoto.width - 10, _btnPhoto.y_Y - 10, 20, 20);
    [_btnDelete setBackgroundImage:[UIImage imageNamed:@"button_red_x"] forState:UIControlStateNormal];
    [_btnDelete addTarget:self action:@selector(btnDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnDelete];
}

- (void)judgeHideBtnDelegate{
    UIImage *img = [UIImage imageNamed:@"button_addphoto"];
    UIImage *btnImg = [_btnPhoto backgroundImageForState:UIControlStateNormal];
    if ([img isEqual:btnImg]) {
        _btnDelete.hidden = YES;
    }else{
        _btnDelete.hidden = NO;
    }
}

- (void)btnPhotoClick:(UIButton *)sender{

    if ([self.delegate respondsToSelector:@selector(UploadPhotoViewBtnPhotoClick: ishavePhoto:)]) {
        [self.delegate UploadPhotoViewBtnPhotoClick:self ishavePhoto:_btnDelete.hidden];
    }
}

- (void)btnDeleteClick:(UIButton *)sender{

    if ([self.delegate respondsToSelector:@selector(UploadPhotoViewBtnDeleteClick:)]) {
        [self.delegate UploadPhotoViewBtnDeleteClick:self];
    }
}

@end
