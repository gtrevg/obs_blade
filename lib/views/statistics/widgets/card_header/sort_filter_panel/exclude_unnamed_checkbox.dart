import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:obs_blade/stores/views/statistics.dart';

class ExcludeUnnamedCheckbox extends StatelessWidget {
  const ExcludeUnnamedCheckbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StatisticsStore statisticsStore = GetIt.instance<StatisticsStore>();

    return Transform.translate(
      offset: const Offset(-12.0, 0.0),
      child: Row(
        children: [
          Observer(
            builder: (_) => Checkbox(
              // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: statisticsStore.excludeUnnamedStreams,
              tristate: true,
              onChanged: (excludeUnnamedStreams) => statisticsStore
                  .setExcludeUnnamedStreams(excludeUnnamedStreams),
            ),
          ),
          Text(
            'Exclude unnamed streams',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }
}
