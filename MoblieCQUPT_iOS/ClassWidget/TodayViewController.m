//
//  TodayViewController.m
//  ClassWidget
//
//  Created by user on 15/11/3.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#define kAPPGroupID @"group.com.mredrock.cyxbs"
#define kAppGroupShareNowWeek @"nowWeek"
#define kAppGroupShareWeekDataArray @"weekDataArray"


#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:kAPPGroupID];
    NSString *nowWeek = [shared stringForKey:kAppGroupShareNowWeek];
    NSArray *weakDataArray = [shared objectForKey:kAppGroupShareWeekDataArray];
    [shared synchronize];
    NSLog(@"共享数据%@:%@",nowWeek,weakDataArray);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
