// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patterns_getx/controllers/home_controller.dart';

import '../views/item_of_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _controller.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("GetX"),
        ),
        body: Obx(
          () => Stack(
            children: [
              ListView.builder(
                itemCount: _controller.items.length,
                itemBuilder: (ctx, index) {
                  return itemOfPost(_controller, _controller.items[index]);
                },
              ),
              _controller.isLoading()
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () => _controller.onCreatePost(context),
          child: const Icon(Icons.add),
        ));
  }
}
