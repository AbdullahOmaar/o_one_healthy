import 'dart:convert';

import 'package:app/screens/base/base_scaffold.dart';
import 'package:app/screens/user_details/model/user_details_model.dart';
import 'package:app/screens/user_details/view_model/user_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDetailsScreen extends ConsumerStatefulWidget {
  static const routeName = "/UserDetailsScreen";

  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserDetailsScreenState();
}

class _UserDetailsScreenState extends ConsumerState<UserDetailsScreen> {
  UserDataModel user = userData;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  Widget build(BuildContext context) {
    print(jsonEncode(user));
    return BaseScaffold(
      body: body(),
    );
  }

  body() => Center(
        child: const SingleChildScrollView(
          child: Column(
            children: [Text("UserDetailsScreen")],
          ),
        ),
      );
}
