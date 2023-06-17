import 'dart:convert';
import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
import 'package:app/screens/doctor_dashboard_screen/view_model/dashboard_view_model.dart';
import 'package:app/screens/subscribers_requests/view/widgets/subscribe_request_item.dart';
import 'package:app/screens/subscribers_screen/view/widgets/subscribe_form.dart';
import 'package:app/screens/subscribers_screen/view/widgets/subscriber_card.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../common/custom_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../doctor_dashboard_screen/models/user_data_model.dart';
import '../../subscribers_screen/models/subscribe_request.dart';

class SubscriberRequests extends ConsumerStatefulWidget {
  const SubscriberRequests({super.key});

  static const routeName = "/subscribersRequest";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SubscriberRequestsState();
}

class _SubscriberRequestsState extends ConsumerState<SubscriberRequests> {
  // TextEditingController searchUserTextController = TextEditingController();
  List<SubscribeRequest>? allRequests;
  User? user;
  FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void initState() {
    fetchAllRequests();

    // fetchUsersData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    fetchAllRequests();
    allRequests= getRequests();
    super.didChangeDependencies();
  }


  @override
  void didUpdateWidget(covariant SubscriberRequests oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    allRequests= getRequests()??[];

    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      bottomNavigationBar: const CustomBottomBarWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                height: MediaQuery.of(context).size.height * 0.70,
                child: Column(
                  children: [
                    allRequests!.isNotEmpty?  Expanded(
                      child: ListView.separated(
                        separatorBuilder: (_,context)=>const SizedBox(height: 16,),
                        itemCount: allRequests!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (ctx, index) {
                          final SubscribeRequest request = allRequests![index];
                          return SubscribeRequestItem(requests: request);
                        },
                      ),
                    ):const Center(child: AutoSizeText('No requests for now !',style: TextStyle(fontSize: 25),),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  List<SubscribeRequest>? getRequests() {
    fetchAllRequests();
    return ref
        .watch(dashboardViewModelProvider)
        .requests;
  }

  fetchAllRequests() async {
    await ref.read(dashboardViewModelProvider.notifier).getAllRequests();
  }
}
