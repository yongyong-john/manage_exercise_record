import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manage_exercise_records/bloc/ad_video/ad_video_bloc.dart';
import 'package:manage_exercise_records/bloc/ad_video/ad_video_event.dart';
import 'package:manage_exercise_records/bloc/ad_video/ad_video_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('AdVideoBloc Test', () {
    late AdVideoBloc adVideoBloc;

    setUp(() {
      adVideoBloc = AdVideoBloc();
    });

    blocTest<AdVideoBloc, AdVideoState>(
      'Should emit AdVideoNextPlay.',

      /// Arrange
      build: () => adVideoBloc,

      /// Act
      act: (bloc) => bloc.add(PlayNextVideo(0, 2)),

      /// Assert
      expect: () => [
        isA<AdVideoLoading>().having((state) => state, 'AdVideoBloc AdVideoLoading', const AdVideoLoading()),
        isA<AdVideoNextPlay>().having((state) => state, 'AdVideoBloc AdVideoNextPlay', const AdVideoNextPlay(1))
      ],
    );

    blocTest<AdVideoBloc, AdVideoState>(
      'Should emit AdVideoNextPlay.',

      /// Arrange
      build: () => adVideoBloc,

      /// Act
      act: (bloc) => bloc.add(PlayNextVideo(1, 2)),

      /// Assert
      expect: () => [
        isA<AdVideoLoading>().having((state) => state, 'AdVideoBloc AdVideoLoading', const AdVideoLoading()),
        isA<AdVideoNextPlay>().having((state) => state, 'AdVideoBloc AdVideoNextPlay', const AdVideoNextPlay(0))
      ],
    );

    tearDown(() {
      adVideoBloc.close();
    });
  });
}
