import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:myproject1/controllers/category_controller/task_controller.dart';
import 'package:myproject1/models/category_model/category_model.dart';
import 'package:myproject1/views/task_add_page/textformwidget.dart';
import 'package:myproject1/views/taskpage/task_page.dart';

class UpdateTaskPage extends StatefulWidget {
  UpdateTaskPage({Key? key, required this.categoryModel, required this.id})
      : super(key: key);
  final CategoryModel categoryModel;
  String id;
  @override
  _UpdateTaskPageState createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  final controller = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAll(() => TaskPage(data: widget.categoryModel));
          },
        ),
        title: Text("update ${widget.categoryModel.name} Task"),
      ),
      body: Obx(
        () {
          return controller.loading.value
              ? Center(child: CircularProgressIndicator())
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormWidget(
                            name: "Task Name",
                            controller: controller.updatetaskName,
                            validator: controller.taskValidator,
                          ),
                          TextFormWidget(
                            name: "Category",
                            controller: controller.updatetasktype,
                            validator: controller.taskValidator,
                          ),
                          Container(
                            // color: Colors.amber,
                            height: 80,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: controller.memeberList.length,
                              itemBuilder: (context, i) {
                                return memebrAvatatr(controller.memeberList[i],
                                    action: () => controller.removeMember(i));
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Get.bottomSheet(
                                BottomSheet(
                                    onClosing: () {},
                                    builder: (context) {
                                      return ListView.builder(
                                          itemCount: controller.names.length,
                                          itemBuilder: (context, i) {
                                            return listMembers(
                                                controller.names[i],
                                                action: () {
                                              controller.addMemebrs(i);
                                            });
                                          });
                                    }),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text("Add Members"),
                            ),
                          ),
                          // TextFormWidget(
                          //   name: "Team Members",
                          //   controller: controller.updatetaskMembers,
                          //   validator: controller.taskValidator,
                          // ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    controller.updatestartdate(context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Start Date",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          controller.upadteStartDate.value,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    controller.updateenddate(context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        const Text(
                                          "End Date",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          controller.upadteendDate.value,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 80),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.amber,
                            ),
                            child: Center(
                              child: TextButton(
                                  onPressed: () {
                                    if (key.currentState!.validate()) {
                                      controller.updateTask(
                                          widget.categoryModel.id!,
                                          taskid: widget.id,
                                          model: widget.categoryModel);
                                    } else {
                                      Get.snackbar(
                                          "select", "all feild are required");
                                    }
                                  },
                                  child: const Text("update Task")),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }

  Widget memebrAvatatr(String name, {required void Function() action}) {
    return InkWell(
      onTap: action,
      child: Container(
        margin: EdgeInsets.only(left: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              child: Stack(children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    name.substring(
                      0,
                      1,
                    ),
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                )
              ]),
            ),
            Text(name)
          ],
        ),
      ),
    );
  }

  Widget listMembers(String name, {required void Function() action}) {
    return InkWell(
      onTap: action,
      child: ListTile(
        leading: CircleAvatar(
          child: Text(name.substring(0, 1)),
        ),
        title: Text(name),
      ),
    );
  }
}
