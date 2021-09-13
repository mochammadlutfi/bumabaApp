import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../Config/color.dart';

class Carouselmodel {
  String imgpath;
  Function onpress;
  Carouselmodel({this.imgpath, this.onpress});
}

// launchURL(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

final List<Carouselmodel> imgList = [
  new Carouselmodel(
      imgpath: 'assets/img/OVO_new-user_landingpage.jpg',
      onpress: () {
      }),
  new Carouselmodel(
      imgpath: 'assets/img/CLBK-OVO.jpg',
      onpress: () {
      }),
  new Carouselmodel(
      imgpath: 'assets/img/bayardisini.jpg',
      onpress: () {
      }),
  new Carouselmodel(
      imgpath: 'assets/img/sos.jpg',
      onpress: () {
      }),
  new Carouselmodel(
      imgpath: 'assets/img/double.jpg',
      onpress: () {
      }),
];

final List<Widget> imageSliders = imgList
    .map((Carouselmodel c) => Container(
          child: GestureDetector(
            onTap: c.onpress,
            child: Container(
              margin: EdgeInsets.only(right: 7.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                child: Image.asset(c.imgpath, fit: BoxFit.cover, width: 1000.0),
              ),
            ),
          ),
        ))
    .toList();

class Imagecarousel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImagecarouselState();
  }
}

class _ImagecarouselState extends State<Imagecarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              height: 126,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
          items: imageSliders,
        ),
        SizedBox(
          height: 13,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.map((url) {
            int index = imgList.indexOf(url);
            return Container(
              width: 6.0,
              height: 6.0,
              margin: EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index ? cyantext : Colors.grey[300],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
