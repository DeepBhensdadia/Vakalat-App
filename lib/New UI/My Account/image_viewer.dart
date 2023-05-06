import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Image_viewer extends StatefulWidget {
  final String image;
  const Image_viewer({Key? key, required  this.image}) : super(key: key);

  @override
  State<Image_viewer> createState() => _Image_viewerState();
}

class _Image_viewerState extends State<Image_viewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      body: PhotoView(

        // controller: _controller,
        // customSize: Size(300, 300),
        imageProvider: NetworkImage(widget.image),
      ),
    );
  }
}
