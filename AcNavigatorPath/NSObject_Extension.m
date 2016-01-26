//
//  NSObject_Extension.m
//  AcNavigatorPath
//
//  Created by Anc on 16/1/26.
//  Copyright © 2016年 Ancc. All rights reserved.
//


#import "NSObject_Extension.h"
#import "AcNavigatorPath.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[AcNavigatorPath alloc] initWithBundle:plugin];
        });
    }
}
@end
