//
//  Common.m
//
//
//  Created by LEEM on 12-5-21.
//  Copyright (c) 2012年 LEEM. All rights reserved.
//

#import "Common.h"
#import <sys/sysctl.h>
#import <UIKit/UIKit.h>


@implementation Common

+ (NSString*)deviceInfo
{
    size_t size = 0;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

+ (NSString *)systemName
{
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *)systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)appVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (float)appVersionFloatValue
{
    NSString *resault = @"";
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSArray *commponts = [version componentsSeparatedByString:@"."];
    if ([commponts count] > 0)
    {
        for (int i=0; i < [commponts count]; i++)
        {
            resault = [resault stringByAppendingString:commponts[i]];
            if (i == 0) resault = [resault stringByAppendingString:@"."];
        }
    }
    return [resault floatValue];
}

+ (CGRect)appFrame
{
    return [UIScreen mainScreen].bounds;
}

+ (NSString *)appName
{
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    if (appName == nil)
    {
        appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    }
    
    return appName;
}

+ (CGFloat)statusBarHeight
{
    return [[Common systemVersion] floatValue] >= 7.0 ? 20 : 0;
}

+ (NSString *) appDocumentsDirectory
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES); //文档目录
	return [paths objectAtIndex:0];
}

+ (NSString *)appCachesDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                         NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *) filePathForDocumentDirectory:(NSString*)fname
{
    NSString *dir = [Common appDocumentsDirectory];
    return [dir stringByAppendingPathComponent:fname];
}

+ (NSString *) filePathForCachesDirectory:(NSString *)fname
{
    NSString *dir = [Common appCachesDirectory];
    return [dir stringByAppendingPathComponent:fname];
}

+ (NSString *) filePathForTempDirectory:(NSString *)fname
{
    NSString *dir = NSTemporaryDirectory();
    return [dir stringByAppendingPathComponent:fname];
}

+ (BOOL)renameFile:(NSString *)filePath NewName:(NSString *)name
{
    BOOL result = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath])
    {
        NSError *error;
        NSString *toPath = [filePath stringByDeletingLastPathComponent];
        toPath = [toPath stringByAppendingPathComponent:name];
        result = [fileManager copyItemAtPath:filePath toPath:toPath error:&error];
        [fileManager removeItemAtPath:filePath error:&error];
    }
    return result;
}

+ (BOOL)deleteFile:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath])
    {
        NSError *error;
        return [fileManager removeItemAtPath:filePath error:&error];
    }
    return NO;
}

+ (BOOL) deleteDocumentFile:(NSString *)fileName
{
    return [Common deleteDocumentFile:[Common filePathForDocumentDirectory:fileName]];
}

+ (NSDictionary *) fileProperty:(NSString *)fileName
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	return [fileManager attributesOfItemAtPath:fileName error:&error];
}

+ (BOOL) checkIsExistsFile:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:fileName];
}

+ (BOOL)creatFile:(NSString *)fileName content:(NSData *)content attributes:(NSDictionary *)attributes
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager createFileAtPath:fileName contents:content attributes:attributes];
}

