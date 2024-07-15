import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Book {
  final String? section;
  final int? bookid;
  final String? bookName;
  final String? authors;
  final int? borrowerId;
  final String? borrowerName;
  final String? issueDate;
  final String? returnDate;

  Book({
    this.section,
    this.bookid,
    this.bookName,
    this.authors,
    this.borrowerId,
    this.borrowerName,
    this.issueDate,
    this.returnDate,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      section: json['section'] as String?,
      bookid: json['bookid'] as int?,
      bookName: json['Book_name'] as String?,
      authors: json['Authors'] as String?,
      borrowerId: json['borrower_ID'] as int?,
      borrowerName: json['borrower_name'] as String?,
      issueDate: json['Issue_Date'] as String?,
      returnDate: json['Return_Date'] as String?,
    );
  }
}

class TestDataView extends StatefulWidget {
  const TestDataView({super.key});

  @override
  State<TestDataView> createState() => _TestDataViewState();
}

class _TestDataViewState extends State<TestDataView> {
  List<Book> data = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final response = await http.get(Uri.parse('https://k1fvh0s4-3000.inc1.devtunnels.ms/testdata'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      if (kDebugMode) {
        print(jsonResponse);
      }
      setState(() {
        data = jsonResponse.map((item) => Book.fromJson(item)).toList();
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
            title: Text(data[index].bookName ?? 'No book name'),
            subtitle: Text('Author: ${data[index].authors}\nBorrower: ${data[index].borrowerName}\nReturn Date: ${data[index].returnDate}'),
          );
        },
      ),
    );
  }
}