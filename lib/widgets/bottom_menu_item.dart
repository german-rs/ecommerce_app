import 'package:ecommerce_app/bloc/ecommerce_bloc.dart';
import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomMenuItem extends StatelessWidget {
  final Function() onTap;
  final bool isActive;
  final String title;
  final IconData icon;
  final bool isCartItem;

  const BottomMenuItem({
    super.key,
    required this.onTap,
    required this.isActive,
    required this.title,
    required this.icon,
    this.isCartItem = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Icon(
                icon,
                color: isActive ? AppColor.green : AppColor.black,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          if (isCartItem)
            BlocBuilder<EcommerceBloc, EcommerceState>(
              builder: (context, state) {
                if (state.cart.isEmpty) {
                  return const SizedBox.shrink();
                }

                final total = state.cart.fold(0, (sum, p) => sum + p.quantity);

                return Positioned(
                  top: -5,
                  right: -5,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppColor.black,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        total.toString(),
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
