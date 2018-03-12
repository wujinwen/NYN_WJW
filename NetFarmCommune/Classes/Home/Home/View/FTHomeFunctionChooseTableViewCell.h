//
//  FTHomeFunctionChooseTableViewCell.h
//  FarmerTreasure
//
//  Created by 123 on 17/4/19.
//  Copyright © 2017年 FarmerTreasure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYNLiveButton.h"

typedef void(^LIveClick)(NYNLiveButton * sender);// 这里的index是参数，我传递的是button的tag值，当然你可以自己决定传递什么参数
@interface FTHomeFunctionChooseTableViewCell : UITableViewCell
@property (nonatomic,strong) NSMutableArray *picArr;
@property (nonatomic,strong) NSMutableArray *textArr;
@property (nonatomic,strong) NYNLiveButton *btOne;
@property (nonatomic,copy) LIveClick buttonAction;


-(void)getLivePicArray:(NSMutableArray*)picArr textArray:(NSMutableArray*)textArray;

@end
