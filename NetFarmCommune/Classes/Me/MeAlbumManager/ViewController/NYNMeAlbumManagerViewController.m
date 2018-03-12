//
//  NYNMeAlbumManagerViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/11.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMeAlbumManagerViewController.h"
#import "NYNAlbumPicsCollectionCell.h"
#import "NYNPicModel.h"

@interface NYNMeAlbumManagerViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) UICollectionView *albumCollectionView;

@property (nonatomic,strong) NSMutableArray *picsArr;

@property (nonatomic,assign) BOOL isEdit;

@property (nonatomic,strong) UIButton *bianJiButton;

@property (strong, nonatomic) IBOutlet UIImageView *headImage;

@property (strong, nonatomic) UIActionSheet *actionSheet;
@end

@implementation NYNMeAlbumManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"管理相册";
    
    UIButton *bianJiButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, JZWITH(40), JZHEIGHT(12))];
    self.bianJiButton = bianJiButton;
    [bianJiButton setTitle:@"编辑" forState:0];
    [bianJiButton setTitleColor:[UIColor whiteColor] forState:0];
    bianJiButton.titleLabel.font = JZFont(13);
    bianJiButton.titleLabel.textAlignment = 2;
    [bianJiButton addTarget:self action:@selector(bianji) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:bianJiButton];
    self.navigationItem.rightBarButtonItem = item;
    
    self.isEdit = NO;
    
    [self.view addSubview:self.albumCollectionView];
    [self.albumCollectionView registerClass:[NYNAlbumPicsCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    self.albumCollectionView.backgroundColor = Colorededed;
    
    [self reloadPics];
}

- (void)reloadPics{
    [self showLoadingView:@""];
    [NYNNetTool GetPicsWithparams:@{} isTestLogin:YES progress:^(NSProgress *progress) {
        
    } success:^(id success) {
        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
            JZLog(@"");
            
            [self.picsArr removeAllObjects];
            
            for (NSDictionary *dic in success[@"data"]) {
                NYNPicModel *model = [NYNPicModel mj_objectWithKeyValues:dic];
                [self.picsArr addObject:model];

            }
            
            NYNPicModel *model = [[NYNPicModel alloc]init];
            [self.picsArr addObject:model];
            
            [self.albumCollectionView reloadData];
//           +号图片的名字 mePicJIia
        }else{
            [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
        }
        [self hideLoadingView];
    } failure:^(NSError *failure) {
        [self hideLoadingView];
    }];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.picsArr.count;
}

/** 每个cell的尺寸*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(JZWITH(112), JZHEIGHT(112));
}

/** 头部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREENWIDTH, .00001);

}

/** 顶部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREENWIDTH, JZHEIGHT(10));

}

/** section的margin*/
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(JZWITH(10), JZWITH(10), JZWITH(10), JZWITH(10));

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NYNPicModel *model = self.picsArr[indexPath.row];
    
    
    NYNAlbumPicsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if ([model isEqual:self.picsArr.lastObject]) {
        cell.picImgeViewW.image = Imaged(@"picCamera");
        cell.detelImageViewW.hidden = YES;

    }else{
        [cell.picImgeViewW sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:PlaceImage];
        [self starLongPress:cell];
        
        if (self.isEdit) {
            cell.detelImageViewW.hidden = NO;
        }else{
            cell.detelImageViewW.hidden = YES;
            
        }
    }
    
    __weak typeof(self)weakSelf = self;
    cell.detelBlock = ^(NSIndexPath *indexPath) {
        
        UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"确定要删除这张照片吗？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //TODO:
        }];
        [sheet addAction:cancelAction];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            //TODO:
            [weakSelf showLoadingView:@""];
            
            [NYNNetTool DetelPicsWithparams:[NSString stringWithFormat:@"%@",model.ID] isTestLogin:YES progress:^(NSProgress *progress) {
                
            } success:^(id success) {
                
                if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                    
                    [weakSelf reloadPics];
                    
                }else{
                    [weakSelf showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
                }
                
                [weakSelf hideLoadingView];
            } failure:^(NSError *failure) {
                [weakSelf hideLoadingView];
            }];
        }];
        [sheet addAction:confirmAction];
        
        [self presentViewController:sheet animated:YES completion:^{
            // TODO
        }];
    };

    
    return cell;

}

