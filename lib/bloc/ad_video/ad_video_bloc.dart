import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_exercise_records/bloc/ad_video/ad_video_event.dart';
import 'package:manage_exercise_records/bloc/ad_video/ad_video_state.dart';

class AdVideoBloc extends Bloc<AdVideoEvent, AdVideoState> {
  AdVideoBloc() : super(const AdVideoInitial()) {
    on<PlayNextVideo>(_onPlayNextVideo);
  }

  void _onPlayNextVideo(PlayNextVideo event, Emitter<AdVideoState> emit) {
    emit(const AdVideoLoading());
    var nextIndex = (event.videoIndex + 1) % event.videoCount;
    emit(AdVideoNextPlay(nextIndex));
  }
}
