import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/models/cart_item.dart';
import 'package:usedev_uninassau/src/models/product.dart';
import 'package:usedev_uninassau/src/screens/product_detail_screen.dart';
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

  final List<Product> produtos = [
    Product(
      nome: 'Bone UseDev',
      imagem: 'assets/bone.png',
      preco: 'R\$ 49,90',
      descricao: 'Bone exclusivo UseDev com bordado de alta qualidade, perfeito para desenvolvedores que querem estilo e conforto.',
    ),
    Product(
      nome: 'Caneca Dev',
      imagem: 'assets/caneca.png',
      preco: 'R\$ 39,90',
      descricao: 'Caneca para café com design inspirador para programadores, tinta resistente e acabamento premium.',
    ),
    Product(
      nome: 'Capivara Gamer',
      imagem: 'assets/capivara.png',
      preco: 'R\$ 89,90',
      descricao: 'Estatueta gamer Capivara com iluminação LED, ideal para decorar sua estação de trabalho ou setup de jogos.',
    ),
    Product(
      nome: 'Chaveiro Dev',
      imagem: 'assets/chaveiro.png',
      preco: 'R\$ 19,90',
      descricao: 'Chaveiro temático com formato de código e acabamento metálico, ideal para fãs de tecnologia.',
    ),
    Product(
      nome: 'Mousepad XL',
      imagem: 'assets/mousepad.png',
      preco: 'R\$ 59,90',
      descricao: 'Mousepad extra grande com superfície lisa e antiderrapante, perfeito para longas sessões de desenvolvimento.',
    ),
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
                  nome: produto.nome,
                  url: produto.imagem,
                  preco: produto.preco,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: produto),
                      ),
                    );
                  },
                  onAddToCart: () {
                    _cartService.addItem(CartItem(
                      nome: produto.nome,
                      url: produto.imagem,
                      preco: produto.preco,
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Produto adicionado ao carrinho'),
                        duration: Duration(seconds: 1),
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