//
//  MDMusicTrackEventEnumerator+MDMusicTrackTempoEventManager.m
//  Mix Up Studio
//
//  Created by user on 06.05.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MDMusicTrackEventEnumerator+MDMusicTrackTempoEventManager.h"

@implementation MDMusicTrackEventEnumerator (MDMusicTrackTempoEventManager)

- (BOOL)removeAllTempoEvent {
    if([self setPositionAtFirstEvent]) {
        OSStatus result = 0;
        while([self hasCurrentEvent]) {
            MusicTimeStamp outTimeStamp = 0.0;
            MusicEventType outEventType = kMusicEventType_NULL;
            const void *outEventData = NULL;
            UInt32 outEventDataSize = sizeof(outEventData);
            result = MusicEventIteratorGetEventInfo(self->_impl,
                                                    &outTimeStamp,
                                                    &outEventType,
                                                    &outEventData,
                                                    &outEventDataSize);
            [MDUtilities checkResult:result
                           operation:"Failed get event info with event iterator"];
            
            if(outEventType == kMusicEventType_ExtendedTempo) {
                result = MusicEventIteratorDeleteEvent(self->_impl);
                [MDUtilities checkResult:result
                               operation:"Failed delete tempo event of tempo track"];
            }
        }
        if(result == noErr) return YES;
    }
    return NO;
}

//- (void)setBpm:(MDTempoInBPM)bpm
//     startTime:(MDTimeInBeats)startTime {
//    MusicEventIterator iterator = (MusicEventIterator)self->_impl;
//    Boolean outHasEvent = false;
//    [MDUtilities checkResult:MusicEventIteratorHasCurrentEvent(iterator, &outHasEvent)
//                   operation:"Failed music event iterator has current event"];
//    while(outHasEvent) {
//        MusicTimeStamp outTimeStamp = 0.0;
//        MusicEventType outEventType = kMusicEventType_NULL;
//        const void *outEventData = NULL;
//        UInt32 outEventDataSize = sizeof(outEventData);
//        [MDUtilities checkResult:MusicEventIteratorGetEventInfo(iterator,
//                                                                &outTimeStamp,
//                                                                &outEventType,
//                                                                &outEventData,
//                                                                &outEventDataSize)
//                       operation:"Failed get event info with event iterator"];
//
//        if(outEventType == kMusicEventType_ExtendedTempo) {
//            [MDUtilities checkResult:MusicEventIteratorDeleteEvent(iterator)
//                           operation:"Failed delete tempo event of tempo track"];
//        }
//        [MDUtilities checkResult:MusicEventIteratorHasCurrentEvent(iterator, &outHasEvent)
//                       operation:"Failed music event iterator has current event"];
//        
//    }
//    
//    [MDUtilities checkResult:MusicTrackNewExtendedTempoEvent(self->_impl,
//                                                             0.0,
//                                                             bpm)
//                   operation:"Failed add new extended tempo event at tempo track"];
//}

@end
