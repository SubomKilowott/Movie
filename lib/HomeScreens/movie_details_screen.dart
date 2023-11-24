// ignore_for_file: depend_on_referenced_packages, avoid_print
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'package:movieapp/Models/VideosResponse.dart';
import 'package:movieapp/db/app_db.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:drift/drift.dart' as drift;
import 'package:dio/dio.dart';

class Details extends StatefulWidget {
  const Details({
    super.key,
    required this.imageUrl,
    required this.movietitle,
    required this.description,
    required this.release,
    required this.popularity,
    required this.vote,
    required this.voteavg,
    required this.id,
  });

  final String imageUrl;
  final String movietitle;
  final String description;
  final String release, popularity, vote, voteavg, id;

  @override
  // ignore: library_private_types_in_public_api
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  VideosResponse? videos;
  String? videoKey;
  late AppDatabase _appDatabase;
  bool intable = false;

  @override
  void initState() {
    super.initState();
    getvideo();

    _appDatabase = AppDatabase();

    _appDatabase.getMovie(widget.id).then((movie) {
      setState(() {
        // ignore: unnecessary_null_comparison
        intable = movie != null;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String?> getvideo() async {
    try {
      var response = await Dio().get(
          'https://api.themoviedb.org/3/movie/${widget.id}/videos?api_key=ff78f911e0dbd4c6c56dd3096993fb27');

      if (response.statusCode == 200) {
        videos = VideosResponse.fromJson(response.data);
        videoKey = videos?.results?[0].key ?? '';
        setState(() {});
      } else {
        print(response.statusCode);
      }
    } on DioException catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  height: 450,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(180),
                        bottomRight: Radius.circular(180)),
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            child: const Icon(
                              Icons.arrow_back,
                              size: 40,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            onTap: () {
                              Navigator.pop(
                                context,
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 250,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: IconButton(
                            onPressed: () {
                              if (intable) {
                                const snackBar = SnackBar(
                                  dismissDirection: DismissDirection.up,
                                  duration: Duration(seconds: 2),
                                  content: Padding(
                                    padding: EdgeInsets.fromLTRB(80, 0, 0, 0),
                                    child: Text('Movie deleted from watchlist'),
                                  ),
                                  backgroundColor:
                                      Color.fromARGB(255, 98, 190, 221),
                                  behavior: SnackBarBehavior.floating,
                                );
                                _appDatabase.deleteMovie(widget.id).then(
                                    (value) => ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar));
                                setState(() {
                                  intable = false;
                                });
                              } else {
                                final entity = MovieCompanion(
                                  id: drift.Value(widget.id),
                                  title: drift.Value(widget.movietitle),
                                  description: drift.Value(widget.description),
                                  category: drift.Value(widget.imageUrl),
                                );
                                const snackBar = SnackBar(
                                  dismissDirection: DismissDirection.up,
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(seconds: 2),
                                  content: Padding(
                                    padding: EdgeInsets.fromLTRB(80, 0, 0, 0),
                                    child: Text('Movie added to watchlist'),
                                  ),
                                  backgroundColor:
                                      Color.fromRGBO(255, 171, 171, 1),
                                );
                                _appDatabase.inserMovie(entity).then(
                                      (value) => ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar),
                                    );
                                setState(() {
                                  intable = true;
                                });
                              }
                            },
                            icon: Icon(
                              intable ? Icons.bookmark : Icons.bookmark_outline,
                              color: intable
                                  ? const Color.fromARGB(255, 255, 183, 183)
                                  : Color.fromARGB(255, 255, 255, 255),
                            ),
                            iconSize: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(36, 10, 0, 0),
              child: Row(
                children: [
                  const Icon(
                    Icons.add_circle_outline_outlined,
                    size: 30,
                    color: Color.fromARGB(255, 133, 133, 133),
                  ),
                  const SizedBox(
                    width: 250,
                  ),
                  IconButton(
                    onPressed: () {
                      Share.share("Title: ${widget.movietitle}\n"
                          "Description: ${widget.description} \n"
                          "PhotoUrl:${widget.imageUrl}\n");
                    },
                    icon: const Icon(
                      Icons.share,
                      size: 30,
                      color: Color.fromARGB(255, 80, 80, 80),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              child: Text(
                widget.movietitle,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Color.fromARGB(255, 232, 232, 232),
                      letterSpacing: 1,
                      fontSize: 30),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    child: Column(
                      children: [
                        Text(
                          " Release date",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 232, 232, 232),
                                letterSpacing: 1,
                                fontSize: 12),
                          ),
                        ),
                        Text(
                          widget.release,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 178, 178, 178),
                                letterSpacing: 1,
                                fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Align(
                    child: Column(
                      children: [
                        Text(
                          "Popularity",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 232, 232, 232),
                                letterSpacing: 1,
                                fontSize: 12),
                          ),
                        ),
                        Text(
                          widget.popularity,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 178, 178, 178),
                                letterSpacing: 1,
                                fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Align(
                    child: Column(
                      children: [
                        Text(
                          "Vote Count",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 232, 232, 232),
                                letterSpacing: 1,
                                fontSize: 12),
                          ),
                        ),
                        Text(
                          widget.vote,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 178, 178, 178),
                                letterSpacing: 1,
                                fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Align(
                    child: Column(
                      children: [
                        Text(
                          "Average Vote",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 232, 232, 232),
                                letterSpacing: 1,
                                fontSize: 12),
                          ),
                        ),
                        Text(
                          widget.voteavg,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 178, 178, 178),
                                letterSpacing: 1,
                                fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.description,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Color.fromARGB(255, 232, 232, 232),
                        letterSpacing: 1,
                        fontSize: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 290, 0),
              child: Text(
                "Trailer",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Color.fromARGB(255, 232, 232, 232),
                      letterSpacing: 1,
                      fontSize: 22,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Visibility(
              visible: videoKey?.isNotEmpty ?? false,
              child: YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: videos?.results?[0].key ?? '',
                    flags: const YoutubePlayerFlags(
                      autoPlay: true,
                      mute: true,
                      isLive: false,
                    ),
                  ),
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                  onReady: () {},
                ),
                builder: (context, player) {
                  return SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: player,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
