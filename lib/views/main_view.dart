import 'package:ecommerce_app/views/cart_view.dart';
import 'package:ecommerce_app/views/catalog_view.dart';
import 'package:ecommerce_app/views/home_view.dart';
import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/widgets/bottom_menu_item.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeView(),
    CatalogView(),
    CartView(),
    Center(child: Text("Favorites coming soon")),
    Center(child: Text("Profile coming soon")),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 80,
        color: AppColor.white,
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomMenuItem(
              onTap: () => onItemTapped(0),
              isActive: selectedIndex == 0,
              title: "Home",
              icon: Icons.home,
            ),
            BottomMenuItem(
              onTap: () => onItemTapped(1),
              isActive: selectedIndex == 1,
              title: "Catalog",
              icon: Icons.search,
            ),
            BottomMenuItem(
              onTap: () => onItemTapped(2),
              isActive: selectedIndex == 2,
              isCartItem: true,
              title: "Cart",
              icon: Icons.shopping_bag_outlined,
            ),
            BottomMenuItem(
              onTap: () => onItemTapped(3),
              isActive: selectedIndex == 3,
              title: "Favorite",
              icon: Icons.favorite_border,
            ),
            BottomMenuItem(
              onTap: () => onItemTapped(4),
              isActive: selectedIndex == 4,
              title: "Profile",
              icon: Icons.person,
            ),
          ],
        ),
      ),
    );
  }
}
