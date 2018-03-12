//
//  SXPoperTableView.m
//  生学堂
//
//  Created by shuhang on 12/11/15.
//  Copyright © 2015 王磊. All rights reserved.
//

#import "SXPoperTableView.h"
//#import "UIImageView+SXForScrollView.h"

@interface SXPoperTableView()
{
    UITableView * popTableView;
}
@end

@implementation SXPoperTableView

- ( id ) initWithFrame:(CGRect)frame
{
    if( self = [super initWithFrame:frame] )
    {
        self.backgroundColor = [UIColor whiteColor];
        
        popTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, frame.size.width, frame.size.height)];
        if ( frame.size.height > 320 ) {
            popTableView.frame = CGRectMake(0, 0, frame.size.width, 320);
            self.frame = popTableView.frame;
        }
        popTableView.delegate = self;
        popTableView.dataSource = self;
        popTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        popTableView.tag = noDisableVerticalScrollTag;
        
        popTableView.scrollEnabled = NO;
        popTableView.backgroundColor = [UIColor clearColor];
        [self addSubview:popTableView];
    }
    return self;
}

- ( void ) reloadTableView
{
    [popTableView reloadData];
    [popTableView flashScrollIndicators];
}

#pragma UITableView
- ( NSInteger ) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- ( NSInteger ) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrayData count];
}

- ( CGFloat ) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- ( UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if( !cell )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
//    cell.textLabel.textAlignment = NSTextAlignmentCenter;
//    cell.textLabel.font = JZFont(13);
//    cell.textLabel.textColor = KNaviBarTintColor;
//    cell.textLabel.text = _arrayData[ indexPath.row ];
//    cell.textLabel.textAlignment = 2;
//    
//    cell.imageView.frame = CGRectMake(15, 4, 15, 15);
//    cell.imageView.image = PlaceImage;
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 12.5, 15, 15)];
    img.image = PlaceImage;
    [cell.contentView addSubview:img];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(img.right + 15, 6, 200, 28)];
    titleLabel.text = _arrayData[ indexPath.row ];
    titleLabel.font = JZFont(12);
    titleLabel.textColor = [UIColor whiteColor];
    [cell.contentView addSubview:titleLabel];
    
    cell.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 39.5, 300, 0.5)];
    lineView.backgroundColor = [UIColor blackColor];
    [cell.contentView addSubview:lineView];
    return cell;
}

- ( void ) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if( [self.delegate respondsToSelector:@selector(clickItemAtIndex:withValue:)] )
    {
        [self.delegate clickItemAtIndex:indexPath.row withValue:_arrayData[ indexPath.row ]];
    }
}

@end
