//
//  EmptyClassViewController.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/3/4.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "EmptyClassViewController.h"
#import "PickView.h"

@interface EmptyClassViewController ()

@end

@implementation EmptyClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    PickView *view = [[PickView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:view];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
