import 'package:ecommerce_app/bloc/ecommerce_bloc.dart';
import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_product_view.dart';

class CatalogView extends StatelessWidget {
  const CatalogView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<EcommerceBloc>()..add(LoadCatalogProductsEvent()),
      child: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catalog Page"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddProductView();
          }));
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<EcommerceBloc, EcommerceState>(
        builder: (context, state) {
          if (state.catalogScreenState == CatalogScreenState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.catalogProducts.isEmpty) {
            return const Center(
              child: Text("Aun no hay productos agregados."),
            );
          }

          return ListView.builder(
            itemCount: state.catalogProducts.length,
            itemBuilder: (context, index) {
              final catalogProd = state.catalogProducts[index];
              return ListTile(
                title: Text(catalogProd.name),
                subtitle: Text("\$${catalogProd.price}"),
                trailing: Image.network(catalogProd.imageUrl),
                leading: IconButton(
                  onPressed: () {
                    context.read<EcommerceBloc>().add(
                          DeleteCatalogProductEvent(product: catalogProd),
                        );
                  },
                  icon: Icon(Icons.delete, color: AppColor.red),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddProductView(product: catalogProd);
                  }));
                },
              );
            },
          );
        },
      ),
    );
  }
}
