//
//  MyLiveOneTVCell.h
//  NetFarmCommune
//
//  Created by manager on 2017/10/12.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMovieListModel.h"
@interface MyLiveOneTVCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *username;

@property (weak, nonatomic) IBOutlet UILabel *fanLabel;

@property(nonatomic,strong)MyMovieListModel * movieModel;
@property (weak, nonatomic) IBOutlet UILabel *levelLbael;

@end
