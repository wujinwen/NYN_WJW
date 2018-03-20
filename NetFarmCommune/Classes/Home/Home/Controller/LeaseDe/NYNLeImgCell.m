//
//  NYNLeImgCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/3/19.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "NYNLeImgCell.h"

@implementation NYNLeImgCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initaInterface];
        
    }
    return self;
    
}

-(void)initaInterface{
    SDCycleScrollView *bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(180)) delegate:self placeholderImage:PlaceImage];
    //    bannerScrollView.imageURLStringsGroup = [NSArray arrayWithArray:_iamgeArr];
    self.bannerScrollView = bannerScrollView;
    bannerScrollView.delegate = self;
    [self addSubview:bannerScrollView];
    self.bannerScrollView.localizationImageNamesGroup = @[@"占位图",@"占位图"];//    self.bannerScrollView.imageURLStringsGroup = [NSArray arrayWithArray:dic];
    
}

-(void)setDataDit:(NSDictionary *)dataDit{
    _bannerScrollView.imageURLStringsGroup = @[[NSString jsonImg:dataDit[@"images"]]];
}

@end
