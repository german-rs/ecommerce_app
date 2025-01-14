import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/widgets/product_form.dart';

class AddProductView extends StatefulWidget {
  final ProductModel? product;

  const AddProductView({super.key, this.product});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.product != null ? "Editar Producto" : "Nuevo Producto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProductForm(product: widget.product),
      ),
    );
  }
}



// https://picsum.photos/250?image=2
// https://picsum.photos/250?image=3
// https://picsum.photos/250?image=4
// https://picsum.photos/250?image=5
// https://picsum.photos/250?image=6
// https://picsum.photos/250?image=7