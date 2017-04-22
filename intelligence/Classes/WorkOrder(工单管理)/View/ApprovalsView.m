//
//  ApprovalsView.m
//  intelligence
//
//  Created by chris on 16/8/21.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ApprovalsView.h"
#import "ApprovalPopupSheetFrontView.h"
#import "SoapUtil.h"
#import "ApprovalPopupSheetBackView.h"
static CGFloat sheetViewHeight = 140;
static CGFloat maxWordNumber   = 100;
@interface ApprovalsView()<UITextViewDelegate>
{
    UIView *sheetView;
    BOOL isFrontView;
    UIView *bottleView;
    ApprovalPopupSheetFrontView *frontView;
    ApprovalPopupSheetBackView *backView;
}
@end
@implementation ApprovalsView

- (instancetype)initWithFrame:(CGRect)frame withNumber:(BOOL)number{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBACOLOR(10, 10, 10, 0.5);
        isFrontView = number;
        //点击手机退出
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelTapAction)];
        [self addGestureRecognizer:tap];
        [self createFrontAndBackView];
    }
    return self;
}
- (void)createFrontAndBackView{
    sheetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    sheetView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapNull)];
    [sheetView addGestureRecognizer:tap];
    [self addSubview:sheetView];
    
    frontView = [ApprovalPopupSheetFrontView showXibView];
    //通过
    [frontView.btnSure addTarget:self action:@selector(frontViewBtnSureClick:) forControlEvents:UIControlEventTouchUpInside];
    //取消
    [frontView.btnCancel addTarget:self action:@selector(frontViewBtnCancelClick:) forControlEvents:UIControlEventTouchUpInside];
    //不通过
    [frontView.noBtn addTarget:self action:@selector(backViewBtnNoClick:) forControlEvents:UIControlEventTouchUpInside];
    frontView.textView.delegate = self;
    frontView.textView.returnKeyType = UIReturnKeyDone;
    frontView.frame = CGRectMake(0, 0, frontView.width, frontView.height);
    frontView.tag = 101;
    frontView.center = sheetView.center;
    
    
    backView = [ApprovalPopupSheetBackView showXibView];
    //否
    [backView.btnSure addTarget:self action:@selector(backViewBtnSureClick:) forControlEvents:UIControlEventTouchUpInside];
    //是
    [backView.btnCancel addTarget:self action:@selector(backViewBtnCancelClick:) forControlEvents:UIControlEventTouchUpInside];
    backView.frame = CGRectMake(0, 0, backView.width, backView.height);
    backView.center = sheetView.center;
    if (isFrontView) {
       [sheetView addSubview:backView];
    }else{
        [sheetView addSubview:frontView];
    }
}

- (void)show{
    [[[UIApplication sharedApplication].windows firstObject] addSubview:self];
}

- (void)dismiss{
    __weak __typeof(&*sheetView)weakSheetView = sheetView;
    [UIView animateWithDuration:0.25 animations:^{
        weakSheetView.y_Y = ScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)cancelTapAction{
    [self dismiss];
}

- (void)tapNull{
    
}

-(void)request:(NSString *)number{
    SVHUD_NO_Stop(@"审批提交中");
    WEAKSELF
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/WFSERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop;
        if (weakSelf.CloseBlick) {
            weakSelf.CloseBlick(dic);
        }
        [self dismiss];
    };
    AccountModel *model = [AccountManager account];
    //不是新建
    NSArray *arr = @[
                     @{@"processname":_processname},
                     @{@"mboName":_mbo},
                     @{@"keyValue":_keyValue},
                     @{@"key":_key},
                     @{@"zx":number},
                     @{@"desc":frontView.textView.text},
                     @{@"loginid":model.personId},
                     ];
    
    [soap requestMethods:@"wfservicewfGoOn" withDate:arr];
    
}
-(void)requests{
    SVHUD_NO_Stop(@"启动工作流");
    WEAKSELF
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/WFSERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        SVHUD_Stop;
        if (weakSelf.CloseBlick) {
            weakSelf.CloseBlick(dic);
        }
        [self dismiss];
    };
    AccountModel *model = [AccountManager account];
    //新建
    NSArray *arr = @[
                     @{@"processname":_processname},
                     @{@"mbo":_mbo},
                     @{@"keyValue":_keyValue},
                     @{@"key":_key},
                     @{@"loginid":model.personId},
                     ];
    [soap requestMethods:@"wfservicestartWF2" withDate:arr];
    
}

//否
-(void)backViewBtnSureClick:(UIButton *)sender{
    NSLog(@"消失");
    [self dismiss];
}
//是
-(void)backViewBtnCancelClick:(UIButton *)sender{
    [self requests];
}

//不同意
- (void)backViewBtnNoClick:(UIButton *)sender{
    [self request:@"0"];
}

//通过
- (void)frontViewBtnSureClick:(UIButton *)sender{
    [frontView endEditing:YES];
    [self request:@"1"];
}
//取消
- (void)frontViewBtnCancelClick:(UIButton *)sender{
    NSLog(@"消失");
    [self dismiss];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    frontView.placeholderLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length > 1) {
        frontView.placeholderLabel.hidden = YES;
    }else{
        frontView.placeholderLabel.hidden = NO;
    }
}

/** 内容发生改变剪辑*/
- (void)textViewDidChange:(UITextView *)textView
{
    //该判断用于联想输入
    if (textView.text.length > maxWordNumber)
    {
        // 截取前500的字符
        textView.text = [textView.text substringToIndex:maxWordNumber];
    }else{
        // 显示剩余量
        //        self.LabelNumberWords.text = [NSString stringWithFormat:@"还可以输入%lu字符", maxWord - self.signatureTextView.text.length];
    }
}
/** 内容将要发生改变编辑*/
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        // 回收键盘
        [frontView endEditing:YES];
        
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    NSLog(@"当前的长度:%lu ,可以改变的长度:%lu , 需要改变的长度:%lu", (unsigned long)textView.text.length, (unsigned long)range.location, (unsigned long)text.length);
    //    当前的长度               将会改变的长度    改变的长度
    if ((textView.text.length - range.length + text.length) > maxWordNumber)
    {
        NSString *substring = [text substringToIndex:maxWordNumber - (textView.text.length - range.length)];
        NSMutableString *lastString = [textView.text mutableCopy];
        
        [lastString replaceCharactersInRange:range withString:substring];
        textView.text = [lastString copy];
        frontView.textView.text = textView.text;
        //        self.LabelNumberWords.text = [NSString stringWithFormat:@"还可以输入%lu字符", maxWord - self.signatureTextView.text.length];
        return NO;
    }else{
        return YES;
    }
}


@end

