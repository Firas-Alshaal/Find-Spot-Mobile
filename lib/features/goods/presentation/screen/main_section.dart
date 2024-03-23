import 'package:flutter/material.dart';
import 'package:lost_find_tracker/core/utils/constant.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/homeItem.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/home_page_item.dart';

class GridDashboard extends StatelessWidget {
  GridDashboard({super.key});

  Items item1 = Items(
      title: "Lost Items",
      subtitle: "You lost things!\nAdd it",
      img: "assets/images/calendar.png",
      route: Constants.LostItemScreen);
  Items item2 = Items(
      title: "Found Items",
      subtitle: "You found things!\nAdd it",
      img: "assets/images/food.png",
      route: Constants.FoundItemScreen);
  Items item3 = Items(
      title: "Add Found",
      subtitle: "Add what you found",
      img: "assets/images/todo.png",
      route: Constants.AddFoundScreen);
  Items item4 = Items(
      title: "Add Lost",
      subtitle: "Add what you lost",
      img: "assets/images/festival.png",
      route: Constants.AddLostScreen);
  Items item5 = Items(
      title: "Locations",
      subtitle: "Check what you lost and found",
      img: "assets/images/map.png",
      route: Constants.LocationScreen);
  Items item6 = Items(
      title: "Search Item",
      subtitle: "search specific item you need",
      img: "assets/images/setting.png",
      route: Constants.SearchScreen);

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    return GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 40,
        children: myList.map((data) {
          return MainSectionWidget(
            data: data,
          );
        }).toList());
  }
}
