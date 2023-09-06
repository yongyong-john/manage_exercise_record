abstract class AdVideoEvent {}

class PlayNextVideo extends AdVideoEvent {
  final int videoIndex;
  final int videoCount;
  PlayNextVideo(this.videoIndex, this.videoCount);
}
