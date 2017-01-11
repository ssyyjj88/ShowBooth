//
//  HPModuleItem.h
//  Demo
//
//  Created by syj on 17/1/10.
//  Copyright © 2017年 syj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WidgetBaseController.h"

@interface BoothModuleItem : NSObject

@property (strong, nonatomic) NSString *moduleKey;        // 组件的key值，与服务端交互的key
@property (strong, nonatomic) NSString *moduleName;       // 组件名称
@property (strong, nonatomic, readonly) WidgetBaseController *compWidget;  // 对应的widget

// 保持
@property (strong, nonatomic) UITableViewCell *tableViewCell;

// 判断模块的界面是否初始化
//@property (assign, nonatomic, readonly, getter=isUIBuild) BOOL UIBuild;

+ (BoothModuleItem *)moduleItemWithResp:(NSDictionary *)resp;

//// 合并两个Item
//- (void)merge:(HPModuleItem *)otherItem;

// 初始化UI
- (void)buildUI;

@end
