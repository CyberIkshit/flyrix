import 'dart:js';

import 'package:bloc/bloc.dart';
import 'package:flyrix/data/models/TrackDetailsModel.dart';
import 'package:meta/meta.dart';
import 'package:flyrix/bloc/TrackDetailsBloc/TrackDetails_event.dart';
import 'package:flyrix/bloc/TrackDetailsBloc/TrackDetails_state.dart';
import 'package:flyrix/data/repository/TrackDetailsRepository.dart';
class TrackDetailsBloc extends Bloc<TrackDetailsEvent,TrackDetailsState>{
  TrackDetailsRepository repository;
  TrackDetailsBloc ({@required this.repository}) : super(TrackDetailsInitialState());

  get track_id => state.props;
  // @override
  // // TODO: implement initialState
  // TrackDetailsState get initialState => TrackDetailsInitialState();
  @override
  Stream<TrackDetailsState> mapEventToState(TrackDetailsEvent event) async* {
  if(event is FetchTrackDetailsEvent) {
    yield TrackDetailsLoadingState();
    try{
    Message message=(await repository.getTrackDetails(track_id)) as Message;
    yield TrackDetailsLoadedState(message: message);
  }
  catch(e)
    {
      yield TrackDetailsErrorState(err: e.toString());
    }
  }
  }



}