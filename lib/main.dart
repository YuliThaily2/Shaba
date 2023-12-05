import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';


void main() => runApp(const MyApp());

class Product {
  final String name;
  final String description;
  final String imagePath;

  Product({
    required this.name,
    required this.description,
    required this.imagePath,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeView(),
        '/second': (context) => const SecondView(),
        '/third': (context) => const ThirdView(),
        '/fourth': (context) => const FourthView(),
      },
    );
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vista Principal'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú lateral',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pushNamed(context, '/second');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/second');
          },
          child: const Text('Mostrar Productos'),
        ),
      ),
    );
  }
}

class SecondView extends StatelessWidget {
  const SecondView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Product> products = [
      Product(
        name: 'Product 1',
        description: 'Description for Product 1',
        imagePath: 'assets/product1.jpg',
      ),
      Product(
        name: 'Product 2',
        description: 'Description for Product 2',
        imagePath: 'assets/product2.jpg',
      ),
      Product(
        name: 'Product 3',
        description: 'Description for Product 3',
        imagePath: 'assets/product3.jpg',
      ),
      Product(
        name: 'Product 4',
        description: 'Description for Product 4',
        imagePath: 'assets/product4.jpg',
      ),
      Product(
        name: 'Product 5',
        description: 'Description for Product 5',
        imagePath: 'assets/product5.jpg',
      ),
      Product(
        name: 'Product 6',
        description: 'Description for Product 6',
        imagePath: 'assets/product6.jpg',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Segunda Vista'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index], onAddToCart: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Se añadió ${products[index].name} al carrito'),
              ),
            );
            Navigator.pushNamed(context, '/fourth', arguments: products[index]);
          });
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductCard({Key? key, required this.product, required this.onAddToCart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.asset(
            product.imagePath,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Text(
            product.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            product.description,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              onAddToCart();
            },
            child: const Text('Añadir al Carrito'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/third', arguments: product);
            },
            child: const Text('Ver Producto'),
          ),
        ],
      ),
    );
  }
}

class ThirdView extends StatelessWidget {
  const ThirdView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              product.imagePath,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              product.description,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class FourthView extends StatelessWidget {
  const FourthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuarta Vista - Carrito'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              product.imagePath,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              product.description,
              style: const TextStyle(fontSize: 14),
            ),
             const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
             
            },
            child: const Text('Pagar'),
          ),
          ],
        ),
      ),
    );
  }
}
