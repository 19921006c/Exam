//
//  NSString+Character.h
//  DoctorPlatForm
//
//  Created by J on 16/8/25.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Character)

+ (NSInteger)indexWithCharacter:(NSString *)string;

+ (NSString *)characterWithIndex:(NSInteger)index;
@end
