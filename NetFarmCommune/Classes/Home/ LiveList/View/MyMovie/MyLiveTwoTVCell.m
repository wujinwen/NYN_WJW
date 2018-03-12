//
//  MyLiveTwoTVCell.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "MyLiveTwoTVCell.h"
#import "Masonry.h"


@interface MyLiveTwoTVCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UILabel * liveName;//直播名
@property(nonatomic,strong)UILabel * liveNumber;//直播人数
@property(nonatomic,strong)UIButton * peperBtn;//废纸篓
@property(nonatomic,strong)UILabel * timeLabel;//时间
@property(nonatomic,strong)UICollectionView * collectionview;


@end

@implementation MyLiveTwoTVCell




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initiaInterface];
        
    }
    return self;
    
}




//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NYNLiveListModel *model = self.dataArr[indexPath.row];
//
//    static NSString * CellIdentifier = @"cell";
//    //在这里注册自定义的XIBcell否则会提示找不到标示符指定的cell
//    UINib *nib = [UINib nibWithNibName:@"NYNLiveListCollectionViewCell" bundle:[NSBundle mainBundle]];
//    [collectionView registerNib:nib forCellWithReuseIdentifier:CellIdentifier];
//    NYNLiveListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//
//    [cell.cellImageView sd_setImageWithURL:[NSURL URLWithString:model.pimg]];
//    cell.titleLabel.text = model.farmTitle;
//    cell.cusetomLabel.text = model.popurlar;
    return nil;
}


-(void)initiaInterface{
    
    _liveName = [[UILabel alloc]init];
    _liveName.text = @"开直播聊天";
    _liveName.textColor = [UIColor blackColor];
    _liveName.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_liveName];
    [_liveName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(10);
        make.width.mas_offset(180);
        make.height.mas_offset(35);
        
    }];
    
    _liveNumber = [[UILabel alloc]init];
    _liveNumber.text = @"最高：152人";
    
    _liveNumber.textColor = [UIColor darkGrayColor];
    _liveNumber.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_liveNumber];
    [_liveNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(180);
        make.height.mas_offset(35);
        make.top.mas_equalTo(_liveName.mas_bottom).offset(10);
        
    }];
    
    _peperBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_peperBtn setImage:[UIImage imageNamed:@"mine_icon_delete2@2x"] forState:UIControlStateNormal];
    [self.contentView addSubview:_peperBtn];
    [_peperBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.width.mas_offset(25);
        make.height.mas_offset(30);
        make.top.mas_offset(10);
    }];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.text =@"12:30";
    _timeLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.width.mas_offset(80);
        make.height.mas_offset(30);
        make.top.mas_equalTo(_peperBtn.mas_bottom).offset(10);
        
        
    }];
    [self.contentView addSubview:self.collectionview];
    

}

-(UICollectionView *)collectionview{
    if (!_collectionview) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setItemSize:CGSizeMake(JZWITH(172), JZWITH(172))];//设置cell的尺寸
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);//设置其边界
        
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 80, SCREENWIDTH, SCREENHEIGHT - 64)collectionViewLayout:flowLayout];
        _collectionview.dataSource = self;
        _collectionview.delegate = self;
        _collectionview.backgroundColor = [UIColor clearColor];
//        [_collectionview registerClass:[NYNLiveListCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return _collectionview;
    
}
@end
