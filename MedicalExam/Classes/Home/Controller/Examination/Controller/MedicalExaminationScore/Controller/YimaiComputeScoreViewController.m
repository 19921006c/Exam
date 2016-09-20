//
//  YimaiComputeScoreViewController.m
//  DoctorPlatForm
//
//  Created by J on 16/8/29.
//  Copyright © 2016年 songzm. All rights reserved.
//

#import "YimaiComputeScoreViewController.h"
#import "YimaiMedicalExaminationScroeView.h"
#import "ExaminationListController.h"
@interface YimaiComputeScoreViewController ()

@end

@implementation YimaiComputeScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadScoreView];
}

- (void)loadScoreView{
    
    YimaiMedicalExaminationScroeView *view = [[[NSBundle mainBundle] loadNibNamed:@"YimaiMedicalExaminationScroeView" owner:self options:nil] lastObject];
    
    view.frame = self.view.bounds;
    
    view.userResultModel = _userResultModel;
    
    [self.view addSubview:view];

}
-(void)comeBack
{
    NSArray *array = self.navigationController.viewControllers;
    
    [self.navigationController popToViewController:[array objectAtIndex:array.count - 3] animated:YES];
}

@end
