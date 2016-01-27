//
// Created by Benoît on 11/01/14.
// Copyright (c) 2014 Pragmatic Code. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DVTTextDocumentLocation : NSObject
@property (readonly) NSRange characterRange;
@property (readonly) NSRange lineRange;
@end

@interface DVTTextPreferences : NSObject
+ (id)preferences;
@property BOOL trimWhitespaceOnlyLines;
@property BOOL trimTrailingWhitespace;
@property BOOL useSyntaxAwareIndenting;
@end

@interface DVTSourceTextStorage : NSTextStorage
- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)string withUndoManager:(id)undoManager;
- (NSRange)lineRangeForCharacterRange:(NSRange)range;
- (NSRange)characterRangeForLineRange:(NSRange)range;
- (void)indentCharacterRange:(NSRange)range undoManager:(id)undoManager;
@end

@interface DVTFileDataType : NSObject
@property (readonly) NSString *identifier;
@end

@interface DVTFilePath : NSObject
@property (readonly) NSURL *fileURL;
@property (readonly) DVTFileDataType *fileDataTypePresumed;
@end

@interface IDEContainerItem : NSObject
@property (readonly) NSString *path;
@property (readonly) DVTFilePath *resolvedFilePath;
@property BOOL usesTabs;
@end


@interface IDEGroup : IDEContainerItem
@end

@interface IDEFileReference : IDEContainerItem
@end

@interface IDENavigableItem : NSObject
@property (readonly) IDENavigableItem *parentItem;
@property (readonly) NSArray *childItems;
@property (readonly) id representedObject;

@end

@interface IDEFileNavigableItem : IDENavigableItem
@property (readonly) DVTFileDataType *documentType;
@property (readonly) NSURL *fileURL;
@end

@interface IDEGroupNavigableItem : IDENavigableItem
//@property (readonly) IDEGroup *group;
@end

@interface IDEStructureNavigator : NSObject
@property (retain  ) NSArray      *selectedObjects;
@property (copy    ) NSSet        *expandedItems;// @dynamic expandedItems;
@property (readonly) NSMutableSet *mutableExpandedItems;// @dynamic mutableExpandedItems;
@end

@interface IDENavigableItemCoordinator : NSObject
- (id)structureNavigableItemForDocumentURL:(id)arg1 inWorkspace:(id)arg2 error:(id *)arg3;
@end

@interface DVTExtension : NSObject
@property(readonly) NSString *identifier;
@end
@interface DVTChoice : NSObject
@property(readonly) DVTExtension *representedObject;
@end

@interface IDENavigatorArea : NSObject
- (id)currentNavigator;
-(NSArrayController *)extensionsController;
@end

@interface IDEWorkspaceTabController : NSObject
@property (readonly) IDENavigatorArea *navigatorArea;
@end

@interface IDEDocumentController : NSDocumentController
+ (id)editorDocumentForNavigableItem:(id)arg1;
+ (id)retainedEditorDocumentForNavigableItem:(id)arg1 error:(id *)arg2;
+ (void)releaseEditorDocument:(id)arg1;
@end

@interface IDESourceCodeDocument : NSDocument
- (DVTSourceTextStorage *)textStorage;
- (NSUndoManager *)undoManager;
@end

@interface IDESourceCodeComparisonEditor : NSObject
@property (readonly) NSTextView *keyTextView;
@property (retain) IDESourceCodeDocument *primaryDocument;
@end

@interface IDESourceCodeEditor : NSObject
@property (retain) NSTextView *textView;
- (IDESourceCodeDocument *)sourceCodeDocument;
@end

@interface IDEEditorContext : NSObject
- (id)editor; // returns the current editor. If the editor is the code editor, the class is `IDESourceCodeEditor`
@end

@interface IDEEditorArea : NSObject
- (IDEEditorContext *)lastActiveEditorContext;
@end

@interface IDEWorkspaceWindowController : NSObject
@property (readonly) IDEWorkspaceTabController *activeWorkspaceTabController;
- (IDEEditorArea *)editorArea;
@end

@interface IDEWorkspace : NSObject
@property (readonly) DVTFilePath *representingFilePath;
@end

@interface IDEWorkspaceDocument : NSDocument
@property (readonly) IDEWorkspace *workspace;
@end


@interface IDEPlistEditor : NSObject
@property NSDocument *document;
@end

@interface IDEFileReferenceNavigableItem : IDEFileNavigableItem
@end
@interface IDEContainerFileReferenceNavigableItem : IDEFileReferenceNavigableItem
@property (readonly) IDEFileReference *representedObject;
@end

