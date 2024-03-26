//
//  UIImage+HB.h
//  TaQu
//
//  Created by 黄文安 on 15/10/28.
//  Copyright © 2015年 厦门海豹信息技术. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XHB)
/**
 *  根据比例拉伸image
 *
 *  @param name      image的名称
 *  @param leftScale 拉伸的位置，左边间距占整个宽度的百分比
 *  @param topScale  拉伸的位置，上边间距占整个高度的百分比
 *
 *  @return 拉伸好的UIImage
 */
+ (UIImage *)resizedImageNamed:(NSString *)name leftScale:(CGFloat)leftScale topScale:(CGFloat)topScale;

/**
 *  拉伸中点的image
 *
 *  @param name image的名称
 *
 *  @return 拉伸好的UIImage
 */
+ (UIImage *)resizedImageNamed:(NSString *)name;

/**
 *  根据颜色创建一个纯色图片
 *
 *  @param color 生成纯色图片的颜色
 *
 *  @return 根据传入颜色和尺寸生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  根据颜色创建一个纯色图片
 *
 *  @param color 生成纯色图片的颜色
 *  @param size  生成纯色图片的大小
 *
 *  @return 根据传入颜色和尺寸生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 * 从本地 资源文件 读取图片
 * @param name  文件名称 | 带后缀
 */
+ (UIImage *)imageWithContentsOfFileName:(NSString *)name;

/**
 *  两张图片合成一张
 *
 *  @param image1 生成纯色图片的颜色
 *  @param image2  生成纯色图片的大小
 *
 *  @return 根据传入颜色和尺寸生成的图片
 */
+ (UIImage *)addImage:(UIImage *)image1 withImage:(UIImage *)image2 rect1:(CGRect)rect1 rect2:(CGRect)rect2;

/**
 压缩图片尺寸和质量
 */
- (UIImage *)scaleToSize:(CGSize)size;

/**
 pod 动态库加载图片（resource_bundles）

 @param imageName 图片名
 @param name pod中资源库的名称
 @param 取一个pod工程的类来获取pod的bundle
 @return 返回相应图片
 */
+ (UIImage *)podImageName:(NSString *)imageName
               bundleName:(NSString *)name
                className:(NSString *)className;

/**
 使用图片名称 从本地 mainBundle 中加载 gif 图片
 */
+ (UIImage *)hb_animatedGIFNamed:(NSString *)name;

/**
 将 gif 图片 data 转换为 UIImage
 */
+ (UIImage *)hb_imageWithGIFData:(NSData *)data;

/**
 是否 gif
 */
- (BOOL)isGIF;

/** UIImage covert to CVPixelBufferRef */
+ (CVPixelBufferRef)pixelBufferFromImage:(UIImage *)image;

/** CVPixelBufferRef covert to UIImage */
+ (UIImage *)imageFromCVPixelBuffer:(CVPixelBufferRef)pixelBuffer;

@end
