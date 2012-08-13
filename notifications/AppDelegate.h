//
//  AppDelegate.h
//  notifications
//
//  Created by Arthur on 08/08/12.
//  Copyright (c) 2012 Arthur. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <ScriptingBridge/ScriptingBridge.h>

#import "iTunes.h"

#import "Notifier.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (strong) NSMenu *menu;
@property (strong) NSStatusItem *statusItem;

@property (strong) Notifier *notifier;

@property (unsafe_unretained) IBOutlet NSWindow *ab;
- (IBAction)email:(id)sender;

@end