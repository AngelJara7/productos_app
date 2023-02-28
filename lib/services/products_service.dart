import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {

  final String _baseUrl = "productos-app-a1bda-default-rtdb.firebaseio.com";
  final List<Product> products = [];
  late Product? selectedProduct;
  File? newPictureFile;
  bool isLoading = true;
  bool isSaving = false;

  ProductsService() {
    loadProducts();
  }
  
  Future<List<Product>> loadProducts() async {

    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, "products.json");
    final resp = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromJson(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();

    return products;
  }

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      await createProduct(product);
    } else {
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {

    final url = Uri.https(_baseUrl, "products/${product.id}.json");
    final resp = await http.put(url, body: json.encode(product.toJson()));
    final decodeData = resp.body;

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(Product product) async {

    final url = Uri.https(_baseUrl, "products.json");
    final resp = await http.post(url, body: json.encode(product.toJson()));
    final decodeData = json.decode(resp.body);

    product.id = decodeData["name"];

    products.add(product);

    return product.id!;
  }

  void updateSelectedProductImage(String path) {

    selectedProduct?.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future<String?> uploadImage() async {

    if (newPictureFile == null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse("https://api.cloudinary.com/v1_1/disyonm4l/image/upload?upload_preset=t8ipnygw");

    final imageUploadRequest = http.MultipartRequest("POST", url);
    final file = await http.MultipartFile.fromPath("file", newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode != 200 && resp.statusCode != 200) {
      return null;
    }

    newPictureFile = null;

    final decodeData = json.decode(resp.body);
    return decodeData["secure_url"];
  }
}