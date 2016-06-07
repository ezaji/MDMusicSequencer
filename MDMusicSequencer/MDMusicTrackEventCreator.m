//
//  MDCreatorMusicTrackEvent.m
//  Mix Up Studio
//
//  Created by user on 05.05.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MDMusicTrackEventCreator.h"

#import "MDMIDINoteEvent.h"

@implementation MDMusicTrackEventCreator

+ (MDMusicTrackEvent *)createMusicTrackEventWithType:(MusicEventType)eventType
                                           timeStamp:(MusicTimeStamp)timeStamp
                                           eventData:(const void *)eventData {
    switch (eventType) {
        case kMusicEventType_ExtendedNote: {
            break;
        }
        case kMusicEventType_User: {
            break;
        }
        case kMusicEventType_Meta: {
            break;
        }
        case kMusicEventType_MIDINoteMessage: {
            return [MDMusicTrackEventCreator createMIDINoteEventWithTimeStamp:timeStamp
                                                                    eventData:eventData];
        }
        case kMusicEventType_MIDIChannelMessage: {
            break;
        }
        case kMusicEventType_MIDIRawData: {
            break;
        }
        case kMusicEventType_Parameter: {
            break;
        }
        case kMusicEventType_AUPreset: {
            break;
        }
        default:
            break;
    }
    return nil;
}

+ (MDMIDINoteEvent *)createMIDINoteEventWithTimeStamp:(MusicTimeStamp)timeStamp
                                            eventData:(const void *)eventData {
    MIDINoteMessage *message        = (MIDINoteMessage *)eventData;
    MIDIChannel channel             = message->channel;
    MDOctaveNote octaveNote         = MDMakeOctaveNoteWithMIDINote(message->note);
    MDNoteVelocity noteVelocity     = MDMakeNoteVelocityReleaseVelocity(message->velocity,
                                                                        message->releaseVelocity);
    MDTimeNoteRange timeNoteRange   = MDMakeTimeNoteRange(timeStamp,
                                                          message->duration);
    return [[MDMIDINoteEvent alloc] initWithChannel:channel
                                         octaveNote:octaveNote
                                       noteVelocity:noteVelocity
                                          noteRange:timeNoteRange];
}

@end
