//
//  SPRouter.h
//  SPRouter
//
//  Created by lishiping on 2025/10/20.
//

/*
 以下是组件之间通讯方案
 功能：解耦业务组件之间互相依赖逻辑
 组件业务A与业务B之间不能有相互的引用，不可以直接调用，调用必须通过路由控制器调用完成
 
 接收方需实现：
 1.import该类
 2.实现接受方法
 SPROUTER_EXTERN_METHOD(SPDemoModule, pushVC, arg, callback) {
    // do something
    return @"abc";
 }
 
 发送方需实现：
 1.import该类
 2.实现接受方法
 NSError *error;
 id ret = [SPRouter openURL:@"router://SPDemoModule/pushVC" arg:@{@"title":@"测试跳转页面"} error:&error completion:^(id  _Nullable object) {
     NSLog(@"打印==%@",object);
 }];
 
 或者
 
 id ret = [SPRouter openURL:@"router://SPDemoModule/pushVC" arg:@{@"title":@"测试跳转页面"} error:nil completion:^(id  _Nullable object) {
     NSLog(@"打印==%@",object);
 }];
 
 */


#import <Foundation/Foundation.h>

// 完成回调的block，可传任意oc对象
typedef void (^SPRouterCompletion)( id __nullable object);

// 组件对外公开接口, m组件名, i接口名, p(arg)接收参数, c(callback)回调block
#define SPROUTER_EXTERN_METHOD(m,i,p,c) + (id) routerHandle_##m##_##i:(NSDictionary*)arg callback:(SPRouterCompletion)callback

NS_ASSUME_NONNULL_BEGIN

@interface SPRouter : NSObject

/**
 *  @author lishiping, 2021-09-20 20:10:30
 *
 *  组件通信（输入方）
 *
 *
 *  @return 任意oc对象
 *
 *  @param urlString        - Scheme的URL,如 router://MyClassName/userInfo, 通过url query传入的参数获取为字典类型
 *
 *  @param arg                     - arg 为任意oc对象, nil.
 *
 *  @param completion     - completion 通信完后相应的callback, 业务输出方自行维护该block
 *
 */

+ (nullable id)openURL:(nonnull NSString *)urlString arg:(nullable id)arg error:(NSError*__nullable *__nullable)error completion:(nullable SPRouterCompletion)completion;


@end

NS_ASSUME_NONNULL_END
