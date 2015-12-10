//
//  TodayViewController.m
//  ClassWidget
//
//  Created by user on 15/11/3.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//
#warning 先放这测试,remove
#define kAPPGroupID @"group.com.mredrock.cyxbs"
#define kAppGroupShareNowDay @"nowDay"
#define kAppGroupShareThisWeekArray @"thisWeekArray"
#define kAutoUpdateInterval 60*5

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>
@property (strong, nonatomic) NSArray *todayClassArray;
@end

@implementation TodayViewController

- (void)viewWillAppear:(BOOL)animated{
    [self autoUpdateTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (NSArray *)todayClassArrayFromWeakClassArray:(NSArray *)weakClassArray{
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    NSInteger today =  [componets weekday];
    today -= 1; //从周日开始转为从周一开始
    today = today>0?today:7;
    NSLog(@"%@",[NSDate date]);
    
    NSMutableArray *mutableToDayClassArray = [NSMutableArray array];
    for (NSDictionary *row in weakClassArray) {
        NSString *tmpString = row[@"day"];
        if ([tmpString integerValue] == today) {
            [mutableToDayClassArray addObject:row];
        }
    }
    
    NSLog(@"今日周%ld,数据:%@",today,mutableToDayClassArray);
    return mutableToDayClassArray;
}

- (void)autoUpdateTimer{
    NSTimer *timer = [[NSTimer alloc]
                initWithFireDate:[NSDate distantPast]
                        interval:kAutoUpdateInterval
                        target:self
                        selector:@selector(updateTodayClass)
                        userInfo:nil
                        repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
}

- (void)updateTodayClass{
    
    [self widgetPerformUpdateWithCompletionHandler:^(NCUpdateResult result) {
        NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:kAPPGroupID];
        NSArray *weakDataArray = [shared objectForKey:kAppGroupShareThisWeekArray];
        self.todayClassArray = [self todayClassArrayFromWeakClassArray:weakDataArray];
    }];
    NSLog(@"更新今日课程数据");
}
@end
