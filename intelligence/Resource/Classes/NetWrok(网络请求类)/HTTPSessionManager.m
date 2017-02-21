//
//  HTTPSessionManager.m
//  Recreation
//
//  Created by 闫光耀 on 16/5/11.
//  Copyright © 2016年 guangyao. All rights reserved.
//

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#import "HTTPSessionManager.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "MBProgressHUD.h"
//无网络
#define ISWUWANGLUO [CoreStatus currentNetWorkStatus] == CoreNetWorkStatusNone

static NSMutableArray *tasks;
@implementation HTTPSessionManager

+ (HTTPSessionManager *)sharedHTTPSessionManager
{
    static HTTPSessionManager *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        handler = [[HTTPSessionManager alloc] init];
    });
    return handler;
}

+(NSMutableArray *)tasks{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DLog(@"创建数组");
        tasks = [[NSMutableArray alloc] init];
    });
    return tasks;
}

+(URLSessionTask *)getWithUrl:(NSString *)url
                         params:(NSDictionary *)params
                        success:(ResponseSuccess)success
                           fail:(ResponseFail)fail
                        {
    
    return [self baseRequestType:1 url:url params:params success:success fail:fail];
    
}

+(URLSessionTask *)postWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                         success:(ResponseSuccess)success
                            fail:(ResponseFail)fail
                         {
    return [self baseRequestType:2 url:url params:params success:success fail:fail];
}

+(URLSessionTask *)baseRequestType:(NSUInteger)type
                                 url:(NSString *)url
                              params:(NSDictionary *)params
                             success:(ResponseSuccess)success
                                fail:(ResponseFail)fail
                             {
    DLog(@"请求地址----%@\n    请求参数----%@",url,params);
    if (ISWUWANGLUO) {
//        SVHUD_ERROR(@"网络已断开");
    }
                            
    NSString *urls = GETSTRING_WITH(BASE_URL,url);
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:urls]?urls:[self strUTF8Encoding:urls];
    
    AFHTTPSessionManager *manager=[self getAFManager];
    
    URLSessionTask *sessionTask=nil;
    
    if (type==1) {
        sessionTask = [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            DLog(@"请求结果=%@",responseObject);
            if (success) {
                success(responseObject);
            }
            
            [[self tasks] removeObject:sessionTask];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DLog(@"error=%@",error);
            if (fail) {
                fail(error);
            }
            
            [[self tasks] removeObject:sessionTask];
        }];
        
    }else{
        
        sessionTask = [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            DLog(@"请求成功=%@",responseObject);
            if (success) {
                success(responseObject);
            }
            
            [[self tasks] removeObject:sessionTask];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DLog(@"error=%@",error);
            if (fail) {
                fail(error);
            }
            
            [[self tasks] removeObject:sessionTask];
            
        }];
        
        
    }
    
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
    
}

+(URLSessionTask *)uploadWithImage:(UIImage *)image
                                 url:(NSString *)url
                            filename:(NSString *)filename
                                name:(NSString *)name
                              params:(NSDictionary *)params
                            progress:(UploadProgress)progress
                             success:(ResponseSuccess)success
                                fail:(ResponseFail)fail
                             {
    
    DLog(@"请求地址----%@\n    请求参数----%@",url,params);
    if (ISWUWANGLUO) {
//         SVHUD_ERROR(@"网络已断开");
    }
                                 
     NSString *urls = GETSTRING_WITH(BASE_URL,url);
    //检查地址中是否有中文
     NSString *urlStr=[NSURL URLWithString:urls]?urls:[self strUTF8Encoding:urls];
    
    AFHTTPSessionManager *manager=[self getAFManager];
    
    URLSessionTask *sessionTask = [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //压缩图片
        NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
        
        NSString *imageFileName = filename;
        if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
        }
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        DLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"上传图片成功=%@",responseObject);
        if (success) {
            success(responseObject);
        }
        
        [[self tasks] removeObject:sessionTask];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"error=%@",error);
        if (fail) {
            fail(error);
        }
        
        [[self tasks] removeObject:sessionTask];
        
        
    }];
    
    
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
}

