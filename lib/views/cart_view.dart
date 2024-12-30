import 'package:ecommerce_app/bloc/ecommerce_bloc.dart';
import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/widgets/app_primary_button.dart';
import 'package:ecommerce_app/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<EcommerceBloc>()..add(LoadCartItemsEvent()),
      child: const CartBody(),
    );
  }
}

class CartBody extends StatelessWidget {
  const CartBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Cart",
          style: TextStyle(
            color: AppColor.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            color: AppColor.black,
            focusColor: AppColor.greyBackground,
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      bottomNavigationBar: BlocBuilder<EcommerceBloc, EcommerceState>(
        builder: (context, state) {
          if (state.cart.isEmpty) {
            return const SizedBox.shrink();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: AppPrimaryButton(
              onTap: () {},
              text: 'Checkout',
            ),
          );
        },
      ),
      body: BlocBuilder<EcommerceBloc, EcommerceState>(
        builder: (context, state) {
          if (state.cart.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Sin productos agregados al carrito de compra",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: state.cart.length,
            itemBuilder: (context, index) {
              final product = state.cart[index];
              return CartItem(product: product);
            },
          );
        },
      ),
    );
  }
}
