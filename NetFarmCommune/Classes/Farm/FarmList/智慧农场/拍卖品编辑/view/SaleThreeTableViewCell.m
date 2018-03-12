//
//  SaleThreeTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/11/24.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "SaleThreeTableViewCell.h"
#import "NYNFarmChooseButton.h"
#import <Masonry/Masonry.h>

@interface SaleThreeTableViewCell()

@property(nonatomic,strong)UILabel * jingyingLabel;//经营业务

@property(nonatomic,strong)UILabel * zhuyingLabel;//主营业务label

@property(nonatomic,strong)UILabel * farmLabel;//农场星级

@property(nonatomic,strong)UILabel * businessLabel;//主营业务

@property(nonatomic,strong)UIImageView * startImageView;//等级





@end


@implementation SaleThreeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initiaInterface];
        
    }
    return self;
    
    
}


-(void)initiaInterface{
    
    [self.contentView addSubview:self.jingyingLabel];
    [self.contentView addSubview:self.zhuyingLabel];
    [self.contentView addSubview:self.farmLabel];
    [self.contentView addSubview:self.businessLabel];

    [self.jingyingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(9);
        make.width.mas_offset(JZWITH(90));
        make.height.mas_offset(JZWITH(40));
        
    }];
    
    [self.farmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(9);
        make.width.mas_offset(JZWITH(90));
        make.height.mas_offset(JZWITH(40));
        make.bottom.mas_offset(-10);
        
        
    }];
    [self.zhuyingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(9);
        make.width.mas_offset(JZWITH(90));
        make.height.mas_offset(JZWITH(40));
         make.bottom.equalTo(self.farmLabel.mas_top).offset(-10);
    }];
    
    
    
    
        for (int i = 0; i < 5; i++) {
            self.startImageView= [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH- JZWITH(60) + JZWITH(5) + (JZWITH(10) + JZWITH(3)) * i, self.frame.size.height-20, JZWITH(10), JZHEIGHT(10))];
           self.startImageView.image = Imaged(@"farm_icon_grade1");
//            starImageView.image = (i < _lightStarCount ?  Imaged(@"farm_icon_grade1") : Imaged(@"farm_icon_grade2")) ;
           [self.contentView addSubview:self.startImageView];
        }
    
    
    
//    for (int i = 0; i < 5; i++) {
//        UIImageView *starImageView = [[UIImageView alloc]initWithFrame:CGRectMake(starLabel.right + JZWITH(5) + (JZWITH(10) + JZWITH(3)) * i, JZHEIGHT(8), JZWITH(10), JZHEIGHT(10))];
//        starImageView.image = (i < _lightStarCount ?  Imaged(@"farm_icon_grade1") : Imaged(@"farm_icon_grade2")) ;
//        [self addSubview:starImageView];
//    }
    
    NSArray *titles = @[@"种植",@"养殖",@"农产品",@"娱乐"];
    
    //每排三个
    for (int i = 0; i<titles.count; i++) {
        NYNFarmChooseButton * farmBtn = [[NYNFarmChooseButton alloc]init];
        farmBtn.textLabel.text = titles[i];
        farmBtn.hidden=YES;
        farmBtn.picImageView.image = Imaged(@"farm_icon_notselected2");
        [self addSubview:farmBtn];
    }
    
}

-(UILabel *)jingyingLabel{
    if (!_jingyingLabel) {
        _jingyingLabel = [[UILabel alloc]init];
        _jingyingLabel.text=@"经营业务";
        _jingyingLabel.textColor = [UIColor blackColor];
        _jingyingLabel.font =[UIFont systemFontOfSize:16];
        
    }
    return _jingyingLabel;
    
}

-(UILabel *)farmLabel{
    if (!_farmLabel) {
        _farmLabel = [[UILabel alloc]init];
        _farmLabel.text=@"农场星级";
        _farmLabel.textColor =[UIColor blackColor];
        _farmLabel.font =[UIFont systemFontOfSize:16];
    }
    return _farmLabel;
    
}

-(UILabel *)zhuyingLabel{
    if (!_zhuyingLabel) {
        _zhuyingLabel = [[UILabel alloc]init];
        _zhuyingLabel.text=@"主营业务";
        _zhuyingLabel.textColor =[UIColor blackColor];
        _zhuyingLabel.font =[UIFont systemFontOfSize:16];
    }
    return _zhuyingLabel;
    
}
-(UILabel *)businessLabel{
    if (!_businessLabel) {
        _businessLabel=[[UILabel alloc]init];
        _businessLabel.text=@"种植";
        _businessLabel.textColor =[UIColor blackColor];
        _businessLabel.font =[UIFont systemFontOfSize:14];
    }
    return _businessLabel;
    
    
}
-(UIImageView *)startImageView{
    if (!_startImageView) {
        _startImageView =[[UIImageView alloc]init];
        
        
        
    }
    return _startImageView;
    
}
@end
