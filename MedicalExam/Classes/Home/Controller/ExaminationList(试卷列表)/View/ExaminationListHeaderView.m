//
//  ExaminationListHeaderView.m
//  examTest4.13
//
//  Created by silent on 16/4/13.
//  Copyright © 2016年 joe. All rights reserved.
//

#import "ExaminationListHeaderView.h"
#import "YimaiExaminationListClassModel.h"
@interface ExaminationListHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end

@implementation ExaminationListHeaderView

static NSString *const identifier = @"ExaminationListHeaderView";

-(void)awakeFromNib
{
    [super awakeFromNib];
    
}

+ (instancetype)headerViewWith:(UITableView *)tableView
{
    
    ExaminationListHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    
    if (view == nil) {
        view = [[ExaminationListHeaderView alloc]initWithReuseIdentifier:identifier];
    }
    
    return view;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
        
    }
    
    self.layer.borderWidth = .5;
    
    self.layer.borderColor = [UIColor colorWithHexString:@"#e8e8e8"].CGColor;
    
    return self;
}

//- (void)setFriendGroupModel:(FriendGroupModel *)friendGroupModel
//{
//    _friendGroupModel = friendGroupModel;
//    
//    self.label.text = friendGroupModel.name;
//}

- (void)setClassModel:(YimaiExaminationListClassModel *)classModel
{
    _classModel = classModel;
    
    self.label.text = classModel.class_name;
}

- (IBAction)headerViewBtnAction:(id)sender {
    
    self.classModel.open = !self.classModel.open;
    
//    NSLog(@"open = %d",self.friendGroupModel.open);
    
//    if (self.block) {
//        self.block(self);
//    }
    
    if ([self.delegate respondsToSelector:@selector(examiantionListHeaderViewDidSelected)]) {
        [self.delegate examiantionListHeaderViewDidSelected];
    }
}

/**
 *  当 当前的view 加载到父控件的时候调用
 */
- (void)didMoveToSuperview
{
    if (self.classModel.open) {
        self.iconImage.transform = CGAffineTransformMakeRotation(M_PI);
    }else{
        self.iconImage.transform = CGAffineTransformIdentity;
    }
}
@end
