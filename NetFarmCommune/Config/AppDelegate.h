//
//  AppDelegate.h
//  NetFarmCommune
//
//  Created by 123 on 2017/5/27.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

/**
 是否横屏
 */
@property (nonatomic, assign) BOOL isHengping;
- (void)saveContext;
@end

