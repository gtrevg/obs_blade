import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../../../shared/general/keyboard_number_header.dart';
import '../../../../../stores/shared/network.dart';
import '../../../../../stores/views/dashboard.dart';
import '../../../../../types/enums/request_type.dart';
import '../../../../../utils/network_helper.dart';

class Transition extends StatelessWidget {
  const Transition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashboardStore dashboardStore = GetIt.instance<DashboardStore>();
    FocusNode focusNode = FocusNode();

    return Observer(builder: (_) {
      TextEditingController controller = TextEditingController(
          text: dashboardStore.sceneTransitionDurationMS?.toString() ?? '-');

      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// TODO: Check if there is a better solution to constrain the max
          /// width of the Text widget in the DropdownButton. Currently need to
          /// hard code maxWidth from LayoutBuilder - 24
          Flexible(
            child: LayoutBuilder(
              builder: (context, constraints) => DropdownButton<String>(
                value: dashboardStore.currentTransitionName,
                disabledHint: const Text('Empty...'),
                isDense: true,
                items: dashboardStore.availableTransitionsNames
                    ?.map(
                      (transition) => DropdownMenuItem<String>(
                        value: transition,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth: constraints.maxWidth - 24),
                          child: Text(
                            transition,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (selectedTransition) => NetworkHelper.makeRequest(
                  GetIt.instance<NetworkStore>().activeSession!.socket,
                  RequestType.SetCurrentTransition,
                  {'transition-name': selectedTransition},
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 12.0,
          ),
          SizedBox(
            width: 72.0,
            child: KeyboardNumberHeader(
              focusNode: focusNode,
              onDone: () {
                if (controller.text.isEmpty) {
                  controller.text = '0';
                  controller.selection =
                      TextSelection.fromPosition(const TextPosition(offset: 1));
                }
                NetworkHelper.makeRequest(
                  GetIt.instance<NetworkStore>().activeSession!.socket,
                  RequestType.SetTransitionDuration,
                  {'duration': int.tryParse(controller.text) ?? 0},
                );
              },
              child: CupertinoTextField(
                focusNode: focusNode,
                enabled: dashboardStore.sceneTransitionDurationMS != null,
                controller: controller,
                textAlign: TextAlign.center,
                maxLength: 5,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
              ),
            ),
          ),
        ],
      );
    });
  }
}
