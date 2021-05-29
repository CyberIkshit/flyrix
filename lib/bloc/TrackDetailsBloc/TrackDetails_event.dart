import 'package:equatable/equatable.dart';

abstract class TrackDetailsEvent extends Equatable {}

class FetchTrackDetailsEvent extends TrackDetailsEvent {
  FetchTrackDetailsEvent();
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
