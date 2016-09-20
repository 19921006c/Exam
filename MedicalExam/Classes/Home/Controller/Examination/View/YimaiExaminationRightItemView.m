//
//  YimaiExaminationRightItemView.m
//  DoctorPlatForm
//
//  Created by J on 16/8/23.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiExaminationRightItemView.h"

@interface YimaiExaminationRightItemView ()

@end
@implementation YimaiExaminationRightItemView

+ (instancetype)view
{
    YimaiExaminationRightItemView *view = [[[NSBundle mainBundle] loadNibNamed:@"YimaiExaminationRightItemView" owner:self options:nil] lastObject];
    
    view.frame = CGRectMake(0, 0, 70, 30);
    
    return view;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    
    return self;
}
- (IBAction)submitBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectedSubmitBtn)]) {
        [self.delegate didSelectedSubmitBtn];
    }
}
- (IBAction)shareBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectedShareBtn)]) {
        [self.delegate didSelectedShareBtn];
    }
}
@end
