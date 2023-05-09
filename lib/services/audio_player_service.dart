import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
// ignore: depend_on_referenced_packages
import 'package:rxdart/rxdart.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final _ishuffle = false.obs;
  final _loopMode = LoopMode.all.obs;
  final _isplaying = false.obs;
  final _currentPlayingIndex = 0.obs;
  final _currentlyPlayingSongs = <Map<String, String>>[].obs;
  final _processingState = ProcessingState.idle.obs;
  final _position = Duration.zero.obs;

  int get currentPlayingIndex => _currentPlayingIndex.value;
  bool get isPlaying => _isplaying.value;

  get isLoopMode => _loopMode.value;
  get isShuffle => _ishuffle.value;
  get processingState => _processingState.value;
  get position => _position.value;
  get duration => _audioPlayer.duration;

  Map<String, String> get currentPlayingSong =>
      _currentlyPlayingSongs.isNotEmpty
          ? _currentlyPlayingSongs[_currentPlayingIndex.value]
          : {};

  AudioSource? get audioSource {
    return _audioPlayer.audioSource;
  }

  Future<AudioPlayerService> init() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    );

    positiondataStream.listen((event) {
      _loopMode.value = event.loopMode;
      _ishuffle.value = event.shuffle!;
      _isplaying.value = event.playerState!.playing;
      _currentPlayingIndex.value = event.index!;
      _processingState.value = event.playerState!.processingState;
      _position.value =
          event.duration!.inMilliseconds > 0 ? event.position! : Duration.zero;

      if (event.playerState!.processingState == ProcessingState.completed) {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });
    return this;
  }

  Stream<PositionData> get positiondataStream {
    return CombineLatestStream.combine7<LoopMode, bool, Duration, Duration,
        Duration?, int?, PlayerState, PositionData>(
      _audioPlayer.loopModeStream,
      _audioPlayer.shuffleModeEnabledStream,
      _audioPlayer.positionStream,
      _audioPlayer.bufferedPositionStream,
      _audioPlayer.durationStream,
      _audioPlayer.currentIndexStream,
      _audioPlayer.playerStateStream,
      (loopmode, shuffle, position, bufferPosition, duration, index,
              processingstate) =>
          PositionData(
        bufferedPosition: bufferPosition,
        duration: duration,
        position: position,
        index: index!,
        playerState: processingstate,
        loopMode: loopmode,
        shuffle: shuffle,
      ),
    );
  }

  Future<void> loadSongs(List<Map<String, String>> songs, int index) async {
    if (listEquals(_currentlyPlayingSongs, songs)) {
      seek(Duration.zero, index: index);
    } else {
      _currentlyPlayingSongs.clear();
    }
    _currentlyPlayingSongs(songs);

    await _audioPlayer.setAudioSource(
        ConcatenatingAudioSource(
          children: songs
              .map((e) => AudioSource.uri(
                    Uri.parse(e['uri']!),
                    tag: MediaItem(
                      id: e['id']!,
                      title: e['title']!,
                      artUri: Uri.parse(e['artUri']!),
                      artist: e['artist'],
                    ),
                  ))
              .toList(),
        ),
        initialIndex: index);
    _audioPlayer.play();
  }

  void play() {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void stop() {
    _audioPlayer.stop();
  }

  void previous() {
    _audioPlayer.seekToPrevious();
  }

  void next() {
    _audioPlayer.seekToNext();
  }

  void seek(Duration position, {int? index}) {
    if (position.inMilliseconds < 0) {
      position = Duration.zero;
    }
    _audioPlayer.seek(position, index: index);
  }

  Future<void> loopmodeSet(String value) async {
    switch (value) {
      case 'off':
        await loopMood(LoopMode.off);
        break;
      case 'one':
        await loopMood(LoopMode.one);
        break;
      case 'all':
        await loopMood(LoopMode.all);
        break;
    }
  }

  Future<void> loop() async {
    if (_loopMode.value == LoopMode.off) {
      await loopMood(LoopMode.one);
    } else if (_loopMode.value == LoopMode.one) {
      await loopMood(LoopMode.all);
    } else if (_loopMode.value == LoopMode.all) {
      await loopMood(LoopMode.off);
    }
  }

  Future<void> loopMood(LoopMode loopMode) async {
    await _audioPlayer.setLoopMode(loopMode);
  }

  Future<void> shuffle(bool shaffle) async {
    await _audioPlayer.setShuffleModeEnabled(shaffle);
    await _audioPlayer.shuffle();
  }
}

class PositionData {
  final Duration? position;
  final Duration? bufferedPosition;
  final Duration? duration;
  final int? index;
  final PlayerState? playerState;
  final bool? shuffle;
  final LoopMode loopMode;

  PositionData({
    required this.position,
    required this.bufferedPosition,
    required this.duration,
    required this.index,
    required this.playerState,
    this.shuffle,
    required this.loopMode,
  });
}
