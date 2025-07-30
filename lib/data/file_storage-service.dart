import 'dart:io';

import 'package:flutter/services.dart';

class FileStorageService {
  // File Path
  // static String filePath = "assets/data/product.txt";
  //
  // static Future<String> _getCurrentPath() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   return directory.path;
  // }
  //
  // static Future<void> orderProduct(
  //   int productId,
  //   double price,
  //   int qty,
  //   int discount,
  // ) async {
  //   String path = await _getCurrentPath();
  //   // Create File
  //   File file = await File("$path/$filePath");
  //   // Check exist file
  //   bool isExist = await file.exists();
  //   if (!isExist) {
  //     file.create(recursive: true);
  //   }
  //   // Create payload
  //   // productId=1,price=2000,qty=2,discount=10
  //   String payload =
  //       "productId=$productId,price=$price,qty=$qty,discount=$discount";
  //
  //   // Write to file
  //   file.openWrite(mode: FileMode.append).writeln(payload);
  // }
  //
  // static Future<List<String>> getOrderProducts() async {
  //   try {
  //     String path = await _getCurrentPath();
  //     // Create File
  //     File file = File("$path/$filePath");
  //     bool isExist = await file.exists();
  //     if(!isExist) {
  //       await file.create(recursive: true);
  //     }
  //
  //     // Read Line
  //     List<String> dataLines = await file.readAsLines();
  //     for (String line in dataLines) {
  //       List<String> dataSplit = line.split(',');
  //       print("productId : ${dataSplit[0]}");
  //     }
  //     return dataLines;
  //   } catch (e) {
  //     print('Error loading data: $e');
  //   }
  //   return [];
  // }
}
