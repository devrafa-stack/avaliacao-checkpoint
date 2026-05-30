import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/models/cart_item.dart';
import 'package:usedev_uninassau/src/services/cart_service.dart';
import 'package:usedev_uninassau/src/widgets/hero_section_widget.dart';
import 'package:usedev_uninassau/src/widgets/product_card_widget.dart';
import 'package:usedev_uninassau/src/widgets/subscription_section_widget.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final CartService _cartService = CartService();

  final List<Map<String, String>> produtos = [
    {'nome': 'Bone UseDev',    'imagem': 'assets/bone.png',     'preco': 'R\$ 49,90'},
    {'nome': 'Caneca Dev',     'imagem': 'assets/caneca.png',   'preco': 'R\$ 39,90'},
    {'nome': 'Capivara Gamer', 'imagem': 'assets/capivara.png', 'preco': 'R\$ 89,90'},
    {'nome': 'Chaveiro Dev',   'imagem': 'assets/chaveiro.png', 'preco': 'R\$ 19,90'},
    {'nome': 'Mousepad XL',    'imagem': 'assets/mousepad.png', 'preco': 'R\$ 59,90'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu, size: 40),
        title: Image.asset('assets/logo_usedev.png', height: 40),
        centerTitle: true,
        actions: [
          const Icon(Icons.person_outline, size: 40),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, size: 40),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
          const SizedBox(width: 25),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeroSectionWidget(),
            Text(
              'Promos Especiais',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.orbitron().fontFamily,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                final produto = produtos[index];
                return ProductCardWidget(
                  nome: produto['nome']!,
                  url: produto['imagem']!,
                  preco: produto['preco']!,
                  onAddToCart: () {
                    _cartService.addItem(CartItem(
                      nome: produto['nome']!,
                      url: produto['imagem']!,
                      preco: produto['preco']!,
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Produto adicionado ao carrinho'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                );
              },
            ),
            const SubscriptionSectionWidget(),
          ],
        ),
      ),
    );
  }
}