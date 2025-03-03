import 'package:dd_shop/employee/employee_list.dart';
import 'package:dd_shop/hr/create_new_role.dart';
import 'package:dd_shop/hr/roles.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class HrDashboard extends StatefulWidget {
  const HrDashboard({super.key});

  @override
  State<HrDashboard> createState() => _HrDashboardState();
}

class _HrDashboardState extends State<HrDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: Drawer(
        elevation: 10,
        backgroundColor: AppColors.appPrimaryColor,
        child: ListView(
          padding: EdgeInsets.only(top: 50),
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HrDashboard()));
                },
                child: Text(
                  "Employees",
                  style: TextStyle(color: AppColors.white),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Divider(),
            ),
            TextButton(
                onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateNewRole(comingFrom: COMINGFROM.CreateRole,)));
                },
                child: Text("Create New Role",
                    style: TextStyle(color: AppColors.white))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Divider(),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>RolesList()));
                },
                child: Text("Roles", style: TextStyle(color: AppColors.white))),
          ],
        ),
      ),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.appPrimaryColor,
        title: const Text('HR Dashboard'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.white,
          tabs: const [
            Tab(
              text: 'Employee',
            ),
            Tab(text: 'Cluster'),
          ],
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          EmployeeList(),
          ClusterTab(),
        ],
      ),
    );
  }
}

class ClusterTab extends StatelessWidget {
  const ClusterTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Cluster Data',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
