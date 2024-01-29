import 'package:project/model/albums.model.dart';
import 'package:project/provider/api.provider.dart';

class AlbumRepository {
  final AlbumApiProvider _apiProvider = AlbumApiProvider();

  Future<Albums> fetchAlbumList() async {
    return await _apiProvider.fetchAlbumList();
  }
}
