import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:loading_animations/loading_animations.dart';
import 'package:google_fonts/google_fonts.dart';

String trackDet;
String trackLyr;

class TrackDetails extends StatefulWidget {
  String track_id;
  TrackDetails(this.track_id) {
    trackLyr =
        "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=${this.track_id}&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7";
    trackDet =
        "https://api.musixmatch.com/ws/1.1/track.get?track_id=${this.track_id}&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7";
  }

  @override
  _TrackDetailsState createState() => _TrackDetailsState();
}

class _TrackDetailsState extends State<TrackDetails> {
  Map res_data;
  Future<Map> _getTrackDet() async {
    var res1 = await http.get(Uri.parse(trackDet));
    var res2 = await http.get(Uri.parse(trackLyr));
    // print("Hey");
    // print(res.body.toString());
    var temp = json.decode(res1.body);
    res_data = temp["message"]["body"]["track"];
    temp = json.decode(res2.body);
    res_data["lyrics"] = temp["message"]["body"]["lyrics"]["lyrics_body"];
    return res_data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text("Track Details"),
        ),
        body: new FutureBuilder(
            future: _getTrackDet(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null)
                return Container(
                  alignment: Alignment.center,
                  child: LoadingBouncingGrid.circle(
                    backgroundColor: Colors.blue,
                    size: 60.0,
                  ),
                );
              else {
                return Container(
                    padding: EdgeInsets.fromLTRB(25.0, 20.0, 0, 0),
                    child: ListView(
                      children: [
                        new Text(
                          "Name",
                          style: GoogleFonts.lato(
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        new Text(
                          snapshot.data["track_name"],
                          style: GoogleFonts.lato(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        new Container(
                          height: 20.0,
                        ),
                        new Text(
                          "Artist",
                          style: GoogleFonts.lato(
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        new Text(
                          snapshot.data["artist_name"],
                          style: GoogleFonts.lato(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        new Container(
                          height: 20.0,
                        ),
                        new Text(
                          "Album Name",
                          style: GoogleFonts.lato(
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        new Text(
                          snapshot.data["album_name"],
                          style: GoogleFonts.lato(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        new Container(
                          height: 20.0,
                        ),
                        new Text(
                          "Explicit",
                          style: GoogleFonts.lato(
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        new Text(
                          toBoolean(snapshot.data["explicit"])
                              ? "True"
                              : "False",
                          style: GoogleFonts.lato(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        new Container(
                          height: 20.0,
                        ),
                        new Text(
                          "Rating",
                          style: GoogleFonts.lato(
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        new Text(
                          snapshot.data["track_rating"].toString(),
                          style: GoogleFonts.lato(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        new Container(
                          height: 20.0,
                        ),
                        new Text(
                          "Lyrics",
                          style: GoogleFonts.lato(
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        new Text(
                          snapshot.data["lyrics"],
                          style: GoogleFonts.lato(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        new Container(
                          height: 20.0,
                        ),
                      ],
                    ));
              }
            }));
  }

  bool toBoolean(int a) {
    if (a == 0)
      return true;
    else
      return false;
  }
}
