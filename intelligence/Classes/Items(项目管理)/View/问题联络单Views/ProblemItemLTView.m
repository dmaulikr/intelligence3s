//
//  ProblemItemLTView.m
//  intelligence
//
//  Created by  on 16/8/7.
//  Copyright © 2016年 chris. All rights reserved.
//

#import "ProblemItemLTView.h"

static CGFloat MAXText = 200;
@interface ProblemItemLTView ()<UITextViewDelegate>
{
    UILabel *redmark;
    UIView *textBottomLine;
    UIView *bottomLine;
    CGFloat textViewHeight;
    CGFloat lastScrollOffset;
}

@end

@implementation ProblemItemLTView

- (void)awakeFromNib {
    [super awakeFromNib];
    textViewHeight = 36;
}

- (void)crateUI{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0];
    self.titleLabel.numberOfLines = 0;
    [self addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(120);
    }];

    redmark = [[UILabel alloc] init];
    redmark.textColor = [UIColor redColor];
    redmark.text = @"*";
    redmark.textAlignment = NSTextAlignmentRight;
    [self addSubview:redmark];
    
    [redmark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.titleLabel.mas_left).offset(0);
        make.centerY.equalTo(self.titleLabel.mas_centerY).offset(3);
        make.height.mas_equalTo(20);
    }];
    
    textBottomLine = [[UIView alloc] init];
    textBottomLine.backgroundColor = RGBCOLOR(97, 97, 97);
    [self addSubview:textBottomLine];
    [textBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(1);
    }];
    
    self.contentText = [[UITextView alloc] init];
//    self.contentText.backgroundColor = [UIColor blueColor];
    self.contentText.font = [UIFont systemFontOfSize:16.0];
    self.contentText.delegate = self;
    [self addSubview:self.contentText];
    [self.contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(textBottomLine.mas_top).offset(0);
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(36);
    }];
    
    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.font = [UIFont systemFontOfSize:16.0];
    self.placeholderLabel.text = @"暂无数据";
    self.placeholderLabel.textColor = UIColorFromRGB(0xCBCBCF);
    [self addSubview:self.placeholderLabel];
    [self.placeholderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentText).offset(8);
        make.left.equalTo(self.contentText).offset(2);
        make.height.mas_equalTo(17);
    }];
    
    
    
    bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = UIColorFromRGB(0xE6E6E6);
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.height.mas_equalTo(1);
    }];
    
}

- (void)setType:(ProblemItemLTViewType)type{
    _type = type;
    switch (type) {
        case ProblemItemLTViewTypeDefault:{
            [self crateUI];
            bottomLine.hidden = YES;
        }break;
        case ProblemItemLTViewTypeHiddenRedMark:{
            [self crateUI];
            redmark.hidden = YES;
        }break;

            
        default:
            break;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.placeholderLabel.hidden = YES;
    textBottomLine.backgroundColor = UIColorFromRGB(0x01D401);
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    textBottomLine.backgroundColor = UIColorFromRGB(0xCBCBCF);
    if (self.contentText.text.length) {
        self.placeholderLabel.hidden = YES;
    }else{
        self.placeholderLabel.hidden = NO;
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    
    //该判断用于联想输入
    if (textView.text.length > MAXText)
    {
        // 截取前200的字符
        textView.text = [textView.text substringToIndex:MAXText];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    //fix ios7 bug (modified by 梦江宝鱼).
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        CGRect r = [textView caretRectForPosition:textView.selectedTextRange.end];
        CGFloat caretY =  MAX(r.origin.y - textView.frame.size.height + r.size.height + 8, 0);
        if (textView.contentOffset.y < caretY && r.origin.y != INFINITY) {
            textView.contentOffset = CGPointMake(0, caretY);
        }
    }
    if (textView.contentSize.height > textViewHeight) {
        textViewHeight = textView.contentSize.height;
        [self.contentText mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(textViewHeight);
        }];
        if (self.executeTextHeightChage) {
            self.executeTextHeightChage(textViewHeight);
        }
    }else if (textView.contentSize.height < textViewHeight){
        textViewHeight = textView.contentSize.height;
        [self.contentText mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(textViewHeight);
        }];
        if (self.executeTextHeightChage) {
            self.executeTextHeightChage(textViewHeight);
        }
    }

}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)setIsend:(BOOL)isend{
    _isend = isend;
    if (_isend) {
        bottomLine.hidden = YES;
    }
}

+ (instancetype)showXibView{
    return [[[NSBundle mainBundle] loadNibNamed:@"ProblemItemLTView" owner:nil options:nil] lastObject];
}

@end
