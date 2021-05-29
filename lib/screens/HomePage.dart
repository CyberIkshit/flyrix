import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyrix/bloc/TracksListBloc/TracksList_bloc.dart';
import 'package:flyrix/bloc/TracksListBloc/TracksList_event.dart';
import 'package:flyrix/bloc/TracksListBloc/TracksList_state.dart';
import 'package:flyrix/data/models/TracksListModel.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flyrix/screens/TrackDetails.dart';
import 'package:flutter_offline/flutter_offline.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TracksListBloc tracksListBloc;
  @override
  void initState() {
    super.initState();
    tracksListBloc = BlocProvider.of<TracksListBloc>(context);
    tracksListBloc.add(FetchTracksListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      debounceDuration: Duration.zero,
      connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
          ) {
        if (connectivity == ConnectivityResult.none) {

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Trending'),
            ),
            body: Center(child: Text('NO INTERNET CONNECTION')),
          );
        }
        return child;
      },
      child:
        Scaffold(
            appBar: new AppBar(
              title: new Text(
                "Trending",
                style: GoogleFonts.lato(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              centerTitle: true,
            ),
            body: Container(
                child: BlocListener<TracksListBloc, TracksListState>(
                    listener: (context, state)  {
              if (state is TracksListErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.err),
                  duration: const Duration(seconds: 1),
                ));
              }
            }, child: BlocBuilder<TracksListBloc, TracksListState>(
              builder: (context, state) {
                if (state is TracksListInitialState)
                  return LoadingIndicator();
                else if (state is TracksListLoadingState)
                  return LoadingIndicator();
                else if (state is TracksListLoadedState) {
                  return TracksList(state.message);
                } else if (state is TracksListErrorState)
                  return buildErrorUi(state.err);
                  else throw Exception();
              },
            )))),

    );
  }

  Widget TracksList(Message message) {
    var snapshot = message.body;
    return ListView.builder(
        itemCount: snapshot.trackList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              snapshot.trackList[index].track.trackName,
              style: GoogleFonts.mavenPro(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(snapshot.trackList[index].track.albumName),
            onTap: () {
              var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new TrackDetails(
                      snapshot.trackList[index].track.trackId.toString()));

              Navigator.of(context).push(router);
            },
            trailing: SizedBox(
              width: 110,
              child: Text(snapshot.trackList[index].track.artistName),
            ),
            leading: new Icon(Icons.library_music_rounded),
          );
        });
  }

  Widget LoadingIndicator() {
    return Container(
      alignment: Alignment.center,
      child: LoadingBouncingGrid.circle(
        backgroundColor: Colors.blue,
        size: 60.0,
        duration: Duration(milliseconds: 500),
      ),
    );
  }

  Widget buildErrorUi(String err) {
    return Center(
      child: Text(err),
    );
  }
  @override
  dispose() {
    super.dispose();
  }
}
