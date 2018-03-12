//
//  NYNDetailContentTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/8.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNDetailContentTableViewCell.h"
#import "HZPhotoItemModel.h"

@implementation NYNDetailContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(10), JZHEIGHT(10), JZWITH(31), JZHEIGHT(31))];
    headerImageView.image = PlaceImage;
    headerImageView.layer.cornerRadius = JZWITH(15.5);
    headerImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:headerImageView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(headerImageView.right + JZWITH(10), JZHEIGHT(18), JZWITH(100), JZHEIGHT(14))];
    nameLabel.text = @"关键词";
    nameLabel.font = JZFont(14);
    nameLabel.textColor = Color383938;
    [self.contentView addSubview:nameLabel];
    
    
    NYNStarsView *starView = [NYNStarsView shareStarsWith:4 with:CGRectMake(nameLabel.right + JZWITH(10), nameLabel.top, JZWITH(100),nameLabel.height)];
    [self.contentView addSubview:starView];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(10 + 100), JZHEIGHT(18.5), JZWITH(100), JZHEIGHT(10))];
    timeLabel.font = JZFont(9);
    timeLabel.textColor = Color888888;
    timeLabel.text = @"2017-4-19";
    timeLabel.textAlignment = 2;
    [self.contentView addSubview:timeLabel];
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(JZHEIGHT(50), JZHEIGHT(46), JZWITH(312), JZHEIGHT(30))];
    textLabel.text = @"智慧农场真的是不错啊，自己种植的蔬菜，吃起来味道 都不一样，完全无添加";
    textLabel.font = JZFont(13);
    textLabel.textColor = Color686868;
    [self.contentView addSubview:textLabel];
    
    

    NSArray *ar = @[@"http://img.97hgo.com/tb/main/575e996bnc22be661.jpg",@"http://img.97hgo.com/tb/main/21071f5f54tb2bd5xx___125114367.jpg",@"http://img.97hgo.com/tb/main/t2gbnfxg4axxxxxxxx_!!125114367.jpg"];
    
    if (ar.count > 0) {
        // 初始化相册
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(textLabel.left, textLabel.bottom + JZHEIGHT(5), textLabel.width, JZHEIGHT(96))];
        [self.contentView addSubview:backView];
        
        HZImagesGroupView *imagesGroupView = [[HZImagesGroupView alloc] initWithFrame:CGRectZero WithIndex:2];
        NSMutableArray *temp = [NSMutableArray array];
        self.imagesGroupView = imagesGroupView;
        
        for (int i = 0; i < ar.count; i ++) {
            HZPhotoItemModel *model = [[HZPhotoItemModel alloc]init];
            model.thumbnail_pic = [NSString stringWithFormat:@"%@",ar[i]];
            [temp addObject:model];
        }
        
        imagesGroupView.photoItemArray = [NSArray arrayWithArray:temp];
        // 设置图片的容器的约束
        //        self.imagebackheight.constant = [imagesGroupView getSelfHeight];
        //        self.imageViewsH = [imagesGroupView getSelfHeight];
        [backView addSubview:imagesGroupView];
    }
    

    
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(201)- 0.5, SCREENWIDTH,  0.5)];
    lineView.backgroundColor = Colore3e3e3;
    [self.contentView addSubview:lineView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
