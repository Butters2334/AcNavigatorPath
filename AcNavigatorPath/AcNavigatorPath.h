//
//  AcNavigatorPath.h
//  AcNavigatorPath
//
//  Created by Anc on 16/1/26.
//  Copyright © 2016年 Ancc. All rights reserved.
//

#import <AppKit/AppKit.h>

@class AcNavigatorPath;

static AcNavigatorPath *sharedPlugin;

@interface AcNavigatorPath : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end