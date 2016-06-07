//
//  MDMIDINoteEvent.h
//  Mix Up Studio
//
//  Created by user on 29.04.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MDMusicTrackEvent.h"

NS_ASSUME_NONNULL_BEGIN

//MIDIChannel constant
extern const MIDIChannel kDefaultMelodicChannel;        // 0 - Является каналом по умолчанию.
extern const MIDIChannel kDefaultPercussionChannel;     // 9
extern const MIDIChannel kSecondPercussionChannel;      // 25
extern const MIDIChannel kMaximumChannel;               // 31

//Note & octave constant
extern const MDNote kDefaultNote;                       // C (нота До)
extern const MDOctave kDefaultOctave;                   // OneLineOctave (Первая октава)

//Velocity & releaseVelocity constant
extern const MDVelocity kDefaultVelocity;         // 100
extern const MDVelocity kMaxVelocity;             // 127
extern const MDVelocity kDefaultReleaseVelocity;  // 0

//Time note range constant
extern const MDTimeInBeats kBeginingTrack;              // 0.0
extern const MDTimeInBeats kDefaultLengthTimeNote;      // 0.25 (Четвертная)

@interface MDMIDINoteEvent : MDMusicTrackEvent

- (id)initWithOctaveNote:(MDOctaveNote)octaveNote
               noteRange:(MDTimeNoteRange)noteRange;

- (id)initWithChannel:(MIDIChannel)channel
           octaveNote:(MDOctaveNote)octaveNote
         noteVelocity:(MDNoteVelocity)noteVelocity
            noteRange:(MDTimeNoteRange)noteRange NS_DESIGNATED_INITIALIZER;

@property (nonatomic) MIDIChannel channel;

@property (nonatomic) MDOctave octave;
@property (nonatomic) MDNote note;

@property (nonatomic) MDVelocity velocity;
@property (nonatomic) MDVelocity releaseVelocity;

@property (nonatomic) MDTimeInBeats durationTime;

@end

NS_ASSUME_NONNULL_END