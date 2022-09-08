import 'package:blocs/converters/loading_error_to_message_converter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repositories/repositories.dart';

class ArtObjectsRepositoryMock extends Mock implements ArtObjectsRepository {}

class LoadingErrorToMessageConverterMock extends Mock implements LoadingErrorToMessageConverter {
  LoadingErrorToMessageConverterMock() {
    when(() => convert(any())).thenReturn('An error occurred');
  }
}
