import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../util/http.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('home page inistate');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        VideoApp(),
        _appBar(),
      ],
    );
  }

  _appBar() {
    final shadow = Shadow(color: Colors.black, offset: Offset(0.5, 0.5));
    return SizedBox(
      height: 80,
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        //导航栏
        title: Text(
          "推荐",
          style: TextStyle(shadows: [shadow]),
        ),
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
    );
  }
}

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  List<VideoPlayerController> _controllers = [];
  List<String> mvs = [];
  int pageIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _fetchVideo();
  }

  @override
  Widget build(BuildContext context) {
    return _pageView();
  }

  _pageView() {
    return PageView.builder(
      onPageChanged: _handlePageChanged,
      controller: pageController,
      itemCount: mvs.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        print('${_controllers.length}, $index');
        if (_controllers.length < index + 1 ||
            !_controllers[index].value.initialized) {
          return SpinKitRing(
            color: Colors.black26,
            size: 50.0,
          );
        } else {
          var _controller = _controllers[index];
          List<Widget> children = [_video(index)];
          if (!_controller.value.isPlaying) {
            children.add(Center(
              child: IconButton(
                icon: Icon(Icons.play_arrow, size: 80, color: Colors.white),
                onPressed: _handleVideoTap,
              ),
            ));
          }
          return Stack(
            children: children,
          );
        }
      },
    );
  }

  _video(index) {
    var _controller = _controllers[index];
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: GestureDetector(
        onTap: _handleVideoTap,
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
        // child: AspectRatio(
        //   aspectRatio: _controller.value.aspectRatio,
        //   child: VideoPlayer(_controller),
        // ),
      ),
    );
  }

  _handleVideoTap() {
    var _controller = _controllers[pageIndex];
    _controller.value.isPlaying ? _controller.pause() : _controller.play();
    setState(() {});
  }

  _handlePageChanged(index) {
    print('_handlePageChanged $index');
    _ctrlVideo(index);
    if (index != pageIndex) {
      setState(() {
        pageIndex = index;
      });
    }
  }

  _ctrlVideo(int nextIndex) {
    print('init video $nextIndex');
    if (_controllers.length > nextIndex) {
      print('init video pause');
      _controllers[pageIndex].pause();
    }
    _initVideo(nextIndex+1);
  }

  _initVideo(nextIndex) {
    print('init video init');
    if (_controllers.length <= nextIndex && mvs.length > nextIndex) {
      String mp4 = mvs[nextIndex];
      var _ctrl =
          VideoPlayerController.network('http://funplay.carvenzhang.cn$mp4');
      _controllers.insert(nextIndex, _ctrl);
      _ctrl
        ..setLooping(true)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  _fetchVideo() async {
    var dio = Http();
    Response resp = await dio.get('/video/recommend');
    List mp4s = resp.data;
    setState(() {
      mvs = mp4s.map((t) {
        String video = t['video'];
        return video;
      }).toList();
    });

    _initVideo(0);
    _initVideo(1);
  }

  @override
  void dispose() {
    super.dispose();
    _controllers.forEach((f) {
      f.dispose();
    });
  }
}
