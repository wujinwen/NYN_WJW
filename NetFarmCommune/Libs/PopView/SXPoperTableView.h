//
//  SXPoperTableView.h
//  生学堂
//
//  Created by shuhang on 12/11/15.
//  Copyright © 2015 王磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SXPoperTableViewDelegate <NSObject>

- ( void ) clickItemAtIndex : ( NSInteger ) index withValue : ( NSString * ) value;

@end

@interface SXPoperTableView : UIView<UITableViewDataSource, UITableViewDelegate>

@property( nonatomic, copy ) NSArray * arrayData;
@property( nonatomic, weak ) id< SXPoperTableViewDelegate > delegate;

- ( void ) reloadTableView;

@end
