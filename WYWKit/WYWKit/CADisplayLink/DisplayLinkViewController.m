//
//  DisplayLinkViewController.m
//  WYWKit
//
//  Created by 王永旺 on 2022/6/23.
//  Copyright © 2022 WYW. All rights reserved.
//

#import "DisplayLinkViewController.h"
#import "WYWMacro.h"
#import "WYWFPSLabel.h"

@interface DisplayLinkViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray <NSString *>*sourceArray;

@end

static NSString *const kCellReuseIdentifier = @"CellReuseIdentifier";
//! 模拟卡顿因子
static NSInteger const kCatonFator = 20;

@implementation DisplayLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareData];
    [self setupUI];
}

- (void)prepareData {
    
    NSInteger count = 100;
    
    NSMutableArray <NSString *>*mArray = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger index = 0; index < count; index++) {
        if ([self isCatonCondition:index]) {
            [mArray addObject: [NSString stringWithFormat:@"模拟卡顿%zd", index]];
        } else {
            [mArray addObject:[NSString stringWithFormat:@"正常展示%zd", index]];
        }
    }
    _sourceArray = [mArray copy];
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTableView];
    [self setupDisplayLinkLabel];
}

- (void)setupDisplayLinkLabel {
        
    WYWFPSLabel *fpsLabel = [WYWFPSLabel new];
    fpsLabel.center = self.view.center;
    [self.view addSubview:fpsLabel];
}

- (void)setupTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellReuseIdentifier];
    }
    cell.textLabel.text = _sourceArray[indexPath.row];
    if ([self isCatonCondition:indexPath.row]) {
        cell.textLabel.backgroundColor = [UIColor redColor];
    } else {
        cell.textLabel.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self isCatonCondition:indexPath.row]) {
        sleep(1.0);
    }
}

//! 卡顿情况
- (BOOL)isCatonCondition:(NSInteger)index {
    
    return index % kCatonFator == 0 && index > 0;
}

- (void)dealloc {
    
    WYWLog(@"%s", __FUNCTION__);
}

// 一些测试的代码
- (void)test {
    
    /*
    WYWFPSLabel *fpsLabel = [[WYWFPSLabel alloc] initWithFrame:CGRectMake(.0, .0, 100.0, 44.0)];
    WYWFPSLabel *fpsLabel = [[WYWFPSLabel alloc] initWithFrame:CGRectMake(.0, .0, 0, 0.0)];
    WYWFPSLabel *fpsLabel = [WYWFPSLabel new];
    fpsLabel.text = @"FPS 60";
    [fpsLabel sizeToFit];
    WYWLog(@"自适应大小: %@", NSStringFromCGSize(fpsLabel.frame.size));
    fpsLabel.center = self.view.center;
    [self.view addSubview:fpsLabel];
     
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         sleep(3.0);
     });
     */
}

@end


