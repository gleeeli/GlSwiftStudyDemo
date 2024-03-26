//
//  UIImage+HB.m
//  TaQu
//
//  Created by 黄文安 on 15/10/28.
//  Copyright © 2015年 厦门海豹信息技术. All rights reserved.
//

#import "UIImage+XHB.h"
#import "NSString+XHB.h"
#import <SDWebImage/UIImage+GIF.h>
#import <SDWebImage/SDImageGIFCoder.h>

@implementation UIImage (XHB)

+ (UIImage *)resizedImageNamed:(NSString *)name {
    return [self resizedImageNamed:name leftScale:0.5 topScale:0.5];
}

+ (UIImage *)resizedImageNamed:(NSString *)name leftScale:(CGFloat)leftScale topScale:(CGFloat)topScale {
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * leftScale topCapHeight:image.size.height * topScale];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (size.height == 0 || size.width == 0) {
//        DDLogError(@"请检查size值,无法正确生成图片-%@", NSStringFromCGSize(size));
    }
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 * 从本地 资源文件 读取图片
 * @param name 文件名称 | 带后缀  @2x.png
 */
+ (UIImage *)imageWithContentsOfFileName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:name];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}

+ (UIImage *)addImage:(UIImage *)image1 withImage:(UIImage *)image2 rect1:(CGRect)rect1 rect2:(CGRect)rect2 {
    CGSize size = rect1.size;
    UIGraphicsBeginImageContext(size);
    [image1 drawInRect:rect1];
    [image2 drawInRect:rect2];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

- (UIImage *)scaleToSize:(CGSize)size {
    BOOL isHorizontal = self.size.width >= self.size.height;
    CGFloat width = 0, height = 0;
    if (isHorizontal) {
        height = self.size.height <= size.height ? self.size.height : size.height;
        width = floorf(height * self.size.width / self.size.height);
    } else {
        width = self.size.width <= size.width ? self.size.width : size.width;
        height = floorf(width * self.size.height / self.size.width);
    }

    CGSize drawSize = CGSizeMake(width, height);
    return [self zoomToSize:drawSize];
}

- (UIImage *)zoomToSize:(CGSize)drawSize {
    if (CGSizeEqualToSize(self.size, drawSize)) {
        return self;
    }

    CGFloat width = drawSize.width;
    CGFloat height = drawSize.height;
    UIImage *scaledImage = nil;
    @autoreleasepool {
        // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContextWithOptions(drawSize, NO, self.scale);
        // 绘制改变大小的图片
        [self drawInRect:CGRectMake(0, 0, width, height)];
        // 从当前context中创建一个改变大小后的图片
        scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
    }

    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (UIImage *)podImageName:(NSString *)imageName
               bundleName:(NSString *)name
                className:(NSString *)className {
    //取一个pod工程的类来获取pod的bundle
    if (!imageName) {
        return nil;
    }
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(className)];
    if (![NSString isEmpty:name]) {
        NSURL *url = [[bundle resourceURL] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle", name]];
        bundle = [NSBundle bundleWithURL:url];
    }
    return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
}

+ (UIImage *)hb_animatedGIFNamed:(NSString *)name {
    if (!name) {
        return nil;
    }
    CGFloat scale = [UIScreen mainScreen].scale;
    if (scale > 1.0f) {
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        if (data) {
            return [UIImage hb_imageWithGIFData:data];
        }
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        data = [NSData dataWithContentsOfFile:path];
        if (data) {
            return [UIImage hb_imageWithGIFData:data];
        }
        return [UIImage imageNamed:name];
    } else {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        if (data) {
            return [UIImage hb_imageWithGIFData:data];
        }
        return [UIImage imageNamed:name];
    }
}

+ (UIImage *)hb_imageWithGIFData:(NSData *)data {
    return [UIImage sd_imageWithGIFData:data];
}

- (BOOL)isGIF {
    return (self.images != nil);
}

/** UIImage covert to CVPixelBufferRef */
+ (CVPixelBufferRef)pixelBufferFromImage:(UIImage *)image {
    if (!image) {
        return NULL;
    }
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey,
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey,
                             nil];
    CVPixelBufferRef pxbuffer = NULL;

    CGImageRef imageRef = image.CGImage;
    CGFloat frameWidth = CGImageGetWidth(imageRef);
    CGFloat frameHeight = CGImageGetHeight(imageRef);
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,
                                          frameWidth,
                                          frameHeight,
                                          kCVPixelFormatType_32ARGB,
                                          (__bridge CFDictionaryRef) options,
                                          &pxbuffer);

    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);

    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata != NULL);

    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();

    CGContextRef context = CGBitmapContextCreate(pxdata, frameWidth, frameHeight, 8, CVPixelBufferGetBytesPerRow(pxbuffer), rgbColorSpace, (CGBitmapInfo)kCGImageAlphaNoneSkipFirst);
    NSParameterAssert(context);
    CGContextConcatCTM(context, CGAffineTransformIdentity);
    CGContextDrawImage(context, CGRectMake(0, 0, frameWidth, frameHeight), imageRef);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);

    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);

    return pxbuffer;
}

/** CVPixelBufferRef covert to UIImage */
+ (UIImage *)imageFromCVPixelBuffer:(CVPixelBufferRef)pixelBuffer {
    if (pixelBuffer == NULL) {
        return nil;
    }
    CIImage *ciImage = [CIImage imageWithCVPixelBuffer:pixelBuffer];
    CIContext *temporaryContext = [CIContext contextWithOptions:nil];
    CGImageRef videoImage = [temporaryContext createCGImage:ciImage fromRect:CGRectMake(0, 0, CVPixelBufferGetWidth(pixelBuffer), CVPixelBufferGetHeight(pixelBuffer))];
    
    UIImage *image = [UIImage imageWithCGImage:videoImage];
    CGImageRelease(videoImage);
    
    return image;
}

@end
