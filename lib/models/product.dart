

class Product {
  int? id;
  String? name;
  double? price;
  int? quantity;

  Product({this.id, this.name, this.price, this.quantity});

  Map<String,dynamic> toMap() {
    return {
      'id':id,
      'name':name,
      'price':price,
      'quantity':quantity
    };
  }


  factory Product.fromMap(Map<String,dynamic> map){
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      quantity: map['quantity']
    );
  }

}