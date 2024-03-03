import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:zb_runner/presentation/screen/search_page.dart';
import 'package:zb_runner/presentation/screen/vid_screen.dart';
import 'package:zb_runner/view_model/movie_view.dart';

import '../../constants/app_constant.dart';
import '../../constants/navigators.dart';
import 'detail_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MainPageState();
}

class _MainPageState extends State<HomePage> {

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
      _viewModel.getPopularMovies();
      _isFirstTime = false;
    }

    return Scaffold(
      backgroundColor: mainTheme(context),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.appColor,
        title: const Text(
          "HD MovieLis+",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () =>navigatePush(context,const SearchPage()),
              icon: const Icon(
                CupertinoIcons.search,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () =>navigatePush(context,const VidScreen()),
              icon: const Icon(CupertinoIcons.videocam_circle,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.appColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(80),
              const Text("Menu",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
              const Gap(30),
              _drawerItemBuilder(Icons.trending_up, "Trends"),
              _drawerItemBuilder(
                  CupertinoIcons.calendar_badge_plus, "Upcoming"),
              _drawerItemBuilder(Icons.star, "Top rated"),
              _drawerItemBuilder(Icons.emergency_recording_outlined, "Genres"),
              _drawerItemBuilder(CupertinoIcons.bookmark_fill, "To watch"),
              _drawerItemBuilder(Icons.settings, "Settings"),
            ],
          ),
        ),
      ),
      body: _viewModel.loading ? const Center(child: CupertinoActivityIndicator(radius: 30)) : _buildMovieGrid(),
    );
  }

  _drawerItemBuilder(IconData icon, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          const Gap(10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white38),
                borderRadius: BorderRadius.circular(12)),
            child: Center(
                child: Text(data,
                    style: const TextStyle(color: Colors.white, fontSize: 18))),
          )
        ],
      ),
    );
  }

  _buildMovieGrid() {
    return Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
        child: GridView.builder(
            itemCount: _viewModel.popularMovieList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 210),
            itemBuilder: (context, index) {
              final movie = _viewModel.popularMovieList[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => navigatePush(context,  DetailedScreen(movie: movie)),
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(children: [
                          Image.network("https://image.tmdb.org/t/p/w500${movie.posterPath}",
                              fit: BoxFit.cover),
                          Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                height: 25,
                                width: 45,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12)),
                                child:  Center(
                                    child: Text("${movie.popularity}",
                                        style: const TextStyle(color: Colors.white))),
                              ))
                        ]),
                      ),
                    ),
                  ),
                  Text("${movie.title}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold))
                ],
              );
            }));
  }
}
