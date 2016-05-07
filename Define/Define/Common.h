//
//  Common.h
//
//
//  Created by LEEM on 12-5-21.
//  Copyright (c) 2012年 LEEM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import <UIKit/UIKit.h>


/** 创建视图控制器（此方法只能在类名与资源文件名相同的情况下使用）*/
#define viewController(x) [[[(x) alloc] initWithNibName:NSStringFromClass((x)) bundle:nil] autorelease]

@interface Common : NSObject

/** 硬件设备及系统信息 */
+ (NSString*)deviceInfo;
+ (NSString*)systemName;
+ (NSString*)systemVersion;
+ (NSString*)appVersion;
+ (float)appVersionFloatValue;
+ (CGRect)appFrame;
+ (NSString*)appName;
+ (CGFloat)statusBarHeight; //专为ipad提供，小心使用。

/** APP下的文件路径 (fname-文件名) */
+ (NSString*)appDocumentsDirectory;
+ (NSString*)appCachesDirectory;
+ (NSString*)filePathForDocumentDirectory:(NSString *)fname;
+ (NSString*)filePathForTempDirectory:(NSString *)fname;
+ (NSString*)filePathForCachesDirectory:(NSString *)fname;

/** 文件属性 */
+ (NSDictionary *)fileProperty:(NSString *)fileName;
+ (BOOL)checkIsExistsFile:(NSString *)fileName;
+ (BOOL)renameFile:(NSString*)filePath NewName:(NSString*)name;
+ (BOOL)deleteFile:(NSString*)filePath;
+ (BOOL)deleteDocumentFile:(NSString *)fileName;
+ (BOOL)creatFile:(NSString*)fileName content:(NSData *)content attributes:(NSDictionary *)attributes;

/** 数据本地持久化 NSUserDefaults */
+ (id)defaultValueForKey:(NSString *)key;
+ (void)setDefaultValue:(id)value forKey:(NSString *)key;
+ (void)removeDefaultForKey:(NSString *)key;
+ (void)safeDictionart:(NSDictionary *)dic;

/** 数据加密 */
+ (NSString *)md5Encode:(NSString *)value;
+ (NSString *)sha1:(NSString *)str;

/** URL编码 */
+ (NSString *)encStringByAddingPercentEscapes:(NSString*)value;

/** RGB (0-255) */
+ (UIColor*)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

/** 适配大小 */
+ (CGSize)fitSize:(CGSize)srcSize inSize:(CGSize)dstSize;
+ (CGSize)fillSize:(CGSize)srcSize inSize:(CGSize)dstSize;

/**
 *	@brief 	给图片添加遮罩，支持裁剪（以遮罩图片的尺寸为准）
 *
 *	@param 	image 	底图
 *	@param 	mask 	遮罩图片
 *	@param 	isCameraCapture 	YES-拍照图片 NO-相册图片
 *	@param 	isFront 	YES-前置摄像头 NO-后置摄像头
 *
 *	@return	返回合成后的图片
 */
+ (UIImage*)makeCoverImage:(UIImage*)image withMask:(UIImage*)mask
           isCameraCapture:(BOOL)isCameraCapture isFront:(BOOL)isFront;

/** 格式化磁盘空间大小 */
+ (NSString*)formatDiskSize:(unsigned long long)size;

@end
