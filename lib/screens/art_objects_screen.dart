import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rijksmuseum/cubit/art_object/art_object_cubit.dart';
import 'package:rijksmuseum/cubit/art_object_details/art_object_details_cubit.dart';
import 'package:rijksmuseum/screens/art_object_details_screen.dart';
import 'package:rijksmuseum/widgets/error_text_and_try_again_button.dart';
import 'package:rijksmuseum/widgets/fetching_progress_indicator.dart';

class ArtObjectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ArtObjectCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Art objects"),
      ),
      body: BlocBuilder<ArtObjectCubit, ArtObjectState>(
        builder: (context, state) {
          if (state is ArtObjectFetching) return FetchingProgressIndicator();
          if (state is ArtObjectError)
            return ErrorTextAndTryAgainButton(
              message: state.message,
              onPressed: bloc.fetchArtObjects,
            );

          state as ArtObjectSuccess;

          return ListView.builder(
            itemCount: state.artObjects.length,
            physics: const RangeMaintainingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            itemBuilder: (context, i) {
              return Card(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (context) =>
                              ArtObjectDetailsCubit(bloc.dataRepository, state.artObjects[i])..fetchArtObjectDetails(),
                          child: ArtObjectDetailsScreen(),
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: state.artObjects[i].headerImgUrl == null
                              ? null
                              : StatefulBuilder(
                                  builder: (context, setState) {
                                    final imgProvider = NetworkImage(state.artObjects[i].headerImgUrl!);
                                    return SizedBox(
                                      height: 90,
                                      child: ColoredBox(
                                        color: Colors.white,
                                        child: Image(
                                          image: imgProvider,
                                          key: UniqueKey(),
                                          errorBuilder: (_, __, ___) {
                                            return GestureDetector(
                                              onTap: () {
                                                imgProvider.evict();
                                                setState(() {});
                                              },
                                              child: ColoredBox(
                                                color: Colors.black,
                                                child: Center(
                                                  child: const Icon(
                                                    Icons.refresh,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          loadingBuilder: (_, widget, progress) {
                                            if (progress == null) return widget;
                                            return const ColoredBox(
                                              color: Colors.black,
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          state.artObjects[i].principalOrFirstMaker,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.purple.shade300,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          state.artObjects[i].title,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple.shade900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
