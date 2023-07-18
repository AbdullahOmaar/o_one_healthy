import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
import 'package:app/common/custom_button.dart';
import 'package:app/common/custom_text_field/custom_text_field.dart';
import 'package:app/screens/base/base_appbar.dart';
import 'package:app/screens/base/base_scaffold.dart';
import 'package:app/util/constant.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/dimens.dart';
import 'package:app/util/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../doctor_dashboard_screen/models/user_data_model.dart';

class PatientsFiles extends ConsumerStatefulWidget {
  static const routeName = "/FilesScreen";

  const PatientsFiles({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PatientsFilesState();
}

class _PatientsFilesState extends ConsumerState<PatientsFiles> {
  String title = "";
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        bottomNavigationBar: const CustomBottomBarWidget(),
        appBar: baseAppBar(context, title, profileImage: Images.profile),
        body: body());
  }

  body() => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "welcome".tr(),
              style: tsS16W800CkPrimary,
            ),
            Dimens.vMargin2,
            Text(
              "have_nice_day".tr(),
              style: tsS14W700CkBlack,
            ),
            Dimens.vMargin2,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    // width: 40.w,
                    height: 7.h,
                    child: TextField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        alignLabelWithHint: false,
                        suffixIcon:Icon(Icons.close) ,
                        prefixIcon: Icon(Icons.search),
                          hintText: "pfiles.search".tr(),
                          hintStyle: tsS12W500CkBlack,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.kPrimary,
                                width: 1.5,
                                style: BorderStyle.solid,),borderRadius: BorderRadius.circular(18.0)
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: ElevatedButton(onPressed: (){}, 
                  child: Image.asset(Images.add,fit:BoxFit.contain,width: 40.0, height: 40.0,),
                  style:ElevatedButton.styleFrom(backgroundColor: ThemeColors.kLightBlue,shape: CircleBorder(),fixedSize: Size(55, 55))),
                )
                // Expanded(
                //   child: CustomTextField(
                //     controller: searchController,
                //     inputType: TextInputType.text,
                //     labelText: "",
                //     prefix: Icons.search,
                //     suffix: Icons.close,
                //     fieldBorder: FieldBorder.outline,
                //     customWidth: CustomWidth.twoThird,
                //   ),
                // ),
              ],
            )
          ],
        ),
      );
}
