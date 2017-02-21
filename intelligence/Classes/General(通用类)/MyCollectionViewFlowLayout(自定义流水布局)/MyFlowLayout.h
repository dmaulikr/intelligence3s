//
//  MyFlowLayout.h
//  NoarterClient
//
//  Created by whj on 14/12/31.
//  Copyright (c) 2014年 whj. All rights reserved.
//
/**
 * 自定义流水布局 该类只可以实现 九宫格 大小相等的布局。
 */
//#import <UIKit/UIKit.h>


@interface MyFlowLayout : UICollectionViewFlowLayout
/** 要布局的列数*/
@property(nonatomic,assign)int numberOfColumns;
/** 行间距*/
@property(nonatomic,assign)CGFloat lineSpace;
/** 列间距*/
@property(nonatomic,assign)CGFloat columnsSpace;

/** section 的 上 左 下 右 边 ：top, left, bottom, right */
@property(nonatomic,assign)UIEdgeInsets sectionInsert;

/** 宽高比例*/
@property(nonatomic,assign)CGSize scal;

@end
