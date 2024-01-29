import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Product>> productList;
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    productList = getProductList();
  }

  Future<List<Product>> getProductList() async {
    late List<Product> products;

    try {
      var response = await dio.get("https://dummyjson.com/products");
      products = response.data['products'].map<Product>((json) => Product.fromJson(json)).toList();
    } catch (error) {
      print(error);
    }

    return products;
  }

  Future<void> refreshData() async {
    productList = getProductList();

    setState(() {
      productList = getProductList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Test Title"),
          backgroundColor: Colors.blue,
        ),
        body: RefreshIndicator(
          onRefresh: () => refreshData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: FutureBuilder<List<Product>>(
              future: productList,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = snapshot.data[index];

                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text("${data.title}(${data.description})"),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
