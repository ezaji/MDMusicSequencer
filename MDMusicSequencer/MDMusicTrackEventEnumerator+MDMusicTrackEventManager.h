//
//  MDMusicTrackEventEnumerator+MDMusicTrackEventManager.h
//  Mix Up Studio
//
//  Created by user on 06.05.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MDMusicTrackEventEnumerator.h"

@interface MDMusicTrackEventEnumerator (MDMusicTrackEventManager)

//------------------------------------------------------------------------------
//Managing music track event
//------------------------------------------------------------------------------

//Устанавливает вместо текущего события новое.
//Также устанавливает и время начала для текущего события, если оно отлично от переданного
- (BOOL)setEvent:(MDMusicTrackEvent *)newEvent;

//Устанавливает новое время для текущего события.
//Enumerator остается на том же событии.
//Использование этого метода в цикле не определено.
- (BOOL)setCurrentEventTime:(MDTimeInBeats)newStartTime;

//Удаляет текущее событие (на которое указывает enumerator).
//После удаления указывает на следующее событие.
//Если событие было последним, то устанавливается на последнее событие после удаления.
- (BOOL)removeCurrentEvent;

//В объектах переданных событий ничего не изменяется. Сохранять их тоже не имеет смысла.
//MDMusicTrack сохраняет их сам.
//Устанавливает вместо старого события новое.
//Также устанавливает и время начала для текущего события, если оно отлично от переданного
- (BOOL)setEventWithOldEvent:(MDMusicTrackEvent *)oldEvent
                    newEvent:(MDMusicTrackEvent *)newEvent;

//Устанавливает новое время для события, переданного в качестве параметра метода.
//Enumerator остается на том же событии.
//Использование этого метода в цикле не определено.
- (BOOL)setEvent:(MDMusicTrackEvent *)event
       startTime:(MDTimeInBeats)newStartTime;

//Удаляет событие, переданное в качестве параметра метода.
//После удаления указывает на следующее событие.
//Если событие было последним, то устанавливается на последнее событие после удаления.
- (BOOL)removeEvent:(MDMusicTrackEvent *)removeEvent;

@end