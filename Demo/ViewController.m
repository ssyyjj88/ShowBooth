//
//  ViewController.m
//  Demo
//
//  Created by syj on 17/1/10.
//  Copyright © 2017年 syj. All rights reserved.
//

#import "ViewController.h"
#import "MainTableViewCell.h"
#import "BoothModuleItem.h"
#import "WidgetBaseController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,WidgetDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *components;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self buildTableView];
    [self getModules];
}

- (void)getModules
{
    [self performSelector:@selector(download) withObject:nil afterDelay:1];
}

-(void)download
{
    //模拟获取展位信息
    NSDictionary *dic = @{@"code":@"APP_HOME_TOP",@"title":@"title1"};
    NSDictionary *dic2 = @{@"code":@"APP_HOME_BOOTH2",@"title":@"title2"};
    NSDictionary *dic3 = @{@"code":@"APP_HOME_BOOTH3",@"title":@"title3"};
    NSDictionary *dic4 = @{@"code":@"APP_HOME_BOOTH4",@"title":@"title4"};
    NSDictionary *dic5 = @{@"code":@"APP_HOME_BOOTH5",@"title":@"title5"};
    BoothModuleItem *item1 = [BoothModuleItem moduleItemWithResp:dic];
    BoothModuleItem *item2 = [BoothModuleItem moduleItemWithResp:dic2];
    BoothModuleItem *item3 = [BoothModuleItem moduleItemWithResp:dic3];
    BoothModuleItem *item4 = [BoothModuleItem moduleItemWithResp:dic4];
    BoothModuleItem *item5 = [BoothModuleItem moduleItemWithResp:dic5];
    
    [self mergeModules:@[item1,item2,item3,item4,item5]];
    [self buildModuleUIs];
    
    [_tableView reloadData];
}

- (void)mergeModules:(NSArray *)nmodule {
    if ([_components count] > 0) {
//        [nmodule enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            HPModuleItem *nItem = obj;
//            
//            NSUInteger index = [_comps indexOfObject:nItem];
//            if (index != NSNotFound ) {
//                HPModuleItem *oItem = [_comps objectAtIndex:index];
//                [nItem merge:oItem];
//            }
//        }];
    }
    
    self.components = nmodule;
}

- (void)buildModuleUIs {
    for (BoothModuleItem *comp in _components) {
        WidgetBaseController *widget = [comp compWidget];
        //可以选择刷新
        
    }
}

-(void)buildTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollsToTop = YES;
    [self.view addSubview:_tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BoothModuleItem *comp = [self.components objectAtIndex:indexPath.section];
    WidgetBaseController *widget = [comp compWidget];
    widget.delegate = self;
    
    return [widget calcHeight];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.components count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BoothModuleItem *comp = [self.components objectAtIndex:indexPath.section];
    if (comp.tableViewCell == nil) {
        
        WidgetBaseController *widget = [comp compWidget];
        widget.delegate = self;
        
        MainTableViewCell *cell = [[MainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:widget.view];
        
        widget.view.frame = cell.contentView.bounds;
        widget.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        comp.tableViewCell = cell;
        
        [widget homepageWillAppear];
        if (widget != nil) {
            [self addChildViewController:widget];
        }
        [widget homepageDidAppear];
        [widget refreshData];
    }
    
    return comp.tableViewCell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
