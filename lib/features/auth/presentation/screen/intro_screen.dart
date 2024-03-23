import 'package:flutter/material.dart';
import 'package:lost_find_tracker/core/utils/assets.dart';
import 'package:lost_find_tracker/core/utils/constant.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';
import 'package:lost_find_tracker/features/auth/domain/entities/on_boarding.dart';
import 'package:lost_find_tracker/features/auth/presentation/widget/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../injection_container.dart' as di;

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _current = 0;

  late List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(Images.lostItem, 'Lost & Found',
        'Join the quest to reunite lost treasures with their owners, as we explore neighborhoods and unravel mysteries together.'),
    OnBoardingModel(Images.foundItem, 'Discover & Return',
        'Embark on a journey of unexpected finds, where each discovery leads to a heartwarming reunion with its rightful owner.'),
    OnBoardingModel(Images.searchOnMap, 'Explore & Navigate',
        'Chart your course through the unknown, as we map out adventures to uncover hidden treasures and create memorable experiences.')
  ];

  var sharedPrefrence;

  @override
  void initState() {
    super.initState();
    sharedPrefrence = di.sl<SharedPreferences>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsFave.whiteColor,
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: PageView.builder(
              itemCount: onBoardingList.length,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      color: ColorsFave.whiteColor,
                      image: DecorationImage(
                          image: AssetImage(onBoardingList[index].imageUrl),
                          fit: BoxFit.contain)),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.08),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(120))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(onBoardingList[_current].title,
                        style: const TextStyle(fontSize: 25)),
                    Text(
                      onBoardingList[_current].description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: ColorsFave.blackColor,
                          height: 1.5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_current < 2)
                          Row(
                            children: [1, 2, 3].asMap().entries.map((entry) {
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorsFave.primaryColor.withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                              );
                            }).toList(),
                          ),
                        ButtonApp(
                          text: _current == 2 ? 'Finish' : 'Next',
                          onPressed: () {
                            setState(() {
                              if (_current < 2) {
                                _current++;
                              } else {
                                sharedPrefrence.setBool(
                                    Constants.OnBoarding, false);
                                Navigator.pushReplacementNamed(
                                    context, Constants.LoginScreen);
                              }
                            });
                          },
                          width: _current == 2
                              ? MediaQuery.of(context).size.width -
                                  MediaQuery.of(context).size.width * 0.16
                              : MediaQuery.of(context).size.width * 0.4,
                        )
                      ],
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
