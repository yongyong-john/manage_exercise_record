import 'package:equatable/equatable.dart';

abstract class AdVideoState extends Equatable {
  const AdVideoState();
}

class AdVideoInitial extends AdVideoState {
  const AdVideoInitial();

  @override
  List<Object> get props => [];
}

class AdVideoLoading extends AdVideoState {
  const AdVideoLoading();

  @override
  List<Object> get props => [];
}

class AdVideoNextPlay extends AdVideoState {
  final int nextIndex;
  const AdVideoNextPlay(this.nextIndex);

  @override
  List<Object> get props => [nextIndex];
}
