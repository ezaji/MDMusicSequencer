//
//  MDMusicTrackEventEnumerator.m
//  Mix Up Studio
//
//  Created by user on 04.05.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MDMusicTrackEventCreator.h"
#import "MDMusicTrackEventEnumerator.h"
#import "MDMusicTrack+MDAccessMusicTrack.h"
#import "MDMusicTrackEvent+MDAccessMusicTrackEvent.h"

@implementation MDMusicTrackEventEnumerator

//------------------------------------------------------------------------------
#pragma mark - Init music track event enumerator
//------------------------------------------------------------------------------
- (id)init {
    return [self initWithMusicTrack:[[MDMusicTrack alloc] init]];
}

- (id)initWithMusicTrack:(MDMusicTrack *)musicTrack {
    if(!musicTrack) return nil;
    self = [super init];
    if(self) {
        MusicEventIterator iterator;
        OSStatus result = NewMusicEventIterator([musicTrack impl], &iterator);
        [MDUtilities checkResult:result
                       operation:"Failed create new music event iterator"];
        if(result == noErr) {
            self->_impl = iterator;
            if([self hasCurrentEvent]) return self;
        }
    }
    return nil;
}

- (id)initWithMusicTrack:(MDMusicTrack *)musicTrack
               startTime:(MDTimeInBeats)startTime {
    self = [self initWithMusicTrack:musicTrack];
    if(self) {
        if([self setPositionAtStartTime:startTime])
            return self;
    }
    return nil;
}

- (id)initWithMusicTrack:(MDMusicTrack *)musicTrack
         musicTrackEvent:(MDMusicTrackEvent *)musicTrackEvent {
    self = [self initWithMusicTrack:musicTrack];
    if(self) {
        if([self setPositionAtMusicTrackEvent:musicTrackEvent])
            return self;
    }
    return nil;
}

- (id)initLastEventWithMusicTrack:(MDMusicTrack *)musicTrack {
    self = [self initWithMusicTrack:musicTrack];
    if(self) {
        if([self setPositionAtLastEvent]) return self;
        return self;
    }
    return nil;
}

//------------------------------------------------------------------------------
#pragma mark - Navigating among music events
//------------------------------------------------------------------------------
- (BOOL)setPositionAtStartTime:(MDTimeInBeats)startTime {
    OSStatus result = MusicEventIteratorSeek(self->_impl, startTime);
    [MDUtilities checkResult:result
                   operation:"Failed set seek event iterator"];
    if(result == noErr) {
        if([self hasCurrentEvent]) return YES;
        return [self previousEvent];
    }
    return NO;
}

- (BOOL)setPositionAtMusicTrackEvent:(MDMusicTrackEvent *)musicTrackEvent {
    if([self setPositionAtStartTime:musicTrackEvent.startTime]) {
        do {
            MDMusicTrackEvent *currentEvent = [self currentEvent];
            if(![MDUtilities compareDoubleWithFirstArgument:musicTrackEvent.startTime
                                             secondArgument:musicTrackEvent.startTime]) {
                goto noMatches;
            }
            if([currentEvent isEqualTo:musicTrackEvent]) return YES;
        } while([self nextEvent]);
    }
noMatches:
    return [self setPositionAtFirstEvent];
}

- (BOOL)setPositionAtFirstEvent {
    return [self setPositionAtStartTime:0.0];
}

- (BOOL)setPositionAtLastEvent {
    return [self setPositionAtStartTime:kMusicTimeStamp_EndOfTrack];
}

- (BOOL)previousEvent {
    Boolean outHasPrevEvent = false;
    OSStatus result = MusicEventIteratorHasPreviousEvent(self->_impl, &outHasPrevEvent);
    [MDUtilities checkResult:result
                   operation:"Failed has previous of track event iterator"];
    if(outHasPrevEvent) {
        result = MusicEventIteratorPreviousEvent(self->_impl);
        [MDUtilities checkResult:result
                       operation:"Failed previous event of track event iterator"];
        if(result == noErr) return YES;
    }
    return NO;
}

- (BOOL)nextEvent {
    Boolean outHasNextEvent = false;
    OSStatus result = MusicEventIteratorHasNextEvent(self->_impl, &outHasNextEvent);
    [MDUtilities checkResult:result
                   operation:"Failed has next event of track event iterator"];
    if(outHasNextEvent) {
        result = MusicEventIteratorNextEvent(self->_impl);
        [MDUtilities checkResult:result
                       operation:"Failed next event of track event iterator"];
        if(result == noErr) return YES;
    }
    return NO;
}

- (BOOL)hasCurrentEvent {
    Boolean outHasCurEvent = false;
    OSStatus result = MusicEventIteratorHasCurrentEvent(self->_impl, &outHasCurEvent);
    [MDUtilities checkResult:result
                   operation:"Failed has current event of track event iterator"];
    if(outHasCurEvent) {
        return YES;
    }
    return NO;
}

- (MDMusicTrackEvent *)currentEvent {
    if([self hasCurrentEvent]) {
        MusicTimeStamp outTimeStamp = 0.0;
        MusicEventType outEventType = kMusicEventType_NULL;
        const void *outEventData = NULL;
        UInt32 outEventDataSize = sizeof(outEventData);
        [MDUtilities checkResult:MusicEventIteratorGetEventInfo(self->_impl,
                                                                &outTimeStamp,
                                                                &outEventType,
                                                                &outEventData,
                                                                &outEventDataSize)
                       operation:"Failed get event info with event iterator"];
        return [MDMusicTrackEventCreator createMusicTrackEventWithType:outEventType
                                                             timeStamp:outTimeStamp
                                                             eventData:outEventData];
    }
    return nil;
}

//------------------------------------------------------------------------------
#pragma mark - Utilities track event enumerator
//------------------------------------------------------------------------------
- (void)printEventEnumerator {
    [MDUtilities printObject:self->_impl];
}

//------------------------------------------------------------------------------
#pragma mark - Dealloc
//------------------------------------------------------------------------------
- (void)dealloc {
    DisposeMusicEventIterator(self->_impl);
    self->_impl = nil;
}

@end
