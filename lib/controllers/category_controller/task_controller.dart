// ignore_for_file: slash_for_doc_comments

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:myproject1/models/category_model/category_model.dart';
import 'package:myproject1/models/task_models/task_models.dart';
import 'package:myproject1/views/taskpage/task_page.dart';

class TaskController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController taskName = TextEditingController();
  TextEditingController tasktype = TextEditingController();
  TextEditingController taskMembers = TextEditingController();
  TextEditingController updatetaskName = TextEditingController();
  TextEditingController updatetasktype = TextEditingController();
  TextEditingController updatetaskMembers = TextEditingController();
  List<String> names = [
    "belwin",
    "ashok",
    "sandhu",
    "vishal",
  ];

  Rx<DateTime> currentDate = DateTime.now().obs;

  var upadteStartDate = "".obs;
  var upadteendDate = "".obs;
  var memeberList = <String>[].obs;
  var startDate = "".obs;
  var endDate = "".obs;
  var loading = false.obs;

  /// **********************delete method******************** */
  Future<void> deleteTask(String id, {required String taskid}) async {
    await db
        .collection("sections")
        .doc(id)
        .collection("task")
        .doc(taskid)
        .delete()
        .then((value) {
      getTaskMethod(id);
    });
  }

  //***************** update method***************************** */

  Future<void> updateTask(String id,
      {required String taskid, required CategoryModel model}) async {
    loading.value = true;
    TaskModels task = TaskModels();
    task.taskName = updatetaskName.text.trim();
    task.taskType = updatetasktype.text.trim();
    task.members = memeberList;
    // task.members = updatetaskMembers.text.trim();

    task.startDate =
        upadteStartDate.value == '' ? startDate.value : upadteStartDate.value;
    task.endDate =
        upadteendDate.value == "" ? endDate.value : upadteendDate.value;
    await db
        .collection("sections")
        .doc(id)
        .collection("task")
        .doc(taskid)
        .update(task.tojson())
        .then((value) async {
      getTaskMethod(id);
      Get.off(() => TaskPage(data: model));
      loading.value = false;
    });
  }

  /// **********************post method************ */
  Future<void> postTask(
    String id,
    CategoryModel data,
  ) async {
    loading.value = true;
    TaskModels task = TaskModels();

    task.taskName = taskName.text.trim();
    task.taskType = tasktype.text.trim();
    //task.members = taskMembers.text.trim();
    task.members = memeberList;
    task.startDate = startDate.value;
    task.startDate = startDate.value;
    task.endDate = endDate.value;
    await db
        .collection("sections")
        .doc(id)
        .collection("task")
        .add(task.tojson())
        .then((value) {
      getTaskMethod(id);
      cleartask();
      Get.offAll(() => TaskPage(data: data));
      loading.value = false;
    });
  }

  /***************** Get method******************** */

  Stream<List<TaskModels>> getTaskMethod(
    String id,
  ) {
    var data = db
        .collection("sections")
        .doc(id)
        .collection("task")
        .snapshots()
        .map((event) => event.docs.map((e) => TaskModels.fromjson(e)).toList());

    return data;
  }

//////********************** date function **************************************** */
  startdate(BuildContext context) async {
    var selectdate = await showDatePicker(
      context: context,
      initialDate: currentDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectdate != null) {
      currentDate.value = selectdate;
      startDate.value = DateFormat.yMMMd().format(currentDate.value);
    }
  }

  enddate(BuildContext context) async {
    var selectdate = await showDatePicker(
      context: context,
      initialDate: currentDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectdate != null) {
      currentDate.value = selectdate;
      endDate.value = DateFormat.yMMMd().format(currentDate.value);
    }
  }

  //*****************************update Date function********* */
  updatestartdate(BuildContext context) async {
    var selectdate = await showDatePicker(
      context: context,
      initialDate: currentDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectdate != null) {
      currentDate.value = selectdate;
      upadteStartDate.value = DateFormat.yMMMd().format(currentDate.value);
    }
  }

  updateenddate(BuildContext context) async {
    var selectdate = await showDatePicker(
      context: context,
      initialDate: currentDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectdate != null) {
      currentDate.value = selectdate;
      upadteendDate.value = DateFormat.yMMMd().format(currentDate.value);
    }
  }

  ///********************* validator *********************************** */

  String? taskValidator(String? value) {
    final values = value!.trim();
    if (values.isEmpty && values == "") {
      return "all feilds are required";
    }
  }

  //*****************add memeber **************************/
  addMemebrs(int i) {
    memeberList.add(names[i]);
  }

  //********************remove Member*********************** */
  removeMember(int i) {
    memeberList.removeAt(i);
  }

  /************************************ */
  cleartask() {
    taskName.clear();
    tasktype.clear();
    startDate.value = "";
    endDate.value = "";
    memeberList.clear();
  }

  @override
  void onClose() {
    cleartask();
    super.onClose();
  }
}
