//
//  UploadPicturesViewController.m
//  intelligence
//
//  Created by  on 16/8/10.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import "UploadPicturesViewController.h"
#import "UploadPhotoView.h"
#import "ZLPhoto.h"
#import "UIButton+WebCache.h"
#import "SoapUtil.h"
static NSInteger MAXChooseImage = 9;
@interface UploadPicturesViewController ()<UploadPhotoViewDelegate, ZLPhotoPickerBrowserViewControllerDelegate>
{
    UIButton *addImg;
}

@property (nonatomic, strong) NSMutableArray *photoViewArray;      // 存放相片View的array
@property (nonatomic, strong) NSMutableArray *photos;              // 相片数组
@end

@implementation UploadPicturesViewController

- (NSMutableArray *)photoViewArray{
    if (!_photoViewArray) {
        _photoViewArray = [NSMutableArray array];
    }
    return _photoViewArray;
}

- (NSMutableArray *)photos{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    if (_photos.count == 0) {
        [addImg setTitle:@"" forState:UIControlStateNormal];
        addImg.userInteractionEnabled = NO;
    }else{
        [addImg setTitle:@"上传" forState:UIControlStateNormal];
        addImg.userInteractionEnabled = YES;
    }
    return _photos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片上传";
    [self addNA];
    [self reloadPhotoView];
    
}
-(void)addNA{
    addImg = [UIButton buttonWithType:UIButtonTypeCustom];
    addImg.titleLabel.font = [UIFont systemFontOfSize:15];
    [addImg setTitle:@"上传" forState:UIControlStateNormal];
    [addImg.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [addImg setTintColor:[UIColor whiteColor]];
    [addImg addTarget:self action:@selector(addimgClick) forControlEvents:UIControlEventTouchUpInside];
    addImg.frame = CGRectMake(30, 5, 50, 30);
    
    // leftItem设置
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:addImg];
    //导航栏上添加按钮
    self.navigationItem.rightBarButtonItem = leftItem;
}
-(void)addimgClick{
    if (self.ownerid.length < 1 || self.ownertable.length < 1) {
        HUDNormal(@"缺少参数");
        return;
    }
    SVHUD_NO_Stop(@"正在上传");
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(delayMethod) userInfo:nil repeats:NO];
    
    

}

- (void)delayMethod{
    SoapUtil *soap = [[SoapUtil alloc]initWithNameSpace:@"http://www.ibm.com/maximo" andEndpoint:[NSString stringWithFormat:@"%@/meaweb/services/MOBILESERVICE",BASE_URL]];
    soap.DicBlock = ^(NSDictionary *dic){
        NSLog(@"--%@",dic);
        SVHUD_Stop;
        HUDNormal(@"图片上传成功");
    };
    
    for (ZLPhotoAssets *asset in self.photos) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
        UIImage *image = asset.originImage;
        //压缩图片
        NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
        NSString *byteArray = [imageData base64Encoding];
        NSArray *arr = @[
                         @{@"filename":imageFileName},
                         @{@"image":byteArray},
                         @{@"ownertable":_ownertable},
                         @{@"ownerid":_ownerid},
                         ];
        [soap requestMethods:@"mobileserviceuploadImage" withDate:arr];
    }
}


