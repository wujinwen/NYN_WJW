//
//  NYNMyFarmPingJiaViewController.m
//  NetFarmCommune
//
//  Created by 123 on 2017/8/28.
//  Copyright © 2017年 NongYiNong. All rights reserved.
//

#import "NYNMyFarmPingJiaViewController.h"
#import "JNTextView.h"
#import "NYNPicModel.h"
#import "NYNAlbumPicsCollectionCell.h"
#import <objc/runtime.h>

@interface NYNMyFarmPingJiaViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) UICollectionView *albumCollectionView;

@property (nonatomic,strong) NSMutableArray *picsArr;

@property (nonatomic,assign) BOOL isEdit;

@property (nonatomic,strong) UIButton *bianJiButton;

@property (strong, nonatomic)  UIImageView *headImage;

@property (strong, nonatomic) UIActionSheet *actionSheet;


@property (nonatomic,strong) JNTextView *tV;


@property (nonatomic,strong) NSMutableArray *imagesArr;

@property (nonatomic,assign) int indexStar;
@end

@implementation NYNMyFarmPingJiaViewController
//定义常量 必须是C语言字符串
static char *PersonNameKey = "PersonNameKey";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.indexStar = 5;
    
    self.title = @"评价";
    
    [self setUI];
}

- (void)setUI{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, JZHEIGHT(290))];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UILabel *pingJiaLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, JZHEIGHT(19), JZWITH(60), JZHEIGHT(12))];
    pingJiaLabel.text = @"评分";
    pingJiaLabel.font = JZFont(14);
    pingJiaLabel.textColor = [UIColor blackColor];
    [topView addSubview:pingJiaLabel];
    
    for (int i = 0; i < 5; i++) {
        UIImageView *starImageView = [[UIImageView alloc]initWithFrame:CGRectMake(pingJiaLabel.right  + (JZWITH(10) + JZWITH(3 + 6)) * i, JZHEIGHT(17), JZWITH(16), JZHEIGHT(16))];
        //        starImageView.image = (i <= lightStarCount ?  Imaged(@"farm_icon_grade1") : Imaged(@"farm_icon_grade2")) ;
        starImageView.image = Imaged(@"farm_icon_grade1");
        
        starImageView.tag = i + 1035;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        [starImageView addGestureRecognizer:tap];
        starImageView.userInteractionEnabled = YES;
        [topView addSubview:starImageView];
        
//        objc_setAssociatedObject(starImageView, PersonNameKey, PersonNameKey, objc_AssociationPolicy policy);
        
        objc_setAssociatedObject(tap, &PersonNameKey, @(i), OBJC_ASSOCIATION_ASSIGN);
        [self.imagesArr addObject:starImageView];
        
    }
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, JZHEIGHT(17) + pingJiaLabel.bottom, SCREENWIDTH, .5)];
    lineView.backgroundColor = Colore3e3e3;
    [topView addSubview:lineView];
    
    JNTextView *tV = [[JNTextView alloc]initWithFrame:CGRectMake(JZWITH(10), lineView.bottom + JZHEIGHT(13), SCREENWIDTH - JZWITH(20), JZHEIGHT(100))];
    tV.placehoder = @"请输入您的看法";
    self.tV = tV;
    [topView addSubview:tV];
    
    
    [self.albumCollectionView registerClass:[NYNAlbumPicsCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    self.albumCollectionView.backgroundColor = [UIColor whiteColor];
    self.albumCollectionView.scrollEnabled = NO;
    [self.view addSubview:self.albumCollectionView];
    NYNPicModel *model = [[NYNPicModel alloc]init];
    model.cType = @"1";
    [self.picsArr addObject:model];
    
    [self.albumCollectionView reloadData];
    
    
    UIButton *tijiaoButton = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT - JZHEIGHT(45) - 64, SCREENWIDTH, JZHEIGHT(45))];
    [tijiaoButton setTitle:@"提交" forState:0];
    [tijiaoButton setTitleColor:[UIColor whiteColor] forState:0];
    tijiaoButton.backgroundColor = Color9ecc5b;
    tijiaoButton.titleLabel.font = JZFont(14);
    [tijiaoButton addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tijiaoButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (void)click:(UITapGestureRecognizer *)tap{
    NSNumber *idd = objc_getAssociatedObject(tap, &PersonNameKey);

    int index = [idd intValue];
    
    self.indexStar = index;
    
    for ( int i = 0; i < self.imagesArr.count; i++) {
        UIImageView *starImageView = self.imagesArr[i];
        
        if (i > self.indexStar) {
            starImageView.image = Imaged(@"farm_icon_grade2");
        }else{
            starImageView.image = Imaged(@"farm_icon_grade1");

        }

    }
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
//    if (self.picsArr.count + 1 == 3) {
//        return self.picsArr.count;
//    }else{
        return self.picsArr.count;
//    }
    
}

/** 每个cell的尺寸*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(JZWITH(70), JZHEIGHT(70));
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
    return UIEdgeInsetsMake(JZWITH(5), JZWITH(20), JZWITH(5), JZWITH(20));
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NYNPicModel *model = self.picsArr[indexPath.row];
    
    
    NYNAlbumPicsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if ([model.cType isEqualToString:@"1"]) {
        cell.picImgeViewW.image = Imaged(@"picCamera");
        cell.detelImageViewW.hidden = YES;
        
    }else{
        [cell.picImgeViewW sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:PlaceImage];
//        [self starLongPress:cell];
        
        cell.detelImageViewW.frame = CGRectMake(JZWITH(70 - 15), 0, JZWITH(15), JZWITH(15));
        
        if ([model.cType isEqualToString:@"1"]) {
            cell.detelImageViewW.hidden = YES;
        }else{
            cell.detelImageViewW.hidden = NO;
            
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
            
            NYNPicModel *md = self.picsArr[indexPath.row];
            
            [self.picsArr removeObject:md];
            
            [weakSelf reloadPics];
            
            //TODO:
//            [weakSelf showLoadingView:@""];
            
//            [NYNNetTool DetelPicsWithparams:[NSString stringWithFormat:@"%@",model.ID] isTestLogin:YES progress:^(NSProgress *progress) {
//                
//            } success:^(id success) {
//                
//                if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
//                    
//                    NYNPicModel *md = self.picsArr[indexPath.row];
//                    
//                    [self.picsArr removeObject:md];
//                    
//                    [weakSelf reloadPics];
//                    
//                }else{
//                    [weakSelf showLoadingView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
//                }
//                
//                [weakSelf hideLoadingView];
//            } failure:^(NSError *failure) {
//                [weakSelf hideLoadingView];
//            }];
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
//    if (indexPath.row == (self.picsArr.count - 1)) {
//        JZLog(@"上传照片");
//        [self callActionSheetFunc];
//    }else{
//        
//    }
//
    NYNPicModel *model = self.picsArr[indexPath.row];
    if ([model.cType isEqualToString:@"1"]) {
        [self callActionSheetFunc];
    }
}


-(UICollectionView *)albumCollectionView{
    if (!_albumCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        // 定义大小
        layout.itemSize = CGSizeMake(JZWITH(70), JZHEIGHT(70));
        // 设置最小行间距
        layout.minimumLineSpacing = JZWITH(20);
        // 设置垂直间距
        layout.minimumInteritemSpacing = JZHEIGHT(5);
        // 设置滚动方向（默认垂直滚动）
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _albumCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.tV.bottom + JZHEIGHT(20), SCREENWIDTH, JZHEIGHT(80)) collectionViewLayout:layout];
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

- (void)reloadPics{
//    [self showLoadingView:@""];
//    [NYNNetTool GetPicsWithparams:@{} isTestLogin:YES progress:^(NSProgress *progress) {
//        
//    } success:^(id success) {
//        if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
//            JZLog(@"");
//            
//            [self.picsArr removeAllObjects];
//            
//            for (NSDictionary *dic in success[@"data"]) {
//                NYNPicModel *model = [NYNPicModel mj_objectWithKeyValues:dic];
//                [self.picsArr addObject:model];
//                
//            }
//            
//            NYNPicModel *model = [[NYNPicModel alloc]init];
//            [self.picsArr addObject:model];
//            
//            [self.albumCollectionView reloadData];
//            //           +号图片的名字 mePicJIia
//        }else{
//            [self showLoadingView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
//        }
//        [self hideLoadingView];
//    } failure:^(NSError *failure) {
//        [self hideLoadingView];
//    }];
    int i = 0;
    
    for (NYNPicModel *subModel in self.picsArr) {
        if ([subModel.cType isEqualToString:@"1"]) {
            
            i++;
        }
    }
    
    if (self.picsArr.count < 3) {
        if (i > 0) {
            
        }else{
            NYNPicModel *md = [[NYNPicModel alloc]init];
            md.cType = @"1";
            [self.picsArr addObject:md];
        }
    }

    
    [self.albumCollectionView reloadData];

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
        
        [self showLoadingView:@""];
        [NYNNetTool PostImageWithparams:@{@"folder":@"avatar"} andFile:dd isTestLogin:YES progress:^(NSProgress *progress) {
            
        } success:^(id success) {
            if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
                JZLog(@"");
                NYNPicModel *model = [[NYNPicModel alloc]init];
                model.url = [NSString stringWithFormat:@"%@",success[@"data"]];
                
                if (self.picsArr.count < 3) {
                    
                    [self.picsArr insertObject:model atIndex:0];
                }else{
                
                    [self.picsArr insertObject:model atIndex:0];
                    [self.picsArr removeObject:self.picsArr.lastObject];
                }
                
                [self reloadPics];
//                [NYNNetTool SavePicsWithparams:@{@"url":[NSString stringWithFormat:@"%@",success[@"data"]]} isTestLogin:YES progress:^(NSProgress *progress) {
//                    
//                } success:^(id success) {
//                    
//                    if ([[NSString stringWithFormat:@"%@",success[@"code"]] isEqualToString:@"200"]) {
//                        [self reloadPics];
//                    }else{
//                        
//                        [self showLoadingView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
//                    }
//                    [self hideLoadingView];
//                } failure:^(NSError *failure) {
//                    [self hideLoadingView];
//                }];
                
            }else{
                [self showTextProgressView:[NSString stringWithFormat:@"%@",success[@"msg"]]];
            }
            
            [self hideLoadingView];
        } failure:^(NSError *failure) {
            [self hideLoadingView];
        }];
    }];
    
    
}

-(NSMutableArray *)imagesArr{
    if (!_imagesArr) {
        _imagesArr = [[NSMutableArray alloc]init];
    }
    return _imagesArr;
}

- (void)tijiao{
    if (self.tV.text.length < 1) {
        [self showTextProgressView:@"请输入评价内容"];
        [self hideLoadingView];
    }else{
        [self showTextProgressView:@"开发中"];
        [self hideLoadingView];
        
//        NSDictionary *dic = @{@"orderId":self.model.orderId,@"":,@"":,@"":,@"":,@"":,@"":,@"":,@"":};
//        [NYNNetTool MyFarmAddPingJiaWithparams:@{} isTestLogin:YES progress:^(NSProgress *progress) {
//            
//        } success:^(id success) {
//            
//        } failure:^(NSError *failure) {
//            
//        }];
    }
//
    
}
@end
