// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:get/get.dart';

class WaterFallTest extends StatefulWidget {
  const WaterFallTest({Key? key}) : super(key: key);

  @override
  _WaterFallTestState createState() => _WaterFallTestState();
}

class _WaterFallTestState extends State<WaterFallTest> {
  final List _list = [0, 1, 2, 3, 4, 5, 6, 7];

  //Get image Size
  Size _calculateImageDimension(Image image) {
    Rx<Size> size = const Size(0, 0).obs;
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;

          // printing image Height on the console
          print("height====> ${myImage.height.toDouble()}");
          size.value =
              Size(myImage.width.toDouble(), myImage.height.toDouble());
        },
      ),
    );
    return size.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: WaterfallFlow.builder(
        addAutomaticKeepAlives: true,
        key: const Key("WaterFallFlow_List"),
        restorationId: "WaterFallFlow",
        itemCount: _list.length,
        padding: const EdgeInsets.all(5.0),
        gridDelegate: const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          // get image from local image store {directory == images}
          Image image = Image.asset(
            'images/$index.jpg',
            fit: BoxFit.cover,
          );
          //passing our values in the stateless widget
          return Obx(() => ShowImage(image, _calculateImageDimension(image)));
        },
      ),
    ));
  }
}

class ShowImage extends StatelessWidget {
  final Image image;
  final Size imageSize;
  const ShowImage(this.image, this.imageSize, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width / 2,
        height: imageSize.height > 1000
            ? imageSize.height > 1900
                ? (imageSize.height * 0.25)
                : (imageSize.height * 0.33)
            : (imageSize.height * 0.57),
        child: Container(
            margin: const EdgeInsets.only(left: 3.0, right: 3.0, bottom: 20),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, //[600],
                    offset: Offset(4.0, 4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0),
                BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0),
              ],
              color: Colors.grey[200],
              shape: BoxShape.rectangle,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(color: Colors.red, child: image),
                ),
                Text(
                    "height: ${imageSize.height} ==========================width:: ${imageSize.width}")
              ],
            )));
  }
}
/*
? imageSize.height / 6
                      : imageSize.height / 3,*/
