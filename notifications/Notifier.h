//
//  Notifier.h
//  Tune Notifier
//
//  Created by Arthur Emidio on 13/08/12.
//  Copyright 2012 Arthur Emidio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ScriptingBridge/ScriptingBridge.h>

#import "iTunes.h"

@interface Notifier : NSObject <NSUserNotificationCenterDelegate>

@property(strong) NSTimer *timer;
@property (strong) iTunesApplication *iTunes;
@property (nonatomic) NSInteger latestSongID;
@property (nonatomic) bool paused;
@property (nonatomic) bool itunesClosed;

- (void)pause;
- (void)playWithTimeInterval:(NSTimeInterval)interval;

@end