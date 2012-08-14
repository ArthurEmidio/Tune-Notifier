//
//  AppDelegate.m
//  Tune Notifier
//
//  Created by Arthur Emidio on 13/08/12.
//  Copyright 2012 Arthur Emidio. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize menu = _menu;
@synthesize statusItem = _statusItem;
@synthesize notifier = _notifier;
@synthesize ab = _ab;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self createMenu];
    self.notifier = [[Notifier alloc] init];
}


// Everything below is related to the menu creation/events
- (void)createMenu {
    NSMenuItem *pauseItem = [[NSMenuItem alloc] initWithTitle:@"Pause" action:@selector(pauseButtonPressed) keyEquivalent:@""];
    NSMenuItem *aboutItem = [[NSMenuItem alloc] initWithTitle:@"About" action:@selector(about) keyEquivalent:@""];
    NSMenuItem *closeItem = [[NSMenuItem alloc] initWithTitle:@"Close" action:@selector(terminate:) keyEquivalent:@""];
    
    self.menu = [[NSMenu alloc] initWithTitle:@"Menu"];
    [self.menu insertItem:pauseItem atIndex:0];
    [self.menu insertItem:aboutItem atIndex:1];
    [self.menu insertItem:closeItem atIndex:2];
    
    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
    self.statusItem = [statusBar statusItemWithLength:NSVariableStatusItemLength];
    [self.statusItem setTitle:@"TN"];
    [self.statusItem setHighlightMode:YES];
    [self.statusItem setMenu:self.menu];
}

- (void)pauseButtonPressed {
    [self.notifier pause];
    [self createMenuOptionWithType:@"Play"];
}

- (void)playButtonPressed {
    [self.notifier playWithTimeInterval:1.0];
    [self createMenuOptionWithType:@"Pause"];
}

- (void)createMenuOptionWithType:(NSString *)type {
    [self.menu removeItemAtIndex:0];
    NSMenuItem *item = [[NSMenuItem alloc] init];
        
    if([type isEqualToString:@"Play"]) {
        [item setTitle:type];
        [item setAction:@selector(playButtonPressed)];
        [item setKeyEquivalent:@""];
    } else if([type isEqualToString:@"Pause"]) {
        [item setTitle:type];
        [item setAction:@selector(pauseButtonPressed)];
        [item setKeyEquivalent:@""];
    }

    [self.menu insertItem:item atIndex:0];
    [self.statusItem setMenu:self.menu];
}

// "about app"-window configuration related
- (void)about {
    if(![self.ab isVisible]) [self.ab center];
    [self.ab makeKeyAndOrderFront:self];
    [NSApp activateIgnoringOtherApps:YES];
}

- (IBAction)email:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"mailto:arthur.500@gmail.com"]];
}

@end