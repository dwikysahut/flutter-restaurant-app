import 'package:flutter/material.dart';
import 'package:resto_app/model/restaurant.dart';
import 'package:resto_app/utils/Colors.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.bg, // Background color
      statusBarIconBrightness: Brightness.light, // Icon color
    ));

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.main,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderText(),
              Expanded(
                child: FutureBuilder<String>(
                  future: DefaultAssetBundle.of(context)
                      .loadString('lib/data/local_restaurant.json'),
                  builder: (context, snapshot) {
                    final List<Restaurant> restaurants =
                        parseRestaurants(snapshot.data);

                    return ListView.builder(
                      itemCount: restaurants.length,
                      itemBuilder: (context, index) {
                        return _buildRestaurantItem(
                            context, restaurants[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 8.0,
      ),
      leading: Hero(
        tag: restaurant.pictureId,
        child: Image.network(
          restaurant.pictureId,
          width: 100,
        ),
      ),
      title: Text(restaurant.name),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 3,
        ),
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Icon(
            Icons.pin_drop,
            color: Colors.grey,
            size: 12.0,
          ),
          const SizedBox(width: 2),
          Text(
            restaurant.city,
            style: const TextStyle(fontSize: 12),
          ),
        ]),
        const SizedBox(height: 4),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(
            Icons.star,
            color: AppColors.accentColor,
            size: 11.0,
          ),
          const SizedBox(width: 2),
          Text(
            restaurant.rating.toString(),
            style: const TextStyle(fontSize: 10),
          ),
        ])
      ]),
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: restaurant);
      },
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(
            height: 20,
          ),
          Text(
            "Restaurant",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w300,
            ),
            // Adjusted for visibility
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Recommendation restaurant for you!",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          SizedBox(
            height: 12,
          ),
          // Additional content
        ]);
  }
}
