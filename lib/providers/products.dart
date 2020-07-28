import 'product.dart';
import 'package:flutter/material.dart';

class Products extends ChangeNotifier {
  List<Product> _items = [
    Product(
        id: 'p1',
        title: 'Men Green & White Casual Shirt',
        description:
            'Green and White checked casual shirt, has a spread collar, long sleeves, button placket, curved hem, and 1 patch pocket',
        price: 2239,
        imageUrl:
            'https://assets.myntassets.com/h_1440,q_90,w_1080/v1/assets/images/11166444/2020/2/20/69898f22-f360-4064-bf10-eed6af5218091582176094217-Levis-Men-Shirts-2871582176092421-1.jpg'),
    Product(
        id: 'p2',
        title: 'Women White & Black Top',
        description:
            'White and Black striped knitted regular top, has a round neck, and three-quarter sleeves',
        price: 1599,
        imageUrl:
            'https://assets.myntassets.com/h_1440,q_90,w_1080/v1/assets/images/11184478/2020/3/3/3e3d7de2-b7dc-4161-bbb1-7036f242f0b01583211553878-Levis-Women-Tops-8411583211551899-1.jpg'),
    Product(
        id: 'p3',
        title: 'Men Blue Slim Fit Jeans',
        description:
            'Blue medium wash 5-pocket mid-rise jeans, clean look, light fade, has a zip fly closure, and waistband with belt loops',
        price: 1950,
        imageUrl:
            'https://assets.myntassets.com/h_1440,q_90,w_1080/v1/assets/images/11165742/2020/2/19/51c34ba7-479c-4219-b13b-822bc8c810bf1582115044254-Levis-Men-Jeans-4461582115041883-2.jpg'),
    Product(
        id: 'p4',
        title: 'Men Off-White Chino Shorts',
        description:
            'Off-White solid mid-rise chino shorts, has 4 pockets, and zip closure',
        price: 1599,
        imageUrl:
            'https://assets.myntassets.com/h_1440,q_90,w_1080/v1/assets/images/11473236/2020/6/17/61da77c1-5eaa-48d9-822c-517863fb2a911592396114281-Nautica-Men-Off-White-Solid-Slim-Fit-Chino-Shorts-8181592396-2.jpg'),
    Product(
        id: 'p5',
        title: 'Men Burgundy Solid Polo T-shirt',
        description:
            'Burgundy solid T-shirt, has a polo collar, and long printed sleeves',
        price: 1799,
        imageUrl:
            'https://assets.myntassets.com/h_1440,q_90,w_1080/v1/assets/images/10847172/2020/6/17/d2faa530-f3a2-42ec-b6da-0be6987df8491592371575546-Nautica-Men-Tshirts-1331592371573495-3.jpg'),
    /*Product(
        id: 'p6',
        title: 'Women White & Black Top',
        description:
        'White and Black striped knitted regular top, has a round neck, and three-quarter sleeves',
        price: 1599,
        imageUrl:
        'https://assets.myntassets.com/h_1440,q_90,w_1080/v1/assets/images/11184478/2020/3/3/3e3d7de2-b7dc-4161-bbb1-7036f242f0b01583211553878-Levis-Women-Tops-8411583211551899-1.jpg'),

    Product(
        id: 'p7',
        title: 'Women White & Black Top',
        description:
        'White and Black striped knitted regular top, has a round neck, and three-quarter sleeves',
        price: 1599,
        imageUrl:
        'https://assets.myntassets.com/h_1440,q_90,w_1080/v1/assets/images/11184478/2020/3/3/3e3d7de2-b7dc-4161-bbb1-7036f242f0b01583211553878-Levis-Women-Tops-8411583211551899-1.jpg'),

    Product(
        id: 'p8',
        title: 'Women White & Black Top',
        description:
        'White and Black striped knitted regular top, has a round neck, and three-quarter sleeves',
        price: 1599,
        imageUrl:
        'https://assets.myntassets.com/h_1440,q_90,w_1080/v1/assets/images/11184478/2020/3/3/3e3d7de2-b7dc-4161-bbb1-7036f242f0b01583211553878-Levis-Women-Tops-8411583211551899-1.jpg'),

    Product(
        id: 'p9',
        title: 'Women White & Black Top',
        description:
        'White and Black striped knitted regular top, has a round neck, and three-quarter sleeves',
        price: 1599,
        imageUrl:
        'https://assets.myntassets.com/h_1440,q_90,w_1080/v1/assets/images/11184478/2020/3/3/3e3d7de2-b7dc-4161-bbb1-7036f242f0b01583211553878-Levis-Women-Tops-8411583211551899-1.jpg'),
    Product(
        id: 'p10',
        title: 'Women White & Black Top',
        description:
        'White and Black striped knitted regular top, has a round neck, and three-quarter sleeves',
        price: 1599,
        imageUrl:
        'https://assets.myntassets.com/h_1440,q_90,w_1080/v1/assets/images/11184478/2020/3/3/3e3d7de2-b7dc-4161-bbb1-7036f242f0b01583211553878-Levis-Women-Tops-8411583211551899-1.jpg'),
        */
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favorites {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String productId) {
    return _items.firstWhere((element) => element.id == productId);
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void addProduct(Product product) {
    final newProduct = Product(
        title: product.title,
        id: DateTime.now().toString(),
        price: product.price,
        imageUrl: product.imageUrl,
        description: product.description);
    _items.add(newProduct);

    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final productIndex = _items.indexWhere((element) => element.id == id);
    if (productIndex >= 0) {
      _items[productIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
