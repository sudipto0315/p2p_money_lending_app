import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class BorrowerNetworkService {
  final String _baseUrl = 'https://k1fvh0s4-3000.inc1.devtunnels.ms'; // Update with your actual server URL

  Future<void> submitLoanRequest(
      String borrowerID,
      String amount,
      String description,
      int tenure,
      ) async {
    const username = 'admin';
    const password = 'password';
    final authHeader = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    if(kDebugMode) {
      print(authHeader);
    }
    try{
      final response = await http.post(
        Uri.parse('$_baseUrl/loan/request'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authHeader,
        },
        body: jsonEncode(<String, dynamic>{
          'BorrowerID': borrowerID,
          'Tenure': tenure,
          'Amount': amount,
          'Description': description,
        }),
      );
      if (response.statusCode == 201) {
        // If the server returns a 201 CREATED response,
        // then parse the JSON.
        if(kDebugMode) {
          print('Loan Details sent successfully');
        }
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        if(kDebugMode) {
          print('Failed to send Loan Details. Status code: ${response.statusCode}. Body: ${response.body}');
        }
        throw Exception('Failed to send Loan Details');
      }
    } catch (e) {
      if(kDebugMode) {
        print('An error occurred while trying to send Loan Details: $e');
      }
      rethrow;
    }
  }

  Future<String> fetchBorrowerID(String userID) async {
    const username = 'admin';
    const password = 'password';
    final authHeader = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    if (kDebugMode) {
      print('Fetching BorrowerID with URL: $_baseUrl/borrower/getBorrowerIDWithUserID/$userID');
      print(authHeader);
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/borrower/getBorrowerIDWithUserID/$userID'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authHeader,
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['BorrowerID'] != null) {
          if (kDebugMode) {
            print('Borrower ID fetched successfully: ${data['BorrowerID']}');
          }
          return data['BorrowerID'].toString();
        } else {
          throw Exception('BorrowerID not Found');
        }
      } else {
        if (kDebugMode) {
          print('Failed to fetch Borrower ID. Status code: ${response.statusCode}. Body: ${response.body}');
        }
        throw Exception('Failed to fetch Borrower ID');
      }
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred while trying to fetch BorrowerID: $e');
      }
      throw Exception('An error occurred while trying to fetch BorrowerID');
    }
  }

  Future<String> getUserIDWithEmailAndRole(String email, String role) async {
    const username = 'admin';
    const password = 'password';
    final authHeader = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    if (kDebugMode) {
      print(authHeader);
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/user/getUserWithEmailAndRole/$email/$role'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authHeader,
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (kDebugMode) {
          print('UserID fetched successfully: ${data['UserID']}');
        }
        return data['UserID'].toString();
      } else {
        throw Exception('Failed to load UserID');
      }
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred while trying to fetch UserID: $e');
      }
      rethrow;
    }
  }
}