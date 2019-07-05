import 'package:flutter/material.dart';
import 'package:flutter_jd/page/ShoppingBusPage.dart';
import 'package:quiver/iterables.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class DiscoveryVideo extends StatefulWidget {
  DiscoveryVideo({this.scrollController});

  final Function scrollController;

  @override
  _DiscoveryVideoState createState() {
    return _DiscoveryVideoState();
  }
}

class _DiscoveryVideoState extends State<DiscoveryVideo> {
  final videoPlayerController = VideoPlayerController.network(
      'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4');

  ChewieController chewieController;
  ScrollController _scrollController;

  var show = false;

  @override
  void initState() {
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        //控制右下角箭头显示
        if (_scrollController.position.pixels >= 150) {
          if (show) {
            return;
          }
          setState(() {
            show = !show;
          });
        } else {
          if (!show) {
            return;
          }
          setState(() {
            show = !show;
          });
        }
      });
    widget.scrollController(_scrollController);
    print("_DiscoveryVideoState initState in ");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
            controller: _scrollController,
            children: range(1).map<Widget>((_num) {
              return Center(
//                heightFactor: 3,
                child: Chewie(
                  controller: chewieController,
                ),
              );
            }).toList()),
        show
            ? Positioned(
                child: GestureDetector(
                  child: getFloatNavi(),
                  onTap: () {
                    _scrollController?.jumpTo(
                        MediaQuery.of(context).padding.top + kToolbarHeight);
                  },
                ),
                bottom: 40,
                right: 16,
              )
            : SizedBox()
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    chewieController.dispose();
  }
}
