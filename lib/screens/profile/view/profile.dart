import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
import 'package:app/common/custom_button.dart';
import 'package:app/screens/base/base_scaffold.dart';
import 'package:app/util/theme/colors.dart';
import 'package:app/util/theme/dimens.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = "/ProfileScreen";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      bottomNavigationBar: const CustomBottomBarWidget(),
      appBar: AppBar(
        title: Text("profile.profilsse".tr()),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                            image: AssetImage(
                                "assets/images/usersdetails/doctor.png"))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: ThemeColors.kPrimary),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text("Mohamed Ali", style: Theme.of(context).textTheme.headline4),
              Text("doctor", style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                height: 40,
                child: solidButton(
                    onPressed: () {}, text: "profile.edite_profile".tr()),
              ),
              Dimens.vMargin2,
              Divider(
                height: 5.h,
                color: ThemeColors.kPrimary,
              ),

              /// -- MENU
              ProfileMenuWidget(
                  title: "profile.change_language".tr(),
                  icon: Icons.language,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "profile.change_password".tr(),
                  icon: Icons.lock,
                  onPress: () {}),
              const Divider(),
              Dimens.vMargin2,
              ProfileMenuWidget(
                  title: "profile.logout".tr(),
                  icon: Icons.logout,
                  onPress: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    // var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    // var iconColor = isDark ? Brightness.dark : Brightness.dark;

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          // color: iconColor.withOpacity(0.1),
        ),
        child: Icon(icon,
            color: icon == Icons.logout ? Colors.red : ThemeColors.primary),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyText1?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                // color: Colors.black.withOpacity(0.1),
              ),
              child: Icon(Icons.arrow_forward_ios,
                  size: 18.0, color: ThemeColors.kmob))
          : null,
    );
  }
}
