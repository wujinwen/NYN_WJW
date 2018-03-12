//
//  NYNMeAlbumManagerViewController.h
//  NetFarmCommune
//
//  Created by 123 on 2017/8/11.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^PicBack)();
@interface NYNMeAlbumManagerViewController : BaseViewController
@property (nonatomic,copy) PicBack picBack;
@end
