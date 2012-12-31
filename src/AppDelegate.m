//
//  AppDelegate.m
//  ofStateManagerCocoa
//
//  Created by Memo Akten on 30/12/2012.
//  Copyright (c) 2012 Memo Akten. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

//-----------------------------------------------------------------------------
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self onControlChanged:nil];
}

//-----------------------------------------------------------------------------
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

//-----------------------------------------------------------------------------
- (void)controlTextDidChange:(NSNotification *)aNotification {
    [self onControlChanged:nil];
}

//-----------------------------------------------------------------------------
-(IBAction)onSelectFolderPressed:(id)sender {
//    NSLog(@"onSelectFolderPressed");
    
    NSOpenPanel* dialog = [NSOpenPanel openPanel];
    
    [dialog setCanChooseFiles:NO];
    [dialog setCanChooseDirectories:YES];
    [dialog setAllowsMultipleSelection:NO];
    [dialog setPrompt:@"Select"];
    [dialog setTitle: @"Select project folder"];
    
    if([dialog runModal] == NSFileHandlingPanelOKButton ) {
        NSURL *url = [[dialog URLs] objectAtIndex:0];
        [projectPathTextField setStringValue: [url path]];
        [self onControlChanged:nil];
    }

    
}

//-----------------------------------------------------------------------------
-(IBAction)onControlChanged:(id)sender {
//    NSLog(@"controlChanged");
    
    NSString *actionString, *pathString, *nameString, *verboseString, *updateString;
    switch([actionSegmentedControl selectedSegment]) {
        case 0:
            actionString = @"record";
            [updateButton setHidden:NO];
            break;
        case 1:
            actionString = @"checkout";
            [updateButton setHidden:YES];
            break;
        case 2:
            actionString = @"archive";
            [updateButton setHidden:YES];
            break;
    }
    
    pathString = [projectPathTextField stringValue];
    if([pathString length] != 0) pathString = [NSString stringWithFormat:@" -p %@", pathString];
    
    nameString = [statusNameTextField stringValue];
    if([nameString length] != 0) nameString = [NSString stringWithFormat:@" -n %@", nameString];
    
    verboseString = [verboseButton intValue] ? @" -v" : @"";
    
    updateString = [updateButton intValue] && ([updateButton isHidden] == NO) ? @" -u" : @"";
    
    [finalCommandTextField setStringValue:[NSString stringWithFormat:
                                           @"%@%@%@%@%@", actionString, pathString, nameString, verboseString, updateString]];
}


//-----------------------------------------------------------------------------
//http://stackoverflow.com/questions/412562/execute-a-terminal-command-from-a-cocoa-app
-(NSString *)runCommand:(NSString *)commandToRun inFolder:(NSString *)folder {
    NSLog(@"*** Running command '%@'", commandToRun);
    
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/sh"];
    
    NSArray *arguments = [NSArray arrayWithObjects:
                          @"-c" ,
                          [NSString stringWithFormat:@"%@", commandToRun],
                          nil];
    [task setArguments: arguments];
    [task setCurrentDirectoryPath:folder];
    
    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file = [pipe fileHandleForReading];

    NSMutableData *data = [NSMutableData dataWithCapacity:512];

    [task launch];
    
//    NSData *data = [file readDataToEndOfFile];
    while ([task isRunning]) { [data appendData:[file readDataToEndOfFile]]; }
    [data appendData:[file readDataToEndOfFile]];
    
    NSString *outputString = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
//    if([outputString length] == 0) outputString = @"An error occured, and unfortunately I can't read what the error is :( Try copy & pasting the command above into terminal (from the script folder) to see what it was.";
    outputString = [NSString stringWithFormat:@"\n\nCOMMAND: %@\n\n%@", commandToRun, outputString];
    
    return outputString;
}

//-----------------------------------------------------------------------------
-(void)runScriptWithParameters:(NSString*)paramString {
    NSURL *workingURL = [[NSBundle mainBundle] bundleURL];
    workingURL = [[workingURL URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"ofStateManager"];
    NSString *command = [NSString stringWithFormat:@"python ofStateManager.py %@", paramString];
    NSString *outputString = [self runCommand:command inFolder:[workingURL path]];
    [outputTextField setString:outputString];
}

//-----------------------------------------------------------------------------
-(IBAction)onGoPressed:(id)sender {
//    NSLog(@"onGoPressed");
    [drawer open];
    [self runScriptWithParameters:[finalCommandTextField stringValue]];
}


//-----------------------------------------------------------------------------
-(IBAction)onHelpPressed:(id)sender {
//    NSLog(@"onHelpPressed");
    [drawer open];
    [self runScriptWithParameters:@"-h"];
}


@end
