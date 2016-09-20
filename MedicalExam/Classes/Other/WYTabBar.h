
//  Created by apple on 14-8-31.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class WYTabBar;

@protocol IWTabBarDelegate <NSObject>
/**
 *  通知外界从哪个按钮切换到了哪个按钮
 *
 *  @param from 上一次选中按钮的tag
 *  @param to   当前选中按钮的tag
 */
- (void)tabBar:(WYTabBar *)tabBar from:(NSInteger)from to:(NSInteger)to;

@end

@interface WYTabBar : UIView

/**
 *  根据模型创建选项卡
 *
 *  @param item 模型数据(标题/默认状态的图片/选中状态的图片)
 */
- (void)addTabBarButton:(UITabBarItem *)item;

- (void)selectIndex:(int)from to:(int)to;
@property (nonatomic, weak) id<IWTabBarDelegate> delegate;
@end
