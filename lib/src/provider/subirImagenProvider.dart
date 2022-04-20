import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'dart:io';

class SubirImagenProvider extends ChangeNotifier {
  bool isLoading = true;
  Future<dynamic> subirImagen(File image, int busqueda) async {
    /* isLoading = true;
    notifyListeners(); */
    var uri = Uri.parse(
        "https://api-rest-lookhere-produccion.herokuapp.com/api/upload/foto/" +
            busqueda.toString());

    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('PUT', uri);
    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('archivo', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    imageUploadRequest.files.add(file);
    // add headers if needed
    //imageUploadRequest.headers.addAll(<some-headers>);
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      print('fotografia subido exitosamente.......................');
      /* isLoading = false;
      notifyListeners(); */
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
