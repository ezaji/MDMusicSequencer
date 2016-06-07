//
//  MDMusicTrackEvent.h
//  Mix Up Studio
//
//  Created by user on 29.04.16.
//  Copyright © 2016 user. All rights reserved.
//

#import <AudioToolbox/MusicPlayer.h>
#import "MDUtilities.h"
#import "MDMusicTrackEventUtilities.h"

NS_ASSUME_NONNULL_BEGIN

@interface MDMusicTrackEvent : NSObject {
@protected
    void *_event;
    MusicEventType _type;
    OSStatus (*_addEvent) ();
}

@property (nonatomic) MDTimeInBeats startTime;

- (BOOL)isEqualTo:(nullable MDMusicTrackEvent *)otherEvent;

//Utilities musicTrackEvent
- (void)printEvent;

@end

NS_ASSUME_NONNULL_END