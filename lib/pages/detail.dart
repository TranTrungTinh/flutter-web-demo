import 'dart:convert';

import 'package:flutter_web/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:movie_web/models/Movies.dart';
import 'package:movie_web/utils/constants.dart';

class DetailPage extends StatefulWidget {
  final int id;
  // In the constructor, require movie id.
  DetailPage({Key key, @required this.id}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<DetailPage> {
  bool _loading = false;
  Map response;
  Movie movie;

  getMovie() async {
    setState(() {
      _loading = true;
    });
    var res =
        await http.get("${Constants.detailUrl}${widget.id}${Constants.apiKey}");
    var decodedJson = jsonDecode(res.body);
    // print(decodedJson);

    if (res.statusCode == 200 && decodedJson != null) {
      if (mounted) {
        setState(() {
          movie = Movie.fromJson(decodedJson);
          print(movie.toJson());
          _loading = false;
        });
      }
    } else {
      // print("Something went wrong");
      if (mounted) {
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
    // var imageURL = "https://image.tmdb.org/t/p/w500" + movie.posterPath;
    return Scaffold(
      body: Container(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).accentColor),
                ),
              )
            : Container(
                padding: EdgeInsets.all(40.0),
                // height: 400.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: FractionalOffset.centerLeft,
                              end: FractionalOffset.centerRight,
                              colors: [
                                Color.fromRGBO(30, 47, 60, 0.98).withOpacity(1.0),
                                Color.fromRGBO(48, 65, 78, 0.88).withOpacity(0.8),
                              ],
                            )
                            ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              // height: 350.0,
                              width: 450.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/w500" + movie.posterPath),  fit: BoxFit.cover))
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: 20.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 500.0,
                            margin: EdgeInsets.all(10.0),
                            child: Text('${movie.title} ( ${DateFormat.y().format(DateTime.parse(movie.releaseDate))} )',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Orbitron',
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(height: 40.0),
                          Container(
                            width: 500.0,
                            margin: EdgeInsets.all(10.0),
                            child: Text("Overview",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Orbitron',
                                  fontSize: 19.0)),
                          ),
                          SizedBox(height: 7.0),
                          Container(
                            width: 500.0,
                            margin: EdgeInsets.all(10.0),
                            child: Text(movie.overview,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Avinir',
                                  fontSize: 17.0)),
                          ),

                          // SizedBox(height: 30.0),
                          // Container(
                          //   width: 500.0,
                          //   margin: EdgeInsets.all(10.0),
                          //   child: Text("Product Country - ${(movie.productionCompanies.first)}",
                          //     style: TextStyle(
                          //         color: Colors.white,
                          //         fontFamily: 'Orbitron',
                          //         fontSize: 19.0)),
                          // ),
                          // SizedBox(height: 7.0),
                          // Container(
                          //   width: 500.0,
                          //   margin: EdgeInsets.all(10.0),
                          //   child: Text(movie.productionCompanies[0].toString(),
                          //     style: TextStyle(
                          //         color: Colors.white,
                          //         fontFamily: 'Avinir',
                          //         fontSize: 17.0)),
                          // )

                        ],
                      )
                    ])),
      ),
    );
  }
}
