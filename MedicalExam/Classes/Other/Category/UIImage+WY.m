//  Created by apple on 14-8-31.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIImage+WY.h"

@implementation UIImage (WY)

+ (instancetype)imageWithName:(NSString *)imageName
{
    // 1.定义返回值
    UIImage *resultImage = nil;
    // 2.判断当前是否是ios7
    if (isIOS7) {
        // 注意, 不是所有的图片都有_os7结尾的图片
        NSString *newImageName = [imageName stringByAppendingString:@"_os7"];
        resultImage = [UIImage imageNamed:newImageName];
        // 判断是否有ios7的图片
    }
    // 判断是否有ios7的图片
    if (resultImage == nil) {
        resultImage = [UIImage imageNamed:imageName];
    }
    // 4.返回结果
    return resultImage;
}

+ (instancetype)resizableImageWithName:(NSString *)imageName
{
    /*
    // 1.创建图片
    UIImage *image = [UIImage imageWithName:imageName];
    // 2.处理图片
    image =  [image stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
    // 3.返回图片
    return image;
     */
    
    return [self resizableImageWithName:imageName leftRatio:0.5 topRatio:0.5];
    
    
}

+ (instancetype)resizableImageWithName:(NSString *)imageName leftRatio:(CGFloat)leftRatio topRatio:(CGFloat)topRatio
{
    // 1.创建图片
    UIImage *image = [UIImage imageWithName:imageName];
    // 2.处理图片
    CGFloat left = image.size.width * leftRatio;
    CGFloat top = image.size.height * topRatio;
    
    image =  [image stretchableImageWithLeftCapWidth:left topCapHeight:top];
    // 3.返回图片
    return image;
}

@end
