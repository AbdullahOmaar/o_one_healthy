import 'package:flutter/material.dart';

class FileTabs extends StatefulWidget {
  const FileTabs({Key? key}) : super(key: key);

  @override
  _FileTabsState createState() => _FileTabsState();
}

class _FileTabsState extends State<FileTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _selectedColor = const Color(0xff1a73e8);

  final _iconTabs = [
    const Tab(icon: Icon(Icons.home)),
    const Tab(icon: Icon(Icons.search)),
    const Tab(icon: Icon(Icons.settings)),
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
      body: Container(
        child: Column(
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
                children: [
                  Container(child: Center(child: Text('people'))),
                  Container(child: Center(child: Text('people'))),
                  Text('Person')
                ],
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TabBar(
// controller: _tabController,
// tabs: _iconTabs,
// unselectedLabelColor: Colors.black,
// labelColor: _selectedColor,
// indicator: BoxDecoration(
// borderRadius: BorderRadius.circular(80.0),
// color: _selectedColor.withOpacity(0.2),
// ),
// ),
