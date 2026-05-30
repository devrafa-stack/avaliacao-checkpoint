import 'package:usedev_uninassau/src/models/cart_item.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  bool get hasItems => _items.isNotEmpty;

  int get totalItems => _items.fold(0, (total, item) => total + item.quantidade);

  void addItem(CartItem item) {
    try {
      final existing = _items.firstWhere((element) => element.nome == item.nome);
      existing.quantidade += item.quantidade;
    } catch (_) {
      _items.add(item);
    }
  }

  void removeItem(String nome) {
    _items.removeWhere((item) => item.nome == nome);
  }

  void increaseQuantity(String nome) {
    for (final item in _items) {
      if (item.nome == nome) {
        item.quantidade += 1;
        break;
      }
    }
  }

  void decreaseQuantity(String nome) {
    for (final item in _items) {
      if (item.nome == nome && item.quantidade > 1) {
        item.quantidade -= 1;
        break;
      }
    }
  }

  void clear() {
    _items.clear();
  }
}
