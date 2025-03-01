import 'package:dd_shop/dashboard/model/add_employee.dart';
import 'package:dd_shop/dashboard/model/add_new_cluster.dart';
import 'package:dd_shop/dashboard/model/assign_role_model.dart';
import 'package:dd_shop/employee/model/employee_list_model.dart';
import 'package:dd_shop/services/api_services.dart';
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


  assignRoleToEmploy(employCode,employName,employPhone,email,description,roles,joinDate, BuildContext context) async {
    AssignRolesModel assignRolesModel = await apiService.assignRoles(employCode,employName,employPhone,email,description,roles,joinDate);
    if (assignRolesModel.statusCode == 201) {

    } else {
    }
    return assignRolesModel;
  }

  getEmployeeList() async {
    EmployeeListModel employeeListModel = await apiService.getEmployeeList();
    return employeeListModel;
  }

  getShopsList() async {
    EmployeeListModel employeeListModel = await apiService.getEmployeeList();
    return employeeListModel;
  }


}

DashboardController dashboardController = DashboardController();