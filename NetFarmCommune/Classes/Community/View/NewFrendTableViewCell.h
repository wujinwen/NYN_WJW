//
//  NewFrendTableViewCell.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/9.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewFriendModel.h"

@protocol friendRequsetDlegate <NSObject>

//- (void)friendRequsetRequse:(UIButton*)btn  userId:(NSString*)userId;
//- (void)friendAgreeRequse:(UIButton*)btn  userId:(NSString*)userId;


@end



@interface NewFrendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property(nonatomic,strong)NewFriendModel * frinedModel;
@property (weak, nonatomic) IBOutlet UIButton *refusedBtn;//拒绝

@property (weak, nonatomic) IBOutlet UIButton *agereeBtn;//同意

@property (weak, nonatomic) IBOutlet UIButton *stateBtn;//状态
@property (weak, nonatomic) IBOutlet UILabel *agelabel;

@property (nonatomic, weak) id<friendRequsetDlegate> delegate;


@end
