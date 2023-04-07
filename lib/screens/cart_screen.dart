import 'package:flutter/material.dart';
import '../main.dart';

class CartScreen extends StatelessWidget {
  final List<Fruit> cart;
  final void Function(Fruit fruit) onRemoveFromCart;

  CartScreen({required this.cart, required this.onRemoveFromCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panier'),
      ),
      body: cart.isEmpty
          ? const Center(child: Text('Le panier est vide'))
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final fruit = cart[index];
                return ListTile(
                  leading: Image.asset('../images/${fruit.name}.png'),
                  title: Text(fruit.name),
                  subtitle: Text('Prix : ${fruit.price} \$'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      onRemoveFromCart(fruit);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${fruit.name} supprimé du panier')),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
