import 'package:project/model/albums.model.dart';
import 'package:project/repository/album.repository.dart';
import 'package:rxdart/rxdart.dart';

class AlbumBloc {
  final AlbumRepository _albumRepository = AlbumRepository();
  final PublishSubject<Albums> _albumSubject = PublishSubject<Albums>();

  Stream<Albums> get albumStream => _albumSubject.stream;

  Future<void> fetchAllAlbums() async {
    Albums albums = await _albumRepository.fetchAlbumList();
    _albumSubject.sink.add(albums);
  }

  dispose() {
    _albumSubject.close();
  }
}
