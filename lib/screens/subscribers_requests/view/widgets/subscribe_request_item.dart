import 'package:app/common/custom_button.dart';
import 'package:app/screens/subscribers_screen/models/subscribe_request.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../doctor_dashboard_screen/view_model/dashboard_view_model.dart';

class SubscribeRequestItem extends ConsumerStatefulWidget {
  final SubscribeRequest requests;

  const SubscribeRequestItem({Key? key, required this.requests})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SubscribeRequestItemState();
}

class _SubscribeRequestItemState extends ConsumerState<SubscribeRequestItem> {
  // final Patient requests;
  Size? screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize!.height * .15,
      child: ListTile(
        leading: Icon(
          Icons.request_page_outlined,
          size: screenSize!.height * .13,
        ),
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.indigo,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: AutoSizeText(widget.requests.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: AutoSizeText(widget.requests.phoneNumber,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 15)),
            ),
            CustomButton(
              fontSize: 15,
              onPressed: () async {
                await ref
                    .read(dashboardViewModelProvider.notifier)
                    .deleteRequest(widget.requests);
              },
              btnWidth: CustomWidth.twoThird,
              text: "cancel",
            )
          ],
        ),
      ),
    );
  }
}
