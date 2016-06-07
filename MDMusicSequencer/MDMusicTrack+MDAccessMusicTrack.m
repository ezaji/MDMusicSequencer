//
//  MDAccessMusicTrack.m
//  Mix Up Studio
//
//  Created by user on 04.05.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MDMusicTrack+MDAccessMusicTrack.h"

@implementation MDMusicTrack (MDAccessMusicTrack)

- (void *)impl {
    return self->_impl;
}

- (void)setImpl:(void *)impl {
    self->_impl = impl;
}

@end
