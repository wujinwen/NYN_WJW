//
//  RefundProductOneCell.h
//  NetFarmCommune
//
//  Created by manager on 2018/2/5.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMDropDownMenu.h"


typedef void(^selectBlock)(NSInteger selectIndex,NSInteger idnexpath);

typedef void(^moneyBlock)(NSString* textfieldText);

@protocol RefundProductOneCellDelagate<NSObject>

-(void)selectIndexpath:(NSInteger)indexPath;
//cell高度需要改变
- (void)cellWillChange:(BOOL)isopen height:(CGFloat)height index:(NSInteger)index;

@end


@interface RefundProductOneCell : UITableViewCell

@property(nonatomic,strong)UITextField * nameTextF;

@property(nonatomic,strong)UILabel * headLabel;




@property(nonatomic,strong)NSArray * dmArray2;

@property(nonatomic,weak)id<RefundProductOneCellDelagate>delaget;

@property(nonatomic,assign)NSInteger indexPath;
@property(nonatomic,strong) DMDropDownMenu * dm2;

@property(nonatomic, copy) selectBlock selectBlock;
@property(nonatomic, copy) moneyBlock moneyBlock;

@end

