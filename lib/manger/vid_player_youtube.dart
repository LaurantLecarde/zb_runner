import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeVidPlayer extends StatelessWidget {
  const YouTubeVidPlayer({super.key, required this.videoKey});

  final String videoKey;

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController controller = YoutubePlayerController(
        initialVideoId: videoKey,
        flags: const YoutubePlayerFlags(autoPlay: true, mute: false));
    return YoutubePlayer(
      controller: controller,
      showVideoProgressIndicator: true,
    );
  }
}
