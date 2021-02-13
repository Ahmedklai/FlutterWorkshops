import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  MovieDetail(this.movie);
  final String imgPath = 'https://image.tmdb.org/t/p/w500/';
  @override
  Widget build(BuildContext context) {
    String path;
    if (movie.posterPath != null) {
      path = imgPath + movie.posterPath;
    } else {
      path =
          'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    }

    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: Hero(
        tag: path,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(path), fit: BoxFit.cover)),
        ),
      ),
      bottomSheet: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.3,
          minChildSize: 0.3,
          maxChildSize: 0.6,
          builder: (BuildContext context, myscroolController) {
            return SingleChildScrollView(
                controller: myscroolController,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: Padding(
                    padding: EdgeInsets.all(13.0),
                    child: Column(
                      children: [
                        Text(
                          movie.title,
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Relase Date : " + movie.releaseDate.toString(),
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: Colors.black54),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          movie.overview,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
