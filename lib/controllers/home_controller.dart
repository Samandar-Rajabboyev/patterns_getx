import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/post_model.dart';
import '../pages/create_or_update_post.dart';
import '../services/http_service.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var items = <Post>[].obs;

  Future apiPostList() async {
    isLoading(true);
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      items.value = Network.parsePostList(response);
    } else {
      items.value = [];
    }
    isLoading(false);
  }

  Future<bool> apiPostDelete(Post post) async {
    isLoading(true);
    var response = await Network.DEL(Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    isLoading(false);
    return response != null;
  }

  Future<bool> _apiPostCreate(Post post) async {
    isLoading(true);
    var response = await Network.POST(Network.API_CREATE, Network.paramsCreate(post));
    isLoading(false);
    return response != null;
  }

  Future<bool> _apiPostUpdate(Post post) async {
    isLoading(true);
    var response = await Network.PUT(Network.API_UPDATE + post.id.toString(), Network.paramsUpdate(post));
    isLoading(false);
    return response != null;
  }

  onCreatePost(BuildContext context) async {
    await openDialog(context, type: DialogType.create).then((post) {
      if (post != null) {
        _apiPostCreate(post).then((value) {
          if (value) apiPostList();
        });
      }
    });
  }

  onUpdatePost(BuildContext context, Post post) async {
    await openDialog(context, type: DialogType.update, post: post).then((post) {
      if (post != null) {
        _apiPostUpdate(post).then((value) {
          if (value) apiPostList();
        });
      }
    });
  }
}
