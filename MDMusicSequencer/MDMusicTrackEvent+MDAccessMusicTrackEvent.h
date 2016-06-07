//
//  MDAccessMusicTrackEvent.h
//  Mix Up Studio
//
//  Created by user on 04.05.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MDMusicTrackEvent.h"

@interface MDMusicTrackEvent (MDAccessMusicTrackEvent)

- (void *)event;
- (MusicEventType)type;
- (OSStatus (*) ())addEvent;

@end
