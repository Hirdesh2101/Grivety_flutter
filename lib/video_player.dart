import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grivety/video_model.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayercustom extends StatefulWidget {
  VideoPlayercustom(this.index, this.documents);
  final int index;
  final dynamic documents;

  @override
  _VideoPlayercustomState createState() => _VideoPlayercustomState();
}

class _VideoPlayercustomState extends State<VideoPlayercustom> {
  bool _visible = false;
  bool _muted = false;
  Video? video;
  @override
  void initState() {
    video = Video.fromJson(widget.documents[widget.index].data());
    video!.loadController().then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    video!.controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!.uid;
    dynamic docu = widget.documents[widget.index].id;
    List<dynamic> list = widget.documents[widget.index].data()['Likes'];
    return video!.controller != null && video!.controller!.value.isInitialized
        ? VisibilityDetector(
            key: Key(widget.index.toString()),
            onVisibilityChanged: (info) {
              var visiblePercentage = info.visibleFraction * 100;
              if (visiblePercentage < 50) {
                if (video!.controller!.value.isPlaying) {
                  video!.controller!.pause();
                }
              } else {
                if (!video!.controller!.value.isPlaying) {
                  video!.controller!.play();
                }
              }
            },
            child: Stack(children: [
              GestureDetector(
                // behavior: HitTestBehavior.opaque,
                onDoubleTap: () async {
                  var obj = [user];

                  //_setLike();
                  if (list.contains(user)) {
                    await FirebaseFirestore.instance
                        .collection('Community')
                        .doc(docu)
                        .update({'Likes': FieldValue.arrayRemove(obj)});
                  } else {
                    setState(() {
                      _visible = !_visible;
                    });
                    Future.delayed(const Duration(seconds: 1), () {
                      setState(() {
                        _visible = !_visible;
                      });
                    });
                    await FirebaseFirestore.instance
                        .collection('Community')
                        .doc(docu)
                        .update({'Likes': FieldValue.arrayUnion(obj)});
                  }
                },
                onLongPressStart:
                    (LongPressStartDetails longPressStartDetails) {
                  if (video!.controller!.value.isPlaying) {
                    video!.controller?.pause();
                  }
                },
                onLongPressEnd: (LongPressEndDetails longPressEndDetails) {
                  if (!video!.controller!.value.isPlaying) {
                    video!.controller?.play();
                  }
                },
                onTap: () {
                  if (video!.controller!.value.volume == 1.0) {
                    video!.controller?.setVolume(0.0);
                    setState(() {
                      _muted = true;
                    });
                  } else {
                    video!.controller?.setVolume(1.0);
                    setState(() {
                      _muted = false;
                    });
                  }
                },
                child: SizedBox(
                  width: video!.controller?.value.size.width ?? 0,
                  height: min(MediaQuery.of(context).size.height * 0.5,
                      video!.controller?.value.size.height as double),
                  child: VideoPlayer(video!.controller!),
                ),
              ),
              _muted
                  ? Positioned(
                      right: 0,
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.height * 0.04,
                          child: const Icon(Icons.volume_off),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey.withOpacity(0.7),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      width: 0,
                      height: 0,
                    ),
              _visible
                  ? Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Lottie.asset(
                        'assests/likeanim.json',
                        repeat: true,
                        height: 80,
                        width: 80,
                      ),
                    )
                  : SizedBox(
                      width: 0,
                      height: 0,
                    ),
            ]),
          )
        : Center(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Text('Loading')),
          );
  }
}
