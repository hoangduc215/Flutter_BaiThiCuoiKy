class CartResponse {
  final List<CartModel> carts;
  final int total;
  final int skip;
  final int limit;

  CartResponse({
    required this.carts,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory CartResponse.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return CartResponse(
      carts:
          (json['carts'] as List?)
              ?.map((e) => CartModel.fromJson(e))
              .toList() ??
          [],
      total: json['total'] ?? 0,
      skip: json['skip'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }
}

class CartModel {
  final int id;
  final int userId;
  final List<CartItem> items;
  final double total;
  final double discountedTotal;
  final int totalProducts;
  final int totalQuantity;

  CartModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
    required this.discountedTotal,
    required this.totalProducts,
    required this.totalQuantity,
  });

  factory CartModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return CartModel(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      items:
          (json['products'] as List?)
              ?.map((e) => CartItem.fromJson(e))
              .toList() ??
          [],
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      discountedTotal: (json['discountedTotal'] as num?)?.toDouble() ?? 0.0,
      totalProducts: json['totalProducts'] ?? 0,
      totalQuantity: json['totalQuantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'products': items.map((e) => e.toJson()).toList(),
    'total': total,
    'discountedTotal': discountedTotal,
    'totalProducts': totalProducts,
    'totalQuantity': totalQuantity,
  };
}

class CartItem {
  final int productId;
  final String title;
  final double price;
  final int quantity;
  final double total;
  final double discountPercentage;
  final double discountedTotal;
  final String thumbnail;

  CartItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedTotal,
    required this.thumbnail,
  });

  factory CartItem.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return CartItem(
      productId: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 0,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      discountedTotal: (json['discountedTotal'] as num?)?.toDouble() ?? 0.0,
      thumbnail: json['thumbnail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': productId,
    'title': title,
    'price': price,
    'quantity': quantity,
    'total': total,
    'discountPercentage': discountPercentage,
    'discountedTotal': discountedTotal,
    'thumbnail': thumbnail,
  };
}

extension CartItemCopy on CartItem {
  CartItem copyWith({
    int? productId,
    String? title,
    double? price,
    int? quantity,
    double? total,
    double? discountPercentage,
    double? discountedTotal,
    String? thumbnail,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      title: title ?? this.title,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      discountedTotal: discountedTotal ?? this.discountedTotal,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }
}

extension CartModelCopy on CartModel {
  CartModel copyWith({
    int? id,
    int? userId,
    List<CartItem>? items,
    double? total,
    double? discountedTotal,
    int? totalProducts,
    int? totalQuantity,
  }) {
    return CartModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      total: total ?? this.total,
      discountedTotal: discountedTotal ?? this.discountedTotal,
      totalProducts: totalProducts ?? this.totalProducts,
      totalQuantity: totalQuantity ?? this.totalQuantity,
    );
  }
}
