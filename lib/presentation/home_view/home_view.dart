import 'package:flutter/material.dart';
import 'package:jellyfin_client/domain/models/video_item/video_item_model.dart';
import 'package:jellyfin_client/presentation/home_view/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (_, model, __) => Scaffold(
        body: Center(
          child: StreamBuilder<HomeViewState>(
            stream: model.state,
            initialData: model.state.value,
            builder: (_, AsyncSnapshot<HomeViewState> snapshot) {
              if (snapshot.data is HomeViewError) {
                final String error = (snapshot.data as HomeViewError).error;
                return Text(error);
              } else if (snapshot.data is HomeViewLoaded) {
                final List<VideoItemModel> tmdbList =
                    (snapshot.data as HomeViewLoaded).tmdbList;
                final List<VideoItemModel> resumeList =
                    (snapshot.data as HomeViewLoaded).resumableList;
                return Text(
                  tmdbList.length.toString() + resumeList.length.toString(),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
