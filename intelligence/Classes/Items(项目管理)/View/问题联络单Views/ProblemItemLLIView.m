//
//  ProblemItemLLIView.m
//  intelligence
//
//  Created by  on 16/8/7.
//  Copyright © 2016年 guangyao. All rights reserved.
//
#import "ProblemItemLLIView.h"

@interface ProblemItemLLIView ()
{
    UILabel *redmark;
    UIView *bottomLine;
}

@end

@implementation ProblemItemLLIView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setType:(ProblemItemLLIViewType)type{
    _type = type;
    switch (type) {
        case ProblemItemTypeDefaultLT:{
            [self createTitleLabelHiddenRedMark:YES];
            [self createContentTextField];
            [self createBottomLine];
        }break;
        case ProblemItemTypeDefaultLV:{
            [self createTitleLabelHiddenRedMark:YES];
            [self createContentTextView];
            [self createBottomLine];
        }break;
        case ProblemItemTypeDefaultLL:{
            [self createTitleLabelHiddenRedMark:YES];
            [self createContentLabel];
            [self createBottomLine];
        }break;
        case ProblemItemTypeDefaultLLI:{
            [self createTitleLabelHiddenRedMark:YES];
            [self createRightImageView];
            [self createBottomLine];
        }break;
        case ProblemDetailsTypeMustLL:{
            [self createTitleLabelHiddenRedMark:NO];
            [self createContentLabel];
            [self createBottomLine];
        }break;
        case ProblemDetailsTypeMustLLI:{
            [self createTitleLabelHiddenRedMark:NO];
            [self createRightImageView];
            [self createBottomLine];
        }break;
            
        default:
            break;
    }
}

- (void)createRedMark:(BOOL)hidden{
    if (hidden) {
        return;
    }
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
}

- (void)createTitleLabelHiddenRedMark:(BOOL)hidden{
    self.titleLabel = [[UILabel alloc] init];
//    self.titleLabel.text = @"占位占位";
    self.titleLabel.font = [UIFont systemFontOfSize:16.0];
    self.titleLabel.numberOfLines = 0;
    [self addSubview:self.titleLabel];
    if (self.type==ProblemItemTypeDefaultLV) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top).offset(10);
            make.centerY.equalTo(self.mas_centerY).offset(0);
            make.width.mas_equalTo(120);
        }];
    }
    else
    {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(10);
//        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.width.mas_equalTo(120);
    }];
    }
    [self createRedMark:hidden];
}

- (void)createContentLabel{
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentLabelTap:)];
    [self.contentLabel addGestureRecognizer:tap];
    self.contentLabel.text = @"暂无数据";
    self.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
    self.contentLabel.font = [UIFont systemFontOfSize:16.0];
    self.contentLabel.numberOfLines = 0;
    [self addSubview:self.contentLabel];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
}

- (void)createContentTextField{
    self.contentTextField = [[UITextField alloc] init];
    self.contentTextField.placeholder = @"暂无数据";
//    self.contentTextField.textColor = UIColorFromRGB(0xCBCBCF);
    self.contentTextField.font = [UIFont systemFontOfSize:16.0];
    [self addSubview:self.contentTextField];
    [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
        make.top.equalTo(self.titleLabel.mas_top);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
}
-(void)createContentTextView
{
    self.contentTextView = [[UITextView alloc] init];
    //    self.contentTextField.textColor = UIColorFromRGB(0xCBCBCF);
    self.contentTextView.font = [UIFont systemFontOfSize:16.0];
    self.contentTextView.contentMode=UIViewContentModeTop;
    [self addSubview:self.contentTextView];
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
        make.top.equalTo(self.titleLabel.mas_top);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
}
- (void)createRightImageView{
    self.rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more_next_icon"]];
    self.rightImageView.contentMode = UIViewContentModeCenter;
    
    [self addSubview:self.rightImageView];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentLabelTap:)];
    [self.contentLabel addGestureRecognizer:tap];
    self.contentLabel.text = @"暂无数据";
    self.contentLabel.textColor = UIColorFromRGB(0xCBCBCF);
    self.contentLabel.font = [UIFont systemFontOfSize:16.0];
    self.contentLabel.numberOfLines = 0;
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.rightImageView.mas_left).offset(5);
    }];
}

- (void)createBottomLine{
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

- (void)contentLabelTap:(UIGestureRecognizer *)sender{
    
    if (self.executeTapContentLabel) {
        self.executeTapContentLabel();
    }
}

- (void)setIsend:(BOOL)isend{
    _isend = isend;
    if (_isend) {
        bottomLine.hidden = YES;
    }
}

+ (instancetype)showXibView{
    return [[[NSBundle mainBundle] loadNibNamed:@"ProblemItemLLIView" owner:nil options:nil] lastObject];
}

@end
