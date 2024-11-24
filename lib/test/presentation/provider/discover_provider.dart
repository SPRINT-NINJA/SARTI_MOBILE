import 'package:flutter/widgets.dart';
import 'package:sarti_mobile/test/domain/entities/video_post.dart';
import 'package:sarti_mobile/test/infrastructure/models/local_video_model.dart';
import 'package:sarti_mobile/test/shared/data/local_video_post.dart';

class DiscoverProvider extends ChangeNotifier{

  //TODO: Repository , datasource

  bool initialLoading = true;
  List<VideoPost> videos = [];

  Future<void> loadNextPage() async {

    await Future.delayed(const Duration(seconds: 5));

    final List<VideoPost> newVideos = videoPosts.map(
      (video) => LocalVideoModel.fromJsonMap(video).toVideoPostEntity()
    ).toList();

    videos.addAll(newVideos);
    initialLoading = false;
    notifyListeners();
  }

}