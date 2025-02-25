import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  @override
  ImageSliderState createState() => ImageSliderState();
}

class ImageSliderState extends State<ImageSlider> {
  List<String> images = [
    'images/slide1.png',
    'images/slide2.png',
    'images/slide3.png',
    'images/slide4.png',
    'images/slide5.png'
  ];
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    return Stack(
      children: [
        Container(
            height: 200.0,
            width: double.infinity,
            child: CarouselSlider(
              items: images
                  .map((item) => Container(
                        margin: EdgeInsets.all(5),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(item,
                                fit: BoxFit.cover, width: double.infinity)),
                      ))
                  .toList(),
              options: CarouselOptions(
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  }),
            )),
        /*Container(
            margin: EdgeInsets.only(top: 200),
            color: CustomColors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: images.map((urlOfItem) {
                int index = images.indexOf(urlOfItem);
                return Container(
                  width: 6.0,
                  height: 6.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Colors.black87
                        : Colors.grey[400],
                  ),
                );
              }).toList(),
            ))*/
      ],
    );
  }
}
