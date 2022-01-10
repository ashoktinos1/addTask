import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject1/controllers/category_controller/task_controller.dart';
import 'package:myproject1/models/category_model/category_model.dart';
import 'package:myproject1/views/task_add_page/textformwidget.dart';
import 'package:myproject1/views/taskpage/task_page.dart';

class TaskAddPage extends StatefulWidget {
  TaskAddPage({Key? key, required this.categoryModel}) : super(key: key);
  final CategoryModel categoryModel;

  @override
  State<TaskAddPage> createState() => _TaskAddPageState();
}

class _TaskAddPageState extends State<TaskAddPage> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  final controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            controller.cleartask();
            Get.offAll(
              () => TaskPage(data: widget.categoryModel),
            );
          },
        ),
        title: Text("Add ${widget.categoryModel.name} Task"),
      ),
      body: Obx(
        () {
          return controller.loading.value
              ? Center(child: CircularProgressIndicator())
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 20),
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
                            controller: controller.taskName,
                            validator: controller.taskValidator,
                          ),
                          TextFormWidget(
                            name: "Category",
                            controller: controller.tasktype,
                            validator: controller.taskValidator,
                          ),
                          controller.memeberList.isEmpty
                              ? const SizedBox(
                                  height: 5,
                                )
                              : SizedBox(
                                  // color: Colors.amber,
                                  height: 80,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: controller.memeberList.length,
                                    itemBuilder: (context, i) {
                                      return memebrAvatatr(
                                          controller.memeberList[i],
                                          action: () =>
                                              controller.removeMember(i));
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text("Add Members"),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    controller.startdate(context);
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
                                          controller.startDate.value,
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
                                    controller.enddate(context);
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
                                          controller.endDate.value,
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
                                    if (key.currentState!.validate() &&
                                        controller.startDate.value != "" &&
                                        controller.endDate.value != "") {
                                      controller.postTask(
                                          widget.categoryModel.id!,
                                          widget.categoryModel);
                                    } else {
                                      Get.snackbar(
                                          "select", "all feilds are requird");
                                    }
                                  },
                                  child: const Text("Add Task")),
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
