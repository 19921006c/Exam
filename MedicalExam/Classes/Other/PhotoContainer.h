//
//  PhotoContainer.h
//  DoctorPlatForm
//
//  Created by weiyi on 15/5/29.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PhotoContainer : UIView

/**
 *  图片的urls
 */
@property (nonatomic, strong) NSArray *picUrls;

/**
 *  @param imageCount
 *
 *  @return self.size
 */
+ (CGSize)sizeWithPhotosCount:(int)count;
+ (CGSize)PhotoSizeWithCount:(int)count;
@end