
//  Created by apple on 14-9-1.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    ButtonDrectionLeft = 0, // 左边按钮
    ButtonDrectionRight = 1, // 右边按钮
} ButtonDrection;

@interface UIBarButtonItem (WY)
/**
 *  创建自定义item
 *
 *  @param norImageName 默认状态图片
 *  @param higImageName 高亮状态图片
 *  @param action       点击事件
 *
 *  @return item
 */
+ (instancetype)itemWithNorImage:(NSString *)norImageName higImage:(NSString *)higImageName targe:(id)targe action:(SEL)action;

+ (instancetype)itemWithNorImage:(NSString *)norImageName higImage:(NSString *)higImageName targe:(id)targe action:(SEL)action withNew:(BOOL)isSign;

+ (instancetype)itemWithDrection:(ButtonDrection)dection NormalTitle:(NSString *)normalTitle selectedTitle:(NSString *)selectedTitle normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor targe:(id)targe action:(SEL)action;
@end
