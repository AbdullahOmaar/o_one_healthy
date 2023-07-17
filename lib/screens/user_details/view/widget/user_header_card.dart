import 'package:app/common/widgets/text_widget.dart';
import 'package:app/screens/user_details/model/user_details_model.dart';
import 'package:app/util/constant.dart';
import 'package:app/util/theme/dimens.dart';
import 'package:app/util/theme/styles.dart';
import 'package:flutter/material.dart';

class UserHeaderCard extends StatefulWidget {
  final UserDataModel userData;
  const UserHeaderCard({super.key, required this.userData});

  @override
  State<UserHeaderCard> createState() => _UserHeaderCardState();
}

class _UserHeaderCardState extends State<UserHeaderCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(Images.docImg),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiText(
                text: widget.userData.name,
                style: tsS14W700CkBlack,
              ),
              UiText(
                text: widget.userData.specialty,
                style: tsS14W700CkBlack,
              ),
              Dimens.vMargin2,
              Row(
                children: [
                  Image.asset(Images.mob),
                  Dimens.hMargin1,
                  UiText(
                    text: widget.userData.phone,
                    style: tsS12W600CKmob,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
