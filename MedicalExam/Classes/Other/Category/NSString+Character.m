//
//  NSString+Character.m
//  DoctorPlatForm
//
//  Created by J on 16/8/25.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "NSString+Character.h"

@implementation NSString (Character)

+ (NSInteger)indexWithCharacter:(NSString *)string
{
    if ([string isEqualToString:@"A"]) {
        return 0;
    }else if ([string isEqualToString:@"B"]) {
        return 1;
    }else if ([string isEqualToString:@"C"]) {
        return 2;
    }else if ([string isEqualToString:@"D"]) {
        return 3;
    }else if ([string isEqualToString:@"E"]) {
        return 4;
    }else if ([string isEqualToString:@"F"]) {
        return 5;
    }else if ([string isEqualToString:@"G"]) {
        return 6;
    }else if ([string isEqualToString:@"H"]) {
        return 7;
    }else if ([string isEqualToString:@"I"]) {
        return 8;
    }else if ([string isEqualToString:@"J"]) {
        return 9;
    }else if ([string isEqualToString:@"K"]) {
        return 10;
    }else if ([string isEqualToString:@"L"]) {
        return 11;
    }else if ([string isEqualToString:@"M"]) {
        return 12;
    }else if ([string isEqualToString:@"N"]) {
        return 13;
    }else if ([string isEqualToString:@"O"]) {
        return 14;
    }else if ([string isEqualToString:@"P"]) {
        return 15;
    }else if ([string isEqualToString:@"Q"]) {
        return 16;
    }else if ([string isEqualToString:@"R"]) {
        return 17;
    }else if ([string isEqualToString:@"S"]) {
        return 18;
    }else if ([string isEqualToString:@"T"]) {
        return 19;
    }else if ([string isEqualToString:@"U"]) {
        return 20;
    }else if ([string isEqualToString:@"V"]) {
        return 21;
    }else if ([string isEqualToString:@"W"]) {
        return 22;
    }else if ([string isEqualToString:@"X"]) {
        return 23;
    }else if ([string isEqualToString:@"Y"]) {
        return 24;
    }else{
        return 25;
    }
}

+ (NSString *)characterWithIndex:(NSInteger)index
{
    NSInteger i = index + 65;
    unichar ch = i;
    
    NSString *str = [NSString stringWithUTF8String:(char *)&ch];
    
    return str;
}
@end
