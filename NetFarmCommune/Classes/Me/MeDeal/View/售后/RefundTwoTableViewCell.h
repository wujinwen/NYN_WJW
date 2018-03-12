//
//  RefundTwoTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2018/2/5.
//  Copyright © 2018年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^refuseBlock)(NSString * text);

@interface RefundTwoTableViewCell : UITableViewCell<UITextViewDelegate>

@property(nonatomic,strong)UITextView * textView;

@property(nonatomic,strong)UILabel * headLabel;

@property(nonatomic,copy)refuseBlock  refuseBlock;
@end
