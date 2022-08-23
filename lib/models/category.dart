// To parse this JSON data, do
//
//     final client = clientFromMap(jsonString);

import 'dart:convert';

class Category {
  Category({
    this.id,
    this.name,
    this.slug,
    this.parent,
    this.description,
    this.display,
    this.image,
    this.menuOrder,
    this.count,
    this.translations,
    this.lang,
    this.links,
  });

  int? id;
  String? name;
  String? slug;
  int? parent;
  String? description;
  String? display;
  Image? image;
  int? menuOrder;
  int? count;
  Translations? translations;
  String? lang;
  Links? links;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        parent: json["parent"] == null ? null : json["parent"],
        description: json["description"] == null ? null : json["description"],
        display: json["display"] == null ? null : json["display"],
        image: json["image"] == null ? null : Image.fromMap(json["image"]),
        menuOrder: json["menu_order"] == null ? null : json["menu_order"],
        count: json["count"] == null ? null : json["count"],
        translations: json["translations"] == null
            ? null
            : Translations.fromMap(json["translations"]),
        lang: json["lang"] == null ? null : json["lang"],
        links: json["_links"] == null ? null : Links.fromMap(json["_links"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "parent": parent == null ? null : parent,
        "description": description == null ? null : description,
        "display": display == null ? null : display,
        "image": image == null ? null : image!.toMap(),
        "menu_order": menuOrder == null ? null : menuOrder,
        "count": count == null ? null : count,
        "translations": translations == null ? null : translations!.toMap(),
        "lang": lang == null ? null : lang,
        "_links": links == null ? null : links!.toMap(),
      };
}

class Image {
  Image({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.src,
    this.name,
    this.alt,
  });

  int? id;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  String? src;
  String? name;
  String? alt;

  factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Image.fromMap(Map<String, dynamic> json) => Image(
        id: json["id"] == null ? null : json["id"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        dateCreatedGmt: json["date_created_gmt"] == null
            ? null
            : DateTime.parse(json["date_created_gmt"]),
        dateModified: json["date_modified"] == null
            ? null
            : DateTime.parse(json["date_modified"]),
        dateModifiedGmt: json["date_modified_gmt"] == null
            ? null
            : DateTime.parse(json["date_modified_gmt"]),
        src: json["src"] == null ? null : json["src"],
        name: json["name"] == null ? null : json["name"],
        alt: json["alt"] == null ? null : json["alt"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "date_created": dateCreated == null ? null : dateCreated.toString(),
        "date_created_gmt":
            dateCreatedGmt == null ? null : dateCreatedGmt.toString(),
        "date_modified": dateModified == null ? null : dateModified.toString(),
        "date_modified_gmt":
            dateModifiedGmt == null ? null : dateModifiedGmt.toString(),
        "src": src == null ? null : src,
        "name": name == null ? null : name,
        "alt": alt == null ? null : alt,
      };
}

class Links {
  Links({
    this.self,
    this.collection,
  });

  List<Collection>? self;
  List<Collection>? collection;

  factory Links.fromJson(String str) => Links.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Links.fromMap(Map<String, dynamic> json) => Links(
        self: json["self"] == null
            ? null
            : List<Collection>.from(
                json["self"].map((x) => Collection.fromMap(x))),
        collection: json["collection"] == null
            ? null
            : List<Collection>.from(
                json["collection"].map((x) => Collection.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "self": self == null
            ? null
            : List<dynamic>.from(self!.map((x) => x.toMap())),
        "collection": collection == null
            ? null
            : List<dynamic>.from(collection!.map((x) => x.toMap())),
      };
}

class Collection {
  Collection({
    this.href,
  });

  String? href;

  factory Collection.fromJson(String str) =>
      Collection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Collection.fromMap(Map<String, dynamic> json) => Collection(
        href: json["href"] == null ? null : json["href"],
      );

  Map<String, dynamic> toMap() => {
        "href": href == null ? null : href,
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
        en: json["en"].toString(),
        ar: json["ar"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "en": en,
        "ar": ar,
      };
}
