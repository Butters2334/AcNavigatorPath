//
//  AcNavigatorPath.m
//  AcNavigatorPath
//
//  Created by Anc on 16/1/26.
//  Copyright © 2016年 Ancc. All rights reserved.
//

#import "AcNavigatorPath.h"
#import "XCFXcodeFormatter.h"

@interface AcNavigatorPath()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation AcNavigatorPath

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    //removeObserver
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    // Create menu items, initialize UI, etc.
    // Sample Menu Item:
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (menuItem) {
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        unichar cf5                = NSF5FunctionKey;
        NSString *f5               = [NSString stringWithCharacters:&cf5 length:1];
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"NavigatorPath" action:@selector(doMenuAction) keyEquivalent:f5];
        //默认为NSCommandKeyMask,设置为0不使用组合键
        [actionMenuItem setKeyEquivalentModifierMask:0];
        [actionMenuItem setTarget:self];
        [[menuItem submenu] addItem:actionMenuItem];
    }
}

// Sample Action, for menu item:
- (void)doMenuAction
{
    NSError *error;
    //[XCFXcodeFormatter formatActiveFileWithError:&error];
    //<IDESourceCodeDocument: 0x11bf8e8a0> URL: file:///Users/huajianma/Nut/Ancy/GitHub/XBookmark/XBookmark/XBookmark.m
    
    
    [XCFXcodeFormatter selectFileWithcurrentSourceCode];
    

    if(error)
    {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:error.domain];
        [alert runModal];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
