//
//  MDMusicTrackEventUtilities.h
//  Mix Up Studio
//
//  Created by user on 26.04.16.
//  Copyright © 2016 user. All rights reserved.
//

#ifndef MDMusicTrackEventUtilities_h
#define MDMusicTrackEventUtilities_h

//------------------------------------------------------------------------------
#pragma mark - For Tempo Track
//------------------------------------------------------------------------------
typedef Float64 MDTempoInBPM;

//------------------------------------------------------------------------------
#pragma mark - MIDI Channel
//------------------------------------------------------------------------------
//от 0 до 31 (25 для ударных).
typedef UInt8 MIDIChannel;

//------------------------------------------------------------------------------
#pragma mark - C function for note
//------------------------------------------------------------------------------
typedef UInt8 MDMIDINote; //от 0 до 127

static const UInt8 CountNote = 12;
typedef NS_ENUM(UInt8, MDNote) {
    C       = 0,    //До
    CSharp  = 1,    //До диез
    
    Db      = 1,    //Ре бемоль
    D       = 2,    //Ре
    DSharp  = 3,    //Ре диез
    
    Eb      = 3,    //Ми бемоль
    E       = 4,    //Ми
    
    F       = 5,    //Фа
    FSharp  = 6,    //Фа диез
    
    Gb      = 6,    //Соль бемоль
    G       = 7,    //Соль
    GSharp  = 8,    //Соль диез
    
    Ab      = 8,    //Ля бемоль
    A       = 9,    //Ля
    ASharp  = 10,   //Ля диез
    
    Bb      = 10,   //Си бемоль
    Hb      = 10,   //Си бемоль
    
    B       = 11,   //Си
    H       = 11    //Си (H и B взаимозаменяемы, для разных обозначений)
};

typedef NS_ENUM(UInt8, MDOctave) {
    SubSubContraOctave          = 0,    //субсубконтроктава (№-1)
    SubcontraOctave             = 12,   //субконтроктава (№0)
    ContraOctave                = 24,   //контроктава (№1)
    GreatOctave                 = 36,   //большая октава (№2)
    SmallOctave                 = 48,   //малая октава (№3)
    OneLineOctave               = 60,   //первая октава (№4)
    TwoLineOctave               = 72,   //вторая октава (№5)
    ThreeLineOctave             = 84,   //третья октава (№6)
    FourLineOctave              = 96,   //четвертая октава (№7)
    FiveLineOctave              = 108,  //пятая октава (№8)
    SixLineOctave               = 120   //шестая октава (№9) !!!неполная №9 октава (до ноты соль (G) включительно)
};

typedef struct _MDOctaveNote {
    MDOctave octave;
    MDNote note;
} MDOctaveNote;

NS_INLINE MDOctaveNote MDMakeOctaveNote (MDOctave _octave,
                                         MDNote _note) {
    MDOctaveNote octaveNote;
    octaveNote.octave = _octave;
    octaveNote.note = _note;
    return octaveNote;
}

NS_INLINE MDOctaveNote MDMakeOctaveNoteWithMIDINote(MDMIDINote midiNote) {
    MDOctaveNote octaveNote;
    octaveNote.octave = (midiNote / CountNote) * CountNote;
    octaveNote.note = midiNote - octaveNote.octave;
    return octaveNote;
}

//------------------------------------------------------------------------------
#pragma mark - C function for note velocity
//------------------------------------------------------------------------------
//Это значение должно быть от 0 до 127
typedef UInt8 MDVelocity;
typedef struct _MDNoteVelocity {
    MDVelocity velocity;
    MDVelocity releaseVelocity;
} MDNoteVelocity;

NS_INLINE MDNoteVelocity MDMakeNoteVelocityReleaseVelocity (MDVelocity _velocity,
                                                            MDVelocity _releaseVelocity) {
    MDNoteVelocity noteVelocity;
    noteVelocity.velocity = _velocity & 0x7F;
    noteVelocity.releaseVelocity = _releaseVelocity & 0x7F;
    return noteVelocity;
}

NS_INLINE MDNoteVelocity MDMakeNoteVelocity (MDVelocity _velocity) {
    return MDMakeNoteVelocityReleaseVelocity(_velocity, 0);
}

//------------------------------------------------------------------------------
#pragma mark - C function for note start, duration beats metronom
//------------------------------------------------------------------------------
typedef Float64 MDTimeInBeats;
typedef struct _MDTimeInBeatsRange {
    MDTimeInBeats startTime;
    MDTimeInBeats lengthTime;
} MDTimeInBeatsRange;

NS_INLINE MDTimeInBeatsRange MDMakeTimeInBeatsRange(MDTimeInBeats startTime,
                                                    MDTimeInBeats lengthTime) {
    MDTimeInBeatsRange r;
    r.startTime = startTime;
    r.lengthTime = lengthTime;
    return r;
}

typedef MDTimeInBeatsRange MDTimeNoteRange;

NS_INLINE MDTimeNoteRange MDMakeTimeNoteRange(MDTimeInBeats startTime,
                                              MDTimeInBeats durationTime) {
    return MDMakeTimeInBeatsRange(startTime, durationTime);
}

#endif /* MDMusicTrackEventUtilities_h */
