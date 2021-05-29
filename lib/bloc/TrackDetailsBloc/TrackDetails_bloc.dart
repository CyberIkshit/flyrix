import 'package:bloc/bloc.dart';
import 'package:flyrix/data/models/TrackDetailsModel.dart';
import 'package:meta/meta.dart';
import 'package:flyrix/bloc/TrackDetailsBloc/TrackDetails_state.dart';
import 'package:flyrix/data/repository/TrackDetailsRepository.dart';

import 'TrackDetails_event.dart';

class TrackDetailsBloc extends Bloc<TrackDetailsEvent, TrackDetailsState> {
  TrackDetailsRepository repository;
  String trackId;
  TrackDetailsBloc({@required this.repository, this.trackId})
      : super(TrackDetailsInitialState());

  // @override
  // // TODO: implement initialState
  // TrackDetailsState get initialState => TrackDetailsInitialState();
  @override
  Stream<TrackDetailsState> mapEventToState(TrackDetailsEvent event) async* {
    if (event is FetchTrackDetailsEvent) {
      yield TrackDetailsLoadingState();
      try {
        Message message =
            (await repository.getTrackDetails(trackId)) as Message;
        yield TrackDetailsLoadedState(message: message);
      } catch (e) {
        yield TrackDetailsErrorState(err: e.toString());
      }
    }
  }
}
