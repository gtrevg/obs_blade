import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../shared/general/social_block.dart';

class SupportDialog extends StatelessWidget {
  const SupportDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('support'),
      direction: DismissDirection.vertical,
      onDismissed: (_) => Navigator.of(context).pop(),
      dismissThresholds: const {DismissDirection.vertical: 0.2},
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CupertinoAlertDialog(
              content: SizedBox(
                height: 184.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (!Platform.isAndroid) const SizedBox(height: 12.0),
                    Text(
                      'Support',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    if (Platform.isAndroid) ...[
                      const Text(
                        'Due to Google Play Payment policies I\'m not allowed to leave donation options here. There are ways to support me available online.',
                      ),
                      const Text(
                        'If you really want to, you will find them - you can also contact me directly!',
                      ),
                    ],
                    if (!Platform.isAndroid) ...[
                      const Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Text(
                          'You sure? Tapped accidentaly? Or just curious? I mean, I always appreciate the love! Motivates me to keep this app updated - but it\'s completly optional :)',
                        ),
                      ),
                      SocialBlock(
                        socialInfos: [
                          SocialEntry(
                            link: 'https://obs-blade.kounex.com/',
                            linkText: 'Read more here!',
                          ),
                        ],
                      ),
                    ],
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     DonateButton(text: 'Nice', value: 0.99),
                    //     DonateButton(text: 'Yoo', value: 2.99),
                    //     DonateButton(text: 'WTF?', value: 5.99),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            Transform(
              transform: Matrix4.identity()..translate(0.0, -110.0),
              child: Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                  // color: CupertinoDynamicColor.resolve(kDialogColor, context)
                  //     .withOpacity(1.0),
                  color: Theme.of(context).toggleableActiveColor,
                  shape: BoxShape.circle,
                ),
                child: const Hero(
                  tag: 'Support Me',
                  child: Icon(
                    CupertinoIcons.heart_solid,
                    size: 38.0,
                  ),
                ),
              ),
            ),
            Transform(
              transform: Matrix4.identity()..translate(105.0, -80.0),
              child: IconButton(
                icon: const Icon(
                  CupertinoIcons.clear_circled_solid,
                  size: 24.0,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            // Transform(
            //   transform: Matrix4.identity()..translate(110.0, 110.0),
            //   child: CupertinoButton(
            //     child: Text('...'),
            //     onPressed: () => Navigator.of(context).pop(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
