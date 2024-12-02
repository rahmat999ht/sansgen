import 'dart:async';
import 'dart:developer';

import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'common.dart';

class AudioService {
  final player = AudioPlayer();

  Future playUrl(String url) async {
    final music = await player.setUrl(url);
    log(music.toString(), name: 'music');
  }

  Future playAssets(String assets) async {
     await player.setAsset(assets);
    // log(music.toString(), name: 'music');
  }

  Future play() async {
    await player.play();
  }

  Future pause() async {
    await player.pause();
  }

  Future stop() async {
    await player.stop();
  }

  Future jumToDuration(Duration duration) async {
    await player.seek(duration);
  }

  Future setSpeed(double speed) async {
    await player.setSpeed(speed);
  }

  Future setVolume(double volume) async {
    await player.setVolume(volume);
  }

  Future dispose() async {
    await player.dispose();
  }

  Stream<PlayerState> get playerStream => player.playerStateStream;

  Stream<PositionData> get positionalDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
              (position, buffer, duration) =>
                  PositionData(position, buffer, duration ?? Duration.zero));
}
