import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tutorial/main.dart';
import 'package:tutorial/product.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const Tutorial12());
}

class Tutorial12 extends StatelessWidget{
  const Tutorial12({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'E-Commerce App'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Product> futureProduct;

  @override 
  void initState() {
    super.initState();
    futureProduct = fetchProduct();
  } 

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

    );
  }
}

Future<Product> fetchProduct() async {
  final response = await http.get(Uri.parse('http://192.168.0.103:8000/api/product'));

  if (response.statusCode == 200) {
    return Product.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception("Failed to load products!");
  }
}

Future<http.Response> createProduct(String name, int price) {
  return http.post(
    Uri.parse('http://192.168.0.103:8000/api/product'),
    headers: <String, String> {'Content-Type': 'application/json; charset=UTF-8'},
    body: json.encode(<String, dynamic> {'name': name, 'price': price}),
  );
}