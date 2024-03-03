import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zb_runner/view_model/movie_view.dart';

import '../../manger/vid_player_youtube.dart';

class VidScreen extends StatefulWidget {
  const VidScreen({super.key});


  @override
  State<VidScreen> createState() => _VidScreenState();
}

class _VidScreenState extends State<VidScreen> {

  late MovieViewModel _viewModel;
  bool _isFirstTime = false;

  @override
  void initState() {
    _isFirstTime = true;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    if(_isFirstTime){
      _viewModel = Provider.of<MovieViewModel>(context);
      _viewModel.getVideos();
      _isFirstTime = false;
    }

    return Scaffold(
      body: _viewModel.loading ? const Center(child: CupertinoActivityIndicator()) : _getTheVid(),
    );
  }

  _getTheVid(){
    return Center(
      child: ListView.builder(itemBuilder: (context,index){
        final movie = _viewModel.vidList[index];
        return YouTubeVidPlayer(videoKey: movie.key ?? "");
      })
    );
  }
}
