//
//  BannerWidgetController.m
//  Demo
//
//  Created by syj on 17/1/10.
//  Copyright © 2017年 syj. All rights reserved.
//

#import "BannerWidgetController.h"

@interface BannerWidgetController ()

//模拟是否有数据
@property NSInteger numberOfItems;

@end

@implementation BannerWidgetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *str = @"Banner show";
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 300, 100)];
    label.text = str;
    [self.view addSubview:label];
    
    //模拟拉取到数据
    [self performSelector:@selector(updateData) withObject:nil afterDelay:3];
}

-(void)updateData
{
    self.numberOfItems = 4;
    if ([self.delegate respondsToSelector:@selector(widgetWillChangeHeight:)]) {
        [self.delegate widgetWillChangeHeight:self];
    }
}

- (CGFloat)calcHeight
{
    //拉取到数据时才显示
    if (self.numberOfItems > 0) {
        return 100;
    }
    else {
        return 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
