//
//  AppDelegate.m
//  MoblieCQUPT_iOS
//
//  Created by user on 15/8/18.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import <BugHD/BugHD.h> 

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //BUGHD
    [BugHD handleCrashWithKey:@"24f1019e4d09ab778e0b9f2780ae4de0"];
    //友盟统计
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([userDefault objectForKey:@"time"] != nil) {
        NSDate *currentTime = [NSDate date];
        NSDate *dataTime = [userDefault objectForKey:@"time"];
        if ([dataTime timeIntervalSinceDate:currentTime] > 0) {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            id view = [storyBoard instantiateViewControllerWithIdentifier:@"MainNavigation"];
            self.window.rootViewController = view;
        }else {
            [userDefault removeObjectForKey:@"stuNum"];
            [userDefault removeObjectForKey:@"idNum"];
            [userDefault removeObjectForKey:@"dataArray"];
            [userDefault removeObjectForKey:@"time"];
            [userDefault synchronize];
            LoginViewController *login = [[LoginViewController alloc]init];
            self.window.rootViewController = login;
        }
    }else {
        LoginViewController *login = [[LoginViewController alloc]init];
        self.window.rootViewController = login;
    }

    
    [MobClick startWithAppkey:@"55dc094a67e58e92f30048eb" reportPolicy:BATCH   channelId:@"Web"];
    [MobClick setAppVersion:@"V1.0.0"];
    [MobClick checkUpdate];
    [MobClick updateOnlineConfig];

    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
//    ORWRequestCache *cache = [[ORWRequestCache alloc] init];
//    NSLog(@"%d",[cache saveDataWithDictionary:@{@"test":@"1",@"haha":@2} url:@"http://122222223.com"]);
//    NSLog(@"%@",[cache filePath]);
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:20];
    
    /*
     
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
     
     [formatter setDateFormat:@"HH:mm:ss"];
     
     NSDate *now = [formatter dateFromString:@"15:00:00"];//触发通知的时间
     
     */
    
    //chuagjian
    /******/
//    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];//注册本地推送
//    
//    UILocalNotification *noti = [[UILocalNotification alloc] init];
//    
//    if (noti) {
//        
//        //设置推送时间
//        
//        noti.fireDate = date;//=now
//        
//        //设置时区
//        
//        noti.timeZone = [NSTimeZone defaultTimeZone];
//        
//        //设置重复间隔
//        
//        noti.repeatInterval = 0;
//        
//        //推送声音
//        
//        noti.soundName = UILocalNotificationDefaultSoundName;
//        
//        //内容
//        
//        noti.alertBody = @"推送内容";
//        
//        //显示在icon上的红色圈中的数子
//        
//        noti.applicationIconBadgeNumber = 1;
//        
//        //设置userinfo 方便在之后需要撤销的时候使用
//        
//        NSDictionary *infoDic = [NSDictionary dictionaryWithObject:@"name" forKey:@"key"];
//        
//        noti.userInfo = infoDic;
//        
//        //添加推送到uiapplication
//        
//        UIApplication *app = [UIApplication sharedApplication];
//        
//        [app scheduleLocalNotification:noti];
    
//    }
    

    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notification

{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"接收到本地提醒 in app"
                          
                                                    message:notification.alertBody
                          
                                                   delegate:nil
                          
                                          cancelButtonTitle:@"确定"
                          
                                          otherButtonTitles:nil];
    
    [alert show];
    
    //这里，你就可以通过notification的useinfo，干一些你想做的事情了
    
    application.applicationIconBadgeNumber -= 1;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
