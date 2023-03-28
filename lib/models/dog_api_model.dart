import 'dart:ui';

class DogBreed {
  DogBreed({
    this.altNames,
    this.experimental,
    this.hairless,
    this.hypoallergenic,
    this.id,
    this.lifeSpan,
    required this.name,
    this.natural,
    this.origin,
    this.rare,
    this.referenceImageId,
    this.rex,
    this.shortLegs,
    this.suppressedTail,
    this.temperament,
    this.weightImperial,
    this.wikipediaUrl,
    this.image,
    this.description,
  });

  String? altNames;
  int? experimental;
  int? hairless;
  int? hypoallergenic;
  int? id;
  String? lifeSpan;
  String name;
  int? natural;
  String? origin;
  int? rare;
  dynamic referenceImageId;
  int? rex;
  int? shortLegs;
  int? suppressedTail;
  String? temperament;
  String? weightImperial;
  String? wikipediaUrl;
  Image? image;
  String? description;

  factory DogBreed.fromJson(Map<String, dynamic> json) => DogBreed(
        altNames: json["alt_names"],
        experimental: json["experimental"],
        hairless: json["hairless"],
        hypoallergenic: json["hypoallergenic"],
        id: json["id"],
        lifeSpan: json["life_span"],
        name: json["name"],
        natural: json["natural"],
        origin: json["origin"],
        rare: json["rare"],
        referenceImageId: json["reference_image_id"],
        rex: json["rex"],
        shortLegs: json["short_legs"],
        suppressedTail: json["suppressed_tail"],
        temperament: json["temperament"],
        weightImperial: json["weight_imperial"],
        wikipediaUrl: json["wikipedia_url"],
        image: Image.fromJson(json["image"]),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "alt_names": altNames,
        "experimental": experimental,
        "hairless": hairless,
        "hypoallergenic": hypoallergenic,
        "id": id,
        "life_span": lifeSpan,
        "name": name,
        "natural": natural,
        "origin": origin,
        "rare": rare,
        "reference_image_id": referenceImageId,
        "rex": rex,
        "short_legs": shortLegs,
        "suppressed_tail": suppressedTail,
        "temperament": temperament,
        "weight_imperial": weightImperial,
        "wikipedia_url": wikipediaUrl,
        "image": image!.toJson(),
        "description": description,
      };
}

class Image {
  Image({
    this.id,
    this.width,
    this.height,
    this.url,
  });

  String? id;
  int? width;
  int? height;
  String? url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "width": width,
        "height": height,
        "url": url,
      };
}
