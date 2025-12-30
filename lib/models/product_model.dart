class ProductResponse {
  final List<Product>? products;
  final int? total;
  final int? skip;
  final int? limit;

  ProductResponse({this.products, this.total, this.skip, this.limit});

  factory ProductResponse.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return ProductResponse(
      products:
          (json['products'] as List?)
              ?.map((e) => Product.fromJson(e as Map<String, dynamic>?))
              .toList() ??
          [],
      total: json['total'] ?? 0,
      skip: json['skip'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'products': products?.map((e) => e.toJson()).toList() ?? [],
    'total': total ?? 0,
    'skip': skip ?? 0,
    'limit': limit ?? 0,
  };
}

class Product {
  final int? id;
  final String? title;
  final String? description;
  final String? category;
  final double? price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final List<String>? tags;
  final String? brand;
  final String? sku;
  final int? weight;
  final Dimensions? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<Review>? reviews;
  final String? returnPolicy;
  final int? minimumOrderQuantity;
  final Meta? meta;
  final List<String>? images;
  final String? thumbnail;

  Product({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.images,
    this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] ?? 0,
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? [],
      brand: json['brand'] ?? '',
      sku: json['sku'] ?? '',
      weight: json['weight'] ?? 0,
      dimensions: json['dimensions'] != null
          ? Dimensions.fromJson(json['dimensions'] as Map<String, dynamic>?)
          : Dimensions(),
      warrantyInformation: json['warrantyInformation'] ?? '',
      shippingInformation: json['shippingInformation'] ?? '',
      availabilityStatus: json['availabilityStatus'] ?? '',
      reviews:
          (json['reviews'] as List?)
              ?.map((e) => Review.fromJson(e as Map<String, dynamic>?))
              .toList() ??
          [],
      returnPolicy: json['returnPolicy'] ?? '',
      minimumOrderQuantity: json['minimumOrderQuantity'] ?? 0,
      meta: json['meta'] != null
          ? Meta.fromJson(json['meta'] as Map<String, dynamic>?)
          : Meta(),
      images:
          (json['images'] as List?)?.map((e) => e.toString()).toList() ?? [],
      thumbnail: json['thumbnail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id ?? 0,
    'title': title ?? '',
    'description': description ?? '',
    'category': category ?? '',
    'price': price ?? 0.0,
    'discountPercentage': discountPercentage ?? 0.0,
    'rating': rating ?? 0.0,
    'stock': stock ?? 0,
    'tags': tags ?? [],
    'brand': brand ?? '',
    'sku': sku ?? '',
    'weight': weight ?? 0,
    'dimensions': dimensions?.toJson() ?? Dimensions().toJson(),
    'warrantyInformation': warrantyInformation ?? '',
    'shippingInformation': shippingInformation ?? '',
    'availabilityStatus': availabilityStatus ?? '',
    'reviews': reviews?.map((e) => e.toJson()).toList() ?? [],
    'returnPolicy': returnPolicy ?? '',
    'minimumOrderQuantity': minimumOrderQuantity ?? 0,
    'meta': meta?.toJson() ?? Meta().toJson(),
    'images': images ?? [],
    'thumbnail': thumbnail ?? '',
  };
}

class Dimensions {
  final double? width;
  final double? height;
  final double? depth;

  Dimensions({this.width = 0.0, this.height = 0.0, this.depth = 0.0});

  factory Dimensions.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Dimensions(
      width: (json['width'] as num?)?.toDouble() ?? 0.0,
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      depth: (json['depth'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'width': width ?? 0.0,
    'height': height ?? 0.0,
    'depth': depth ?? 0.0,
  };
}

class Review {
  final int? rating;
  final String? comment;
  final String? date;
  final String? reviewerName;
  final String? reviewerEmail;

  Review({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Review(
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      date: json['date'] ?? '',
      reviewerName: json['reviewerName'] ?? '',
      reviewerEmail: json['reviewerEmail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'rating': rating ?? 0,
    'comment': comment ?? '',
    'date': date ?? '',
    'reviewerName': reviewerName ?? '',
    'reviewerEmail': reviewerEmail ?? '',
  };
}

class Meta {
  final String? createdAt;
  final String? updatedAt;
  final String? barcode;
  final String? qrCode;

  Meta({
    this.createdAt = '',
    this.updatedAt = '',
    this.barcode = '',
    this.qrCode = '',
  });

  factory Meta.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Meta(
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      barcode: json['barcode'] ?? '',
      qrCode: json['qrCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'createdAt': createdAt ?? '',
    'updatedAt': updatedAt ?? '',
    'barcode': barcode ?? '',
    'qrCode': qrCode ?? '',
  };
}
