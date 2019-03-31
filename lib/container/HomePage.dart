import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
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
  List<String> mvs = [
    '1553999276207090.mp4',
    '1553999276218217.mp4',
    '1553999276228608.mp4',
    '1554038445433021.mp4'
  ];
  int pageIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _initVideo(0);
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
          return Container();
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
    if (_controllers.length <= nextIndex) {
      _initVideo(nextIndex);
    }
  }

  _initVideo(nextIndex) {
    String mp4 = mvs[nextIndex];
    print('init video init');
    var _ctrl = VideoPlayerController.network('http://192.168.1.4:8080/$mp4');
    _controllers.insert(nextIndex, _ctrl);
    _ctrl
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controllers.forEach((f) {
      f.dispose();
    });
  }
}
