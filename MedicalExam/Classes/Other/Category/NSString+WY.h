//
//  NSString+WY.h
//  DoctorPlatForm
//
//  Created by weiyi on 15/4/21.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WY)
/**
 判断字符串为空或者为空字符串
 @param str : 要判断的字符串
 @return 返回BOOL表示结果
 */
UIKIT_STATIC_INLINE BOOL StringIsNullOrEmpty(NSString* str)
{
    return ((NSNull *)str==[NSNull null] || str==nil||[str isEqualToString:@""]);
}

/**
 判断字符串不为空并且不为空字符串
 @param str : 要判断的字符串
 @return 返回BOOL表示结果
 */
UIKIT_STATIC_INLINE BOOL StringNotNullAndEmpty(NSString* str)
{
    return ((NSNull *)str!=[NSNull null] && str!=nil&&![str isEqualToString:@""]);
}

///返回一个占位字符，用于做Placeholder显示
UIKIT_STATIC_INLINE NSString * StringPlaceholderForString(NSString* placeholder,NSString* string)
{
    return StringNotNullAndEmpty(string)?string:placeholder;
}
+(BOOL)empty:(NSString *)str;

- (UIImage *)createQRCode;
- (UIImage *)createQRCode:(NSString *)url;
+ (BOOL)stringContainsEmoji:(NSString *)string;
@end
