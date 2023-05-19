import 'dart:convert';

import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
import 'package:app/common/custom_button.dart';
import 'package:app/common/widget_utils.dart';
import 'package:app/screens/doctor_dashboard_screen/view/widgets/create_user_form.dart';
import 'package:app/screens/doctor_dashboard_screen/view/widgets/filter_text_btn.dart';
import 'package:app/screens/doctor_dashboard_screen/view/widgets/user_card.dart';
import 'package:app/screens/patients/patients_files_search/view/patients_files_search.dart';
import 'package:app/screens/patients/patients_files_search/view_model/patients_files_search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../common/custom_text_field/custom_text_field.dart';
import '../../../routes/app_routes.dart';
import '../../../routes/route_generator.dart';
import '../../patients/patients_files_search/models/patient_model.dart';
import '../models/user_data_model.dart';
import '../view_model/dashboard_view_model.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const routeName = "/DoctorDashboardScreen";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends ConsumerState<DashboardScreen> {
  TextEditingController searchUserTextController = TextEditingController();
  TextEditingController searchPatientTextController = TextEditingController();
  FocusNode focusNode = FocusNode();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  List<User>? allUsers;
  List<Patient>? allPatients;
  User? user;
  bool isAdminToggled=false;
  bool isPharmacyToggled=false;

  @override
  void initState() {
    getCurrentUserData();
    fetchPatientsAndUsersData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    allPatients =ref.watch(patientFSViewModelProvider).patients;
    allUsers =ref.watch(dashboardViewModelProvider).users??[];

    fetchPatientsAndUsersData();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant DashboardScreen oldWidget) {
    getCurrentUserData();
    fetchPatientsAndUsersData();
    // FocusScope.of(context).requestFocus(FocusNode());

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    if(searchUserTextController.text.isEmpty && (!isAdminToggled&&!isPharmacyToggled)) {
      allUsers =ref.watch(dashboardViewModelProvider).users;
    }

    return Scaffold(
      bottomNavigationBar: const CustomBottomBarWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.all(16),
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  Image.asset('assets/images/logo/logo.jpeg')
                                      .image),
                          Text(
                            user?.name ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () async {},
                              icon: const Icon(
                                Icons.settings,
                                size: 40,
                                color: Colors.grey,
                              )),
                          IconButton(
                              onPressed: () async {
                                await storage.delete(key: 'userSession');
                                await storage.delete(key: 'currentUser');
                                Navigator.of(context).pushAndRemoveUntil(
                                  RouteGenerator.generateRoute(
                                      const RouteSettings(
                                          name: AppRoutes.home)),
                                  (route) => false,
                                );
                              },
                              icon: const Icon(
                                Icons.exit_to_app_rounded,
                                size: 40,
                                color: Colors.grey,
                              )),
                        ],
                      )
                    ],
                  )),
              CustomButton(
                btnWidth: CustomWidth.twoThird,
                fontSize: 18,
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(45))),
                      constraints: BoxConstraints(
                          minHeight: 200,
                          maxHeight: MediaQuery.of(context).size.height,
                          minWidth: 100,
                          maxWidth: 1100),

                      context: context,
                      builder: (context) => const CreateUserForm());
                },
                text: 'Create patient file',
              ),
              Container(
                padding: const EdgeInsets.all(4),
                margin:const  EdgeInsets.fromLTRB(8, 8, 8, 8),
                height: MediaQuery.of(context).size.height * 0.40,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: searchUserTextController,
                        inputType: TextInputType.text,
                        labelText: 'Search users',
                        isPassword: false,
                        fieldBorder: FieldBorder.outline,
                        onChanged: searchUser,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.045,
                      child: ToggleButtons(

                        fillColor: Colors.indigo,
                        selectedColor: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        isSelected: [isAdminToggled,isPharmacyToggled],
                        onPressed: (i){
                          switch(i){
                            case 0:
                              isAdminToggled=!isAdminToggled;
                              break;
                            case 1:
                              isPharmacyToggled=!isPharmacyToggled;
                              break ;
                          }
                          toggleFilter();
                        },
                        children: [
                          FilterTextShape(text: 'is admin'),
                          FilterTextShape(text: 'is Pharmacy'),
                        ],),
                    ),

                    Expanded(
                      child: ListView.builder(
                        itemCount: allUsers!.length,
                        itemBuilder: (ctx, index) {
                          final User user =allUsers![index];
                          return UserCard(user: user);
                        },
                      ),
                    )
                  ],
                )
                /*SearchableList<User>(
                  focusNode: focusNode,
                  keyboardAction: TextInputAction.none,
                  searchMode: SearchMode.onEdit,
                  autoCompleteHints: const [],
                  searchTextController: searchTextController,
                  initialList: ref.watch(dashboardViewModelProvider).users,
                  builder: (User user) => UserCard(user: user),
                  filter: (value) => ref
                      .watch(dashboardViewModelProvider)
                      .users
                      .where(
                        (element) => element.name
                            .toLowerCase()
                            .contains(searchTextController.text),
                      )
                      .toList(),
                  emptyWidget: const SizedBox(
                    child: Text('No matched users'),
                  ),
                  inputDecoration: InputDecoration(
                    labelText: "Search User",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                )*/
                ,
              ),
              getVerticalSpacerLine(MediaQuery.of(context).size.width,
                  CustomWidth.matchParent, Colors.black26, 20),
              Container(
                padding: const EdgeInsets.all(4),
                margin:const  EdgeInsets.fromLTRB(8, 8, 8, 8),
                height: MediaQuery.of(context).size.height * 0.40,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: searchPatientTextController,
                        inputType: TextInputType.text,
                        labelText: 'Search patients',
                        isPassword: false,
                        fieldBorder: FieldBorder.outline,
                        onChanged: (String val){
                          searchPatients(val);
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: allPatients!.length,
                        itemBuilder: (ctx, index) {
                          final Patient patient =allPatients![index];
                          return PatientCard(patient: patient);
                        },
                      ),
                    )
                  ],
                ),
              ),
              getVerticalSpacerLine(MediaQuery.of(context).size.width,
                  CustomWidth.matchParent, Colors.black26, 20),
            ],
          ),
        ),
      ),
    );
  }

  fetchPatientsAndUsersData() async {
    await ref.read(dashboardViewModelProvider.notifier).getUsersList();
    await ref.read(patientFSViewModelProvider.notifier).getPatientList();
  }
  void searchUser(String query){
    if(query.isNotEmpty) {
      final suggestions =
          ref.watch(dashboardViewModelProvider).users.where((User user) {
        final userName = user.name.toLowerCase();
        final userID = user.uid.toLowerCase();
        final input = query.toLowerCase();
        return userName.contains(input)||userID.contains(input);
      }).toList();
      setState(() {
        allUsers = suggestions;
      });
    }else{
      setState(() {
        allUsers =ref.watch(dashboardViewModelProvider).users;
      });
    }
  }
  void searchPatients(String query){
    if(query.isNotEmpty) {
      final suggestions =
          ref.watch(patientFSViewModelProvider).patients.where((Patient patient) {
        final patientNameEN = patient.nameEN.toLowerCase();
        final patientNameAR = patient.nameAR.toLowerCase();
        final patientUID = patient.uid.toLowerCase();
        final input = query.toLowerCase();
        return patientNameEN.contains(input)||patientNameAR.contains(input)||patientUID.contains(input);
      }).toList();
      setState(() {
        allPatients = suggestions;
      });
    }else{
      setState(() {
        allPatients =ref.watch(patientFSViewModelProvider).patients;
      });
    }
  }
  toggleFilter(){
    // if(query.isNotEmpty) {
    if(isAdminToggled ||isPharmacyToggled) {
      final suggestions =
          ref.watch(dashboardViewModelProvider).users.where((User user) {
        final isAdmin = user.privileges.isAdmin;
        final isPharmacy = user.privileges.isPharmacy;
        // final input = query.toLowerCase();
        return (isAdminToggled && isAdmin) || (isPharmacyToggled && isPharmacy);
      }).toList();
      setState(() {
        allUsers = suggestions;
      });
    }else{
      setState(() {
        allUsers =ref.watch(dashboardViewModelProvider).users;
      });
    }
  }
  getCurrentUserData() async {
    String? data = await storage.read(
      key: 'currentUser',
    );
    user = User.fromJson(json.decode(data ?? ''));
  }
}
