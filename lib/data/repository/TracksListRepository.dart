import 'package:flyrix/data/models/TracksListModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class TracksListRepository {
  Future<Message> getTracksList();
}

class TracksListImpl implements TracksListRepository {
  String length;
  @override
  Future<Message> getTracksList() async {
    var res = await http.get(Uri.parse(
        "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=d224b62664ddcc1f57b94acb41d76f9d"));

    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      Message message = TracksListModel.fromJson(data).message;
      return message;
    } else
      throw Exception();
  }
}
