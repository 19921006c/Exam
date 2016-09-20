
//
//  Created by apple on 14-8-31.
//  Copyright (c) 2014年. All rights reserved.
//

#import "WYTabBar.h"
#import "WYTabBarButton.h"

@interface WYTabBar()
/**
 *  加号按钮
 */
@property (nonatomic, weak)  UIButton *plusBtn;

@property (nonatomic, strong) NSMutableArray *tabBarButtons;
/**
 *  当前选中的按钮
 */
@property (nonatomic, weak) WYTabBarButton *currentSelectedBtn;
@end

@implementation WYTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//#warning 后期优化
        // 1. 设置背景
        [self setupBg];
    }
    return self;
}
/**
 *  添加加号按钮
 */
- (void)setupPlusBtn
{
    // 1.创建按钮
    UIButton *plusBtn = [[UIButton alloc] init];
    
    // 2.设置背景图片
    [plusBtn setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [plusBtn setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    
    // 3.设置图标
    [plusBtn setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [plusBtn setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    
    // 4.添加
    [self addSubview:plusBtn];
    self.plusBtn = plusBtn;
    
    
    
}
- (void)layoutSubviews
{
   // 一定要注意, 调用父类的方法
    [super layoutSubviews];
    
    // 1.设置加号按钮的frame
    [self setupPlusBtnFrame];
    
    // 2.设置选项卡按钮的frame
    [self setupTabBarBtnFrame];
}

/**
 *  设置选项卡按钮的frame
 */
- (void)setupTabBarBtnFrame
{
    NSUInteger count = self.tabBarButtons.count;
    CGFloat btnWidth = self.width / count;
    CGFloat btnHeight = self.height;
    
    for (int i = 0; i < count; i++) {
        // 1.取出对应的按钮
        UIButton *btn = self.tabBarButtons[i];
//        btn.tag = i;
        // 2.计算frame
        CGFloat btnW = btnWidth;
        CGFloat btnH = btnHeight;
        CGFloat btnY = 0;
        CGFloat btnX = i * btnW;
        UIView *separatorView = [[UIView alloc] init];
        separatorView.frame = CGRectMake(CGRectGetMaxX(btn.frame), 9, 1, 28);
        [separatorView setBackgroundColor:[UIColor colorWithHexString:@"#f2f2f2"]];
        // 3.设置frame
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn addSubview:separatorView];
    }
}

/**
 *  设置加号按钮的frame
 */
- (void)setupPlusBtnFrame
{
    // 1.设置加号按钮的frame
    // 1.1.设置加号按钮的宽高
    CGSize currentSize =  self.plusBtn.currentBackgroundImage.size;
    self.plusBtn.width = currentSize.width;
    self.plusBtn.height = currentSize.height;
    
    // 1.2.设置加号按钮的位置
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;

}
/**
 *  设置背景
 */
- (void)setupBg
{
    if (isIOS7) {
        self.backgroundColor = [UIColor whiteColor];
    }else
    {
        // 设置背景图片
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
    }
}


- (void)addTabBarButton:(UITabBarItem *)item
{
    
    // 1.创建按钮
    WYTabBarButton *btn = [[WYTabBarButton alloc] init];
    btn.item = item;
    
    // 添加tag
    btn.tag = self.tabBarButtons.count;

    // 添加按钮监听事件
//    [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchDown];
    
    // 5.添加选项卡到自定义tabbar
    [self addSubview:btn];
    // 6.添加当前的按钮到数组中
    [self.tabBarButtons addObject:btn];
    
    // 7.判断是否是第一个按钮
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *registers = [defaults objectForKey:@"register"];
    int btnNum = 1;
    if ([registers isEqualToString:@"register"]) {
        btnNum = 4;
    }
    if (self.tabBarButtons.count == btnNum) {
        // 第一个按钮
        if (registers.length != 0) {
            [defaults removeObjectForKey:@"register"];
        }
        [self btnOnClick:btn];
    }
}

- (void)btnOnClick:(WYTabBarButton *)btn
{
    // 0.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:from:to:)]) {
//        if (3 == [[[NSUserDefaults standardUserDefaults] objectForKey:@"loginAfter"] intValue]) {
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginAfter"];
//            [self.delegate tabBar:self from:self.currentSelectedBtn.tag to:3];
//            return;
//        }

        [self.delegate tabBar:self from:self.currentSelectedBtn.tag to:btn.tag];
    }

    // 1.取消选中上一次选中的按钮
    self.currentSelectedBtn.selected = NO;
    // 2.选中当前的按钮
    btn.selected = YES;
    // 3.记录当前选中的按钮
    self.currentSelectedBtn = btn;    
}
- (void)selectIndex:(int)from to:(int)to
{
    self.currentSelectedBtn.selected = NO;
    self.currentSelectedBtn = (WYTabBarButton *)[self viewWithTag:to];
    self.currentSelectedBtn.selected = YES;
    
}

#pragma mark - 懒加载

- (NSMutableArray *)tabBarButtons
{
    if (!_tabBarButtons) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}
@end
