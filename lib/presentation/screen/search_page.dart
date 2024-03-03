import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:zb_runner/constants/navigators.dart';
import 'package:zb_runner/presentation/screen/detail_screen.dart';
import 'package:zb_runner/view_model/movie_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late MovieViewModel _viewModel;
  bool _isFirstTime = false;

  @override
  void initState() {
    _isFirstTime = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstTime) {
      _viewModel = Provider.of<MovieViewModel>(context);
      _viewModel.getPopularMovies();
      _viewModel.getDisMovie();
      _isFirstTime = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: SearchBar(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
          backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
          hintText: "Search movie...",
          elevation: MaterialStateProperty.all(0),
          onChanged: (query) => _viewModel.searchMovies(query),
        ),
      ),
      body: _filteredMovies(),
    );
  }

  _filteredMovies() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ListTile(
            leading: Icon(CupertinoIcons.search),
            title: Text("Filtered movies"),
            titleAlignment: ListTileTitleAlignment.center,
            trailing: Icon(CupertinoIcons.forward),
          ),
          _recentlyAdded(),
          _viewModel.popularMovieList.isNotEmpty
              ? _fetchMovies()
              : const Center(child: Text("No such a movie"))
        ],
      ),
    );
  }

  _fetchMovies() {
    return SizedBox(
      height: 600,
      width: double.infinity,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // mainAxisExtent: 500,
              crossAxisSpacing: 5,
              childAspectRatio: 1/1.6),
          itemCount: _viewModel.popularMovieList.length,
          itemBuilder: (context, index) {
            final movie = _viewModel.popularMovieList[index];
            return InkWell(
              onTap: ()=>navigatePush(context, DetailedScreen(movie: movie)),
              child: Card(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                      "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                      fit: BoxFit.cover),
                ),
              ),
            );
          }),
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
                                          style: const TextStyle(
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
