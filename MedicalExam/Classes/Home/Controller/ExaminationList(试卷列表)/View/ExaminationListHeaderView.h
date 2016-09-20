//
//  ExaminationListHeaderView.h
//  examTest4.13
//
//  Created by silent on 16/4/13.
//  Copyright © 2016年 joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExaminationListHeaderViewDelegate <NSObject>

@optional

- (void)examiantionListHeaderViewDidSelected;

@end

//typedef void(^ExaminationListHeaderViewBlock)(id);
@class YimaiExaminationListClassModel;
//@class FriendGroupModel;
@interface ExaminationListHeaderView : UITableViewHeaderFooterView

//@property (nonatomic, strong)FriendGroupModel *friendGroupModel;

@property (nonatomic, strong) YimaiExaminationListClassModel *classModel;

//@property (nonatomic, copy)ExaminationListHeaderViewBlock block;

+ (instancetype)headerViewWith:(UITableView *)tableView;

@property (nonatomic, assign) id<ExaminationListHeaderViewDelegate> delegate;

@end
