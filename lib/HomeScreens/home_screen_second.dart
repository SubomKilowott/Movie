// ignore: file_names

// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/HomeScreens/movie_details_screen.dart';
import 'package:movieapp/HomeScreens/popular_screen.dart';
import 'package:movieapp/HomeScreens/top_rated_screen.dart';
import 'package:movieapp/HomeScreens/upcoming_screens.dart';
import 'package:movieapp/Models/Popular.dart';
import 'package:movieapp/Models/Top_rated.dart';
import 'package:movieapp/Models/Upcoming_movies.dart';
import 'package:movieapp/Models/movie_details.dart';

class Secondpage extends StatefulWidget {
  const Secondpage({
    super.key,
  });

  @override
  State<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  @override
  void initState() {
    super.initState();

    get();
    getpopular();
    getcoming();
  }

  late MoviesDetailsResponse jsonlist;
  TopDetails? details;
  Popular_Movies? popular;
  Upcoming_movies? coming;

  // ignore: non_constant_identifier_names
  final String api_key = 'ff78f911e0dbd4c6c56dd3096993fb27';

  void get() async {
    try {
      var response = await Dio().get(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=ff78f911e0dbd4c6c56dd3096993fb27');
      if (response.statusCode == 200) {
        setState(() {
          details = TopDetails.fromJson(response.data);
        });
      } else {
        print(response.statusCode);
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  void getpopular() async {
    try {
      var response = await Dio().get(
          'https://api.themoviedb.org/3/movie/popular?api_key=ff78f911e0dbd4c6c56dd3096993fb27');
      if (response.statusCode == 200) {
        setState(() {
          popular = Popular_Movies.fromJson(response.data);
        });
      } else {
        print(response.statusCode);
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  void getcoming() async {
    try {
      var response = await Dio().get(
          'https://api.themoviedb.org/3/movie/upcoming?api_key=ff78f911e0dbd4c6c56dd3096993fb27');
      if (response.statusCode == 200) {
        setState(() {
          coming = Upcoming_movies.fromJson(response.data);
        });
      } else {
        print(response.statusCode);
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CarouselSlider.builder(
                options: CarouselOptions(
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 1.5,
                    viewportFraction: 0.8),
                itemCount: 4,
                itemBuilder: (context, index, realIndex) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Details(
                            imageUrl:
                                'http://image.tmdb.org/t/p/w500${details?.results?[index].posterPath}',
                            movietitle:
                                popular?.results?[index].originalTitle ??
                                    'No title Available',
                            description: popular?.results![index].overview ??
                                'No title Available',
                            release: popular?.results![index].releaseDate ??
                                'No title Available',
                            popularity: popular?.results?[index].popularity
                                    .toString() ??
                                'Popularity Not available',
                            vote:
                                popular?.results?[index].voteCount.toString() ??
                                    'Popularity Not available',
                            voteavg: popular?.results?[index].voteAverage
                                    .toString() ??
                                'Popularity Not available',
                            id: popular?.results?[index].id.toString() ??
                                'Popularity Not available',
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: details?.results?[index].posterPath ==
                                      null
                                  ? 'https://bub.bh/wp-content/uploads/2018/02/image-placeholder.jpg'
                                  : 'http://image.tmdb.org/t/p/w500${coming?.results?[index].posterPath}',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 220,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Container(
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 40),
                          child: Text(
                            coming?.results?[index].originalTitle ??
                                'No title Available',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  letterSpacing: 1,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text(
                      "Top Rated Movies",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 232, 232, 232),
                            letterSpacing: 1,
                            fontSize: 15),
                      ),
                    ),
                    const SizedBox(
                      width: 140,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const Toprated(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_right_alt,
                        size: 30,
                        color: Color.fromARGB(255, 80, 80, 80),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  height: 340.0,
                  autoPlay: false,
                  viewportFraction: 0.6,
                ),
                itemCount: details?.results?.length ?? 0,
                itemBuilder: (context, index, realIndex) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Details(
                            imageUrl:
                                'http://image.tmdb.org/t/p/w500${details?.results?[index].posterPath}',
                            movietitle:
                                details?.results?[index].originalTitle ??
                                    'No title Available',
                            description: details?.results![index].overview ??
                                'No title Available',
                            release: details?.results![index].releaseDate ??
                                'No title Available',
                            popularity: details?.results?[index].popularity
                                    .toString() ??
                                'Popularity Not available',
                            vote:
                                details?.results?[index].voteCount.toString() ??
                                    'Popularity Not available',
                            voteavg: details?.results?[index].voteAverage
                                    .toString() ??
                                'Popularity Not available',
                            id: details?.results?[index].id.toString() ??
                                'Popularity Not available',
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: details?.results?[index].posterPath == null
                              ? 'https://bub.bh/wp-content/uploads/2018/02/image-placeholder.jpg'
                              : 'http://image.tmdb.org/t/p/w500${details?.results?[index].posterPath}',
                          imageBuilder: (context, imageProvider) => Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            height: 220,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            details?.results?[index].originalTitle ??
                                'No title Available',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.people_alt,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              coming?.results?[index].popularity.toString() ??
                                  'Popularity Not available',
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text(
                      "Popular",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 232, 232, 232),
                            letterSpacing: 1,
                            fontSize: 15),
                      ),
                    ),
                    const SizedBox(
                      width: 230,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const Popular(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_right_alt,
                        size: 30,
                        color: Color.fromARGB(255, 80, 80, 80),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  height: 340.0,
                  autoPlay: false,
                  viewportFraction: 0.6,
                ),
                itemCount: popular?.results?.length ?? 0,
                itemBuilder: (context, index, realIndex) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Details(
                            imageUrl:
                                'http://image.tmdb.org/t/p/w500${popular?.results?[index].posterPath}',
                            movietitle:
                                popular?.results?[index].originalTitle ??
                                    'No title Available',
                            description: popular?.results![index].overview ??
                                'No title Available',
                            release: popular?.results![index].releaseDate ??
                                'No title Available',
                            popularity: popular?.results?[index].popularity
                                    .toString() ??
                                'Popularity Not available',
                            vote:
                                popular?.results?[index].voteCount.toString() ??
                                    'Popularity Not available',
                            voteavg: popular?.results?[index].voteAverage
                                    .toString() ??
                                'Popularity Not available',
                            id: popular?.results?[index].id.toString() ??
                                'Popularity Not available',
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: popular?.results?[index].posterPath == null
                              ? 'https://bub.bh/wp-content/uploads/2018/02/image-placeholder.jpg'
                              : 'http://image.tmdb.org/t/p/w500${popular?.results?[index].posterPath}',
                          imageBuilder: (context, imageProvider) => Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            height: 220,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            popular?.results?[index].originalTitle ?? '',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.people_alt,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              coming?.results?[index].popularity.toString() ??
                                  '',
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text(
                      "Upcoming Movies",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 232, 232, 232),
                            letterSpacing: 1,
                            fontSize: 15),
                      ),
                    ),
                    const SizedBox(
                      width: 140,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const Upcoming(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_right_alt,
                        size: 30,
                        color: Color.fromARGB(255, 80, 80, 80),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  height: 340.0,
                  autoPlay: false,
                  viewportFraction: 0.6,
                ),
                itemCount: coming?.results?.length ?? 0,
                itemBuilder: (context, index, realIndex) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Details(
                            imageUrl:
                                'http://image.tmdb.org/t/p/w500${coming?.results?[index].posterPath}',
                            movietitle: coming?.results?[index].originalTitle ??
                                'No title Available',
                            description: coming?.results![index].overview ??
                                'No title Available',
                            release: coming?.results![index].releaseDate ??
                                'No title Available',
                            popularity:
                                coming?.results?[index].popularity.toString() ??
                                    'Popularity Not available',
                            vote:
                                coming?.results?[index].voteCount.toString() ??
                                    'Popularity Not available',
                            voteavg: coming?.results?[index].voteAverage
                                    .toString() ??
                                'Popularity Not available',
                            id: coming?.results?[index].id.toString() ??
                                'Popularity Not available',
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: coming?.results?[index].posterPath == null
                              ? 'https://bub.bh/wp-content/uploads/2018/02/image-placeholder.jpg'
                              : 'http://image.tmdb.org/t/p/w500${coming?.results?[index].posterPath}',
                          imageBuilder: (context, imageProvider) => Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            height: 220,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            coming?.results?[index].originalTitle ??
                                'No title Available',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.people_alt,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              coming?.results?[index].popularity.toString() ??
                                  'Popularity Not available',
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            TextButton(
              onPressed: () => throw Exception(),
              child: const Text("Throw Test Exception"),
            ),
          ],
        ),
      ),
    );
  }
}
