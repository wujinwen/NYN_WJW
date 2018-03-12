//
//  RootsTableViewCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/1/17.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "RootsTableViewCell.h"
#import "PicCollectionViewCell.h"
#import <Masonry/Masonry.h>
@interface RootsTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView * collectionView;

/**
 要显示图片个数
 */
@property (nonatomic, assign) NSInteger cellCount;

@end
static NSString * CellIdentifier = @"cell";

@implementation RootsTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initiaInterface];
        
    }
    return self;
    
}

-(void)initiaInterface{
    
    self.size = CGSizeMake(10, 10);
    self.cellCount = 0;
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(40);
        make.height.mas_equalTo(0);
        make.right.equalTo(self.contentView).offset(-20);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    UIImageView * roundView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 12, 12)];
//    roundView.backgroundColor = [UIColor colorWithHexString:@"9ECC5B"];
    roundView.image = [UIImage imageNamed:@"quan"];
    [self addSubview:roundView];
    roundView.layer.cornerRadius=12/2;
    roundView.clipsToBounds=YES;

    
    UIView * lineLabel = [[UIView alloc]init];
    lineLabel.backgroundColor = [UIColor colorWithRed:176/255.0 green:176/255.0 blue:176/255.0 alpha:1];
    [self addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.width.mas_offset(1);
        make.top.mas_offset(JZWITH(27));
        make.bottom.mas_offset(0);
    }];
    
    
    
    [self addSubview:self.headImageView];
    [self addSubview:self.farmLabel];
    [self addSubview:self.messegeLabel];
    
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(roundView.mas_right).offset(JZWITH(20));
        make.width.height.mas_offset(JZWITH(60));
        make.top.mas_offset(JZWITH(18));

    }];
    self.headImageView.layer.cornerRadius = 60/2;
    self.headImageView.clipsToBounds = YES;
    
    [self.farmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(JZWITH(20));
        make.width.height.mas_offset(60);
        make.top.mas_offset(JZWITH(18));
        
    }];
    



    
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.width.mas_offset(90);
        make.height.mas_offset(30);
        
        make.top.mas_offset(JZWITH(27));
        
    }];
    

    [self addSubview:self.peopleLabel];
    [self.peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.width.mas_offset(120);
        make.top.equalTo(_timeLabel.mas_bottom).offset(10);
        ;
    }];
    
    
}


#pragma mark--UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cellCount;
    
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    PicCollectionViewCell * cell = [[PicCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
      PicCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    [cell.imageView sd_setImageWithURL:_picArr[indexPath.row] placeholderImage:[UIImage imageNamed:@"占位图"]];
    
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return self.size;
}


-(void)setPicArr:(NSArray *)picArr {
    if ([_picArr isEqualToArray:picArr]) {
        return;
    }
    _picArr = picArr;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger count = _picArr.count;
        if (count < 1) {
            //没有图片就隐藏collection
            self.collectionView.hidden = YES;
            self.cellCount = 0;
            [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(40);
                make.height.mas_equalTo(0);
                make.right.equalTo(self.contentView).offset(-20);
                make.bottom.equalTo(self.contentView).offset(-10);
            }];
        }else if (count <= 9) {
            //1 ~ 9张,有多少显示多少
            self.cellCount = count;
            [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(40);
                make.height.mas_equalTo((self.cellCount<=3) ? self.size.height : ((self.cellCount<=6) ? self.size.height*2 +10: self.size.height*3+10*2));
                make.right.equalTo(self.contentView).offset(-20);
                make.bottom.equalTo(self.contentView).offset(-10);
            }];
        }else {
            // 大于 9 张只显示9张
            self.cellCount = 9;
            [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(40);
                make.height.mas_equalTo(3*self.size.height+10*2);
                make.right.equalTo(self.contentView).offset(-20);
                make.bottom.equalTo(self.contentView).offset(-10);
            }];
        }
        
        [self.collectionView reloadData];
    });
    

    

}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
        //        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];//设置其布局方向
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//设置其边界
        flowLayout.minimumLineSpacing = 10;//水平间隔
        flowLayout.minimumInteritemSpacing = 10;//竖直间隔
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
        flowLayout.itemSize = CGSizeMake(SCREENWIDTH/4, ( SCREENHEIGHT/3- SCREENHEIGHT/18)/2);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollEnabled =NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[PicCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
        
    }
    return _collectionView;
}



-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView =[[UIImageView alloc]init];
        _headImageView.image = [UIImage imageNamed:@"占位图"];
    }
    return _headImageView;
    
}

-(UILabel *)farmLabel{
    if (!_farmLabel) {
        _farmLabel = [[UILabel alloc]init];
        _farmLabel.textColor = [UIColor blackColor];
        _farmLabel.text =@"农场";
        _farmLabel.font=[UIFont systemFontOfSize:14];
    }
    return _farmLabel;
    
}

-(UILabel *)messegeLabel{
    if (!_messegeLabel) {
        _messegeLabel = [[UILabel alloc]init];
        _messegeLabel.text=@"播种";
        _messegeLabel.textColor=[UIColor blackColor];
        
        
    }
    return _messegeLabel;
    
}
-(UILabel *)peopleLabel{
    if (!_peopleLabel) {
        _peopleLabel=[[UILabel alloc]init];
        _peopleLabel.textColor = [UIColor blackColor];
        _peopleLabel.text=@"执行人:李德贵";
         _peopleLabel.font=[UIFont systemFontOfSize:14];
    }
    return _peopleLabel;
    
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor=[UIColor darkGrayColor];
        _timeLabel.font=[UIFont systemFontOfSize:12];
        _timeLabel.text=@"2017-2-2";
    }
    return _timeLabel;
    
}

@end
