class HomeModel{
   bool? status;
   late HomeModelData data;

  HomeModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = HomeModelData.fromJson(json['data']);
  }
}

class HomeModelData{
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeModelData.fromJson(Map<String,dynamic> json){
    json['banners'].forEach((element){
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element){
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel{
  late int id ;
  late String image;

  BannerModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel{
   int? id;
   dynamic price;
   dynamic old_price;
   dynamic discount;
   String? image;
   String? name;
   bool? in_favorites;
   bool? in_cart;

  ProductModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }

}