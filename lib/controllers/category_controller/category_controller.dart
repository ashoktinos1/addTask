import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myproject1/models/category_model/category_model.dart';

class CategoryController extends GetxController {
  var categoryList = <CategoryModel>[].obs;
  var loading = true.obs;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> categoryget() async {
    loading.value = true;
    await db.collection("sections").get().then((value) {
      categoryList.value =
          value.docs.map((e) => CategoryModel.fromjson(e.data())).toList();
      loading.value = false;
    });
  }

  @override
  void onInit() {
    categoryget().then((value) {
      
      print(categoryList[1].name);
    });
    super.onInit();
  }
}
