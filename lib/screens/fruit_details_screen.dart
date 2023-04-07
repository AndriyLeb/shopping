import 'package:flutter/material.dart';
import '../main.dart';

class FruitDetailsScreen extends StatelessWidget {
  const FruitDetailsScreen({Key? key, required this.fruit, required this.onAddToCart, required this.onRemoveFromCart});

  final Fruit fruit;
  final void Function(BuildContext) onAddToCart;
  final void Function(BuildContext) onRemoveFromCart;

  @override
  Widget build(BuildContext context) {
    String fruitName = fruit.name;
      return Scaffold(
        appBar: AppBar(
          title: Text(fruit.name),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('../images/$fruitName.png'),
            const SizedBox(height: 16),
            Text('Nom : ${fruit.name}'),
            Text('Couleur : ${fruit.color}'),
            Text('Prix : ${fruit.price} \$'),
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => onAddToCart(context),
              child: const Icon(Icons.shopping_cart),
              tooltip: 'Ajouter au panier',
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              onPressed: () => onRemoveFromCart(context),
              child: const Icon(Icons.remove_shopping_cart),
              tooltip: 'Supprimer du panier',
            ),
          ],
        ),
      );
  }
}