+ (URLSessionTask *)uploadWithImages:(NSArray *)images
                                 url:(NSString *)url
                            filename:(NSArray *)filename
                                name:(NSString *)name
                              params:(NSDictionary *)params
                            progress:(UploadProgress)progress
                             success:(ResponseSuccess)success
                                fail:(ResponseFail)fail
{
    DLog(@"请求地址----%@\n    请求参数----%@",url,params);
    if (ISWUWANGLUO) {
//        SVHUD_ERROR(@"网络已断开");
    }
    
    NSString *urls = GETSTRING_WITH(BASE_URL,url);
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:urls]?urls:[self strUTF8Encoding:urls];
    AFHTTPSessionManager *manager=[self getAFManager];
    
    URLSessionTask *sessionTask = [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //压缩图片
        int i = 0;
        for (UIImage *image in images) {
            NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
            NSString *imageFileName = [NSString stringWithFormat:@"%@",filename[i]];
            if (imageFileName.length == 0) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmssSSS";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
            }
            if (i == 0) {
                [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/jpeg"];
            }else{
                [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"%@%d",name,i] fileName:imageFileName mimeType:@"image/jpeg"];
            }
            i++;
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        DLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"上传图片成功=%@",responseObject);
        if (success) {
            success(responseObject);
        }
        
        [[self tasks] removeObject:sessionTask];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"error=%@",error);
        if (fail) {
            fail(error);
        }
        
        [[self tasks] removeObject:sessionTask];
        
        
    }];
    
    
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;

}

+ (URLSessionTask *)uploadWithDifferentImages:(NSArray *)images
                                          url:(NSString *)url
                                     filename:(NSArray *)filename
                                        names:(NSArray *)names
                                       params:(NSDictionary *)params
                                     progress:(UploadProgress)progress
                                      success:(ResponseSuccess)success
                                         fail:(ResponseFail)fail
{
    DLog(@"请求地址----%@\n    请求参数----%@",url,params);
    if (ISWUWANGLUO) {
//        SVHUD_ERROR(@"网络已断开");
    }
    
    NSString *urls = GETSTRING_WITH(BASE_URL,url);
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:urls]?urls:[self strUTF8Encoding:urls];
    AFHTTPSessionManager *manager=[self getAFManager];
    
    URLSessionTask *sessionTask = [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //压缩图片
        int i = 0;
        for (UIImage *image in images) {
            NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
            NSString *imageFileName = [NSString stringWithFormat:@"%@",filename[i]];
            if (imageFileName.length == 0) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmssSSS";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
            }
            
            [formData appendPartWithFileData:imageData name:names[i] fileName:imageFileName mimeType:@"image/jpeg"];
            i++;
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        DLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"上传图片成功=%@",responseObject);
        if (success) {
            success(responseObject);
        }
        
        [[self tasks] removeObject:sessionTask];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"error=%@",error);
        if (fail) {
            fail(error);
        }
        
        [[self tasks] removeObject:sessionTask];
        
        
    }];
    
    
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
    
}

+ (URLSessionTask *)uploadWithVideo:(NSArray *)videoArray
                                url:(NSString *)url
                              names:(NSArray *)names
                             params:(NSDictionary *)params
                           progress:(UploadProgress)progress
                            success:(ResponseSuccess)success
                               fail:(ResponseFail)fail
{
    DLog(@"请求地址----%@\n    请求参数----%@",url,params);
    if (ISWUWANGLUO) {
//        SVHUD_ERROR(@"网络已断开");
    }
    
    NSString *urls = GETSTRING_WITH(BASE_URL,url);
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:urls]?urls:[self strUTF8Encoding:urls];
    
    AFHTTPSessionManager *manager=[self getAFManager];
    
    URLSessionTask *sessionTask = [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 以时间戳命名名字
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        
        
        for (int i = 0; i < 2; i++) {
            // 第一个为视频Data文件
            if (i == 0) {
                NSString *imageFileName = [NSString stringWithFormat:@"%@.mp4", str];
                NSString *name = names[0];
                NSData *videoData = videoArray[0];
                // 上传s视频，以文件流的格式
                 [formData appendPartWithFileData:videoData name:name fileName:imageFileName mimeType:@"mp4"];
            }else{
                NSString *imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
                UIImage *image = videoArray[1];
                //压缩图片
                NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
                NSString *name = names[1];
                // 上传图片，以文件流的格式
                [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/jpeg"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        DLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"上传图片成功=%@",responseObject);
        if (success) {
            success(responseObject);
        }
        
        [[self tasks] removeObject:sessionTask];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"error=%@",error);
        if (fail) {
            fail(error);
        }
        
        [[self tasks] removeObject:sessionTask];
        
        
    }];
    
    
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;

}


