import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:async";
import 'package:loading_animations/loading_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flyrix/screens/TrackDetails.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Map> _getTracks() async {
    String apiURL =
        "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7";
    var res = await http.get(Uri.parse(apiURL));
    // print("Hey");
    // print(res.body.toString());
    var res_data = json.decode(res.body);
    return res_data["message"]["body"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: FutureBuilder(
          future: _getTracks(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null)
              return Container(
                alignment: Alignment.center,
                child: LoadingBouncingGrid.circle(
                  backgroundColor: Colors.blue,
                  size: 60.0,
                  duration: Duration(milliseconds: 500),
                ),
              );
            else {
              // print(snapshot.data["track_list"][0]);
              return ListView.builder(
                  itemCount: snapshot.data["track_list"].length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        snapshot.data["track_list"][index]["track"]
                            ["track_name"],
                        style: GoogleFonts.mavenPro(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(snapshot.data["track_list"][index]["track"]
                          ["album_name"]),
                      // hoverColor: Colors.redAccent,
                      onTap: () {
                        var router = new MaterialPageRoute(
                            builder: (BuildContext context) => new TrackDetails(
                                snapshot.data["track_list"][index]["track"]
                                        ["track_id"]
                                    .toString()));

                        Navigator.of(context).push(router);
                      },
                      trailing: Text(snapshot.data["track_list"][index]["track"]
                          ["artist_name"]),
                      leading: new Icon(Icons.library_music_rounded),
                    );
                  });
            }
          },
        ));
  }
}
