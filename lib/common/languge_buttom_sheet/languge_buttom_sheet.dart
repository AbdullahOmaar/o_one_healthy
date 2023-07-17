import 'package:app/common/custom_button.dart';
import 'package:app/common/widgets/text_widget.dart';
import 'package:app/util/constant.dart';
import 'package:app/util/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

languageBottomSheet(context) {
  showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0.sp),
      ),
      context: context,
      builder: (BuildContext state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            bottomSheetHeader(
              context,
              "change_language".tr(),
            ),
            Expanded(child: ChangeLanguageScreen()),
          ],
        );
      });
}

class ChangeLanguageScreen extends StatefulWidget {
  Function? isLang;
  ChangeLanguageScreen({super.key, this.isLang});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  String? bottomRadioValue = Lang.ar.name;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        bottomRadioValue = context.locale.languageCode;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: Lang.values.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Radio<String>(
                  value: Lang.values[index].name,
                  groupValue: bottomRadioValue,
                  onChanged: (value) {
                    setState(() {
                      bottomRadioValue = value;
                    });
                  },
                ),
                title: UiText(
                  text: Lang.values[index].title,
                  style: tsS14W700CkBlack,
                ),
              );
            },
          ),
        ),
        // const Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
          child: solidButton(
              onPressed: () {
                context.setLocale(Locale(bottomRadioValue ?? Lang.ar.name));
                Navigator.pop(context);
              },
              text: "choose".tr()),
        )
      ],
    );
  }
}

Widget bottomSheetHeader(BuildContext context, String headerText,
    {Function? clearAction}) {
  return Column(children: [
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      Flexible(
        child: Text(
          headerText, // A very long text
          overflow: TextOverflow.ellipsis,
        ),
      ),
      const Opacity(
          opacity: 0.0,
          child: IconButton(
            icon: Icon(Icons.clear),
            onPressed: null,
          )),
    ]),
  ]);
}