+ (URLSessionTask *)uploadWithVideoAndImages:(NSArray *)dataArray
                                         url:(NSString *)url
                                    imgNames:(NSArray *)imgNames
                                  videoNames:(NSArray *)videoNames
                                       ratio:(CGFloat)ratio
                                      params:(NSDictionary *)params
                                    progress:(UploadProgress)progress
                                     success:(ResponseSuccess)success
                                        fail:(ResponseFail)fail{
    DLog(@"请求地址----%@\n    请求参数----%@",url,params);
    if (ISWUWANGLUO) {
        //        SVHUD_ERROR(@"网络已断开");
    }
    
    NSString *urls = GETSTRING_WITH(BASE_URL,url);
    //检查地址中是否有中文
    NSString *urlStr = [NSURL URLWithString:urls]?urls:[self strUTF8Encoding:urls];
    
    AFHTTPSessionManager *manager=[self getAFManager];
    
    URLSessionTask *sessionTask = [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 以时间戳命名名字
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        
        
        for (int i = 0; i < 2; i++) {
            // 第一个为图片Data文件
            if (i == 0) {
                NSArray *imgsArray = dataArray[i];
                int j = 0;
                for (UIImage *img in imgsArray) {
                    NSString *imageFileName = [NSString stringWithFormat:@"%@%d.jpg", str, j];
                    NSString *name = imgNames[j];
                    NSData *imageData = UIImageJPEGRepresentation(img, ratio);
//                     上传图片，以文件流的格式
                    [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/jpeg"];
                    j++;
                }
//                NSString *imageFileName = [NSString stringWithFormat:@"%@.mp4", str];
//                NSString *name = names[0];
//                NSData *videoData = videoArray[0];
//                // 上传s视频，以文件流的格式
//                [formData appendPartWithFileData:videoData name:name fileName:imageFileName mimeType:@"mp4"];
            }else{
                NSArray *videoArray = dataArray[i];
                for (NSData *videoData in videoArray) {
                    int j = 0;
                    NSString *imageFileName = [NSString stringWithFormat:@"%@%d.mp4", str, j];
                    NSString *name = videoNames[0];
                    // 上传s视频，以文件流的格式
                    [formData appendPartWithFileData:videoData name:name fileName:imageFileName mimeType:@"mp4"];
                    j++;
                }

            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        DLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"上传图片成功=%@",responseObject);
        if (success) {
            success(responseObject);
        }
        
        [[self tasks] removeObject:sessionTask];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"error=%@",error);
        if (fail) {
            fail(error);
        }
        
        [[self tasks] removeObject:sessionTask];
        
        
    }];
    
    
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;

    
}




+ (URLSessionTask *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                             progress:(DownloadProgress)progressBlock
                              success:(ResponseSuccess)success
                              failure:(ResponseFail)fail
                              {
    
    
    DLog(@"请求地址----%@\n    ",url);
    if (url==nil) {
        return nil;
    }
    
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPSessionManager *manager = [self getAFManager];
    
    URLSessionTask *sessionTask = nil;
    
    sessionTask = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        DLog(@"下载进度--%.1f",1.0 * downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progressBlock) {
                progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (!saveToPath) {
            
            NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            DLog(@"默认路径--%@",downloadURL);
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
            
        }else{
            return [NSURL fileURLWithPath:saveToPath];
            
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        DLog(@"下载文件成功");
        
        [[self tasks] removeObject:sessionTask];
        
        if (error == nil) {
            if (success) {
                success([filePath path]);//返回完整路径
            }
            
        } else {
            if (fail) {
                fail(error);
            }
        }
        
        
    }];
    
    //开始启动任务
    [sessionTask resume];
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
    
    
}

+(AFHTTPSessionManager *)getAFManager{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = manager = [AFHTTPSessionManager manager];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];//设置请求数据为json
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    
    
    return manager;
    
}

#pragma makr - 开始监听网络连接

+ (void)startMonitoring
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                DLog(@"未知网络");
                [HTTPSessionManager sharedHTTPSessionManager].networkStats=StatusUnknown;
                
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                DLog(@"没有网络");
                [HTTPSessionManager sharedHTTPSessionManager].networkStats=StatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                DLog(@"手机自带网络");
                [HTTPSessionManager sharedHTTPSessionManager].networkStats=StatusReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                
                [HTTPSessionManager sharedHTTPSessionManager].networkStats=StatusReachableViaWiFi;
                DLog(@"WIFI--%d",[HTTPSessionManager sharedHTTPSessionManager].networkStats);
                break;
        }
    }];
    [mgr startMonitoring];
}


+(NSString *)strUTF8Encoding:(NSString *)str{
    //return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
