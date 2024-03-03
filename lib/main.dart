import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zb_runner/presentation/screen/home_page.dart';
import 'package:zb_runner/presentation/screen/vid_screen.dart';
import 'package:zb_runner/view_model/movie_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>MovieViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3:true,
          primaryColor: const Color(0xfffdfafd),
        ),
        home: const HomePage()),
    );
  }
}

