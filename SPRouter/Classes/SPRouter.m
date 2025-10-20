//
//  SPRouter.m
//  SPRouter
//
//  Created by lishiping on 2025/10/20.
//

#import "SPRouter.h"

@implementation SPRouter

+ (nullable id)openURL:(NSString *)urlString arg:(nullable id)arg error:(NSError **)error completion:(nullable SPRouterCompletion)completion
{
    NSString *classNameString = nil;
    NSString *methodString = nil;
    NSDictionary *parameters = arg;
    id callback = completion;
    id ret = nil;
    
    if ([urlString hasPrefix:@"router://"]){
        NSString *stringCom = [urlString substringFromIndex:9];
        NSArray *stringArr = [stringCom componentsSeparatedByString:@"/"];
        if (stringArr.count>=2) {
            classNameString = [stringArr objectAtIndex:0];
            methodString = [stringArr objectAtIndex:1];
        }
    }

    if (!classNameString || !methodString) {
        NSLog(@"路由字符串格式不对，应该是router://xxx/xxx");
        if (error) {
            *error = [NSError errorWithDomain:@"路由字符串格式不对，应该是router://xxx/xxx" code:0 userInfo:@{}];
        }
        return nil;
    }
    
    NSString *selString = [NSString stringWithFormat:@"routerHandle_%@_%@:callback:",classNameString,methodString];

    Class clazz = NSClassFromString(classNameString);
   
    if (clazz) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        SEL sel = NSSelectorFromString(selString);
#pragma clang diagnostic pop
        if ([clazz respondsToSelector:sel]) {
            IMP imp = [clazz methodForSelector:sel];
            //定义函数指针，消除告警
            id (*func)(id, SEL, NSDictionary *, id) = (void *)imp;
            ret = func(clazz, sel,parameters,callback);
        }
        else{
            NSLog(@"组件:%@未实现方法:%@",classNameString,methodString);
            if (error) {
                *error = [NSError errorWithDomain:[NSString stringWithFormat:@"组件:%@未实现方法:%@",classNameString,methodString] code:0 userInfo:@{}];
            }
        }
    }else{
        NSLog(@"未找到组件:%@",classNameString);
        if (error) {
            *error = [NSError errorWithDomain:[NSString stringWithFormat:@"未找到组件:%@",classNameString] code:0 userInfo:@{}];
        }
    }
    
    return ret;
}

@end
