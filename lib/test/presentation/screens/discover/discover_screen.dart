import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarti_mobile/test/presentation/widgets/shared/video_scrollable_view.dart';

import '../../provider/discover_provider.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final discoverProvider = context.watch<DiscoverProvider>();


    return Scaffold(
      body: discoverProvider.initialLoading
          ? const Center(child: CircularProgressIndicator())
          : VideoScrollableView(videos: discoverProvider.videos),
    );
  }
}
