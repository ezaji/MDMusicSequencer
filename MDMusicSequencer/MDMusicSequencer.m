//
//  MDMusicSequencer.m
//  Mix Up Studio
//
//  Created by user on 25.04.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MDMusicSequencer.h"
#import "MDMusicTrack+MDAccessMusicTrack.h"

//------------------------------------------------------------------------------
#pragma mark - Hidden interface MDMusicSequencer
//------------------------------------------------------------------------------

@interface MDMusicSequencer ()

@end

//------------------------------------------------------------------------------
#pragma mark - Implementation MDMusicSequencer
//------------------------------------------------------------------------------

@implementation MDMusicSequencer {
    NSMutableDictionary <NSString *, MDMusicTrack *> *_tracks;
    MusicPlayer _playerSequence;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        MusicSequence sequencer;
        OSStatus result = NewMusicSequence(&sequencer);
        [MDUtilities checkResult:result
                       operation:"Failed new music sequence"];
        if(result != noErr) goto fail;
        
        result = NewMusicPlayer(&self->_playerSequence);
        [MDUtilities checkResult:result
                       operation:"Failed new music player for sequence"];
        if(result != noErr) goto fail;
        
        result = MusicPlayerSetSequence(self->_playerSequence, sequencer);
        [MDUtilities checkResult:result
                       operation:"Failed set sequence for music player"];
        if(result != noErr) goto fail;

        MusicTrack tempoTrack;
        result = MusicSequenceGetTempoTrack(sequencer, &tempoTrack);
        [MDUtilities checkResult:result
                       operation:"Failed get tempo track of music sequencer"];
        if(result != noErr) goto fail;
        
        self->_tempoTrack = [[MDMusicTempoTrack alloc] init];
        [self->_tempoTrack setImpl:tempoTrack];
        self->_impl = sequencer;
        self->_tracks = [[NSMutableDictionary alloc] init];
        return self;
    }
fail:
    return nil;
}

//------------------------------------------------------------------------------
#pragma mark - Working with Music tracks
//------------------------------------------------------------------------------
- (BOOL)createMusicTrackWithName:(NSString *)name {
    if(![self trackWithName:name]) {
        MusicTrack newTrack;
        OSStatus result = MusicSequenceNewTrack(self->_impl, &newTrack);
        [MDUtilities checkResult:result
                       operation:"Failed create and add new track"];
        if(result == noErr) {
            MDMusicTrack *addTrack = [[MDMusicTrack alloc] init];
            [addTrack setImpl:newTrack];
            [self->_tracks setObject:addTrack forKey:name];
            return YES;
        }
    }
    return NO;
}

- (void)removeTrackWithName:(NSString *)name {
    MDMusicTrack *removeTrack = self->_tracks[name];
    if(removeTrack) {
        OSStatus result = MusicSequenceDisposeTrack(self->_impl, [removeTrack impl]);
        [MDUtilities checkResult:result
                       operation:"Failed dispose music track of music sequence"];
        if(result == noErr) {
            [removeTrack setImpl:nil];
            [self->_tracks removeObjectForKey:name];
        }
    }
}

- (nullable MDMusicTrack *)trackWithName:(NSString *)name {
    MDMusicTrack *resultTrack = self->_tracks[name];
    return resultTrack;
}

//------------------------------------------------------------------------------
#pragma mark - Properties music sequence
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
#pragma mark - Utilities sequencer
//------------------------------------------------------------------------------
- (void)printSequencer {
    [MDUtilities printObject:self->_impl];
}

- (void)printGraphSequencers {
    AUGraph graph;
    OSStatus result = MusicSequenceGetAUGraph(self->_impl, &graph);
    [MDUtilities checkResult:result
                   operation:"Failed get AUGraph of the sequence"];
    if(result == noErr) [MDUtilities printObject:graph];
}

//------------------------------------------------------------------------------
#pragma mark - Dealloc
//------------------------------------------------------------------------------
- (void)dealloc {
    [self stop];
    for(MDMusicTrack *removeTrack in self->_tracks.allValues) {
        [MDUtilities checkResult:MusicSequenceDisposeTrack(self->_impl, [removeTrack impl])
                       operation:"Failed dispose ALL music track of music sequence"];
    }
    [self->_tracks removeAllObjects];
    [MDUtilities checkResult:DisposeMusicPlayer(self->_playerSequence)
                   operation:"Failed dispose music player"];
    self->_playerSequence = nil;
    [MDUtilities checkResult:DisposeMusicSequence(self->_impl)
                   operation:"Failed dispose music sequence"];
    self->_impl = nil;
}

@end

//------------------------------------------------------------------------------
#pragma mark - MDMusicPlayer
//------------------------------------------------------------------------------
@implementation MDMusicSequencer (MDMusicPlayer)

- (BOOL)isPlaying {
    Boolean outIsPlaying = false;
    [MDUtilities checkResult:MusicPlayerIsPlaying(self->_playerSequence, &outIsPlaying)
                   operation:"Failed isPlaying music player"];
    return outIsPlaying;
}

- (BOOL)play {
    OSStatus result = MusicPlayerStart(self->_playerSequence);
    [MDUtilities checkResult:result
                   operation:"Failed start music player"];
    if(result) return NO;
    return YES;
}

- (BOOL)stop {
    OSStatus result = MusicPlayerStop(self->_playerSequence);
    [MDUtilities checkResult:result
                   operation:"Failed stop music player"];
    if(result) return NO;
    result = MusicPlayerSetTime(self->_playerSequence, 0.0);
    [MDUtilities checkResult:result
                   operation:"Failed set time for music player"];
    if(result) return NO;
    return YES;
}

- (BOOL)prepareToPlay {
    OSStatus result = MusicPlayerPreroll(self->_playerSequence);
    [MDUtilities checkResult:result
                   operation:"Failed prepare music player"];
    if(result) return NO;
    return YES;
}

@end
