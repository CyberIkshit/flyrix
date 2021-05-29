import 'package:flyrix/data/models/TrackDetailsModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
abstract class TrackDetailsRepository{
  Future <Message> getTrackDetails(track_id);
}
class TrackDetailsImpl implements TrackDetailsRepository{
  @override
  Future <Message> getTrackDetails(track_id) async{
    var res=await http.get(Uri.parse("https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=${track_id}&apikey=d224b62664ddcc1f57b94acb41d76f9d"));
    if(res.statusCode==200)
    {
      var data= json.decode(res.body);
      Message message=TrackDetailsModel.fromJson(data).message;
      return message;
    }
    else
      throw Exception();
  }

}
