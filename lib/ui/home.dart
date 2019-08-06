import 'dart:convert';
// import 'dart:html' as html;

import 'package:flutter_web/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_web/podo/Movies.dart';
import 'package:movie_web/util/constants.dart';
import 'package:movie_web/util/responsive.dart';

import 'package:movie_web/ui/about-us.dart';
import 'package:movie_web/ui/detail.dart';

class HomePage extends StatefulWidget {

  final String title;
  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  bool _loading;
  Map response;
  Movies movies;

  getMovies() async {

    setState(() {
      _loading = true;
    });
    var res = await http.get("${Constants.popularUrl}${Constants.apiKey}");
    var decodedJson = jsonDecode(res.body);
    // print(decodedJson);

    if(res.statusCode == 200 && decodedJson != null){
      if(mounted) {
        setState(() {
          movies = Movies.fromJson(decodedJson);
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
    // html.window.history.pushState(null, "HomePage", "/");
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Padding(
          child: Text("${widget.title}"),
          padding: EdgeInsets.only(left: 12.0),
        ),
        automaticallyImplyLeading: false,

        actions: <Widget>[
          FlatButton(
            child: Text("Home", style: TextStyle(color: Colors.white, fontSize: 17.0, fontFamily: 'Avenir')),
            onPressed: (){
              print("pressed");
            },
          ),

          FlatButton(
            child: Text("Popular", style: TextStyle(color: Colors.white, fontSize: 17.0, fontFamily: 'Avenir')),
            onPressed: (){
              print("pressed");
            },
          ),

          FlatButton(
            child: Text("Top Rated", style: TextStyle(color: Colors.white, fontSize: 17.0, fontFamily: 'Avenir')),
            onPressed: (){
              print("pressed");
            },
          ),

          FlatButton(
            child: Text("About Us", style: TextStyle(color: Colors.white, fontSize: 17.0, fontFamily: 'Avenir')),
            onPressed: (){
              // Navigator.pushNamed(context, '/about');
              Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
              // print("pressed");
            },
          ),

          FlatButton(
            child: Text("Contact Us", style: TextStyle(color: Colors.white, fontSize: 17.0, fontFamily: 'Avenir')),
            onPressed: (){
              print("pressed");
            },
          ),

          // IconButton(
          //   icon: Icon(
          //     Icons.search,
          //   ),
          //   onPressed: (){
          //     print("Pressed");
          //   },
          // ),

        ],
//        elevation: 0.0,
        backgroundColor: Colors.black,
      ),

      body: Padding(
        padding: EdgeInsets.all(5.0),

        child:  _loading ? Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
          ),
        ) : GridView.builder(
          itemCount: movies.results == null ? 0 : movies.results.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: ResponsiveWidget.isSmallScreen(context) ? 2 : 4,
            childAspectRatio: 8.0 / 9.0,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
          ),
          itemBuilder: (BuildContext context, int index){
            Results movie = movies.results[index];
            var imageURL = "https://image.tmdb.org/t/p/w500" + movie.posterPath;
            return Container(
              padding: EdgeInsets.all(5.0),
              child: GridTile(
                footer: GridTileBar(
                  backgroundColor: Colors.black45,
                  title: Text(movie.title)
                ),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, '/movie', arguments: movie.id);
                    // print(movie.title);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(id: movie.id)));
                  },
                  child: Image.network(imageURL, fit: BoxFit.cover ),
                ),
              ),
            );
          },
        ),

      ),
    );
  }
}
