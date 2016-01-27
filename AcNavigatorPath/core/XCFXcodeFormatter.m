//
// Created by Benoît on 11/01/14.
// Copyright (c) 2014 Pragmatic Code. All rights reserved.
//

#import "XCFXcodeFormatter.h"
#import "XCFXcodePrivate.h"
#import <objc/runtime.h>
@implementation NSObject (AllProerty)
- (NSString *)allProperty
{
    NSMutableString *allPP = [NSMutableString new];
    unsigned int outCount;
    objc_property_t *pp = class_copyPropertyList([self class], &outCount);
    for (NSInteger index = 0; index < outCount; index++) {
        objc_property_t property = pp[index];
        NSString *name = @(property_getName(property));
        //        NSString *att  = @(property_getAttributes(property));
        NSString *value = [self valueForKey:name];
        [allPP appendFormat:@"\n%@ = %@ \n", name, value];
    }
    if (allPP.length > 0) {
        [allPP deleteCharactersInRange:NSMakeRange(allPP.length-1, 1)];
    }
    return allPP;
}

@end


@implementation XCFXcodeFormatter

/**
 *  打开当前编辑代码在finder中的位置
 */
+(void)openFinderWithCurrentSourceCode
{
    NSURL *sourceCodePathURL = [self currentSourceCodePathURL];
    NSString *sourceCodePath = sourceCodePathURL.absoluteString.lowercaseString;
    
}

+(void)selectFileWithCurrentSourceCode
{
    //当前编辑框
    NSURL *sourceCodePathURL = [self currentSourceCodePathURL];
    NSString *sourceCodePath = sourceCodePathURL.absoluteString.lowercaseString;
    //处理侧栏层级
    id currentWindowController = [[NSApp keyWindow] windowController];
    if (sourceCodePath && [currentWindowController isKindOfClass:NSClassFromString(@"IDEWorkspaceWindowController")])
    {
        IDEWorkspaceWindowController *workspaceController = currentWindowController;
        IDEWorkspaceTabController *workspaceTabController = [workspaceController activeWorkspaceTabController];
        IDENavigatorArea *navigatorArea                   = [workspaceTabController navigatorArea];
        NSArrayController *arrayController                = [navigatorArea extensionsController];
        for(NSInteger index=0;index<[arrayController.arrangedObjects count];index++)
        {
            DVTChoice *choice       = arrayController.arrangedObjects[index];
            DVTExtension *extension = [choice representedObject];
            //找到路径栏
            if([extension.identifier isEqualToString:@"Xcode.IDEKit.Navigator.Structure"])
            {
                [arrayController setSelectionIndex:index];
                break;
            }
        }
        
        id currentNavigator = [navigatorArea currentNavigator];
        if ([currentNavigator isKindOfClass:NSClassFromString(@"IDEStructureNavigator")])
        {
            IDEStructureNavigator *structureNavigator = currentNavigator;
            NSSet *set     = [structureNavigator mutableExpandedItems];
            NSArray *array = [set allObjects];
            //暂时没搞清楚为什么会有多个group(排除项目文件外还有两个)
            for(IDEContainerFileReferenceNavigableItem *rootGroup in array)
            {
                //if([rootGroup isKindOfClass:NSClassFromString(@"IDEContainerFileReferenceNavigableItem")])
                {
                    //IDEFileReference *fileRference = [rootGroup representedObject];
                    //直接获取项目级别
                    //if([fileRference.path hasSuffix:@".xcodeproj"])
                    {
                        for(IDENavigableItem *item in [rootGroup childItems])
                        {
                            if([self recursivlyNavigableItem:item searchFilePath:sourceCodePath])
                            {
                                //.xcodeproj级别,root级别打不开
                                //[self openFolderWithGroupNavigableItem:rootGroup];
                                return ;
                            }
                        }
                    }
                }
            }
            NSLog(@"end");
        }
    }
}

/**
 *  在路径中查询与传入路径相同的文件
 *  return YES时需要将当前item父级文件夹打开(openFolderWithGroupNavigableItem)
 */
