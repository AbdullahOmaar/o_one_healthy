import 'package:app/screens/patients/patients_file/view/widgets/medicine.dart';
import 'package:flutter/material.dart';
import '../../../patients/patients_file/view/widgets/Rays.dart';
import '../../../patients/patients_files_search/models/patient_model.dart';

class FileTabs extends StatefulWidget {
  Patient patient ;
   FileTabs({Key? key ,required this.patient}) : super(key: key);

  @override
  _FileTabsState createState() => _FileTabsState();
}

class _FileTabsState extends State<FileTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _selectedColor = const Color(0xff1a73e8);

  final _iconTabs = [
    const Tab(icon: Icon(Icons.medical_services)),
    const Tab(icon: Icon(Icons.ac_unit)),
    const Tab(icon: Icon(Icons.ac_unit)),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TabBar(
            controller: _tabController,
            tabs: _iconTabs,
            unselectedLabelColor: Colors.black,
            labelColor: _selectedColor,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(80.0),
              color: _selectedColor.withOpacity(0.2),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:  [
               const  Medicine(),
                const Center(child: Text('1')),
                RaysScreen(patient: widget.patient,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
