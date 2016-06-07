//
//  MDMusicTrackEventEnumerator.h
//  Mix Up Studio
//
//  Created by user on 04.05.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MDMusicTrackEvent.h"

@class MDMusicTrack;

NS_ASSUME_NONNULL_BEGIN

@interface MDMusicTrackEventEnumerator : NSObject {
@protected
    void *_impl;
}

//------------------------------------------------------------------------------
//Init music track event enumerator
//!!! Важно !!! Возвращает nil, если произошла ошибка инициализации,
//              или если music track не имеет event (событий) !!!
//------------------------------------------------------------------------------
//!!! При изменении musicTrack независимо от enumerator необходимо заново создавать enumerator.
//Поэтому лучше получать enumerator непосредственно из musicTrack.
//И использовать его всегда через musicTrack, не сохраняя ссылку на него.

//Init music event enumerator points at the first event on the music track
- (id)initWithMusicTrack:(MDMusicTrack *)musicTrack NS_DESIGNATED_INITIALIZER;

//Init with position for the music event enumerator, in beats.
//If there is no music event at the specified time, on output the enumerator points to the first event after that time.
//Если startTime > trackLength, то enumerator устанавливается в позицию последнего event (события) в треке.
- (id)initWithMusicTrack:(MDMusicTrack *)musicTrack
               startTime:(MDTimeInBeats)startTime;

//Init music event enumerator points at the music track event.
//Если нет такого события в треке, то enumerator устанавливается в начальное положение.
- (id)initWithMusicTrack:(MDMusicTrack *)musicTrack
         musicTrackEvent:(MDMusicTrackEvent *)musicTrackEvent;

//Init music event enumerator points at last event
//Устанавливает enumerator на последнее событие в треке
- (id)initLastEventWithMusicTrack:(MDMusicTrack *)musicTrack;

//------------------------------------------------------------------------------
//Navigating among music events
//------------------------------------------------------------------------------

//If there is no music event at the specified time, on output the enumerator points to the first event after that time.
//Если startTime > trackLength, то enumerator устанавливается в позицию последнего event (события) в треке.
- (BOOL)setPositionAtStartTime:(MDTimeInBeats)startTime;

//Init music event enumerator points at the music track event.
//Если нет такого события в треке, то enumerator устанавливается в начальное положение.
- (BOOL)setPositionAtMusicTrackEvent:(MDMusicTrackEvent *)musicTrackEvent;

//Устанавливает enumerator на первое событие в треке
- (BOOL)setPositionAtFirstEvent;

//Устанавливает enumerator на последнее событие в треке
- (BOOL)setPositionAtLastEvent;

//Возвращает YES, если возможно перейти на предыдущее/следующее событие
//и осуществляет этот переход при возможности.
- (BOOL)previousEvent;
- (BOOL)nextEvent;

//Возвращает musicTrackEvent, на котором установлен enumerator.
- (MDMusicTrackEvent *)currentEvent;

//Возвращает YES, если enumerator установлен на какое-либо событие.
//Enumerator всегда установлен на какое-либо событие.
//Если в треке были удалены все события, тогда enumerator ни на что не указывает
//и данный метод вернет  NO.
- (BOOL)hasCurrentEvent;

//------------------------------------------------------------------------------
//Utilities track event enumerator
//------------------------------------------------------------------------------

- (void)printEventEnumerator;

@end

NS_ASSUME_NONNULL_END
