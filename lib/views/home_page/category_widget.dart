import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myproject1/controllers/category_controller/category_controller.dart';
import 'package:myproject1/controllers/category_controller/task_controller.dart';
import 'package:myproject1/conts/png_images.dart';
import 'package:myproject1/views/taskpage/task_page.dart';

class CategoryWidget extends StatelessWidget {
  double itemWidth;
  double itemHeight;
  CategoryWidget({
    Key? key,
    required this.itemHeight,
    required this.itemWidth,
  }) : super(key: key);
  final controller = Get.put(CategoryController());
  final taskcontroller = Get.put(TaskController());

  @override
  Widget build(
    BuildContext context,
  ) {
    return RefreshIndicator(
      onRefresh: () => controller.categoryget(),
      child: Obx(() {
        return controller.loading.value
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                itemCount: controller.categoryList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (itemWidth / itemHeight),
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8),
                itemBuilder: (context, i) {
                  final data = controller.categoryList[i];
                  return Stack(
                    children: [
                      InkWell(
                        onTap: ()  {
                           taskcontroller
                              .getTaskMethod(controller.categoryList[i].id!);
                          Get.to(() => TaskPage(data: data));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                    color: Colors.blueAccent.shade200
                                        .withOpacity(0.5),
                                  ),
                                  child: SvgPicture.network(data.image!),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 12, top: 24, bottom: 15, right: 15),
                                  alignment: Alignment.centerLeft,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.name!,
                                        style: const TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 6.3,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          RichText(
                                            text:  const TextSpan(
                                                text: "Task ",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                children: [
                                                  TextSpan(
                                                    text:"3",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                ]),
                                          ),
                                          RichText(
                                            text: const TextSpan(
                                                text: "employees ",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                children: [
                                                  TextSpan(
                                                    text: "10",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                ]),
                                          ),
                                          // const Text(
                                          //   "employee 8",
                                          //   style: TextStyle(
                                          //       color: Colors.red,
                                          //       fontWeight: FontWeight.w600),
                                          // ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Card(
                            shadowColor: Colors.black,
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 10,
                                backgroundImage: AssetImage(PngImages.teamIcon),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
      }),
    );
  }
}
