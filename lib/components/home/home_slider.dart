import 'dart:ui';

import 'package:bumaba/models/slide_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class HomeSliderWidget extends StatefulWidget {
  final List<Slide> slides;

  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();

  HomeSliderWidget({Key key, this.slides}) : super(key: key);
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  // ignore: unused_field
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
          color: Colors.white,
          margin: EdgeInsets.only(bottom: 0),
          padding: EdgeInsets.only(top: 14, bottom: 17),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Info dan Promo Spesial",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              widget.slides == null || widget.slides.isEmpty ? 
              CarouselSlider(
                options: CarouselOptions(
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  height: 120,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }
                ),
                items: [1,2,3,].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: EdgeInsets.only(right: 7.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          child: Image.asset('assets/img/loading.gif', fit: BoxFit.fill, width: double.infinity,),
                        ),
                      );
                    },
                  );
                }).toList(),
              )
              : CarouselSlider(
                options: CarouselOptions(
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  height: 120,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }
                ),
                items: widget.slides.map((Slide slide) {
                  return Builder(builder: (BuildContext context) {
                      return Container(
                        child: GestureDetector(
                          onTap: (){},
                          child: Container(
                            margin: EdgeInsets.only(right: 7.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              child: CachedNetworkImage(
                                width: double.infinity,
                                fit: BoxFit.fill,
                                imageUrl: slide.image,
                                placeholder: (context, url) => Image.asset(
                                  'assets/img/loading.gif',
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error_outline),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
  }
}
