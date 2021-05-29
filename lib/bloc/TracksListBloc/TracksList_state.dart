import 'package:equatable/equatable.dart';
import 'package:flyrix/data/models/TracksListModel.dart';
import 'package:meta/meta.dart';
abstract class TracksListState extends Equatable{}

class TracksListInitialState extends TracksListState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class TracksListLoadingState extends TracksListState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class TracksListLoadedState extends TracksListState{
  Message message;
  TracksListLoadedState({@required this.message});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class TracksListErrorState extends TracksListState{
  String err;
  TracksListErrorState({@required this.err});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
