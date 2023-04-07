import 'package:flutter/material.dart';
import 'screens/fruit_details_screen.dart';
import 'screens/cart_screen.dart';


void main() {
  runApp(const MyApp());
}

class Fruit {
  String name;
  Color color;
  double price;

  Fruit({required this.name, required this.color, required this.price});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FruitsMaster(
        fruits: [
          Fruit(name: 'banane', color: Colors.yellow, price: 2.25),
          Fruit(name: 'pomme', color: Colors.green, price: 1.79),
          Fruit(name: 'cassis', color: Colors.purple, price: 0.22),
          Fruit(name: 'citron-vert', color: Colors.lightGreen, price: 1.25),
          Fruit(name: 'framboise', color: Colors.red, price: 2.12),
          Fruit(name: 'citron', color: Colors.yellow, price: 2.3),
          Fruit(name: 'fraise', color: Colors.red, price: 0.33),
        ],
      ),
    );
  }
}

class FruitsMaster extends StatefulWidget {
  const FruitsMaster({Key? key, required this.fruits});

  final List<Fruit> fruits;

  @override
  _FruitsMasterState createState() => _FruitsMasterState();
}

class FruitPreview extends StatelessWidget {
  const FruitPreview({Key? key, required this.fruit, required this.onViewDetails, required this.onAddToCart});

  final Fruit fruit;
  final VoidCallback onViewDetails;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    final fruitName = fruit.name.toLowerCase();
    return InkWell(
      onTap: onViewDetails,
      child: Container(
        color: fruit.color,
        child: ListTile(
          leading: Image.asset('../images/$fruitName.png'),
          title: Text(fruit.name),
          subtitle: Text('Couleur : ${fruit.color}, Prix : ${fruit.price} \$'),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: onAddToCart,
          ),
        ),
      ),
    );
  }
}


class _FruitsMasterState extends State<FruitsMaster> with SingleTickerProviderStateMixin {


  PageController _pageController = PageController();
  int _selectedIndex = 0;
  List<Fruit> _cart = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des fruits'),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          ListView.builder(
            itemCount: widget.fruits.length,
            itemBuilder: (context, index) {
              final fruit = widget.fruits[index];
              return FruitPreview(
                fruit: fruit,
                onViewDetails: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FruitDetailsScreen(
                        fruit: fruit,
                        onAddToCart: (BuildContext innerContext) {
                          setState(() {
                            _cart.add(fruit);
                          });
                          ScaffoldMessenger.of(innerContext).showSnackBar(
                            SnackBar(content: Text('${fruit.name} ajouté au panier')),
                          );
                        },
                        onRemoveFromCart: (BuildContext innerContext) {
                          setState(() {
                            _cart.remove(fruit);
                          });
                          ScaffoldMessenger.of(innerContext).showSnackBar(
                            SnackBar(content: Text('${fruit.name} supprimé du panier')),
                          );
                        },
                      ),
                    ),
                  );
                },
                onAddToCart: () {
                  setState(() {
                    _cart.add(fruit);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${fruit.name} ajouté au panier')),
                  );
                },
              );
            },
          ),
          CartScreen(
            cart: _cart,
            onRemoveFromCart: (fruit) {
              setState(() {
                _cart.remove(fruit);
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.list),
            label: 'Fruits',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart),
            label: 'Panier',
          ),
        ],
      ),
    );
  }
}



         
