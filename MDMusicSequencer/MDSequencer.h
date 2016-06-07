//
//  MDMusicSequencer.h
//  Mix Up Studio
//
//  Created by user on 25.04.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MDMusicTrack.h"
#import "MDMusicTempoTrack.h"

NS_ASSUME_NONNULL_BEGIN

@interface MDMusicSequencer : NSObject {
@protected
    void *_impl;
}

@property(nonatomic, readonly) MDMusicTempoTrack *tempoTrack;

//Создает и добавляет пустой music track по переданному имени.
//Если все прошло успешно возвращает YES.
//Если трек с таким именем уже существует, то возвращает NO.
- (BOOL)createMusicTrackWithName:(NSString *)name;

//Удаляет music track, соответствующий переданному имени.
- (void)removeTrackWithName:(NSString *)name;

//Возвращает music track по имени.
- (nullable MDMusicTrack *)trackWithName:(NSString *)name;

//Utilities sequencer
- (void)printSequencer;
- (void)printGraphSequencers;

@end

@interface MDMusicSequencer (MDMusicPlayer)

@property(nonatomic, readonly, getter=isPlaying) BOOL playing;

- (BOOL)play;
- (BOOL)stop;
- (BOOL)prepareToPlay;

@end

NS_ASSUME_NONNULL_END