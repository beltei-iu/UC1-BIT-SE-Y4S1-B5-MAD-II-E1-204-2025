
import 'package:mad_2_204/data/db_manager.dart';
import 'package:mad_2_204/models/product.dart';

class ProductService {

  Future<void> insertProduct(Product product) async{
    final db = await DBManager.instance.database;
    await db.insert("tbl_product", product.toMap());
  }

  Future<List<Product>> getProducts() async{
    final db = await DBManager.instance.database;
    final products = await db.query("tbl_product");
    return products.map((e) => Product.fromMap(e)).toList();
  }
}