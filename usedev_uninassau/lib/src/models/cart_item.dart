class CartItem {
  CartItem({
    required this.nome,
    required this.url,
    required this.preco,
    this.quantidade = 1,
  });

  final String nome;
  final String url;
  final String preco;
  int quantidade;

  double get priceValue {
    final valueString = preco
        .replaceAll('R\$', '')
        .replaceAll(' ', '')
        .replaceAll('.', '')
        .replaceAll(',', '.');
    return double.tryParse(valueString) ?? 0;
  }

  String get subtotal {
    final total = priceValue * quantidade;
    return 'R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}';
  }
}
