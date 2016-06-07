//
//  MDMusicTrackEvent.m
//  Mix Up Studio
//
//  Created by user on 29.04.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MDMusicTrackEvent.h"

@implementation MDMusicTrackEvent

- (id)init {
    if(![self isMemberOfClass:[MDMusicTrackEvent class]]) {
        self = [super init];
        if(self) return self;
    }
    return nil;
}

- (BOOL)isEqualTo:(nullable MDMusicTrackEvent *)otherEvent {
    if(self == otherEvent) return YES;
    return NO;
}

- (void)printEvent {
    NSLog(@"Override method");
}

- (void)dealloc {
    free(self->_event);
    self->_addEvent = NULL;
}

@end