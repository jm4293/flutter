import 'package:flutter/material.dart';
import 'package:project/bloc/album.bloc.dart';
import 'package:project/model/albums.model.dart';

class AlbumView extends StatefulWidget {
  const AlbumView({super.key});

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  final AlbumBloc _albumBloc = AlbumBloc();

  @override
  void initState() {
    super.initState();
    _albumBloc.fetchAllAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Blocl 패턴"),
        ),
        body: StreamBuilder<Albums>(
          stream: _albumBloc.albumStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Albums? albumList = snapshot.data;
              return ListView.builder(
                itemCount: albumList?.albums.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ID: ${albumList?.albums[index].id.toString()}"),
                        Text("Title: ${albumList?.albums[index].title}"),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
