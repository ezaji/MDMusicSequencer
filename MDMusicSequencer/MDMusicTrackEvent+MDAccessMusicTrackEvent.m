//
//  MDAccessMusicTrackEvent.m
//  Mix Up Studio
//
//  Created by user on 04.05.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MDMusicTrackEvent+MDAccessMusicTrackEvent.h"

@implementation MDMusicTrackEvent (MDAccessMusicTrackEvent)

- (void *)event {
    return self->_event;
}

- (MusicEventType)type {
    return self->_type;
}

- (OSStatus (*) ())addEvent {
    return self->_addEvent;
}

@end
