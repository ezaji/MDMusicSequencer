//
//  MDMusicTempoTrack.h
//  Mix Up Studio
//
//  Created by user on 06.05.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MDMusicTrack.h"

NS_ASSUME_NONNULL_BEGIN

@interface MDMusicTempoTrack : MDMusicTrack

//При установке этого свойства >=0, значение bpm устнавливается
//для всей длины воспроизведения. Остальные значения ритма удаляются.
//По умолчанию оно установлено в 120 bpm и применено для всей длины вопроизведения.
//Значение равно -1.0, если установлено несколько ритмов по длине воспроизведения.
@property (nonatomic) MDTempoInBPM bpm;

//Для более точной настройки ритма по длине воспроизведения следует использовать
//следующий метод
- (void)setBpm:(MDTempoInBPM)bpm
     startTime:(MDTimeInBeats)startTime;

@end

NS_ASSUME_NONNULL_END