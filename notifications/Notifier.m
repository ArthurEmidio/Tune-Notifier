//
//  Notifier.m
//  Tune Notifier
//
//  Created by Arthur Emidio - arthur.500@gmail.com
//

#import "Notifier.h"

@implementation Notifier

@synthesize timer = _timer;
@synthesize iTunes = _iTunes;
@synthesize latestSongID = _latestSongID;
@synthesize paused = _paused;
@synthesize itunesClosed = _itunesClosed;

- (id)init {
    self.iTunes = [SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];
    [self playWithTimeInterval:1.0];
    
    return self;
}

- (void)playWithTimeInterval:(NSTimeInterval)interval {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(work) userInfo:nil repeats:YES];
    [self.timer fire];
    
}

- (void)pause {
    self.paused = YES;
    [self.timer invalidate];
}

- (void)work {
    if([self.iTunes isRunning]) {
        iTunesEPlS state = [self.iTunes playerState];
        
        // if iTunes was closed before and then got initialized, restart the interval to 1 second
        if(self.itunesClosed == YES) {
            self.itunesClosed = NO;
            [self pause];
            [self playWithTimeInterval:1.0];
        }
        
        if(state == iTunesEPlSPlaying) {
            
            iTunesTrack *currentTrack = [self.iTunes currentTrack];
            if(self.latestSongID != currentTrack.databaseID || self.paused == YES) {
                self.latestSongID = currentTrack.databaseID;
                self.paused = NO;
                
                
                // prepare the notification content
                NSUserNotification *notification = [[NSUserNotification alloc] init];
                [notification setTitle: currentTrack.name];
                [notification setSubtitle: currentTrack.artist];
                [notification setInformativeText: currentTrack.album];
                [notification setSoundName: nil];
                
                NSUserNotificationCenter *notificationCenter = [NSUserNotificationCenter defaultUserNotificationCenter];
                [notificationCenter setDelegate:self];
                
                [notificationCenter deliverNotification:notification];
                [notificationCenter removeAllDeliveredNotifications]; // don't keep Notification Center UI saving all the triggered notifications.
            }
            
        } else if(state == iTunesEPlSPaused || state == iTunesEPlSStopped) {
            self.paused = YES; // when the song is previously paused, the notification will come up again when the song gets played
        }
    } else if(self.itunesClosed == NO) {
        // for better performance, change the interval to 10 seconds when iTunes is closed
        self.itunesClosed = YES;
        [self pause];
        [self playWithTimeInterval:10.0];
    }
}

// get iTunes in foreground if the user presses the notification
- (void)userNotificationCenter:(NSUserNotificationCenter *)center didActivateNotification:(NSUserNotification *)notification {
    [self.iTunes activate];
}

@end