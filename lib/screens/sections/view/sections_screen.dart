import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
import 'package:app/common/logo.dart';
import 'package:app/routes/app_routes.dart';
import 'package:app/screens/base/base_appbar.dart';
import 'package:app/screens/base/base_scaffold.dart';
import 'package:app/util/constant.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/dimens.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SectionsScreen extends StatefulWidget {
  static const routeName = "/SectionsScreen";

  const SectionsScreen({super.key});

  @override
  State<SectionsScreen> createState() => _SectionsScreenState();
}

class _SectionsScreenState extends State<SectionsScreen> {
  SectionsModel sections = SectionsModel.fromJson(sectionsList);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      bottomNavigationBar: const CustomBottomBarWidget(),
      appBar: baseAppBar(context, "sections.sections".tr()),
      body: body(),
    );
  }

  body() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          appLogo(),
          Dimens.vMargin5,
          Expanded(
            child: ListView.builder(
                itemCount: sections.sections?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return sectionsCard(sections.sections![index]);
                }),
          )
        ],
      );

  sectionsCard(Sections sections) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.subscribersScreen);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          tileColor: ThemeColors.primary,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          shape: RoundedRectangleBorder(
            // side: const BorderSide(width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          leading: CircleAvatar(
            backgroundImage: AssetImage(
              Images.docImg,
            ),
          ),
          title: Text(
            '${sections.sectionName}',
          ),
        ),
      ),
    );
  }
}

var sectionsList = {
  "sections": [
    {"sectionImage": "", "sectionName": "sections.doctors".tr()},
    {"sectionImage": "", "sectionName": "sections.hospitals".tr()},
    {"sectionImage": "", "sectionName": "sections.x_rays".tr()},
  ]
};

class SectionsModel {
  List<Sections>? sections;

  SectionsModel({this.sections});

  SectionsModel.fromJson(Map<String, dynamic> json) {
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(Sections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sections {
  String? sectionImage;
  String? sectionName;

  Sections({this.sectionImage, this.sectionName});

  Sections.fromJson(Map<String, dynamic> json) {
    sectionImage = json['sectionImage'];
    sectionName = json['sectionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['sectionImage'] = sectionImage;
    data['sectionName'] = sectionName;
    return data;
  }
}
