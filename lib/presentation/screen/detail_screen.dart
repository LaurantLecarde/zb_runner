import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:zb_runner/constants/navigators.dart';
import 'package:zb_runner/model/popular_movie_response.dart';
import 'package:zb_runner/presentation/screen/vid_screen.dart';
import 'package:zb_runner/view_model/movie_view.dart';
import '../../constants/app_constant.dart';
import '../widget/leading_icon.dart';

class DetailedScreen extends StatefulWidget {
  const DetailedScreen({super.key, required this.movie});

  final movie;

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  late MovieViewModel _viewModel;
  bool _isFirstTime = false;
  bool _isExpanded = false;

  @override
  void initState() {
    _isFirstTime = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstTime) {
      _viewModel = Provider.of<MovieViewModel>(context);
      _viewModel.getDisMovie();
      _isFirstTime = false;
    }

    return Scaffold(
      backgroundColor: mainTheme(context),
      body: _singleMovieField(),
    );
  }

  _singleMovieField() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _imgDataField(),
          _shareUploadSave(),
          _aboutMovie(),
          _recentlyAdded()
        ],
      ),
    );
  }

  _movieDataBuilder(IconData icon, String movieData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(movieData,
                style: const TextStyle(color: Colors.grey, fontSize: 19)),
          )
        ],
      ),
    );
  }

  _imgDataField() {
    return SizedBox(
      height: 520,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.network(
                  "https://image.tmdb.org/t/p/w500${widget.movie.backdropPath}",
                  fit: BoxFit.cover)),
          Positioned(
            top: 45,
            left: 5,
            child: leadingIcon(context),
          ),
          Positioned(
            left: 20,
            bottom: 0,
            child: Row(
              children: [
                SizedBox(
                  height: 250,
                  width: 170,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500${widget.movie.posterPath}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(10),
                      Text(
                        "${widget.movie.title}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const Gap(10),
                      _movieDataBuilder(CupertinoIcons.calendar,
                          "${widget.movie.releaseDate}"),
                      _movieDataBuilder(Icons.watch_later_outlined,
                          "${widget.movie.voteAverage}"),
                      _movieDataBuilder(CupertinoIcons.pano_fill,
                          "${widget.movie.originalTitle}")
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _shareUploadSave() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _shareUploadSaveBuilder(CupertinoIcons.bookmark),
        _shareUploadSaveBuilder(Icons.next_plan_outlined),
        _shareUploadSaveBuilder(Icons.upload),
      ],
    );
  }

  _shareUploadSaveBuilder(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
            color: AppColors.appColor,
            borderRadius: BorderRadius.circular(100)),
        child: Center(
          child: IconButton(
              icon: Icon(icon, color: Colors.white, size: 35),
              onPressed: () {}),
        ),
      ),
    );
  }

  _aboutMovie() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("About Movie",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 23)),
          const Gap(15),
          ExpandableText(style: TextStyle(fontSize: 16),
            '${widget.movie.overview}',
            expandText: 'More',
            collapseText: 'Less',
            maxLines: 3,
            expanded: _isExpanded,
            onExpandedChanged: (newBool) {
              setState(() {
                _isExpanded = newBool;
              });
            },
            linkColor: Colors.blue, // Optional: Color of the 'More' and 'Less' links
          ),
          const Gap(10),
          const Text("Recently Added",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 23)),
        ],
      ),
    );
  }

  _recentlyAdded() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _viewModel.ranVidList.length,
            itemBuilder: (context, index) {
              final movie = _viewModel.ranVidList[index];
              return SizedBox(
                height: 300,
                width: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () =>navigatePush(context,  DetailedScreen(movie: movie)),
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: movie.posterPath!.isNotEmpty
                              ? Stack(children: [
                                  Image.network(
                                      "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                                      fit: BoxFit.cover),
                                  Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        height: 25,
                                        width: 45,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Center(
                                            child: Text("${movie.popularity}",
                                                style: TextStyle(
                                                    color: Colors.white))),
                                      ))
                                ])
                              : Center(child: CupertinoActivityIndicator()),
                        ),
                      ),
                    ),
                    Text("${movie.title}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
              );
            }),
      ),
    );
  }
}
