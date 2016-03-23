//
//  ACLogIDEConsoleArea.m
//  AcNavigatorPath
//
//  Created by Anc on 16/3/23.
//  Copyright © 2016年 Ancc. All rights reserved.
//

#import "ACLogIDEConsoleArea.h"
#import "MethodSwizzle.h"
#import <objc/runtime.h>

@interface ACLogIDEConsoleArea ()

@end

@implementation ACLogIDEConsoleArea

+ (void)load {
    //Class clazz = NSClassFromString(@"IDEConsoleArea");
    //IMP hookedShouldAppendItemIMP = class_getMethodImplementation([ACLogIDEConsoleArea class],
    //                                                              @selector(_shouldAppendItem:));
    //
    //[MethodSwizzleHelper swizzleMethodForClass:clazz
    //                                  selector:@selector(_shouldAppendItem:)
    //                            replacementIMP:hookedShouldAppendItemIMP
    //                             isClassMethod:NO];
    
    //DVTSourceTextView
}

- (BOOL)_shouldAppendItem:(id)obj {
    static IMP originalIMP = nil;
    if (originalIMP == nil) {
        Class clazz = NSClassFromString(@"IDEConsoleArea");
        SEL selector = @selector(_shouldAppendItem:);
        originalIMP = [MethodSwizzleHelper originalIMPForClass:clazz selector:selector];
    }
    
    //if (obj == nil) {
    //    return [originalIMP(self, _cmd, obj) boolValue];
    //}
    //
    //NSMutableDictionary *consoleItemsMap = [MCLog consoleItemsMap];
    //NSString *consoleItemsKey = hash(self);
    //
    //MCOrderedMap *originConsoleItems = consoleItemsMap[consoleItemsKey];
    //if (!originConsoleItems) {
    //    originConsoleItems = [[MCOrderedMap alloc] init];
    //    originConsoleItems.maximumnItemsCount = 65535;
    //    consoleItemsMap[consoleItemsKey] = originConsoleItems;
    //}
    //[originConsoleItems addObject:obj forKey:@([obj timestamp])];
    //
    //BOOL isInputItem           = [[obj valueForKey:@"input"] boolValue];
    //BOOL isPromptItem          = [[obj valueForKey:@"prompt"] boolValue];
    //BOOL isoutputRequestByUser = [[obj valueForKey:@"outputRequestedByUser"] boolValue];
    //BOOL isDebuggerAdaptor     = [[obj valueForKey:@"adaptorType"] hasSuffix:@".Debugger"];
    //
    //NSInteger filterMode = [[self valueForKey:@"filterMode"] intValue];
    //BOOL shouldShowLogLevel = YES;
    //if (filterMode >= MCLogLevelVerbose) {
    //    shouldShowLogLevel =
    //    [obj logLevel] >= filterMode || isInputItem || isPromptItem || isoutputRequestByUser || isDebuggerAdaptor;
    //} else {
    //    shouldShowLogLevel = [originalIMP(self, _cmd, obj) boolValue];
    //}
    //
    //if (!shouldShowLogLevel) {
    //    return NO;
    //}
    //
    //NSSearchField *searchField = getSearchField(self);
    //if (searchField == nil) {
    //    return YES;
    //}
    //if (!searchField.consoleArea) {
    //    searchField.consoleArea = (MCLogIDEConsoleArea *)self;
    //}
    //
    //if (searchField.stringValue.length == 0) {
    //    [[MCLog filterPatternsMap] removeObjectForKey:consoleItemsKey];
    //    return YES;
    //}
    //
    //// Remove prefix log pattern
    //NSString *content = [obj content];
    //NSRange range = NSMakeRange(0, content.length);
    //
    //NSRegularExpression *logRegex = logItemPrefixPattern();
    //content = [logRegex stringByReplacingMatchesInString:content
    //                                             options:(NSRegularExpressionCaseInsensitive |
    //                                                      NSRegularExpressionDotMatchesLineSeparators)
    //                                               range:range
    //                                        withTemplate:@""];
    //
    //// Test with user's regex pattern
    //NSRegularExpression *regex = [MCLog filterPatternsMap][consoleItemsKey];
    //NSError *error;
    //if (regex == nil || ![regex.pattern isEqualToString:searchField.stringValue]) {
    //    regex = [NSRegularExpression regularExpressionWithPattern:searchField.stringValue
    //                                                      options:(NSRegularExpressionCaseInsensitive |
    //                                                               NSRegularExpressionDotMatchesLineSeparators)
    //                                                        error:&error];
    //    if (regex == nil) {
    //        // display all if with regex is error
    //        MCLogger(@"error:%@", error);
    //        return YES;
    //    }
    //    [MCLog filterPatternsMap][consoleItemsKey] = regex;
    //}
    //
    //range = NSMakeRange(0, content.length);
    //NSArray *matches = [regex matchesInString:content options:0 range:range];
    //if ([matches count] > 0 || isInputItem || isPromptItem || isoutputRequestByUser || isDebuggerAdaptor) {
    //    return YES;
    //}
    
    return YES;
}

@end
