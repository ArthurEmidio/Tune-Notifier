//
//  AppDelegate.h
//  Tune Notifier
//
//  Created by Arthur Emidio on 13/08/12.
//  Copyright 2012 Arthur Emidio. All rights reserved.
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