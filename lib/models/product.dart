import 'dart:convert';
import '../models/category.dart';

List<Product> productFromJson(List<dynamic> str) {
  List<Product> products = [];
  for (var element in str) {
    products.add(Product.fromJson(element));
  }
  return products;
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.permalink,
    required this.type,
    required this.status,
    required this.featured,
    required this.catalogVisibility,
    required this.description,
    required this.shortDescription,
    required this.sku,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.onSale,
    required this.purchasable,
    required this.totalSales,
    required this.virtual,
    required this.externalUrl,
    required this.taxStatus,
    required this.taxClass,
    required this.manageStock,
    required this.stockQuantity,
    required this.backorders,
    required this.backordersAllowed,
    required this.backordered,
    required this.lowStockAmount,
    required this.soldIndividually,
    required this.weight,
    required this.dimensions,
    required this.shippingRequired,
    required this.shippingTaxable,
    required this.shippingClass,
    required this.shippingClassId,
    required this.reviewsAllowed,
    required this.averageRating,
    required this.ratingCount,
    required this.parentId,
    required this.purchaseNote,
    required this.categories,
    required this.tags,
    required this.images,
    required this.attributes,
    required this.defaultAttributes,
    required this.variations,
    required this.groupedProducts,
    required this.menuOrder,
    required this.priceHtml,
    required this.relatedIds,
    required this.stockStatus,
    required this.translations,
    required this.metaData,
    required this.lang,
  });

  int id;
  String name;
  String slug;
  String permalink;
  String type;
  String status;
  bool featured;
  String catalogVisibility;
  String description;
  String shortDescription;
  String sku;
  String price;
  String regularPrice;
  String salePrice;
  bool onSale;
  bool purchasable;
  int totalSales;
  bool virtual;
  String externalUrl;
  String taxStatus;
  String taxClass;
  bool manageStock;
  int? stockQuantity;
  String backorders;
  bool backordersAllowed;
  bool backordered;
  dynamic lowStockAmount;
  bool soldIndividually;
  String weight;
  Dimensions dimensions;
  bool shippingRequired;
  bool shippingTaxable;
  String shippingClass;
  int shippingClassId;
  bool reviewsAllowed;
  String averageRating;
  int ratingCount;
  int parentId;
  String purchaseNote;
  List<Category> categories;
  List<dynamic> tags;
  List<ImageData> images;
  List<Attribute> attributes;
  List<dynamic> defaultAttributes;
  List<dynamic> variations;
  List<dynamic> groupedProducts;
  int menuOrder;
  String priceHtml;
  List<int> relatedIds;
  String stockStatus;
  Translations translations;
  List<MetaDatum> metaData;
  String lang;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        permalink: json["permalink"],
        type: json["type"],
        status: json["status"],
        featured: json["featured"],
        catalogVisibility: json["catalog_visibility"],
        description: json["description"],
        shortDescription: json["short_description"],
        sku: json["sku"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        onSale: json["on_sale"],
        purchasable: json["purchasable"],
        totalSales: json["total_sales"],
        virtual: json["virtual"],
        metaData: List<MetaDatum>.from(
            json["meta_data"].map((x) => MetaDatum.fromMap(x))),
        externalUrl: json["external_url"],
        taxStatus: json["tax_status"],
        taxClass: json["tax_class"],
        manageStock: json["manage_stock"],
        stockQuantity: json["stock_quantity"],
        backorders: json["backorders"],
        backordersAllowed: json["backorders_allowed"],
        backordered: json["backordered"],
        lowStockAmount: json["low_stock_amount"],
        soldIndividually: json["sold_individually"],
        weight: json["weight"],
        dimensions: Dimensions.fromMap(json["dimensions"]),
        shippingRequired: json["shipping_required"],
        shippingTaxable: json["shipping_taxable"],
        shippingClass: json["shipping_class"],
        shippingClassId: json["shipping_class_id"],
        reviewsAllowed: json["reviews_allowed"],
        averageRating: json["average_rating"],
        ratingCount: json["rating_count"],
        parentId: json["parent_id"],
        purchaseNote: json["purchase_note"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromMap(x))),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        images: List<ImageData>.from(
            json["images"].map((x) => ImageData.fromMap(x))),
        attributes: List<Attribute>.from(
            json["attributes"].map((x) => Attribute.fromMap(x))),
        defaultAttributes:
            List<dynamic>.from(json["default_attributes"].map((x) => x)),
        variations: List<dynamic>.from(json["variations"].map((x) => x)),
        groupedProducts:
            List<dynamic>.from(json["grouped_products"].map((x) => x)),
        menuOrder: json["menu_order"],
        priceHtml: json["price_html"],
        relatedIds: List<int>.from(json["related_ids"].map((x) => x)),
        stockStatus: json["stock_status"] ?? "0",
        translations: Translations.fromMap(json["translations"]),
        lang: json["lang"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "permalink": permalink,
        "type": type,
        "status": status,
        "featured": featured,
        "catalog_visibility": catalogVisibility,
        "description": description,
        "short_description": shortDescription,
        "sku": sku,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "on_sale": onSale,
        "purchasable": purchasable,
        "total_sales": totalSales,
        "virtual": virtual,
        "external_url": externalUrl,
        "tax_status": taxStatus,
        "tax_class": taxClass,
        "manage_stock": manageStock,
        "stock_quantity": stockQuantity,
        "backorders": backorders,
        "backorders_allowed": backordersAllowed,
        "backordered": backordered,
        "low_stock_amount": lowStockAmount,
        "sold_individually": soldIndividually,
        "weight": weight,
        "dimensions": dimensions.toMap(),
        "shipping_required": shippingRequired,
        "shipping_taxable": shippingTaxable,
        "shipping_class": shippingClass,
        "shipping_class_id": shippingClassId,
        "reviews_allowed": reviewsAllowed,
        "average_rating": averageRating,
        "rating_count": ratingCount,
        "parent_id": parentId,
        "purchase_note": purchaseNote,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "images": List<dynamic>.from(images.map((x) => x.toMap())),
        "attributes": List<dynamic>.from(attributes.map((x) => x.toMap())),
        "default_attributes":
            List<dynamic>.from(defaultAttributes.map((x) => x)),
        "variations": List<dynamic>.from(variations.map((x) => x)),
        "grouped_products": List<dynamic>.from(groupedProducts.map((x) => x)),
        "menu_order": menuOrder,
        "price_html": priceHtml,
        "related_ids": List<dynamic>.from(relatedIds.map((x) => x)),
        "meta_data": List<dynamic>.from(metaData.map((x) => x.toMap())),
        "stock_status": stockStatus,
        "meta_data": List<dynamic>.from(metaData.map((x) => x.toMap())),
        "translations": translations.toMap(),
        "lang": lang,
      };
}

