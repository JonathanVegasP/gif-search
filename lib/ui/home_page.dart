import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gifs_search/apis/apis.dart';
import 'package:gifs_search/images/images.dart';
import 'package:gifs_search/ui/gif_selected.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  int _offset = 0;

  Future<Map> _getGifs() async {
    http.Response response;
    if (_search == null || _search.isEmpty)
      response = await http.get(GIFS);
    else
      response = await http.get(search(_search, _offset));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.asset(APPBAR),
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (s) {
                  setState(() {
                    _search = s;
                    _offset = 0;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _getGifs(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Container(
                        width: 200.0,
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      );
                    default:
                      if (snapshot.hasError)
                        return Container();
                      else
                        return _createGitTable(context, snapshot);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  int _getCount(List data) {
    if (_search == null || _search.isEmpty)
      return data.length;
    else
      return data.length + 1;
  }

  Widget _createGitTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: _getCount(snapshot.data["data"]),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemBuilder: (context, index) {
        if (_search == null ||
            _search.isEmpty ||
            index < snapshot.data["data"].length)
          return GestureDetector(
            onLongPress: () => Share.share(
                snapshot.data["data"][index]["images"]["fixed_height"]["url"]),
            onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GifSelected(
                          snapshot.data["data"][index],
                        ),
                  ),
                ),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: snapshot.data["data"][index]["images"]["fixed_height"]["url"],
              fit: BoxFit.cover,
            ),
          );
        else
          return GestureDetector(
            onTap: () {
              setState(() {
                _offset += 19;
              });
            },
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 50.0,
              ),
            ),
          );
      },
    );
  }
}
