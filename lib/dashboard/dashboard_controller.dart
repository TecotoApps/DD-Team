import 'package:dd_shop/dashboard/model/add_employee.dart';
import 'package:dd_shop/dashboard/model/add_new_cluster.dart';
import 'package:dd_shop/dashboard/model/assign_role_model.dart';
import 'package:dd_shop/dashboard/model/order_list_model.dart';
import 'package:dd_shop/employee/model/employee_list_model.dart';
import 'package:dd_shop/hr/model/role_list_model.dart';
import 'package:dd_shop/services/api_services.dart';
import 'package:dd_shop/services/sharedPress.dart';
import 'package:flutter/material.dart';

class DashboardController{

  addNewCluster(clusterName, description, BuildContext context) async {
    AddClusterModel addClusterModel = await apiService.addCluster(clusterName, description);
    if (addClusterModel.statusCode == 201) {
    } else {
    }
    return addClusterModel;
  }

  addShopToCluster(clusterName, description, BuildContext context) async {
    AddClusterModel addClusterModel = await apiService.addCluster(clusterName, description);
    if (addClusterModel.statusCode == 201) {

    } else {
    }
    return addClusterModel;
  }

  addEmployeeByHR(employName,employPhone,email,description,joinDate, BuildContext context) async {
    AddEmployeeModel addEmployeeModel = await apiService.addEmployeeByHR(employName,employPhone,email,description,joinDate);
    if (addEmployeeModel.statusCode == 201) {

    } else {
    }
    return addEmployeeModel;
  }

  updateEmployDataByHR(employCode,employName,employPhone,email,description,roles,joinDate, BuildContext context) async {
    AddEmployeeModel addEmployeeModel = await apiService.updateEmployeeDataByHR(employCode,employName,employPhone,email,description,roles,joinDate);
    if (addEmployeeModel.statusCode == 201) {

    } else {
    }
    return addEmployeeModel;
  }



  Future<EmployeeListModel> getEmployeeList() async {
    EmployeeListModel employeeListModel = await apiService.getEmployeeList();
    return employeeListModel;
  }

  Future<RoleListModel> getAllRolesList(context) async{
    RoleListModel roleListModel = await apiService.getRolesList();
    print("this is roles res $roleListModel");
    return roleListModel;
  }

  Future getOrdersList(shopId,context) async{
    var shopOrderModel = await apiService.getShopOrder(shopId);
    print("this is roles res $shopOrderModel");
    return shopOrderModel;
  }

  Future getDeliveryOrders(context) async{
    String empCode = await sharedPress.getData('EMPCODE');
    var shopOrderModel = await apiService.deliveryOders(empCode);
    print("this is delivery res $shopOrderModel");
    return shopOrderModel;
  }

  getShopsList() async {
    EmployeeListModel employeeListModel = await apiService.getEmployeeList();
    return employeeListModel;
  }


}

DashboardController dashboardController = DashboardController();