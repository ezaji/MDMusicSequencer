//
//  MDCreatorMusicTrackEvent.h
//  Mix Up Studio
//
//  Created by user on 05.05.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MDMusicTrackEvent.h"

@class MDMIDINoteEvent;

NS_ASSUME_NONNULL_BEGIN

@interface MDMusicTrackEventCreator : NSObject

+ (MDMusicTrackEvent *)createMusicTrackEventWithType:(MusicEventType)eventType
                                           timeStamp:(MusicTimeStamp)timeStamp
                                           eventData:(const void *)eventData;

@end

NS_ASSUME_NONNULL_END
