//
//  HPModuleItem.m
//  Demo
//
//  Created by syj on 17/1/10.
//  Copyright © 2017年 syj. All rights reserved.
//

#import "BoothModuleItem.h"
#import "PACompResult.h"
#import "BannerWidgetController.h"

@interface BoothModuleItem()
{
    
}

@property (strong, nonatomic) PACompResult *compResult;  // 对应的widget

@end

@implementation BoothModuleItem
+ (BoothModuleItem *)moduleItemWithResp:(NSDictionary *)resp {
    if (nil == resp) {
        return nil;
    }
    
    BoothModuleItem *moduleItem = [[BoothModuleItem alloc] init];
    moduleItem.moduleKey = [resp objectForKey:@"code"];
    moduleItem.moduleName = [resp objectForKey:@"title"];
    
    return moduleItem;
}

- (WidgetBaseController *)compWidget {
    if ([_moduleKey isEqualToString:@"APP_HOME_TOP"]) {
        if (nil == _compResult) {
            BannerWidgetController *vc = [[BannerWidgetController alloc] init];
            self.compResult = [[PACompResult alloc] init];
            _compResult.viewController = vc;
        }
    }
    
    if ([_compResult.viewController isKindOfClass:[WidgetBaseController class]]) {
        return (WidgetBaseController *)_compResult.viewController;
    }
    
    return nil;
}

@end
