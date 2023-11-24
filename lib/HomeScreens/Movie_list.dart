// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Movielist extends StatefulWidget {
  String title;
  String subtitle;
  Color color;
  String trailingImage;
  Color gradient;
  VoidCallback ontab;

  Movielist({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.trailingImage,
    required this.gradient,
    required this.ontab,
  });

  @override
  State<Movielist> createState() => _MovielistState();
}

class _MovielistState extends State<Movielist> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          Card(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  gradient: LinearGradient(
                      colors: [widget.color, widget.gradient],
                      begin: Alignment.topCenter,
                      end: Alignment.topRight)),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(widget.title),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    widget.subtitle,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.white,
                  onPressed: () {
                    // _deleteMovieData(movies.id);
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: SizedBox(
              height: 180,
              child: Image.network(
                widget.trailingImage,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
