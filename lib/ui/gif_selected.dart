import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GifSelected extends StatelessWidget {
  Map<String, dynamic> _getGif;

  GifSelected(Map<String, dynamic> getGif) {
    _getGif = getGif;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getGif["title"]),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => Share.share(
                  _getGif["images"]["fixed_height"]["url"],
                ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_getGif["images"]["fixed_height"]["url"]),
      ),
    );
  }
}
