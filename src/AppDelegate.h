//
//  AppDelegate.h
//  ofStateManagerCocoa
//
//  Created by Memo Akten on 30/12/2012.
//  Copyright (c) 2012 Memo Akten. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSSegmentedControl *actionSegmentedControl;
    IBOutlet NSTextField *projectPathTextField;
    IBOutlet NSTextField *statusNameTextField;
    IBOutlet NSTextField *finalCommandTextField;
    IBOutlet NSButton *verboseButton;
    IBOutlet NSButton *updateButton;
    IBOutlet NSDrawer *drawer;
    IBOutlet NSTextView *outputTextField;
}

@property (assign) IBOutlet NSWindow *window;

-(IBAction)onSelectFolderPressed:(id)sender;
-(IBAction)onControlChanged:(id)sender;
-(IBAction)onGoPressed:(id)sender;
-(IBAction)onHelpPressed:(id)sender;

@end
