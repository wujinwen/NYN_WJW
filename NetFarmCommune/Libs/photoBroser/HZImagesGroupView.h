//
//  HZImagesGroupView.h
//  photoBrowser
//
//  Created by huangzhenyu on 15/6/23.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZImagesGroupView : UIView
@property (nonatomic, strong) NSArray *photoItemArray;
/**
 *  自身的高度
 */
- (CGFloat )getSelfHeight;
/**
 *  根据传入的index不同 来设置不同的浏览器类型 0：9宫格  1：上下排列
 *
 *  @param index
 *
 *  @return 
 */
- (CGFloat)getSelfWideth;
- (instancetype)initWithFrame:(CGRect)frame WithIndex:(NSInteger)index;

@end
