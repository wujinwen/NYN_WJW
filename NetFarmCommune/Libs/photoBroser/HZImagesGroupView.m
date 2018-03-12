//
//  HZImagesGroupView.m
//  photoBrowser
//
//  Created by huangzhenyu on 15/6/23.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import "HZImagesGroupView.h"
#import "HZPhotoBrowser.h"
#import "UIButton+WebCache.h"
#import "HZPhotoItemModel.h"
#import "UIImageView+WebCache.h"

#define kImagesMargin 3.5

@interface HZImagesGroupView() <HZPhotoBrowserDelegate>

@property (nonatomic,assign)NSInteger       index;

@end

@implementation HZImagesGroupView
- (id)initWithFrame:(CGRect)frame WithIndex:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        // 清除图片缓存，便于测试
//        [[SDWebImageManager sharedManager].imageCache clearDisk];
        self.index = index;
    }
    return self;
}

- (void)setPhotoItemArray:(NSArray *)photoItemArray
{
    _photoItemArray = photoItemArray;
    [photoItemArray enumerateObjectsUsingBlock:^(HZPhotoItemModel *obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = [[UIButton alloc] init];
        
        //让图片不变形，以适应按钮宽高，按钮中图片部分内容可能看不到
        btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        btn.clipsToBounds = YES;
        //btn.backgroundColor=CHRGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256));
        
        
        ////注意  这里网络请求改成本地暂用图片
        [btn sd_setImageWithURL:[NSURL URLWithString:obj.thumbnail_pic] forState:UIControlStateNormal placeholderImage:PlaceImage options:SDWebImageRetryFailed];//placeImgTesg //"whiteplaceholder
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:obj.thumbnail_pic] forState:UIControlStateNormal placeholderImage:PlaceImage];
        
//        btn.imageView.image = Imaged(obj.thumbnail_pic);
        
        //UIImageView *imgViewTemp=[[UIImageView alloc] init];
        //imgViewTemp.frame=CGRectMake(0, 0, 0, 0);
        //[imgViewTemp sd_setImageWithURL:[NSURL URLWithString:obj.thumbnail_pic]];
        btn.tag = idx;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        //[self addSubview:imgViewTemp];
        [self addSubview:btn];
        
        
    }];
    long imageCount = self.photoItemArray.count;
    //如果总数为4个，那么每排2个，否则就是每排3个
    int perRowImageCount =3;// ((imageCount == 4) ? 2 : 3);
    CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
    int totalRowCount = ceil(imageCount / perRowImageCountF); // ((imageCount + perRowImageCount - 1) / perRowImageCount)
    if (self.index == 0) {
        
        self.frame = CGRectMake(0, 0, SCREENWIDTH-55, totalRowCount * (kImagesMargin + JZHEIGHT(85)));
    }
    
    else if(self.index==1){
        self.frame = CGRectMake(0,0, SCREENWIDTH-55-10,imageCount*(SCREENWIDTH-45));
    }else if (self.index == 2){
        int perRowImageCount =(int)imageCount;// ((imageCount == 4) ? 2 : 3);
        CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
        int totalRowCount = ceil(imageCount / perRowImageCountF);
        self.frame = CGRectMake(0, 0, 100000, totalRowCount * (0 + 80));
    }

    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    long imageCount = self.photoItemArray.count;
    
    if (self.index==0) {
        
        int perRowImageCount = 3;// ((imageCount == 4) ? 2 : 3);
        CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
        int totalRowCount = ceil(imageCount / perRowImageCountF); // ((imageCount + perRowImageCount - 1) / perRowImageCount)
        
        CGFloat w = JZWITH(85);
        CGFloat h = JZHEIGHT(85);
        
        [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
            
            long rowIndex = idx / perRowImageCount;
            int columnIndex = idx % perRowImageCount;
            CGFloat x = columnIndex * (w + kImagesMargin);
            CGFloat y = rowIndex * (h + kImagesMargin);
            btn.frame = CGRectMake(x, y, w, h);
        }];
        
        //    self.frame = CGRectMake(0, 0, 280 * LD_WITH, totalRowCount * (kImagesMargin + h));
        
    }else if(self.index == 1){
        
        CGFloat w = SCREENWIDTH-55-10;
        CGFloat h = w;
        
        [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
           
            btn.frame = CGRectMake(0,(h+10)*idx, w, h);
            
//            if (idx == 0) {
//                btn.frame = CGRectMake(0,0, w, h);
//                
//
//            }else if(idx == 1){
//                btn.frame = CGRectMake(0,h+10*CHScaleX, w, h);
//                
//            }else if(idx == 2){
//                btn.frame = CGRectMake(0, (h+10*CHScaleX)*2, w, h);
//
//            }
            
           
            
        }];

        
        
    }else if (self.index == 2){
        int perRowImageCount = (int)imageCount;// ((imageCount == 4) ? 2 : 3);
        CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
        int totalRowCount = ceil(imageCount / perRowImageCountF); // ((imageCount + perRowImageCount - 1) / perRowImageCount)
        
        CGFloat w = JZWITH(96);
        CGFloat h = JZHEIGHT(96);
        
        [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
            
            long rowIndex = idx / perRowImageCount;
            int columnIndex = idx % perRowImageCount;
            CGFloat x = columnIndex * (w + JZWITH(5));
            CGFloat y = rowIndex * (h + 0);
            btn.frame = CGRectMake(x, y, w, h);
        }];
    }
    
    
    
    

}

- (void)buttonClick:(UIButton *)button
{
//    CHLog(@"button.frame:===========%@",NSStringFromCGRect(button.frame));
    //启动图片浏览器
    HZPhotoBrowser *browserVc = [[HZPhotoBrowser alloc] init];
    browserVc.sourceImagesContainerView = self; // 原图的父控件
    browserVc.imageCount = self.photoItemArray.count; // 图片总数
    browserVc.currentImageIndex = (int)button.tag;
    browserVc.delegate = self;
    browserVc.indexNumber=self.index;
    [browserVc show];

}

- (CGFloat)getSelfHeight{
    
    return CGRectGetHeight(self.frame);
}

- (CGFloat)getSelfWideth{
    
    return CGRectGetWidth(self.frame);
}
#pragma mark - photobrowser代理方法
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [self.subviews[index] currentImage];
}

- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = [[self.photoItemArray[index] thumbnail_pic] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    return [NSURL URLWithString:urlStr];
}
@end
