import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageScreen extends StatefulWidget{

  List images;
  ImageScreen(this.images);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ImageScreen();
  }

}

class _ImageScreen extends State<ImageScreen>{

  int _currentImage = 0;

  List<Widget> buildPageIndicator(){
    List<Widget> list = [];
    for (var i = 0; i < widget.images.length; i++) {
      list.add(buildIndicator(i == _currentImage));
    }
    return list;
  }

  Widget buildIndicator(bool isActive){
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 6),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.blueGrey : Colors.grey[400],
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 120,
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (int page){
                    setState((){
                      _currentImage = page;
                    });
                  },
                  children: widget.images.map((path) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: PhotoView(
                        imageProvider: NetworkImage(
                          path,
                        )
                      ),
                    );
                  }).toList(),
                ),
              ),

              widget.images.length > 1
                  ? Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: buildPageIndicator(),
                ),
              )
                  : Container(),
            ],
          )
        )
      ),
    );
  }

}