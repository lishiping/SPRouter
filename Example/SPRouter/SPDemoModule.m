//
//  SPDemoModule.m
//  SPRouter_Example
//
//  Created by lishiping on 2025/10/20.
//  Copyright © 2025 xiao ping ge. All rights reserved.
//

#import "SPDemoModule.h"
#import "SPDemoBController.h"

#import <SPRouter/SPRouter-umbrella.h>


@implementation SPDemoModule

SPROUTER_EXTERN_METHOD(SPDemoModule, pushVC, arg, callback) {
    NSString *name = [arg objectForKey:@"title"];
    
    SPDemoBController *bvc = [[SPDemoBController alloc] init];
    
    UIViewController *abc = UIApplication.sharedApplication.keyWindow.rootViewController;
    
    abc.title = name;
    [abc presentViewController:bvc animated:YES completion:^{
        callback(@{@"title":@"动画完成"});
    }];
    
    return bvc;
    
}

@end
