import 'dart:convert';

import 'package:http/http.dart';
import 'package:project/model/albums.model.dart';

class AlbumApiProvider {
  Client client = Client();

  Future<Albums> fetchAlbumList() async {
    final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Albums.fromJson(data);
    } else {
      throw Exception('Failed to load album');
    }
  }
}
