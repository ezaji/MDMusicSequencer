//
//  MDMIDINoteEvent.m
//  Mix Up Studio
//
//  Created by user on 29.04.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MDMIDINoteEvent.h"

//------------------------------------------------------------------------------
#pragma mark - Constant for MDMIDINoteMessage
//------------------------------------------------------------------------------
const MIDIChannel kDefaultMelodicChannel        = 0;
const MIDIChannel kDefaultPercussionChannel     = 9;
const MIDIChannel kSecondPercussionChannel      = 25;
const MIDIChannel kMaximumChannel               = 31;

const MDNote kDefaultNote                       = C;
const MDOctave kDefaultOctave                   = OneLineOctave;

const MDVelocity kDefaultVelocity         = 100;
const MDVelocity kMaxVelocity             = 127;
const MDVelocity kDefaultReleaseVelocity  = 0;

const MDTimeInBeats kBeginingTrack              = 0.0;
const MDTimeInBeats kDefaultLengthTimeNote      = 0.25;

@implementation MDMIDINoteEvent

//------------------------------------------------------------------------------
#pragma mark - Init methods
//------------------------------------------------------------------------------
- (id)init {
    return [self initWithChannel:kDefaultMelodicChannel
                      octaveNote:MDMakeOctaveNote(kDefaultOctave, kDefaultNote)
                    noteVelocity:MDMakeNoteVelocityReleaseVelocity(kDefaultVelocity, kDefaultReleaseVelocity)
                       noteRange:MDMakeTimeNoteRange(kBeginingTrack, kDefaultLengthTimeNote)];
}

- (id)initWithOctaveNote:(MDOctaveNote)octaveNote
               noteRange:(MDTimeNoteRange)noteRange {
    return [self initWithChannel:kDefaultMelodicChannel
                      octaveNote:octaveNote
                    noteVelocity:MDMakeNoteVelocityReleaseVelocity(kDefaultVelocity, kDefaultReleaseVelocity)
                       noteRange:noteRange];
}

- (id)initWithChannel:(MIDIChannel)channel
           octaveNote:(MDOctaveNote)octaveNote
         noteVelocity:(MDNoteVelocity)noteVelocity
            noteRange:(MDTimeNoteRange)noteRange {
    self = [super init];
    if(self) {
        MIDINoteMessage *message    = malloc(sizeof(MIDINoteMessage));
        message->channel            = channel;
        message->note               = (octaveNote.note + octaveNote.octave);
        message->velocity           = noteVelocity.velocity;
        message->releaseVelocity    = noteVelocity.releaseVelocity;
        message->duration           = noteRange.lengthTime;
        self->_event                = message;
        self->_type                 = kMusicEventType_MIDINoteMessage;
        self.startTime              = noteRange.startTime;
        self->_addEvent             = &MusicTrackNewMIDINoteEvent;
        return self;
    }
    return nil;
}

//------------------------------------------------------------------------------
#pragma mark - Properties MDMIDINoteEvent
//------------------------------------------------------------------------------
//@property (nonatomic) MIDIChannel channel;
- (MIDIChannel)channel {
    return ((MIDINoteMessage*)self->_event)->channel;
}

- (void)setChannel:(MIDIChannel)channel {
    ((MIDINoteMessage*)self->_event)->channel = channel;
}

//------------------------------------------------------------------------------
//@property (nonatomic) MDOctave octave;
- (MDOctave)octave {
    MDOctaveNote octaveNote = MDMakeOctaveNoteWithMIDINote(((MIDINoteMessage*)self->_event)->note);
    return octaveNote.octave;
}

- (void)setOctave:(MDOctave)octave {
    MDOctaveNote octaveNote = MDMakeOctaveNoteWithMIDINote(((MIDINoteMessage*)self->_event)->note);
    ((MIDINoteMessage*)self->_event)->note = octaveNote.note + octave;
}

//------------------------------------------------------------------------------
//@property (nonatomic) MDNote note;
- (MDNote)note {
    MDOctaveNote octaveNote = MDMakeOctaveNoteWithMIDINote(((MIDINoteMessage*)self->_event)->note);
    return octaveNote.note;
}

- (void)setNote:(MDNote)note {
    MDOctaveNote octaveNote = MDMakeOctaveNoteWithMIDINote(((MIDINoteMessage*)self->_event)->note);
    ((MIDINoteMessage*)self->_event)->note = note + octaveNote.octave;
}

//------------------------------------------------------------------------------
//@property (nonatomic) MDVelocity velocity;
- (MDVelocity)velocity {
    return ((MIDINoteMessage*)self->_event)->velocity;
}

- (void)setVelocity:(MDVelocity)velocity {
    ((MIDINoteMessage*)self->_event)->velocity = velocity;
}

//------------------------------------------------------------------------------
//@property (nonatomic) MDVelocity releaseVelocity;
- (MDVelocity)releaseVelocity {
    return ((MIDINoteMessage*)self->_event)->releaseVelocity;
}

- (void)setReleaseVelocity:(MDVelocity)releaseVelocity {
    ((MIDINoteMessage*)self->_event)->releaseVelocity = releaseVelocity;
}

//------------------------------------------------------------------------------
//@property (nonatomic) MDTimeInBeats durationTime;
- (MDTimeInBeats)durationTime {
    return ((MIDINoteMessage*)self->_event)->duration;
}

- (void)setDurationTime:(MDTimeInBeats)durationTime {
    ((MIDINoteMessage*)self->_event)->duration = durationTime;
}

//------------------------------------------------------------------------------
#pragma mark - Equal
//------------------------------------------------------------------------------
- (BOOL)isEqualTo:(nullable MDMusicTrackEvent *)otherEvent {
    if([super isEqualTo:otherEvent]) return YES;
    if([self class] == [otherEvent class]) {
        MIDINoteMessage *first      = (MIDINoteMessage *)self->_event;
        MIDINoteMessage *second     = (MIDINoteMessage *)otherEvent->_event;
        BOOL isStartTime            = [MDUtilities compareDoubleWithFirstArgument:self.startTime
                                                                   secondArgument:otherEvent.startTime];
        BOOL isChannel              = (first->channel == second->channel);
        BOOL isNote                 = (first->note == second->note);
        BOOL isVelocity             = (first->velocity == second->velocity);
        BOOL isReleaseVelocity      = (first->releaseVelocity == second->releaseVelocity);
        BOOL isDuration             = [MDUtilities compareDoubleWithFirstArgument:first->duration
                                                                   secondArgument:second->duration];
        return (isStartTime &&
                isChannel &&
                isNote &&
                isVelocity &&
                isReleaseVelocity &&
                isDuration);
    }
    return NO;
}

//------------------------------------------------------------------------------
#pragma mark - Utilities MIDINoteEvent
//------------------------------------------------------------------------------
- (void)printEvent {
    MIDINoteMessage *message = (MIDINoteMessage *)self->_event;
    NSLog(@"MIDINoteMessage = StartTime:%f Ch: %d, Note:%d, Velocity: %d, Duration: %f",
          self.startTime,
          message->channel,
          message->note,
          message->velocity,
          message->duration);
}

@end
