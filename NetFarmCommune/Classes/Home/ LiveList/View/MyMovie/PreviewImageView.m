//
//  PreviewImageView.m
//  NetFarmCommune
//
//  Created by manager on 2017/10/19.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "PreviewImageView.h"



@interface PreviewImageView()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@end

@implementation PreviewImageView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
    
}

-(void)initiaInterface{
    _headImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_headImageBtn setImage:[UIImage imageNamed:@"占位图"] forState:UIControlStateNormal];
    [_headImageBtn addTarget:self action:@selector(headImageBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_headImageBtn];
}

-(void)headImageBtn:(UIButton*)sender{
    
    
    
}
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1000) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        else {
            if (buttonIndex == 2) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        

    }
}

@end
