import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../util/http.dart';
import '../util/const.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key, 
    this.video
  }): super(key: key);

  final Map video;
  @override
  State<StatefulWidget> createState() => _HomePage(video: video);
}

class _HomePage extends State<HomePage> {
  _HomePage({
    this.video
  }) : super();
  final Map video;

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
        VideoApp(video: video,),
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
  const VideoApp({
    Key key, 
    this.video
  }): super(key: key);

  final Map video;
  @override
  _VideoAppState createState() => _VideoAppState(initVideo: video);
}

class _VideoAppState extends State<VideoApp> {

  _VideoAppState({
    this.initVideo
  }) : super();
  final Map initVideo;

  List<VideoPlayerController> _controllers = [];
  List<Map> mvs = [];
  int pageIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _fetchVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageView(),
    );
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
          return DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("$HOST/${mvs[index]['thumb']}"),
                fit: BoxFit.fill,
              ),
            ),
            child: SpinKitRing(
              color: Colors.black26,
              size: 50.0,
            ),
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
    _initVideo(nextIndex - 1);
    _initVideo(nextIndex + 1);
  }

  _initVideo(nextIndex) {
    print('init video init');
    if (nextIndex >= 0 && _controllers.length > nextIndex) {
      var _ctrl =_controllers[nextIndex];
      if(!_ctrl.value.initialized){
        _ctrl
        ..initialize().then((_) {
          setState(() {});
        });
      }
    }
  }

  _fetchVideo() async {
    var dio = Http();
    Response<List> resp = await dio.get('/video/recommend');
    setState(() {
      mvs = resp.data.map((t){
        return {
          'video': t['video'],
          'thumb': t['thumb']
        };
      }).toList();
    });
    _controllers = resp.data.map((t){
      String mp4 = t['video'];
      return VideoPlayerController.network('http://funplay.carvenzhang.cn$mp4')
        ..setLooping(true);
    }).toList();
    int index = 0;
    if(initVideo != null){
      index = resp.data.indexWhere((item){
      return item['video'] == initVideo['video'];
      });
    }
    pageController.jumpToPage(index);
    _initVideo(index);
    _initVideo(index + 1);
      setState(() {
        pageIndex = index;
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
