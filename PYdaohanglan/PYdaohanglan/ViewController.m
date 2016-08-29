//
//  ViewController.m
//  PYdaohanglan
//
//  Created by Apple on 16/7/25.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "MXNavigationBarManager.h"

#define SCREEN_RECT [UIScreen mainScreen].bounds
static const CGFloat headerImageHeight = 200;

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *myTableView;
@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, self.view.frame.size.width, self.view.frame.size.height + 64)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;

    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, headerImageHeight)];
    headerImageView.image = [UIImage imageNamed:@"5.jpg"];
    self.myTableView.tableHeaderView = headerImageView;
    
    [self.view addSubview:self.myTableView];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.myTableView.delegate = nil;
    [MXNavigationBarManager reStoreWithZeroStatus];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor cyanColor];
    self.navigationItem.title = @"滑动改变颜色";
//    self.navigationController.navigationBar.translucent = YES;

    [self initBarManager];
}
- (void)initBarManager {
    [MXNavigationBarManager managerWithController:self];
    [MXNavigationBarManager setBarColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];

    [MXNavigationBarManager setTintColor:[UIColor orangeColor]];
    [MXNavigationBarManager setStatusBarStyle:(UIStatusBarStyleDefault)];
    [MXNavigationBarManager setZeroAlphaOffset:-64];
    [MXNavigationBarManager setFullAlphaOffset:0];
    [MXNavigationBarManager setFullAlphaTintColor:[UIColor cyanColor]];
    [MXNavigationBarManager setFullAlphaBarStyle:(UIStatusBarStyleLightContent)];
}


#pragma mark ---- scrollView 代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [MXNavigationBarManager changeAlphaWithCurrentOffset:scrollView.contentOffset.y];
    //下拉,改变导航栏位置
    if (scrollView.contentOffset.y < -84) {
        //隐藏导航栏
            self.navigationController.navigationBar.hidden = YES;

    } else if (scrollView.contentOffset.y >= -84){
        self.navigationController.navigationBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 64);
        self.navigationController.navigationBar.hidden = NO;

    }
}
#pragma mark ======= tab代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"11";
    return cell;

}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
