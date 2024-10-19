import 'package:driving/controller.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  final DrivingController drivingController = Get.find<DrivingController>();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          centerTitle: true,
          elevation: 8,
          title: const Text('Walid Cherifi'),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: FutureBuilder(
                future: loadJsonData(),
                builder: (builder, snapshot) {
                  if (snapshot.hasData) {
                    List<Map<String, dynamic>> data =
                        snapshot.data as List<Map<String, dynamic>>;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(children: [
                                Expanded(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      Text(
                                        data[index]['question'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        maxLines: 3,
                                      ),
                                      Text(data[index]['correct_answer']),
                                    ])),
                                if (data[index]['image'] != null)
                                  Image.network(
                                    data[index]['image'],
                                    height: 60,
                                  ),
                              ]),
                              const Divider()
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ));
  }

  Future<List<Map<String, dynamic>>> loadJsonData() async {
    final String jsonString =
        await rootBundle.loadString(r'assets\new_data.json');
    final data = json.decode(jsonString);

    return List<Map<String, dynamic>>.from(data);

    // You can process the data as needed
  }
}