class Attribute {
  Attribute({
    required this.id,
    required this.name,
    required this.position,
    required this.visible,
    required this.variation,
    required this.options,
  });

  int id;
  String name;

  @override
  String toString() {
    return toJson();
  }

  int position;
  bool visible;
  bool variation;
  List<String> options;

  factory Attribute.fromJson(String str) => Attribute.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Attribute.fromMap(Map<String, dynamic> json) => Attribute(
        id: json["id"],
        name: json["name"],
        position: json["position"],
        visible: json["visible"],
        variation: json["variation"],
        options: List<String>.from(json["options"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "position": position,
        "visible": visible,
        "variation": variation,
        "options": List<dynamic>.from(options.map((x) => x)),
      };
}

class Dimensions {
  Dimensions({
    required this.length,
    required this.width,
    required this.height,
  });

  String length;
  String width;
  String height;

  factory Dimensions.fromJson(String str) =>
      Dimensions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Dimensions.fromMap(Map<String, dynamic> json) => Dimensions(
        length: json["length"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toMap() => {
        "length": length,
        "width": width,
        "height": height,
      };
}

class ImageData {
  ImageData({
    required this.id,
    required this.dateCreated,
    required this.dateCreatedGmt,
    required this.dateModified,
    required this.dateModifiedGmt,
    required this.src,
    required this.name,
    required this.alt,
  });

  int id;
  DateTime dateCreated;
  DateTime dateCreatedGmt;
  DateTime dateModified;
  DateTime dateModifiedGmt;
  String src;
  String name;
  String alt;

  factory ImageData.fromJson(String str) => ImageData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ImageData.fromMap(Map<String, dynamic> json) => ImageData(
        id: json["id"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        dateModified: DateTime.parse(json["date_modified"]),
        dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
        src: json["src"],
        name: json["name"],
        alt: json["alt"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "date_created": dateCreated.toIso8601String(),
        "date_created_gmt": dateCreatedGmt.toIso8601String(),
        "date_modified": dateModified.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt.toIso8601String(),
        "src": src,
        "name": name,
        "alt": alt,
      };
}

class Collection {
  Collection({
    required this.href,
  });

  String href;

  factory Collection.fromJson(String str) =>
      Collection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Collection.fromMap(Map<String, dynamic> json) => Collection(
        href: json["href"],
      );

  Map<String, dynamic> toMap() => {
        "href": href,
      };
}

class MetaDatum {
  MetaDatum({
    required this.id,
    required this.key,
    required this.value,
  });

  int id;
  String key;
  dynamic value;

  factory MetaDatum.fromJson(String str) => MetaDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MetaDatum.fromMap(Map<String, dynamic> json) => MetaDatum(
        id: json["id"],
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "key": key,
        "value": value,
      };
}

class Translations {
  Translations({
    this.en,
    this.ar,
  });

  String? en;
  String? ar;

  factory Translations.fromJson(String str) =>
      Translations.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Translations.fromMap(Map<String, dynamic> json) => Translations(
        en: json["en"],
        ar: json["ar"],
      );

  Map<String, dynamic> toMap() => {
        "en": en,
        "ar": ar,
      };
}
