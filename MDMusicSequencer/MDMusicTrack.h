//
//  MDMusicTrack.h
//  Mix Up Studio
//
//  Created by user on 22.04.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MDMusicTrackEventEnumerator.h"
#import "MDMusicTrackEventEnumerator+MDMusicTrackEventManager.h"

//Данный класс не нужно инстанцировать. Для создания музыкальных треков необходимо пользоваться секвенсором

NS_ASSUME_NONNULL_BEGIN

//------------------------------------------------------------------------------
#pragma mark - Public interface MDMusicTrack
//------------------------------------------------------------------------------
@interface MDMusicTrack : NSObject {
@protected
    void *_impl;
}

@property (nonatomic, readonly) MDTimeInBeats trackLength;

//Событие добавляется, если его нет в music track.
//Не имеет смысл в трек добавлять множество абсолютно одинаковых событий.
- (void)addMusicTrackEvent:(MDMusicTrackEvent *)musicTrackEvent;

//Удаляет все события, расположенные в переданном диапазоне времени.
- (void)removeAllEventsWithRange:(MDTimeInBeatsRange)beatNoteRange;

//Удаляет все события.
- (void)removeAllEvents;

//Возвращает enumerator, установленный на первое событие.
//Если событий в music track нет, то возвращает nil.
- (MDMusicTrackEventEnumerator *)eventEnumerator;

- (BOOL)containsTrackEvent:(MDMusicTrackEvent *)musicTrackEvent;

//Utilities track
- (void)printTrack;
- (void)printAllEvent;

@end

@interface MDMusicTrack (MDMusicTrackEventEditor)
//------------------------------------------------------------------------------
#pragma mark - Editing All Events of Music Track
//------------------------------------------------------------------------------
- (void)moveAllEventsWithRange:(MDTimeInBeatsRange)beatNoteRange
          inMoveNumberBeatNote:(MDTimeInBeats)inMoveNumberBeatNote;


@end

NS_ASSUME_NONNULL_END