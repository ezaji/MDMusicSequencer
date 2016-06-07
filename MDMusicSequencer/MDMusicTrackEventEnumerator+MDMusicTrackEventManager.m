//
//  MDMusicTrackEventEnumerator+MDMusicTrackEventManager.m
//  Mix Up Studio
//
//  Created by user on 06.05.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MDMusicTrackEventEnumerator+MDMusicTrackEventManager.h"
#import "MDMusicTrackEvent+MDAccessMusicTrackEvent.h"

@implementation MDMusicTrackEventEnumerator (MDMusicTrackEventManager)

//------------------------------------------------------------------------------
#pragma mark - Managing music track current event
//------------------------------------------------------------------------------
- (BOOL)setEvent:(MDMusicTrackEvent *)newEvent {
    MDMusicTrackEvent *currentEvent = [self currentEvent];
    if(![MDUtilities compareDoubleWithFirstArgument:currentEvent.startTime
                                     secondArgument:newEvent.startTime]) {
        if(![self setCurrentEventTime:newEvent.startTime]) return NO;
    }
    if([self hasCurrentEvent]) {
        OSStatus result = MusicEventIteratorSetEventInfo(self->_impl,
                                                         [newEvent type],
                                                         [newEvent event]);
        [MDUtilities checkResult:result
                       operation:"Failed set event info with event iterator"];
        if(result == noErr) return YES;
    }
    return NO;
}

- (BOOL)setCurrentEventTime:(MDTimeInBeats)newStartTime {
    if([self hasCurrentEvent]) {
        MDMusicTrackEvent *currentEvent = [self currentEvent];
        OSStatus result = MusicEventIteratorSetEventTime(self->_impl, newStartTime);
        [MDUtilities checkResult:result
                       operation:"Failed set event time with event iterator"];
        if(result == noErr) {
            currentEvent.startTime = newStartTime;
            return [self setPositionAtMusicTrackEvent:currentEvent];
        }
    }
    return NO;
}

- (BOOL)removeCurrentEvent {
    if([self hasCurrentEvent]) {
        OSStatus result = MusicEventIteratorDeleteEvent(self->_impl);
        [MDUtilities checkResult:result
                       operation:"Failed delete current event"];
        if(result == noErr) {
            if([self hasCurrentEvent]) return YES;
            return [self setPositionAtLastEvent];
        }
    }
    return NO;
}

//------------------------------------------------------------------------------
#pragma mark - Managing music track any event
//------------------------------------------------------------------------------
- (BOOL)setEventWithOldEvent:(MDMusicTrackEvent *)oldEvent
                    newEvent:(MDMusicTrackEvent *)newEvent {
    if([self setPositionAtMusicTrackEvent:oldEvent]) {
        return [self setEvent:newEvent];
    }
    return NO;
}

- (BOOL)setEvent:(MDMusicTrackEvent *)event
       startTime:(MDTimeInBeats)newStartTime {
    if([self setPositionAtMusicTrackEvent:event]) {
        return [self setCurrentEventTime:newStartTime];
    }
    return NO;
}

- (BOOL)removeEvent:(MDMusicTrackEvent *)removeEvent {
    if([self setPositionAtMusicTrackEvent:removeEvent]) {
        return [self removeCurrentEvent];
    }
    return NO;
}

@end