+ (id) defaultValueForKey:(NSString *)key
{
	return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void) setDefaultValue:(id)value forKey:(NSString *)key
{
	[[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) removeDefaultForKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)safeDictionart:(NSDictionary *)dic
{
    for (NSString *key in [dic allKeys])
    {
        if (dic[key] && dic[key] == [NSNull null])
        {
            [dic setValue:@"" forKey:key];
        }
        if ([dic[key] isKindOfClass:[NSDictionary class]])
        {
            [self safeDictionart:dic[key]];
        }
    }
}

+ (NSString *)md5Encode:(NSString *)value
{
    const char *str = [value UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    return filename;
}

+ (NSString *)sha1:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

+ (NSString *)encStringByAddingPercentEscapes:(NSString*)value
{
    CFStringRef ref = CFURLCreateStringByAddingPercentEscapes(NULL, /* allocator */
                                                              (CFStringRef)value, NULL, /* charactersToLeaveUnescaped */
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    NSString *result = [NSString stringWithString:(__bridge NSString*)ref];
    CFRelease(ref);
    return result;
}

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
    return [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:1.0];
}

+ (CGSize)fitSize:(CGSize)srcSize inSize:(CGSize)dstSize
{
	CGFloat scale;
	CGSize newsize;
	
	if((srcSize.width < dstSize.width) && (srcSize.height < dstSize.height))
	{
		newsize = srcSize;
	}
	else
	{
		if(srcSize.width >= srcSize.height)
		{
			scale = dstSize.width/srcSize.width;
			newsize.width = dstSize.width;
			newsize.height = srcSize.height*scale;
		}
		else if(srcSize.width < srcSize.height)
		{
			scale = dstSize.height/srcSize.height;
			newsize.height = dstSize.height;
			newsize.width = srcSize.width*scale;
		}
	}
	return newsize;
}

+ (CGSize)fillSize:(CGSize)srcSize inSize:(CGSize)dstSize
{
	CGFloat scale;
	CGSize newsize;
	
    if(srcSize.width >= srcSize.height)
    {
        scale = dstSize.width/srcSize.width;
        newsize.width = dstSize.width;
        newsize.height = srcSize.height*scale;
    }
    else if(srcSize.width < srcSize.height)
    {
        scale = dstSize.height/srcSize.height;
        newsize.height = dstSize.height;
        newsize.width = srcSize.width*scale;
    }
	return newsize;
}

+ (UIImage *)makeCoverImage:(UIImage *)image withMask:(UIImage *)mask
            isCameraCapture:(BOOL)isCameraCapture isFront:(BOOL)isFront
{
    if (image && mask)
    {
        CGSize size = mask.size; //以遮罩大小为参考
        
        CGFloat bytesPerPixel = 4; // RGBA
        int bytesPerRow = bytesPerPixel * size.width;
        void *destBitmapData = malloc(bytesPerRow * size.height); //BMP图片
        CGContextRef context = CGBitmapContextCreate(destBitmapData, size.width, size.height,
                                                     CGImageGetBitsPerComponent(image.CGImage),
                                                     bytesPerRow, CGImageGetColorSpace(image.CGImage),
                                                     CGImageGetBitmapInfo(image.CGImage));
        if (context)
        {
            if (isCameraCapture) //拍照
            {
                /* 根据图像的属性，获取图片的方向，进行平移和旋转 */
                CGContextSaveGState(context);

                if (isFront)
                {
                    /* 前置摄像头 */
                    CGContextTranslateCTM(context, size.width, size.height); //平移
                    CGContextScaleCTM(context, -1, 1);  //翻转
                    CGContextRotateCTM(context, -M_PI_2); //旋转
                }
                else
                {
                    /* 后置摄像头 */
                    CGContextTranslateCTM(context, 0.0f, size.height); //平移
                    CGContextRotateCTM(context, -M_PI_2); //旋转
                }
                
                /* 绘制底图 */
                CGContextDrawImage(context, CGRectMake(0, 0, size.height, size.width), image.CGImage);
                CGContextRestoreGState(context);
            }
            else //相册
            {
                /* 根据图像的属性，获取图片的方向，标准化处理（处理后的图片正前向上） */
                CGContextSaveGState(context);
                CGSize scaleSize = [self fillSize:image.size inSize:size]; //重新计算缩放后的大小
                CGFloat x = (size.width - scaleSize.width) / 2;
                CGFloat y = (size.height - scaleSize.height) / 2;

                switch (image.imageOrientation)
                {
                    case UIImageOrientationUp:
                    case UIImageOrientationUpMirrored: //横屏向左
                    {
                        break;
                    }
                    case UIImageOrientationDown:
                    case UIImageOrientationDownMirrored: //横屏向右
                    {
                        CGContextTranslateCTM(context, size.width, size.width + y); //平移
                        CGContextRotateCTM(context, M_PI); //旋转
                        break;
                    }
                    case UIImageOrientationLeft:
                    case UIImageOrientationLeftMirrored: //竖屏向下
                    {
                        CGContextTranslateCTM(context, size.width, 0.0f); //平移
                        CGContextRotateCTM(context, M_PI_2); //旋转
                        scaleSize = CGSizeMake(scaleSize.height, scaleSize.width); //改变宽和高
                        break;
                    }
                    case UIImageOrientationRight:
                    case UIImageOrientationRightMirrored: //竖屏向上
                    {
                        CGContextTranslateCTM(context, 0.0f, size.height); //平移
                        CGContextRotateCTM(context, -M_PI_2); //旋转
                        scaleSize = CGSizeMake(scaleSize.height, scaleSize.width); //改变宽和高
                        break;
                    }
                }
                
                /* 绘制底图 */
                CGContextDrawImage(context, CGRectMake(x, y, scaleSize.width, scaleSize.height), image.CGImage);
                CGContextRestoreGState(context);
            }
            
            /* 绘制Mask */
            CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), mask.CGImage); //遮罩
            
            CGImageRef destImageRef = CGBitmapContextCreateImage(context); //生成图片
            UIImage *newImage = [UIImage imageWithCGImage:destImageRef];
            CGImageRelease(destImageRef);
            
            CGContextRelease(context);
            free(destBitmapData);
            
            return newImage;
        }
    }
    
    return image;
}

+ (NSString *)formatDiskSize:(unsigned long long)size
{
    CGFloat fsize = (CGFloat)size / 1024; //KB
    if (fsize >= 1024 * 1024 * 1024) // TB
        return [NSString stringWithFormat:@"%0.1f TB", fsize/1024/1024/1024];
    else if (fsize >= 1024 * 1024) // GB
        return [NSString stringWithFormat:@"%0.1f GB", fsize/1024/1024];
    else if (fsize >= 1024) // MB
        return [NSString stringWithFormat:@"%0.1f MB", fsize/1024];
    else // kB
        return [NSString stringWithFormat:@"%0.1f KB", fsize];
}

@end
