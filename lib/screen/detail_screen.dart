import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:resto_app/model/restaurant.dart';
import 'package:resto_app/utils/Colors.dart';

class DetailScreen extends StatelessWidget {
  final Restaurant restaurant;

  const DetailScreen({Key? key, required this.restaurant}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FloatingTitle(restaurant: restaurant),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: AppColors.bg,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 12.0,
                          ),
                          Text(
                            restaurant.rating.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      restaurant.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: AppColors.bg,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.restaurant_menu_outlined,
                            color: Colors.orange,
                            size: 12.0,
                          ),
                          Text(
                            'Menu',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 120,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
              child: ListView.builder(
                itemCount: restaurant.menus.foods.length,
                itemBuilder: (context, index) {
                  final restaurantItem = restaurant.menus.foods;
                  return MenuItem<Food>(
                    restaurant: restaurant,
                    restaurantItem: restaurantItem,
                    index: index,
                  );
                },
                // This next line does the trick.
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 120,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
              child: ListView.builder(
                itemCount: restaurant.menus.drinks.length,
                itemBuilder: (context, index) {
                  final restaurantItem = restaurant.menus.drinks;
                  return MenuItem<Food>(
                    restaurant: restaurant,
                    restaurantItem: restaurantItem,
                    index: index,
                  );
                },
                // This next line does the trick.
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem<T> extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.restaurant,
    required this.restaurantItem,
    required this.index,
  });

  final Restaurant restaurant;
  final List<Food> restaurantItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16.0),
      width: 160,
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      height: 120,
      child: Stack(
        children: [
          // Gambar dengan Hero untuk animasi
          Positioned(
            right: 30,
            top: 15,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Icon(
                Icons.menu_book,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          // Kotak di atas gambar
          Positioned(
            bottom: 2, // Posisi atas dari kotak
            left: 8, // Posisi kiri dari kotak
            right: 8, //
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurantItem[index].name.toString(),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("Rp.15.000"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FloatingTitle extends StatelessWidget {
  const FloatingTitle({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gambar dengan Hero untuk animasi
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Hero(
            tag: restaurant.pictureId,
            child: Image.network(
              restaurant.pictureId,
              fit: BoxFit.cover,
              width: double.infinity, // Ensure the image takes full width
              height: 250, // Set a fixed height for the image
            ),
          ),
        ),
        // Kotak di atas gambar
        Positioned(
          bottom: 10, // Posisi atas dari kotak
          left: 12, // Posisi kiri dari kotak
          right: 12, // Posisi kanan dari kotak
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.pin_drop,
                      color: Colors.grey,
                      size: 12.0,
                    ),
                    Text(restaurant.city),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
