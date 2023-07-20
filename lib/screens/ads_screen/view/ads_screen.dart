import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
import 'package:app/common/widgets/text_widget.dart';
import 'package:app/screens/base/base_appbar.dart';
import 'package:app/screens/base/base_scaffold.dart';
import 'package:app/util/constant.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/dimens.dart';
import 'package:app/util/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AdsScreen extends StatefulWidget {
  static const routeName = "/AdsScreen";

  const AdsScreen({Key? key}) : super(key: key);

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  TextEditingController searchPatientTextController = TextEditingController();

  List imageURL = [
    'https://img.freepik.com/free-psd/medical-business-social-media-promo-template_23-2149488298.jpg?w=2000',
    'https://img.freepik.com/free-vector/flat-design-medical-facebook-ad_23-2149092570.jpg?w=2000',
    'https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop',
    'https://img.freepik.com/free-psd/healthcare-banner-square-flyer-with-doctor-theme-social-media-post-template_202595-574.jpg?w=2000'
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: body(),
      bottomNavigationBar: CustomBottomBarWidget(),
      appBar: baseAppBar(context, "ads.ads".tr()),
    );
  }

  body() => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Dimens.vMargin2,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60.w,
                  child: TextField(
                    decoration: new InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      suffixIcon:
                          Icon(Icons.clear, color: ThemeColors.iconColor),
                      prefixIcon:
                          Icon(Icons.search, color: ThemeColors.iconColor),
                      labelText: "search".tr(),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: ThemeColors.kPrimary)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: ThemeColors.kPrimary),
                      ),
                    ),
                    onChanged: (String val) {
                      // searchPatients(val);
                    },
                  ),
                ),
                Dimens.hMargin2,
                ElevatedButton(
                    onPressed: () {},
                    child: Image.asset(
                      Images.add,
                      fit: BoxFit.contain,
                      width: 30.0,
                      height: 30.0,
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.bgColor,
                        shape: CircleBorder(),
                        fixedSize: Size(50, 50))),
              ],
            ),
            Dimens.vMargin2,
            UiText(
              text: "ads.ads".tr(),
              style: tsS16W800CkPrimary,
            ),
            Dimens.vMargin2,
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: imageURL.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: Image.network(imageURL[index]),
                );
              },
            )
          ],
        ),
      );
}
