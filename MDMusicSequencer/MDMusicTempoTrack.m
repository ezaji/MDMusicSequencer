//
//  MDMusicTempoTrack.m
//  Mix Up Studio
//
//  Created by user on 06.05.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MDMusicTempoTrack.h"
#import "MDMusicTrackEventEnumerator+MDMusicTrackTempoEventManager.h"

@implementation MDMusicTempoTrack

- (void)setBpm:(MDTempoInBPM)bpm {
    self->_bpm = bpm;
}

- (void)setBpm:(MDTempoInBPM)bpm
     startTime:(MDTimeInBeats)startTime {
//    [MDUtilities checkResult:MusicTrackNewExtendedTempoEvent(self->_impl,
//                                                             startTime,
//                                                             bpm)
//                   operation:"Failed add new extended tempo event at tempo track"];
//    self->_bpm = -1.0;
}

@end

