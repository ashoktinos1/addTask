import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:myproject1/controllers/category_controller/task_controller.dart';
import 'package:myproject1/models/category_model/category_model.dart';
import 'package:myproject1/models/task_models/task_models.dart';
import 'package:myproject1/views/home_page/home_page.dart';
import 'package:myproject1/views/task_add_page/task_add_page.dart';
import 'package:myproject1/views/update_task/update_task.dart';

class TaskPage extends StatelessWidget {
  CategoryModel data;
  TaskPage({Key? key, required this.data}) : super(key: key);
  final controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => const HomePage());
        controller.cleartask();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.offAll(() => const HomePage());
              controller.cleartask();
            },
          ),
          title: Text(data.name!),
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child:
                // Obx(() {
                //   return
                StreamBuilder<List<TaskModels>>(
                    stream: controller.getTaskMethod(data.id!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) {
                              final datas = snapshot.data![i];
                              return taskCard(
                                  update: () {
                                 
                                    controller.updatetaskName.text =
                                        datas.taskName!;
                                    controller.memeberList.value =
                                        datas.members!;
                                    controller.updatetasktype.text =
                                        datas.taskType!;
                                    controller.upadteStartDate.value =
                                        datas.startDate!;
                                    controller.upadteendDate.value =
                                        datas.endDate!;
                                    Get.to(() => UpdateTaskPage(
                                        categoryModel: data, id: datas.id!));
                                  },
                                  name: datas.taskName!,
                                  cat: datas.taskType!,
                                  // members: datas.members!,
                                  startdate: datas.startDate!,
                                  enddate: datas.endDate!,
                                  action: () {
                                    controller.deleteTask(data.id!,
                                        taskid: datas.id!);
                                  },
                                  data: datas
                                  // count: datas.members!.length,
                                  //   members: datas.members![i],
                                  // member1: datas.members![0],
                                  // member2: datas.members![1] ?? "",
                                  // member3: datas.members![2] ?? "",
                                  );
                            });
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return const Center(
                        child: Text("No Task"),
                      );
                    })
            // }),
            ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
           
            Get.to(() => TaskAddPage(categoryModel: data));
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget taskCard({
    required TaskModels data,
    required String name,
    required void Function() action,
    required String cat,
    //required String members,
    // required String member2,
    // required String member3,
    //required int count,
    required String startdate,
    required String enddate,
    required void Function() update,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Colors.blue.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      cat,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: update,
                    icon: const Icon(
                      Icons.edit,
                      size: 25,
                    ))
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(),
            ),
            Container(
              height: 50,
              //color: Colors.green,
              child: ListView.builder(
                  itemCount: data.members!.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    return Row(
                      children: [
                        const Icon(
                          Icons.person_pin,
                          size: 20,
                        ),
                        Text(data.members![i]),
                      ],
                    );
                  }),
            ),
            // Row(
            //   children: [
            //     const Icon(
            //       Icons.person_pin,
            //       size: 20,
            //     ),
            //     Text(" $member1"),
            //   ],
            // ),
            // Row(
            //   children: [
            //     const Icon(
            //       Icons.person_pin,
            //       size: 20,
            //     ),
            //     Text(" $member2"),
            //   ],
            // ),
            // Row(
            //   children: [
            //     const Icon(
            //       Icons.person_pin,
            //       size: 20,
            //     ),
            //     Text(" $member1"),
            //   ],
            // ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.date_range),
                    Text(" $startdate - $enddate"),
                  ],
                ),
                InkWell(
                  onTap: action,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 25,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
