//
//  MDMusicTrack.m
//  Mix Up Studio
//
//  Created by user on 22.04.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MDMusicTrack.h"
#import "MDMusicTrackEventEnumerator+MDMusicTrackEventManager.h"
#import "MDMusicTrackEvent+MDAccessMusicTrackEvent.h"

//------------------------------------------------------------------------------
#pragma mark - Hidden interface MDMusicTrack
//------------------------------------------------------------------------------
@interface MDMusicTrack ()

@end

//------------------------------------------------------------------------------
#pragma mark - Implementation MDMusicTrack
//------------------------------------------------------------------------------
@implementation MDMusicTrack

- (id)init {
    self = [super init];
    if(self) {
        return self;
    }
    return nil;
}

//------------------------------------------------------------------------------
#pragma mark - Adding & Removing events to Music Track
//------------------------------------------------------------------------------
- (void)addMusicTrackEvent:(MDMusicTrackEvent *)musicTrackEvent {
    if(![self containsTrackEvent:musicTrackEvent]) {
        OSStatus (*addEvent) (MusicTrack, MusicTimeStamp, const void*) = [musicTrackEvent addEvent];
        [MDUtilities checkResult:addEvent(self->_impl,
                                          musicTrackEvent.startTime,
                                          [musicTrackEvent event])
                       operation:"Failed add new event"];
    }
}

- (void)removeAllEventsWithRange:(MDTimeInBeatsRange)beatNoteRange {
    [MDUtilities checkResult:MusicTrackClear(self->_impl,
                                             beatNoteRange.startTime,
                                             beatNoteRange.lengthTime)
                   operation:"Failed clear event track"];
}

- (void)removeAllEvents {
    [MDUtilities checkResult:MusicTrackClear(self->_impl,
                                             0.0,
                                             self.trackLength)
                   operation:"Failed clear event track"];
}

//------------------------------------------------------------------------------
#pragma mark - Properties of Music Track
//------------------------------------------------------------------------------
- (MDTimeInBeats)trackLength {
    MDTimeInBeats trackLength = 0.0;
    UInt32 ioLength = sizeof(trackLength);
    [MDUtilities checkResult:MusicTrackGetProperty(self->_impl,
                                                   kSequenceTrackProperty_TrackLength,
                                                   &trackLength,
                                                   &ioLength)
                   operation:"Failed get track length property of the music track"];
    return trackLength;
}

//------------------------------------------------------------------------------
#pragma mark - Track event enumerator
//------------------------------------------------------------------------------
- (MDMusicTrackEventEnumerator *)eventEnumerator {
    return [[MDMusicTrackEventEnumerator alloc] initWithMusicTrack:self];
}

//------------------------------------------------------------------------------
#pragma mark - Querying an music track
//------------------------------------------------------------------------------
- (BOOL)containsTrackEvent:(MDMusicTrackEvent *)musicTrackEvent {
    MDMusicTrackEventEnumerator *eventEnumerator = [self eventEnumerator];
    if(eventEnumerator) {
        MDMusicTrackEvent *firstEvent = [eventEnumerator currentEvent];
        if([musicTrackEvent isEqualTo:firstEvent]) return YES;
        
        [eventEnumerator setPositionAtMusicTrackEvent:musicTrackEvent];
        MDMusicTrackEvent *incomingEvent = [eventEnumerator currentEvent];
        if(![incomingEvent isEqualTo:firstEvent]) return YES;
    }
    return NO;
}

//------------------------------------------------------------------------------
#pragma mark - Utilities track
//------------------------------------------------------------------------------
- (void)printTrack {
    [MDUtilities printObject:self->_impl];
    NSLog(@"Length: %f", self.trackLength);
}

- (void)printAllEvent {
    MDMusicTrackEventEnumerator *enumerator = [self eventEnumerator];
    do {
        MDMusicTrackEvent *currentEvent = [enumerator currentEvent];
        [currentEvent printEvent];
    } while([enumerator nextEvent]);
}

//------------------------------------------------------------------------------
#pragma mark - Dealloc music track
//------------------------------------------------------------------------------
- (void)dealloc {
    self->_impl = nil;
}

@end

//------------------------------------------------------------------------------
#pragma mark - Category for Editing Music Track Event
//------------------------------------------------------------------------------
@implementation MDMusicTrack (MDMusicTrackEventEditor)

//Editing All Events of Music Track
- (void)moveAllEventsWithRange:(MDTimeInBeatsRange)beatNoteRange
          inMoveNumberBeatNote:(MDTimeInBeats)inMoveNumberBeatNote {
    [MDUtilities checkResult:MusicTrackMoveEvents(self->_impl,
                                                  beatNoteRange.startTime,
                                                  beatNoteRange.lengthTime,
                                                  inMoveNumberBeatNote)
                   operation:"Failed move all events with range"];
}

//Editing Event of Music Track


@end