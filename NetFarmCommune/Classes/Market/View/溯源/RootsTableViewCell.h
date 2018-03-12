//
//  RootsTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2018/1/17.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootsTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView * headImageView;


@property(nonatomic,strong)UILabel * farmLabel;//农场名

@property(nonatomic,strong)UILabel * timeLabel;//时间


@property(nonatomic,strong)UILabel * messegeLabel;//农场说明

@property(nonatomic,strong)UILabel * peopleLabel;//执行人

/**
 图片数组
 */
@property (nonatomic, strong) NSArray * picArr;

@property (nonatomic, assign) CGSize size;



@end
