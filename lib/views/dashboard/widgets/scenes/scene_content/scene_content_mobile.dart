import 'package:flutter/material.dart';

import '../../../../../models/enums/scene_item_type.dart';
import 'audio_inputs/audio_inputs.dart';
import 'scene_items/scene_items.dart';
import 'visibility_edit_toggle.dart';

class SceneContentMobile extends StatelessWidget {
  const SceneContentMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: Theme.of(context).cupertinoOverrideTheme!.barBackgroundColor,
            child: const TabBar(
              tabs: [
                Tab(
                  child: Text('Scene Items'),
                ),
                Tab(
                  child: Text('Audio'),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 300,
            child:
                TabBarView(physics: NeverScrollableScrollPhysics(), children: [
              VisibilityEditToggle(
                sceneItemType: SceneItemType.Source,
                child: SceneItems(),
              ),
              VisibilityEditToggle(
                sceneItemType: SceneItemType.Audio,
                child: AudioInputs(),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
