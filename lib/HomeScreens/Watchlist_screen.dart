// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import 'package:movieapp/db/app_db.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  late AppDatabase _appDatabase;

  @override
  void initState() {
    _appDatabase = AppDatabase();
    super.initState();
  }

  void _deleteMovieData(String id) async {
    await _appDatabase.deleteMovie(id);
    setState(() {});
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: FutureBuilder<List<MovieData>>(
        future: _appDatabase.getEmployess(),
        builder: (context, snapshot) {
          final List<MovieData>? movie = snapshot.data;

          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (movie != null) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: movie.length,
              itemBuilder: (context, index) {
                final movies = movie[index];
                return Container(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: <Widget>[
                      Container(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                              color: Color.fromARGB(255, 59, 90, 116)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  textAlign: TextAlign.start,
                                  movies.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 0, 0, 0),
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
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 140, 0),
                                child: Text(
                                  textAlign: TextAlign.start,
                                  truncateDescription(movies.description,
                                      50), // Limit to 20 words
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: IconButton(
                                  iconSize: 25,
                                  icon: const Icon(Icons.delete),
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  onPressed: () {
                                    _deleteMovieData(movies.id);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: SizedBox(
                          height: 210,
                          child: Image.network(
                            movies.category,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Text('No Data Found');
        },
      ),
    );
  }
}
