import 'package:data_sources/data_sources.dart';
import 'package:models/models.dart';

class ArtObjectsRepository {
  final ArtObjectsRemoteDataSource _artObjectsRemoteDataSource;

  ArtObjectsRepository(this._artObjectsRemoteDataSource);

  Future<List<ArtObject>> getArtObjects(int page) {
    return _artObjectsRemoteDataSource.getArtObjects(page);
  }

  Future<ArtObjectDetails> getArtObjectDetails(String objectNumber) {
    return _artObjectsRemoteDataSource.getArtObjectDetails(objectNumber);
  }
}
