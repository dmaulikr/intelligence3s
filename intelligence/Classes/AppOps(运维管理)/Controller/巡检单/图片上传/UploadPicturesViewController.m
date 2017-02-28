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
#import "UIImage+base64.h"
#import "UIImageView+WebCache.h"
static NSInteger MAXChooseImage = 9;
@interface UploadPicturesViewController ()<UploadPhotoViewDelegate, ZLPhotoPickerBrowserViewControllerDelegate>
{
    UIButton *addImg;
}

@property (nonatomic, strong) NSMutableArray *photoViewArray;      // 存放相片View的array
@property (nonatomic, strong) NSMutableArray *photos;              // 相片数组
@property (nonatomic, strong) NSMutableArray *hasUploadPhotos;              // 已上传相片数组

@property (nonatomic, strong) UIView * one;//
@property (nonatomic, strong) UIView * two;//

@end

@implementation UploadPicturesViewController

- (NSMutableArray *)photoViewArray{
    if (!_photoViewArray) {
        _photoViewArray = [NSMutableArray array];
    }
    return _photoViewArray;
}
- (void)requestData{
    
    NSDictionary *requestDic = @{
                                 @"appid"     :@"DOCLINKS",
                                 @"objectname":@"DOCLINKS",
                                 @"option"    :@"read",
                                 @"condition" :@{@"OWNERTABLE":self.ownertable,@"OWNERID":self.ownerid}
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        
        SVHUD_Stop
        
        NSArray *array = response[@"result"];
        
        NSLog(@"请求已上传的附件 %@",array);
        
        for (NSDictionary *dic in array) {
            
            NSString * docinfoId = dic[@"DOCINFOID"];
            
            [self requestDocinfo:docinfoId];
            
        }
        
    } fail:^(NSError *error) {
        SVHUD_ERROR(@"网络异常")

    }];
}
- (void)requestDocinfo:(NSString *)docinfoId{
    
    NSDictionary *requestDic = @{
                                 @"appid"     :@"DOCINFO",
                                 @"objectname":@"DOCINFO",
                                 @"option"    :@"read",
                                 @"condition" :@{@"DOCINFOID":docinfoId}
                                 };
    
    NSString *requestJson = kDictionaryToJson(requestDic)
    NSDictionary *dataDic = @{@"data":requestJson};
    
    self.task = [HTTPSessionManager getWithUrl:@"/maximo/mobile/common/api" params:dataDic success:^(id response) {
        
        SVHUD_Stop
        
        NSArray *array = response[@"result"];
        
        NSLog(@"一个附件的信息 %@",response);
        
        for (NSDictionary *dic in array) {
            NSString * url = dic[@"URLNAME"];
            NSString * baseinfourl;
            NSString *patch = [USERDEFAULT objectForKey:@"server"];
            
            if ([patch isEqualToString:@"http://eamapp.mywind.com.cn:9080"]) {
                
                baseinfourl = @"http://eamapp.mywind.com.cn";
                
            }else if ([patch isEqualToString:@"http://deveamapp.mywind.com.cn:9080"]){
                
                baseinfourl = @"http://deveamapp.mywind.com.cn";
                
            }
            url = [url stringByReplacingOccurrencesOfString:@"/share/doclinks/" withString:@"/"];
            NSLog(@"一个附件的地址 %@",[NSString stringWithFormat:@"%@%@",baseinfourl,url]);
            NSString *stringUrl = [NSString stringWithFormat:@"%@%@",baseinfourl,url];
            stringUrl = [stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [self.hasUploadPhotos addObject:stringUrl];
            
            [self reloadHasUploadedPhotoView];
        }
        
    } fail:^(NSError *error) {
        SVHUD_ERROR(@"网络异常")
        
    }];
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
    //
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"已上传",@"待上传",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(0.0, 0.0, 290, 30.0);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor grayColor];
    
    [segmentedControl addTarget:self  action:@selector(indexDidChangeForSegmentedControl:)
               forControlEvents:UIControlEventValueChanged];
    
    [self.navigationItem setTitleView:segmentedControl];
    
    //
    self.hasUploadPhotos = [NSMutableArray array];
    
    self.one = [[UIView alloc] initWithFrame:self.view.frame];
    self.two = [[UIView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:self.one];
    [self.view addSubview:self.two];
    [self.two setHidden:YES];
    
    [self addNA];
    [self reloadPhotoView];
    [self requestData];
    
}
-(void)indexDidChangeForSegmentedControl:(UISegmentedControl*) segmentedControl
{
    if (segmentedControl.selectedSegmentIndex==0) {
        
        [addImg setTitle:@"" forState:UIControlStateNormal];
        addImg.userInteractionEnabled = NO;
        
        [self.one setHidden:NO];
        [self.two setHidden:YES];
    }else{
        [addImg setTitle:@"上传" forState:UIControlStateNormal];
        
       [self.one setHidden:YES];
        [self.two setHidden:NO];
        
        addImg.userInteractionEnabled = YES;
    }
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
        NSString *imageFileName = [NSString stringWithFormat:@"%@.png", str];
        UIImage *image = asset.originImage;
        //压缩图片
        NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
        NSString *byteArray =[NSString stringWithFormat:@"%@",[image imageToBase64]];
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
    
    [[self.two subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
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
        [self.two addSubview:photoView];
    }
}
- (void)reloadHasUploadedPhotoView{
    
    [[self.one subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger assetCount = self.hasUploadPhotos.count + 1;
    
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
        if (i == self.hasUploadPhotos.count) {
           
                photoView.hidden = YES;
            
        }else{
            NSLog(@"图片地址 %@",self.hasUploadPhotos[i]);
            
            [photoView.btnPhoto sd_setImageWithURL:[NSURL URLWithString:self.hasUploadPhotos[i]] forState:UIControlStateNormal];
            photoView.tag = 100 + i;
            photoView.btnDelete.hidden=YES;
            [photoView.btnPhoto setUserInteractionEnabled:NO];
            UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImage:)];
            [photoView addGestureRecognizer:gesture];
           
        }
        [self.one addSubview:photoView];
    }
}
-(void)showImage:(UITapGestureRecognizer *)gesture;
{
    UploadPhotoView * photoView =(UploadPhotoView*) gesture.view;
    
    NSLog(@"我是第%ld张图片",photoView.tag - 100 + 1);
    NSMutableArray *photos = [NSMutableArray array];
    ZLPhotoPickerBrowserPhoto *photo = [[ZLPhotoPickerBrowserPhoto alloc] init];
    photo.toView = photoView.btnPhoto.imageView;
    [photos addObject:photo];
    ZLPhotoPickerBrowserViewController *browserVc = [[ZLPhotoPickerBrowserViewController alloc] init];
    browserVc.photos = photos;
    //browserVc.delegate = self;
    [browserVc showPickerVc:self];
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
