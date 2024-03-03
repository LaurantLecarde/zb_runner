import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zb_runner/view_model/movie_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

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
      appBar:  AppBar(
        title: const Text("HD Movie"),
      ),
      body: _viewModel.loading ? Center(child: CupertinoActivityIndicator()):_getTheData(),
    );
  }
  _getTheData(){
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Popular',
              style: TextStyle(fontSize: 20),
            ),
          ),
          _viewModel.popularMovieList.isNotEmpty ?_buildCarousel() : Center(child: Text("DIDNT WORK USE YOUR MIND")),

        ],
      ),
    );
  }
  
  _buildCarousel(){
    return SizedBox(
      height: 600,
      width: double.infinity,
      child: CarouselSlider.builder(
        options: CarouselOptions(
            height: 400, viewportFraction: 0.7, enlargeCenterPage: true),
        itemCount: _viewModel.popularMovieList.length,
        itemBuilder: (context, index, pageIndex) => OpenContainer(
          closedElevation: 0,
          closedBuilder: (context, invoke) {
            final movie = _viewModel.popularMovieList[index];
            return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                        "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                        fit: BoxFit.cover)));
          },
          openBuilder: (context, invoke) => const SizedBox(),
        ),
      )
    );
  }
}
