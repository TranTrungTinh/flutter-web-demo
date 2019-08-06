import 'dart:convert';

import 'package:flutter_web/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_web/podo/Movies.dart';
import 'package:movie_web/util/constants.dart';

class DetailPage extends StatefulWidget {

  final int id;  
  // In the constructor, require movie id.
  DetailPage({Key key, @required this.id}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<DetailPage> {

  bool _loading;
  Map response;
  Movie movie;

  getMovie() async {

    setState(() {
      _loading = true;
    });
    var res = await http.get("${Constants.detailUrl}${widget.id}${Constants.apiKey}");
    var decodedJson = jsonDecode(res.body);
    // print(decodedJson);

    if(res.statusCode == 200 && decodedJson != null){
      if(mounted) {
        setState(() {
          movie = Movie.fromJson(decodedJson);
          print(movie.toJson());
          _loading = false;
        });
      }

    } else {
      // print("Something went wrong");
      if(mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getMovie();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container (
        child: _loading ? Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
          ),
        ) : Center(
              child: RaisedButton(
                child: Text(
                  'Detail page ${widget.id}',
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/");
                },
              ),
            ),
      ),
    );
  }
}