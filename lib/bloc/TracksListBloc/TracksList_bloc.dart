import 'package:bloc/bloc.dart';
import 'package:flyrix/data/models/TracksListModel.dart';
import 'package:meta/meta.dart';
import 'package:flyrix/bloc/TracksListBloc/TracksList_event.dart';
import 'package:flyrix/bloc/TracksListBloc/TracksList_state.dart';
import 'package:flyrix/data/repository/TracksListRepository.dart';
class TracksListBloc extends Bloc<TracksListEvent,TracksListState>{
  TracksListRepository repository;
  TracksListBloc ({@required this.repository}) : super(TracksListInitialState());
  // @override
  // // TODO: implement initialState
  // TracksListState get initialState => TracksListInitialState();
  @override
  Stream<TracksListState> mapEventToState(TracksListEvent event) async* {
  if(event is FetchTracksListEvent) {
    yield TracksListLoadingState();
    try{
    Message message=(await repository.getTracksList()) as Message;
    yield TracksListLoadedState(message: message);
  }
  catch(e)
    {
      yield TracksListErrorState(err: e.toString());
    }
  }
  }



}