//
//  MyFlowLayout.m
//  NoarterClient
//
//  Created by whj on 14/12/31.
//  Copyright (c) 2014年 whj. All rights reserved.
//

#import "MyFlowLayout.h"

@interface MyFlowLayout()
{
    //item的宽度是
    CGFloat _itemWidth;
    CGFloat _itemHeight;
}
@end


@implementation MyFlowLayout
/**
 *  布局之前的准备
 *
 */
-(void)prepareLayout{

    [super prepareLayout];
    
    //布局的可用宽度
    CGFloat fullWidth = self.collectionView.frame.size.width-(self.sectionInsert.left+self.sectionInsert.right);
    
    //获取可用的布局空间的宽度 item可用的区域
    CGFloat avaliableSpaceExcludingPadding = fullWidth - (self.columnsSpace*(self.numberOfColumns-1));
    //item的宽度是
    _itemWidth = (avaliableSpaceExcludingPadding/self.numberOfColumns);
    _itemHeight = (_itemWidth*self.scal.height)/self.scal.width;
   
    //item 之间的 行、列间距
    self.minimumInteritemSpacing = self.columnsSpace;
    self.minimumLineSpacing = self.lineSpace;
    
     //初始化 宽高
    self.itemSize = CGSizeMake(_itemWidth, _itemHeight);
    self.sectionInset = self.sectionInsert;
}
/** 遍历属性*/
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
//     NSLog(@"UIcolectionViewLayout 的数量 == %ld",array.count);
    
    for (UICollectionViewLayoutAttributes *attr in array) {
//        NSLog(@"UIcolectionViewLayout == %@",attr);
    }
    
    
    return array;
}


@end
