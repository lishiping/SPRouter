//
//  SPViewController.m
//  SPRouter
//
//  Created by xiao ping ge on 10/20/2025.
//  Copyright (c) 2025 xiao ping ge. All rights reserved.
//

#import "SPViewController.h"

#import <SPRouter/SPRouter-umbrella.h>

@interface SPViewController ()

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *titleArray;

@end

@implementation SPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"测试组件间路由";
    self.titleArray = @[@"测试组件之间路由跳转"];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = self.titleArray[indexPath.row];
    
    if ([title isEqualToString:@"测试组件之间路由跳转"]) {
        
//        NSError *error;
//        id ret = [SPRouter openURL:@"router//SPDemoModule/pushVC" arg:@{@"title":@"测试跳转页面"} error:&error completion:^(id  _Nullable object) {
//            NSLog(@"打印==%@",object);
//        }];
        
        id ret = [SPRouter openURL:@"router://SPDemoModule/pushVC" arg:@{@"title":@"测试跳转页面"} error:nil completion:^(id  _Nullable object) {
            NSLog(@"打印==%@",object);
        }];
                        
        NSLog(@"打印返回值==%@",ret);
        
    }
}



-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height-44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}


@end