+ (BOOL)recursivlyNavigableItem:(IDENavigableItem *)navigableItem searchFilePath:(NSString *)sourceCodePath
{
    if ([navigableItem isKindOfClass:NSClassFromString(@"IDEGroupNavigableItem")])
    {
        IDEGroupNavigableItem *groupNavigableItem = (IDEGroupNavigableItem *)navigableItem;
        for(IDENavigableItem *item in groupNavigableItem.childItems)
        {
            if([self recursivlyNavigableItem:item searchFilePath:sourceCodePath])
            {
                [self openFolderWithGroupNavigableItem:groupNavigableItem];
                return YES;
            }
        }
    }else if ([navigableItem isKindOfClass:NSClassFromString(@"IDEFileNavigableItem")]){
        IDEFileNavigableItem *fileNavigableItem = (IDEFileNavigableItem *)navigableItem;
        NSString *itemFilePath = fileNavigableItem.fileURL.absoluteString.lowercaseString;
        if([sourceCodePath isEqualToString:itemFilePath])
        {
            //NSLog(@"选中 -  %@",fileNavigableItem);
            [self setStrureNavigatorSelectedObjects:@[fileNavigableItem]];
            return YES;
        }
    }
    return NO;
}


/**
 *  部分文件夹会随着文件被选中而自动打开,不能保证所有文件夹都正常
 *
 *  @param groupNavigableItem 需要打开的文件夹
 */
+(void)openFolderWithGroupNavigableItem:(IDEGroupNavigableItem *)groupNavigableItem
{
    //暂时找不到打开侧边栏文件夹的办法
    NSLog(@"%@ - %@",NSStringFromSelector(_cmd),groupNavigableItem);
}

+(void)setStrureNavigatorSelectedObjects:(NSArray *)selectedObjects
{
    id currentWindowController = [[NSApp keyWindow] windowController];
    if ([currentWindowController isKindOfClass:NSClassFromString(@"IDEWorkspaceWindowController")]) {
        IDEWorkspaceWindowController *workspaceController = currentWindowController;
        IDEWorkspaceTabController *workspaceTabController = [workspaceController activeWorkspaceTabController];
        IDENavigatorArea *navigatorArea                   = [workspaceTabController navigatorArea];
        NSArrayController *arrayController                = [navigatorArea extensionsController];
        for(NSInteger index=0;index<[arrayController.arrangedObjects count];index++)
        {
            DVTChoice *choice = arrayController.arrangedObjects[index];
            DVTExtension *extension = [choice representedObject];
            //找到路径栏
            if([extension.identifier isEqualToString:@"Xcode.IDEKit.Navigator.Structure"])
            {
                [arrayController setSelectionIndex:index];
                break;
            }
        }
        
        id currentNavigator = [navigatorArea currentNavigator];
        if ([currentNavigator isKindOfClass:NSClassFromString(@"IDEStructureNavigator")]) {
            IDEStructureNavigator *structureNavigator = currentNavigator;
            structureNavigator.selectedObjects        = selectedObjects;
        }
    }
}

#pragma mark - Helpers

+ (id)currentEditor
{
	NSWindowController *currentWindowController = [[NSApp keyWindow] windowController];
	
	if ([currentWindowController isKindOfClass:NSClassFromString(@"IDEWorkspaceWindowController")]) {
		IDEWorkspaceWindowController *workspaceController = (IDEWorkspaceWindowController *)currentWindowController;
        IDEEditorArea *editorArea       = [workspaceController editorArea];
        IDEEditorContext *editorContext = [editorArea lastActiveEditorContext];
		return [editorContext editor];
	}
	return nil;
}
+(NSURL *)currentSourceCodePathURL
{
    IDESourceCodeEditor *editor = [XCFXcodeFormatter currentEditor];
    //常规代码编辑框
    if ([editor isKindOfClass:NSClassFromString(@"IDESourceCodeEditor")])
    {
        return editor.sourceCodeDocument.fileURL;
    }
    //开启代码对比工具
    if ([editor isKindOfClass:NSClassFromString(@"IDESourceCodeComparisonEditor")])
    {
        IDESourceCodeDocument *document = ((IDESourceCodeComparisonEditor *)editor).primaryDocument;
        if ([document isKindOfClass:NSClassFromString(@"IDESourceCodeDocument")])
        {
            return document.fileURL;
        }
    }
    //plist
    if([editor isKindOfClass:NSClassFromString(@"IDEPlistEditor")])
    {
        return ((IDEPlistEditor *)editor).document.fileURL;
    }
    
    return nil;
}

@end
