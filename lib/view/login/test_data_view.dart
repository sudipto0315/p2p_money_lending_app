import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TestDataView extends StatefulWidget {
  const TestDataView({super.key});

  @override
  State<TestDataView> createState() => _TestDataViewState();
}

class _TestDataViewState extends State<TestDataView> {
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final response = await http.get(Uri.parse('http://localhost:3000/testdata'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      if (kDebugMode) {
        print(jsonResponse);
      }
      setState(() {
        data = jsonResponse;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Data View'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index]['title']), // replace 'title' with the actual key name in your data
            subtitle: Text(data[index]['subtitle']), // replace 'subtitle' with the actual key name in your data
          );
        },
      ),
    );
  }
}