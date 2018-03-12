//
//  RefundtProductThreeCell.m
//  NetFarmCommune
//
//  Created by manager on 2018/2/5.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import "RefundtProductThreeCell.h"

#import "NYNAlbumPicsCollectionCell.h"

@interface RefundtProductThreeCell()<UICollectionViewDelegate,UICollectionViewDataSource>




@property (strong, nonatomic) UIActionSheet *actionSheet;
@end

@implementation RefundtProductThreeCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initaInterface];
        
    }
    return self;
    
}

-(void)initaInterface{
    [self.contentView addSubview:self.headLabel];
    
    
       [self.contentView addSubview:self.albumCollectionView];
      [self.albumCollectionView registerClass:[NYNAlbumPicsCollectionCell class] forCellWithReuseIdentifier:@"cell"];

    
    
    
}


#pragma markk--UICollectionViewDelegate,UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _picsArr.count+1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NYNAlbumPicsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row == _picsArr.count) {
         cell.picImgeViewW.image = Imaged(@"picCamera");
       
        
    }else{
        cell.picImgeView.image = _picsArr[indexPath.row];
        cell.picImgeViewW.image =_picsArr[indexPath.row];
        
    }
     cell.detelImageView.hidden=YES;
     cell.detelImageViewW.hidden=YES;
    return cell;
    
}

/** 每个cell的尺寸*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(JZWITH(70), JZHEIGHT(70));
}
/** section的margin*/
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(JZWITH(10), JZWITH(10), JZWITH(10), JZWITH(10));
    
}
/** 选中某一个cell*/
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row== _picsArr.count) {
        if (self.selectBlock) {
            self.selectBlock(indexPath);
            
        }
       
    }else{
        
        
    }
    
    
    
}



-(UILabel *)headLabel{
    if (!_headLabel) {
        _headLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, SCREENWIDTH, 40)];
        _headLabel.textColor = [UIColor blackColor];
        _headLabel.backgroundColor =  Colorededed;
        _headLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _headLabel;
    
}

-(UICollectionView *)albumCollectionView{
    if (!_albumCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        // 定义大小
        layout.itemSize = CGSizeMake(JZWITH(100), JZHEIGHT(100));
        // 设置最小行间距
        layout.minimumLineSpacing = JZWITH(10);
        // 设置垂直间距
        layout.minimumInteritemSpacing = JZHEIGHT(5);
        // 设置滚动方向（默认垂直滚动）
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _albumCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, SCREENWIDTH, 200) collectionViewLayout:layout];
        _albumCollectionView.delegate = self;
        _albumCollectionView.dataSource = self;
        _albumCollectionView.showsVerticalScrollIndicator = NO;
        _albumCollectionView.showsHorizontalScrollIndicator = YES;
        _albumCollectionView.backgroundColor = [UIColor whiteColor];
        
    }
    return _albumCollectionView;
}

-(NSMutableArray *)picsArr{
    if (!_picsArr) {
        _picsArr = [[NSMutableArray alloc]init];
        
    }
    return _picsArr;
    
}
@end
