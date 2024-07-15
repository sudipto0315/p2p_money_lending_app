import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<void> sendUserDetailsToServer(
    String userID,
    String firstName,
    String lastName,
    String gender,
    String maritalStatus,
    String dateOfBirth,
    String phoneNumber,
    String email,
    String occupation,
    String address,
    String role,
    ) async {
  const username = 'admin';
  const password = 'password';
  final authHeader =
      'Basic ${base64Encode(utf8.encode('$username:$password'))}';
  if (kDebugMode) {
    print(authHeader);
  }
  try {
    // Choose the endpoint based on the role
    String endpoint = role == 'Borrower' ? 'borrower/add' : 'lender/add';
    final response = await http.post(
      Uri.parse('https://k1fvh0s4-3000.inc1.devtunnels.ms/$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authHeader,
      },
      body: jsonEncode(<String, String>{
        'UserID': userID,
        'FirstName': firstName,
        'LastName': lastName,
        'Gender': gender,
        'MaritalStatus': maritalStatus,
        'DateOfBirth': dateOfBirth,
        'PhoneNumber': phoneNumber,
        'Email': email,
        'Occupation': occupation,
        'Address': address,
        'Role': role,
      }),
    );

    if (response.statusCode == 201) {
      if (kDebugMode) {
        print('User details sent successfully');
      }
    } else {
      if (kDebugMode) {
        print(
            'Failed to send user details. Status code: ${response.statusCode}. Body: ${response.body}');
      }
      throw Exception('Failed to send user details');
    }
  } catch (e) {
    if (kDebugMode) {
      print('An error occurred while trying to send user details: $e');
    }
    rethrow;
  }
}

Future<void> sendKYCDetailsToServer(
    String userID,
    String aadhaarNumber,
    String panNumber,
    String bankAccountNumber,
    ) async {
  const username = 'admin';
  const password = 'password';
  final authHeader = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
  if (kDebugMode) {
    print(authHeader);
  }
  try {
    final response = await http.post(
      Uri.parse('https://k1fvh0s4-3000.inc1.devtunnels.ms/kyc/add'),
      // Replace with your server address
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authHeader,
      },
      body: jsonEncode(<String, String>{
        'UserID': userID, // Ensure this matches the backend key
        'AadhaarNumber': aadhaarNumber,
        'PANNumber': panNumber,
        'BankAccountNumber': bankAccountNumber,
      }),
    );

    if (response.statusCode == 201) {
      // If the server returns a 201 CREATED response,
      // then parse the JSON.
      if (kDebugMode) {
        print('KYC details sent successfully');
      }
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      if (kDebugMode) {
        print('Failed to send KYC details. Status code: ${response.statusCode}. Body: ${response.body}');
      }
      throw Exception('Failed to send KYC details');
    }
  } catch (e) {
    if (kDebugMode) {
      print('An error occurred while trying to send KYC details: $e');
    }
    rethrow;
  }
}

Future<List<String>> getUserRole(String email) async {
  const username = 'admin';
  const password = 'password';
  final authHeader = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';

  final response = await http.get(
    Uri.parse('https://k1fvh0s4-3000.inc1.devtunnels.ms/user/getUserRole/$email'),
    headers: <String, String>{
      'Authorization': authHeader,
    },
  );
  if (response.statusCode == 200) {
    final List<dynamic> roles = jsonDecode(response.body);
    return roles.cast<String>();
  } else {
    throw Exception('Failed to load user roles');
  }
}

Future<void> sendUserToServer(
    String email,
    String role,
    ) async {
  const username = 'admin';
  const password = 'password';
  final authHeader = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
  if (kDebugMode) {
    print(authHeader);
  }
  try {
    final response = await http.post(
      Uri.parse('https://k1fvh0s4-3000.inc1.devtunnels.ms/user/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authHeader,
      },
      body: jsonEncode(<String, String>{
        'Email': email,
        'Role': role,
      }),
    );

    if (response.statusCode == 201) {
      if (kDebugMode) {
        print('User details sent successfully');
      }
    } else {
      if (kDebugMode) {
        print(
            'Failed to send user details. Status code: ${response.statusCode}. Body: ${response.body}');
      }
      throw Exception('Failed to send user details');
    }
  } catch (e) {
    if (kDebugMode) {
      print('An error occurred while trying to send user details: $e');
    }
    rethrow;
  }
}

Future<String> getUserIDWithEmailAndRole(
    String email,
    String role,
    ) async {
  const username = 'admin';
  const password = 'password';
  final authHeader =
      'Basic ${base64Encode(utf8.encode('$username:$password'))}';
  if (kDebugMode) {
    print(authHeader);
  }
  try {
    final response = await http.get(
      Uri.parse(
          'https://k1fvh0s4-3000.inc1.devtunnels.ms/user/getUserWithEmailAndRole/$email/$role'),
      headers: <String, String>{
        'Authorization': authHeader,
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['UserID'] != null) {
        if (kDebugMode) {
          print('User ID fetched successfully');
        }
        return data['UserID'].toString();
      } else {
        throw Exception('User not found');
      }
    } else {
      if (kDebugMode) {
        print(
            'Failed to fetch user ID. Status code: ${response
                .statusCode}. Body: ${response.body}');
      }
      throw Exception('Failed to fetch user ID');
    }
  } catch (e) {
    if (kDebugMode) {
      print('An error occurred while trying to fetch UserID: $e');
    }
    rethrow;
  }
}

Future<bool> doesUserExist(
    String email,
    String role,
    ) async {
  const username = 'admin';
  const password = 'password';
  final authHeader =
      'Basic ${base64Encode(utf8.encode('$username:$password'))}';
  if (kDebugMode) {
    print(authHeader);
  }
  try {
    final response = await http.get(
      Uri.parse('https://k1fvh0s4-3000.inc1.devtunnels.ms/user/exists/$email/$role'),
      headers: <String, String>{
        'Authorization': authHeader,
      },
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('User existence check successful');
      }
      return jsonDecode(response.body)['exists'];
    } else {
      if (kDebugMode) {
        print(
            'Failed to check user existence. Status code: ${response.statusCode}. Body: ${response.body}');
      }
      throw Exception('Failed to check user existence');
    }
  } catch (e) {
    if (kDebugMode) {
      print('An error occurred while trying to check user existence: $e');
    }
    rethrow;
  }
}