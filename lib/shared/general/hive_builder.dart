import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:obs_blade/types/enums/hive_keys.dart';
import 'package:obs_blade/types/enums/settings_keys.dart';

class HiveBuilder<T> extends StatelessWidget {
  final HiveKeys hiveKey;
  final List<SettingsKeys>? rebuildKeys;
  final Widget Function(BuildContext context, Box<T> box, Widget? child)
      builder;

  const HiveBuilder({
    Key? key,
    required this.hiveKey,
    required this.builder,
    this.rebuildKeys,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<T>(this.hiveKey.name).listenable(
        keys: this.rebuildKeys?.map((key) => key.name).toList(),
      ),
      builder: this.builder,
    );
  }
}
