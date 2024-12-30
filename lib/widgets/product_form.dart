import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/bloc/ecommerce_bloc.dart';

class ProductForm extends StatefulWidget {
  final ProductModel? product;

  const ProductForm({super.key, this.product});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _descriptionController.text = widget.product!.name;
      _imageUrlController.text = widget.product!.imageUrl;
      _priceController.text = widget.product!.price.toString();
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final description = _descriptionController.text;
      final imageUrl = _imageUrlController.text;
      final price = double.parse(_priceController.text);

      if (widget.product != null) {
        // Editar producto existente
        final editedProduct = widget.product!.copyWith(
          name: description,
          imageUrl: imageUrl,
          price: price,
        );
        context.read<EcommerceBloc>().add(
              UpdateCatalogProductEvent(product: editedProduct),
            );
      } else {
        // Crear nuevo producto
        context.read<EcommerceBloc>().add(
              CreateNewProductEvent(
                description: description,
                imageUrl: imageUrl,
                price: price,
              ),
            );
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Descripción del Producto',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una descripción';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _imageUrlController,
            decoration: const InputDecoration(
              labelText: 'URL de la Imagen',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un URL de imagen';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _priceController,
            decoration: const InputDecoration(
              labelText: 'Precio',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un precio';
              }
              if (double.tryParse(value) == null) {
                return 'Por favor ingrese un número válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text(widget.product != null
                ? 'Actualizar Producto'
                : 'Agregar Producto'),
          ),
        ],
      ),
    );
  }
}
