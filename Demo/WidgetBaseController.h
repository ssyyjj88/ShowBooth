//
//  WidgetBaseController.h
//  Demo
//
//  Created by syj on 17/1/10.
//  Copyright © 2017年 syj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WidgetBaseController;

@protocol WidgetDelegate <NSObject>

@optional

- (void)widgetWillChangeHeight:(WidgetBaseController *)widget;
- (void)widgetDidChangedHeight:(WidgetBaseController *)widget;
// 获取导航
- (UINavigationController *)homePageNavigationController;

@end

@interface WidgetBaseController : UIViewController

@property (weak, nonatomic) id<WidgetDelegate> delegate;

- (CGFloat)calcHeight;
- (void)homepageWillAppear;
- (void)homepageDidAppear;
- (void)homepageWillDisappear;
- (void)homepageDidDisappear;

- (void)refreshData;

@end
