//
//  AcNavigatorPath.m
//  AcNavigatorPath
//
//  Created by Anc on 16/1/26.
//  Copyright © 2016年 Ancc. All rights reserved.
//

#import "AcNavigatorPath.h"
#import "ACXcodeFormatter.h"

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
        //
        unichar cf5                = NSF5FunctionKey;
        NSString *f5               = [NSString stringWithCharacters:&cf5 length:1];
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"打开当前ViewController.m" action:@selector(doMenuAction) keyEquivalent:f5];
        //默认为NSCommandKeyMask,设置为0不使用组合键
        [actionMenuItem setKeyEquivalentModifierMask:0];
        [actionMenuItem setTarget:self];
        [[menuItem submenu] addItem:actionMenuItem];
        //
        NSMenuItem *actionMenuItem2 = [[NSMenuItem alloc] initWithTitle:@"OpenFinderWithCode" action:@selector(doMenuAction2) keyEquivalent:f5];
        //默认为NSCommandKeyMask,设置为0不使用组合键
        [actionMenuItem2 setKeyEquivalentModifierMask:NSControlKeyMask];
        [actionMenuItem2 setTarget:self];
        [[menuItem submenu] addItem:actionMenuItem2];
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(consoleDidChange:)
                                                name:NSTextDidEndEditingNotification
                                              object:nil];
}
-(void)consoleDidChange:(NSNotification *)notification
{
    if([notification.object isKindOfClass:NSClassFromString(@"IDEConsoleTextView")])
    {
        NSString *string    = [[[notification.object layoutManager]firstTextView]string];
        NSArray *listString = [string componentsSeparatedByString:@"\n"];
        if(listString.count<=2)return;
        NSString *lastObject = listString[listString.count-2];
        //NSLog(@"notification  - %@",latObject);
        if([lastObject rangeOfString:@"AcNavigationFilePath"].location != NSNotFound)
        {
            NSArray *pathComm = [lastObject componentsSeparatedByString:@"AcNavigationFilePath - "];
            if(pathComm.count>=2)
            {
                [ACXcodeFormatter saveCurrentViewControllerClass:pathComm[1]];
            }
        }
    }
}
- (void)doMenuAction
{
    [ACXcodeFormatter openCurrentViewController];
}
//打开当前编辑框在路径栏的位置
//- (void)doMenuAction
//{
//    [XCFXcodeFormatter selectFileWithCurrentSourceCode];
//}
//打开当前编辑框文件的实际路径
- (void)doMenuAction2
{
    [ACXcodeFormatter openFinderWithCurrentSourceCode];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
