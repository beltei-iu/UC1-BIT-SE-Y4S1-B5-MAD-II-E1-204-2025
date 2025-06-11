import 'dart:io';

import 'package:flutter/services.dart';

class FileStorageService {
  static Future<void> orderProduct(
    int productId,
    double price,
    int qty,
    int discount,
  ) async {
    // File Path
    String filePath = "assets/data/product.txt";
    // Create File
    File file = File(filePath);
    // Check exist file
    if (file.exists() == false) {
      file.create();
    }

    // Create payload
    // productId=1,price=2000,qty=2,discount=10
    String payload =
        "productId=$productId,price=$price,qty=$qty,discount=$discount";

    // Write to file
    file.openWrite(mode: FileMode.append).writeln(payload);
  }

  static Future<List<String>> getOrderProducts() async {
    try {
      // File Path
      String filePath = "assets/data/product.txt";
      // Create File
      File file = File(filePath);
      // Read Line
      List<String> dataLines = await file.readAsLines();
      for (String line in dataLines) {
        List<String> dataSplit = line.split(',');
        print("productId : ${dataSplit[0]}");
      }
      return dataLines;
    } catch (e) {
      print('Error loading data: $e');
    }
    return [];
  }
}