- (void)reloadPhotoView{
    [[self.view subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger assetCount = self.photos.count + 1;
    for (NSInteger i = 0; i < assetCount; i++) {
        CGFloat width = (ScreenWidth - 15) / 3.0;
        CGRect frame;
        if (i < 3) {
            frame = CGRectMake(width * i + 5, 0 + 75, width, width);
        }else if (i > 2 && i < 6){
            frame = CGRectMake(width * (i - 3) + 5, width + 5 + 75, width, width);
        }else{
            frame = CGRectMake(width * (i - 6) + 5, (width + 5) * 2 + 75, width, width);
        }
        
        UploadPhotoView *photoView = [[UploadPhotoView alloc] initWithFrame:frame];
        
        // UIButton(最后一个)
        if (i == self.photos.count) {
            if (i == MAXChooseImage) { // 超过最大选择数时隐藏 '加号' button
                photoView.hidden = YES;
            }else{
                photoView.delegate = self;
            }
        }else{
            if ([[self.photos objectAtIndex:i] isKindOfClass:[ZLPhotoAssets class]]) { // 相册
                [photoView.btnPhoto setBackgroundImage:[self.photos[i] originImage] forState:UIControlStateNormal];
            }else if ([[self.photos objectAtIndex:i] isKindOfClass:[ZLCamera class]]){ // 相机
                [photoView.btnPhoto setBackgroundImage:[self.photos[i] photoImage] forState:UIControlStateNormal];
            }else if ([[self.photos objectAtIndex:i] isKindOfClass:[NSString class]]){ // URL
                [photoView.btnPhoto sd_setImageWithURL:[NSURL URLWithString:self.photos[i]] forState:UIControlStateNormal];
            }
            photoView.tag = 100 + i;
            photoView.delegate = self;
        }
        [photoView judgeHideBtnDelegate];
        [self.view addSubview:photoView];
    }
}

- (void)chooseUploadPhoto{
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    // MaxCount, Default = 9
    pickerVc.maxCount = 9;
    // Jump AssetsVc
    pickerVc.status = PickerViewShowStatusCameraRoll;
    // Filter: PickerPhotoStatusAllVideoAndPhotos, PickerPhotoStatusVideos, PickerPhotoStatusPhotos.
    pickerVc.photoStatus = PickerPhotoStatusPhotos;
    // Recoder Select Assets
    pickerVc.selectPickers = self.photos;
    // Desc Show Photos, And Suppor Camera
    pickerVc.topShowPhotoPicker = YES;   // 从上或从下显示照片
    pickerVc.isShowCamera = YES;
    // CallBack
    pickerVc.callBack = ^(NSArray<ZLPhotoAssets *> *status){
        self.photos = status.mutableCopy;
        [self reloadPhotoView];
    };
    
    [pickerVc showPickerVc:self];
}



#pragma mark - UploadPhotoViewDelegate
- (void)UploadPhotoViewBtnPhotoClick:(UploadPhotoView *)photoView ishavePhoto:(BOOL)ishavePhoto{
    if (!ishavePhoto) {
        NSLog(@"我是第%ld张图片",photoView.tag - 100 + 1);
        NSMutableArray *photos = [NSMutableArray array];
        if (self.photos.count && self.photos.count - 1 >= photoView.tag - 100) {
            for (ZLPhotoAssets *asset in self.photos) {
                ZLPhotoPickerBrowserPhoto *photo = [[ZLPhotoPickerBrowserPhoto alloc] init];
                if ([asset isKindOfClass:[ZLPhotoAssets class]]) {
                    photo.asset = asset;
                }else if ([asset isKindOfClass:[ZLCamera class]]){
                    ZLCamera *camera = (ZLCamera *)asset;
                    photo.thumbImage = [camera thumbImage];
                }
                
//                if ([imageView isKindOfClass:[UIImageView class]]) {
//                    photo.toView = imageView;
//                }
                [photos addObject:photo];
            }
        }
        ZLPhotoPickerBrowserViewController *browserVc = [[ZLPhotoPickerBrowserViewController alloc] init];
        //    browserVc.editing = YES;
        browserVc.photos = photos;
        browserVc.delegate = self;
        browserVc.currentIndex = photoView.tag - 100;
        [browserVc showPickerVc:self];
    }else{
        NSLog(@"添加");
        [self chooseUploadPhoto];
    }
}

- (void)UploadPhotoViewBtnDeleteClick:(UploadPhotoView *)photoView{
    NSLog(@"删除");
    [self.photos removeObjectAtIndex:photoView.tag - 100];
    [self reloadPhotoView];
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

@end