/** 选中某一个cell*/
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    JZLog(@"点击了第%ld个cell",(long)indexPath.row);
    if (indexPath.row == (self.picsArr.count - 1)) {
        JZLog(@"上传照片");
        [self callActionSheetFunc];
    }else{
    
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UICollectionView *)albumCollectionView{
    if (!_albumCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        // 定义大小
        layout.itemSize = CGSizeMake(JZWITH(112), JZHEIGHT(112));
        // 设置最小行间距
        layout.minimumLineSpacing = JZWITH(10);
        // 设置垂直间距
        layout.minimumInteritemSpacing = JZHEIGHT(5);
        // 设置滚动方向（默认垂直滚动）
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _albumCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) collectionViewLayout:layout];
        _albumCollectionView.delegate = self;
        _albumCollectionView.dataSource = self;
        _albumCollectionView.showsVerticalScrollIndicator = NO;
        _albumCollectionView.showsHorizontalScrollIndicator = YES;
    }
    return _albumCollectionView;
}

-(NSMutableArray *)picsArr{
    if (!_picsArr) {
        _picsArr = [[NSMutableArray alloc]init];
    }
    return _picsArr;
}

- (void)bianji{
    self.isEdit = !self.isEdit;
    
    if (self.isEdit) {
        [self.bianJiButton setTitle:@"编辑中" forState:0];
    }else{
        [self.bianJiButton setTitle:@"编辑" forState:0];
    }
    
    [self.albumCollectionView reloadData];
}

//开始抖动

- (void)starLongPress:(NYNAlbumPicsCollectionCell *)cell{
    
    if (self.isEdit) {
        
        [self shakeImage:cell];
        
    }else {
        
        [self resume:cell];
        
    }
    
}

- (void)shakeImage:(NYNAlbumPicsCollectionCell *)cell {
    
    //创建动画对象,绕Z轴旋转
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //设置属性，周期时长
    
    [animation setDuration:0.08];
    
    //抖动角度
    
    animation.fromValue = @(-M_1_PI/4);
    
    animation.toValue = @(M_1_PI/4);
    
    //重复次数，无限大
    
    animation.repeatCount = HUGE_VAL;
    
    //恢复原样
    
    animation.autoreverses = YES;
    
    //锚点设置为图片中心，绕中心抖动
    
    cell.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    [cell.layer addAnimation:animation forKey:@"rotation"];
    
}

- (void)pause:(NYNAlbumPicsCollectionCell *)cell {
    
    cell.layer.speed = 0.0;
    
}

- (void)resume:(NYNAlbumPicsCollectionCell *)cell {
    
    cell.layer.speed = 1.0;
    
}

/**
 @ 调用ActionSheet
 */
- (void)callActionSheetFunc{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    }else{
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    
    self.actionSheet.tag = 1000;
    [self.actionSheet showInView:self.view];
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
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        self.headImage.image = image;
        
        //这里上传图片
        
        NSData *dd = UIImageJPEGRepresentation(image, 1);
        

        [NYNNetTool PostImageWithparams:@{@"folder":@"avatar"} andFile:dd isTestLogin:YES progress:^(NSProgress *progress) {
            
        } success:^(id success) {
            if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                JZLog(@"");
                [NYNNetTool SavePicsWithparams:@{@"url":[NSString stringWithFormat:@"%@",success[@"data"]]} isTestLogin:YES progress:^(NSProgress *progress) {
                    
                } success:^(id success) {
                    
                    if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                        [self reloadPics];
                    }else{
                        
                        [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
                    }
                    [self hideLoadingView];
                } failure:^(NSError *failure) {
                    [self hideLoadingView];
                }];
                
            }else{
                [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
            }
            
            [self hideLoadingView];
        } failure:^(NSError *failure) {
            [self hideLoadingView];
        }];
    }];
    

}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)clickPickImage:(id)sender {
    
    [self callActionSheetFunc];
}

- (void)backToLast:(UIButton *)btn{
    if (self.picBack) {
        self.picBack();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
