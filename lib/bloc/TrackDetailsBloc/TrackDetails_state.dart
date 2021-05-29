import 'package:equatable/equatable.dart';
import 'package:flyrix/data/models/TrackDetailsModel.dart';
import 'package:meta/meta.dart';

abstract class TrackDetailsState extends Equatable {}

class TrackDetailsInitialState extends TrackDetailsState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class TrackDetailsLoadingState extends TrackDetailsState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class TrackDetailsLoadedState extends TrackDetailsState {
  Message message;

  TrackDetailsLoadedState({@required this.message});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class TrackDetailsErrorState extends TrackDetailsState {
  String err;
  TrackDetailsErrorState({@required this.err});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
