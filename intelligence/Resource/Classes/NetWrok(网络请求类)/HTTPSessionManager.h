//
//  HTTPSessionManager.h
//  Recreation
//
//  Created by 闫光耀 on 16/5/11.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    
    StatusUnknown           = -1, //未知网络
    StatusNotReachable      = 0,    //没有网络
    StatusReachableViaWWAN  = 1,    //手机自带网络
    StatusReachableViaWiFi  = 2     //wifi
    
}HTTPNetworkStatus;

typedef void( ^ ResponseSuccess)(id response);
typedef void( ^ ResponseFail)(NSError *error);

typedef void( ^ UploadProgress)(int64_t bytesProgress,
                                  int64_t totalBytesProgress);

typedef void( ^ DownloadProgress)(int64_t bytesProgress,
                                    int64_t totalBytesProgress);

/**
 *  方便管理请求任务。执行取消，暂停，继续等任务.
 *  - (void)cancel，取消任务
 *  - (void)suspend，暂停任务
 *  - (void)resume，继续任务
 */
typedef NSURLSessionTask URLSessionTask;




@interface HTTPSessionManager : NSObject

///**
// *  单例
// *
// *  @return
// */
//+ (HTTPSessionManager *)sharedNetworking;

/**
 *  获取网络
 */
@property (nonatomic,assign)HTTPNetworkStatus networkStats;

/**
 *  开启网络监测
 */
+ (void)startMonitoring;

/**
 *  get请求方法,block回调
 *
 *  @param url     请求连接，根路径
 *  @param params  参数
 *  @param success 请求成功返回数据
 *  @param fail    请求失败
 *  @param showHUD 是否显示HUD
 */
+(URLSessionTask *)getWithUrl:(NSString *)url
                         params:(NSDictionary *)params
                        success:(ResponseSuccess)success
                           fail:(ResponseFail)fail;

/**
 *  post请求方法,block回调
 *
 *  @param url     请求连接，根路径
 *  @param params  参数
 *  @param success 请求成功返回数据
 *  @param fail    请求失败
 *  @param showHUD 是否显示HUD
 */
+(URLSessionTask *)postWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                         success:(ResponseSuccess)success
                            fail:(ResponseFail)fail;

/**
 *  上传图片方法
 *
 *  @param image      上传的图片
 *  @param url        请求连接，根路径
 *  @param filename   图片的名称(如果不传则以当时间命名)
 *  @param name       上传图片时填写的图片对应的参数
 *  @param params     参数
 *  @param progress   上传进度
 *  @param success    请求成功返回数据
 *  @param fail       请求失败
 *  @param showHUD    是否显示HUD
 */
+ (URLSessionTask *)uploadWithImage:(UIImage *)image
                                  url:(NSString *)url
                             filename:(NSString *)filename
                                 name:(NSString *)name
                               params:(NSDictionary *)params
                             progress:(UploadProgress)progress
                              success:(ResponseSuccess)success
                                 fail:(ResponseFail)fail;
// 多图长传 Image与imagename 改为数组其他一样
// 技术要点：name 参数自增1
+ (URLSessionTask *)uploadWithImages:(NSArray *)images
                                 url:(NSString *)url
                            filename:(NSArray *)filename
                                name:(NSString *)name
                              params:(NSDictionary *)params
                            progress:(UploadProgress)progress
                             success:(ResponseSuccess)success
                                fail:(ResponseFail)fail;

// 多图长传 
// 技术要点：name 在 names数组里通过下标来取
+ (URLSessionTask *)uploadWithDifferentImages:(NSArray *)images
                                          url:(NSString *)url
                                     filename:(NSArray *)filename
                                        names:(NSArray *)names
                                       params:(NSDictionary *)params
                                     progress:(UploadProgress)progress
                                      success:(ResponseSuccess)success
                                         fail:(ResponseFail)fail;

/**
 *  上传视频方法
 *
 *  @param videoArray  上传的视频和图片
 *  @param url        请求连接，根路径
 *  @param filename   图片的名称(如果不传则以当时间命名)
 *  @param name       上传图片时填写的图片对应的参数
 *  @param params     参数
 *  @param progress   上传进度
 *  @param success    请求成功返回数据
 *  @param fail       请求失败
 *  @param showHUD    是否显示HUD
 */
+ (URLSessionTask *)uploadWithVideo:(NSArray *)videoArray
                                url:(NSString *)url
                              names:(NSArray *)names
                             params:(NSDictionary *)params
                           progress:(UploadProgress)progress
                            success:(ResponseSuccess)success
                               fail:(ResponseFail)fail;

/**
 *  上传视频+图片数组方法
 *
 *  @param videoArray  上传的视频和图片 [图片数组,视频数组]
 *  @param url        请求连接，根路径
 *  @param filename   图片的名称(如果不传则以当时间命名)
 *  @param imgNames   上传图片时填写的图片对应的参数
 *  @param videoNames 上传视频时填写的图片对应的参数
 *  @param ratio      压缩比 1.0~0.0
 *  @param params     参数
 *  @param progress   上传进度
 *  @param success    请求成功返回数据
 *  @param fail       请求失败
 *  @param showHUD    是否显示HUD
 */
+ (URLSessionTask *)uploadWithVideoAndImages:(NSArray *)dataArray
                                         url:(NSString *)url
                                    imgNames:(NSArray *)imgNames
                                  videoNames:(NSArray *)videoNames
                                       ratio:(CGFloat)ratio
                                      params:(NSDictionary *)params
                                    progress:(UploadProgress)progress
                                     success:(ResponseSuccess)success
                                        fail:(ResponseFail)fail;





/**
 *  下载文件方法
 *
 *  @param url           下载地址
 *  @param saveToPath    文件保存的路径,如果不传则保存到Documents目录下，以文件本来的名字命名
 *  @param progressBlock 下载进度回调
 *  @param success       下载完成
 *  @param fail          失败
 
 *  @return 返回请求任务对象，便于操作
 */
+ (URLSessionTask *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                             progress:(DownloadProgress )progressBlock
                              success:(ResponseSuccess )success
                              failure:(ResponseFail )fail;

@end
