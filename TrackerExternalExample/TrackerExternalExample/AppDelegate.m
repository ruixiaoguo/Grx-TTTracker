//
//  AppDelegate.m
//  TrackerExternalExample
//
//  Created by fengyadong on 2017/5/3.
//  Copyright © 2017年 toutiao. All rights reserved.
//

#import "AppDelegate.h"
#import <TTTracker/TTTracker.h>
#import <TTTracker/TTInstallIDManager.h>
#import <TTTracker/TTABTestConfFetcher.h>
#import <TTTracker/TTInstallIDManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //配置
    [[TTTracker sharedInstance] setConfigParamsBlock:^NSDictionary * _Nullable{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:@"123455" forKey:@"user_unique_id"];
        
        return [params copy];
    }];
    
    [[TTTracker sharedInstance] setCustomHeaderBlock:^NSDictionary<NSString *,id> *{
        NSMutableDictionary *customParams = [NSMutableDictionary dictionary];
        [customParams setValue:@(1) forKey:@"user_is_login"];
        
        return [customParams copy];
    }];
    
    //DEBUG模式配置
    [[TTTracker sharedInstance] setIsInHouseVersion:YES];
    [[TTTracker sharedInstance] setDebugLogServerHost:@"10.2.201.7:10304"];
    
   ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //初始化appID和自定义参数
//    [TTTracker startWithAppID:@"10008" channel:@"local_test" appName:@"_test"];
    //可控制初始化
    [[TTTracker sharedInstance] setSessionEnable:NO];
    [TTTracker startWithAppID:@"10008" channel:@"local_test" appName:@"_test"];

    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //统计埋点
    for (NSUInteger i = 0; i < 10; i++) {
//        [TTTracker eventV3:@"toutiao" params:@{@"is_log_in":@(1)}];
        // 可控制埋点
        [TTTracker eventV3:@"toutiao" params:@{@"is_log_in":@(1)}];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [TTTracker eventV3:@"tracker" params:@{@"user_id":@"123"}];
        });
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    NSNumber *color = [[TTABTestConfFetcher sharedInstance] getConfig:@"btnColor" defaultValue:@(0)];
    NSLog(@"color是：%ld",(long)[color longValue]);
    
    
    [[TTInstallIDManager sharedInstance] setCurrentUserUniqueID:@"1234567" didRetriveSSIDBlock:^(NSString *deviceID, NSString *installID, NSString *ssID) {
        NSLog(@"当前用户的ssid是：%@",ssID);
    }];
    
    [[TTABTestConfFetcher sharedInstance] startFetchABTestConf:^(NSDictionary *allConfigs) {
        NSLog(@"%@", [allConfigs description]);
    }];
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //Game
//    [TTTracker registerEventByMethod:@"wechat" isSuccess:YES];
//    //支付
//    [TTTracker purchaseEventWithContentType:@"mingwen"
//                                contentName:@"qiangjian"
//                                  contentID:@"2345556"
//                              contentNumber:100
//                             paymentChannel:@"weixin"
//                                   currency:@"rmb"
//                            currency_amount:80000
//                                  isSuccess:YES];
    
    return YES;
}
@end
