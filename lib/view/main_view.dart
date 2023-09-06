import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_exercise_records/bloc/ad_video/ad_video_bloc.dart';
import 'package:manage_exercise_records/bloc/ad_video/ad_video_event.dart';
import 'package:manage_exercise_records/bloc/ad_video/ad_video_state.dart';
import 'package:manage_exercise_records/bloc/category_image/category_image_bloc.dart';
import 'package:manage_exercise_records/bloc/category_image/category_image_event.dart';
import 'package:manage_exercise_records/bloc/login/login_bloc.dart';
import 'package:manage_exercise_records/bloc/login/login_state.dart';
import 'package:manage_exercise_records/common/consts.dart';
import 'package:manage_exercise_records/common/widget/snackbar.dart';
import 'package:manage_exercise_records/view/history_exercise_view.dart';
import 'package:manage_exercise_records/view/login_view.dart';
import 'package:manage_exercise_records/view/record_exercise_view.dart';
import 'package:video_player/video_player.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainView();
}

class _MainView extends State<MainView> {
  final List<GlobalKey> _buttonKeys = List.generate(3, (index) => GlobalKey());
  late VideoPlayerController _controller;
  final List<String> _videoUrls = [
    fittrixAdVideo1,
    fittrixAdVideo2,
  ];
  int _currentVideoIndex = 0;
  int? _currentIndex;
  bool _loginInfo = false;

  @override
  void initState() {
    super.initState();
    _playVideo(_currentVideoIndex);
  }

  void _playVideo(int index) {
    _controller = VideoPlayerController.asset(_videoUrls[index])
      ..initialize().then((_) {
        _controller.play();
        _controller.addListener(_videoListener);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _videoListener() {
    if (_controller.value.position == _controller.value.duration) {
      BlocProvider.of<AdVideoBloc>(context).add(PlayNextVideo(_currentVideoIndex, _videoUrls.length));
    }
  }

  void _handleTap() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  ListTile buildListTile(BuildContext context, int index, String title, String image, OverlayEntry overlayEntry) {
    return ListTile(
      title: Text(title),
      onTap: () async {
        BlocProvider.of<CategoryImageBloc>(context).add(SetCategoryImage(title, image));
        overlayEntry.remove();
        _controller.pause();
        if (index == 0) {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RecordExerciseView()),
          );
        } else if (index == 1) {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HistoryExerciseView()),
          );
        }
        _controller.play();
      },
    );
  }

  void _showOverlay(BuildContext context, int index) {
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                overlayEntry.remove();
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          // Menu content
          Positioned(
            bottom: 60,
            left: 20,
            right: 20,
            child: Material(
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildListTile(context, index, lunge, lungeImage, overlayEntry),
                  buildListTile(context, index, squat, squatImage, overlayEntry),
                  buildListTile(context, index, pushUp, pushUpImage, overlayEntry),
                  buildListTile(context, index, legRaises, legRaisesImage, overlayEntry),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    Overlay.of(context)?.insert(overlayEntry);
  }

  Future<void> _onItemTapped(BuildContext context, int index) async {
    if (_loginInfo == false && index != 2) {
      snackBarWithText(context, 'You are not logged in. Please proceed to login.');
      return;
    }
    if (index == 0 || index == 1) {
      _showOverlay(context, index);
    } else if (index == 2) {
      _controller.pause();
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
      _controller.play();
    }
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _bottomNavigationBar() {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          3,
          (index) => Expanded(
            child: GestureDetector(
              key: _buttonKeys[index],
              onTap: () {
                _onItemTapped(context, index);
              },
              child: Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: Text(
                  [recordExercise, viewExerciseHistory, login][index],
                  style: TextStyle(
                    color: _currentIndex == index ? Colors.black : Colors.grey,
                    fontWeight: _currentIndex == index ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginSuccess) {
          _loginInfo = true;
        } else if (state is LoginFailure || state is LoginNotYet) {
          _loginInfo = false;
        }
        return Scaffold(
          body: MultiBlocListener(
            listeners: [
              BlocListener<AdVideoBloc, AdVideoState>(
                listener: (context, state) {
                  if (state is AdVideoNextPlay) {
                    _currentVideoIndex = state.nextIndex;
                    _playVideo(_currentVideoIndex);
                  }
                },
              ),
            ],
            child: GestureDetector(
              onTap: _handleTap,
              child: Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
          ),
          bottomNavigationBar: _bottomNavigationBar(),
        );
      },
    );
  }
}
