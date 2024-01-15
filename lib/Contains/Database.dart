import 'dart:io';
import 'dart:typed_data';
import 'package:pharmaconnectbyturjo/pages/edit_screen.dart';

File uint8ListToFile(Uint8List uint8List, String fileName) {
  // Create a temporary directory
  Directory tempDir = Directory.systemTemp;

  // Create a temporary file
  File tempFile = File('${tempDir.path}/$fileName');

  // Write the Uint8List data to the file
  tempFile.writeAsBytesSync(uint8List);

  return tempFile;
}

void main() {
  // Example Uint8List
  Uint8List uint8List = Uint8List.fromList([65, 66, 67, 68, 69]);

  // Specify a file name for the temporary file
  String fileName = 'example_file.txt';

  // Convert Uint8List to File
  File file = uint8ListToFile(uint8List, fileName);

  // Use the created File
  print('File path: ${file.path}');
}
