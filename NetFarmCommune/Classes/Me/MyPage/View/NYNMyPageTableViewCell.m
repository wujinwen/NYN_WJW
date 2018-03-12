//
//  NYNMyPageTableViewCell.m
//  NetFarmCommune
//
//  Created by 123 on 2017/6/15.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMyPageTableViewCell.h"

@implementation NYNMyPageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(JZWITH(10), JZHEIGHT(15), JZWITH(38), JZHEIGHT(38))];
    headerImageView.image = PlaceImage;
    headerImageView.layer.cornerRadius = JZWITH(19);
    headerImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:headerImageView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(headerImageView.right + JZWITH(10), JZHEIGHT(15), JZWITH(150), JZHEIGHT(16))];
    nameLabel.textColor = Color383938;
    nameLabel.font = JZFont(16);
    nameLabel.text = @"关键词";
    [self.contentView addSubview:nameLabel];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.left, nameLabel.bottom + JZHEIGHT(10), JZWITH(150), JZHEIGHT(10))];
    timeLabel.text = @"04-30 17:06";
    timeLabel.font = JZFont(13);
    timeLabel.textColor = Color888888;
    [self.contentView addSubview:timeLabel];
    
    UIButton *detelButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - JZWITH(30), JZHEIGHT(15), JZWITH(15), JZHEIGHT(15))];
    UIImageView *detelImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, detelButton.width, detelButton.height)];
    detelImageView.image = Imaged(@"mine_icon_delete2");
    detelImageView.userInteractionEnabled = NO;
    [detelButton addSubview:detelImageView];
    [detelButton addTarget:self action:@selector(detel) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:detelButton];
    
    UILabel *contentLB = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.left, headerImageView.bottom + JZHEIGHT(15), SCREENWIDTH - JZWITH(10) - nameLabel.left, JZHEIGHT(JZHEIGHT(60)))];
    contentLB.text = @"12点农场真的是不错啊，自己种植的蔬菜，吃起来味 道都不一样，完全无添加";
    contentLB.font = JZFont(15);
    contentLB.textColor = Color383938;
    contentLB.numberOfLines = 0;
    [self.contentView addSubview:contentLB];
    
    NSArray *ar = @[@"http://img.97hgo.com/tb/main/575e996bnc22be661.jpg",@"http://img.97hgo.com/tb/main/21071f5f54tb2bd5xx___125114367.jpg",@"http://img.97hgo.com/tb/main/t2gbnfxg4axxxxxxxx_!!125114367.jpg"];
    
    if (ar.count > 0) {
        // 初始化相册
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(nameLabel.left, contentLB.bottom + JZHEIGHT(5), contentLB.width, JZHEIGHT(96))];
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
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)detel{

}
@end
