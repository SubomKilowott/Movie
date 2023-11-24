// ignore: file_names

// ignore_for_file: depend_on_referenced_packages, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movieapp/HomeScreens/movie_details_screen.dart';
import 'package:movieapp/HomeScreens/navigation.dart';
import 'package:movieapp/Models/Popular.dart';

class Popular extends StatefulWidget {
  const Popular({
    super.key,
  });

  @override
  State<Popular> createState() => _Popular();
}

class _Popular extends State<Popular> {
  int _page = 1;
  bool _hasNextpage = true;
  Popular_Movies? details;
  Popular_Movies? rated;
  late ScrollController _controller;
  bool _firstloading = false;
  bool _LoadMoreRunning = false;

  @override
  void initState() {
    super.initState();
    _firstload();
    _controller = ScrollController()..addListener(_loadmore);
  }

  @override
  void dispose() {
    super.dispose();
    _controller;
    _firstload();
  }

  void _loadmore() async {
    if (_hasNextpage == true &&
        _firstloading == false &&
        _LoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _LoadMoreRunning == true;
      });
      _page += 1;

      try {
        var response = await Dio().get(
            'https://api.themoviedb.org/3/movie/popular?page=$_page&api_key=ff78f911e0dbd4c6c56dd3096993fb27');

        rated = Popular_Movies.fromJson(response.data);
        setState(() {
          if (rated != null && _page <= 3) {
            setState(() {
              details?.results?.addAll(rated?.results ?? []);
            });
          } else {
            setState(() {
              _hasNextpage = false;
            });
          }
        });
      } on DioException catch (e) {
        print(e);
      }

      setState(() {
        _LoadMoreRunning == false;
      });
    }
  }

  void _firstload() async {
    setState(() {
      _firstloading = true;
    });
    try {
      var response = await Dio().get(
          'https://api.themoviedb.org/3/movie/popular?page=$_page&api_key=ff78f911e0dbd4c6c56dd3096993fb27');
      if (response.statusCode == 200) {
        setState(() {
          details = Popular_Movies.fromJson(response.data);
        });
      } else {
        print(response.statusCode);
      }
    } on DioException catch (e) {
      print(e);
    }
    setState(() {
      _firstloading = false;
    });
  }

  String truncateDescription(String description, int maxWords) {
    if (description.isEmpty) return '';

    List<String> words = description.split(' ');

    if (words.length <= maxWords) {
      return description;
    } else {
      return '${words.take(maxWords).join(' ')}...';
    }
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Popular',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_circle_left_outlined,
            color: Color.fromARGB(255, 135, 135, 135),
          ),
          onPressed: () {
            const MyBottomNavigationBar();

            Navigator.pop(context);
          },
        ),
      ),
      body: _firstloading
          ? const Center(
              child: SpinKitFadingCircle(
                color: Color.fromARGB(255, 255, 255, 255),
                size: 40,
              ),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: details?.results?.length ?? 0,
                    controller: _controller,
                    itemBuilder: (_, index) => Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                      child: GestureDetector(
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
                                description:
                                    details?.results![index].overview ??
                                        'No title Available',
                                release: details?.results![index].releaseDate ??
                                    'No title Available',
                                popularity: details?.results?[index].popularity
                                        .toString() ??
                                    'Popularity Not available',
                                vote: details?.results?[index].voteCount
                                        .toString() ??
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
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                              color: Color.fromARGB(255, 0, 0, 0)),
                          padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.0),
                                    ),
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        textAlign: TextAlign.start,
                                        details?.results?[index]
                                                .originalTitle ??
                                            'No title Available',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          decoration: TextDecoration.underline,
                                          shadows: [
                                            Shadow(
                                                color: Colors.black,
                                                offset: Offset(0, -1))
                                          ],
                                        )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 140, 0),
                                      child: Text(
                                        textAlign: TextAlign.start,
                                        truncateDescription(
                                            details?.results?[index].overview ??
                                                'No title Available',
                                            50), // Limit to 20 words
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: SizedBox(
                                  height: 210,
                                  child: Image.network(
                                    'http://image.tmdb.org/t/p/w500${details?.results?[index].posterPath}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (_LoadMoreRunning == true)
                  const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 40),
                      child: Center(
                        child: SpinKitFadingCircle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          size: 40,
                        ),
                      )),
                if (_hasNextpage == false)
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    color: Colors.amber,
                    child: const Center(
                      child: Text('You have fetched all of the content'),
                    ),
                  ),
              ],
            ),
    );
  }
}
