import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/constants/strings/paths.dart';
import 'package:grounded/screens/parent/login_parent.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Intro extends StatefulWidget {
  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _introScreens = [
      _buildIntroScreens(
          currentPosition: 0.0,
          title: 'Assign Tasks To Your Kids Remotely',
          subTitle: "Give your kids assignments to do while you're away",
          sliderImage: 'intro_1.png'),
      _buildIntroScreens(
          currentPosition: 1.0,
          title: 'Monitor And Track Thier Progress',
          subTitle:
              'With Grounded you can monitor and track thier progress with ease',
          sliderImage: 'intro_2.png'),
    ];

    return CustomScaffold(
      bubblePosition: BackgroundBubblePosition.topRight,
      body: CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height,
          autoPlay: true,
          viewportFraction: 1.0,
          initialPage: 0,
          autoPlayInterval: const Duration(seconds: 5),
          scrollDirection: Axis.horizontal,
        ),
        items: _introScreens,
      ),
    );
  }

  Widget _buildSlideDots({required List<Widget> widgets}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widgets,
      ),
    );
  }

  Widget _buildIntroScreens({
    required double currentPosition,
    required String title,
    required String subTitle,
    required String sliderImage,
  }) {
    return SafeArea(
      child: Stack(
        children: [
          Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
              child: Image.asset("${imagePath}intro/$sliderImage",
                  height: 400, width: 500),
            ),
            const Spacer(),
            Container(
                decoration: const BoxDecoration(
                    color: ThemeColors.primary,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                height: 320,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 40),
                      child: Text(title,
                          style: TextStyles.extraBold.copyWith(
                              fontSize: 26, color: ThemeColors.lightElement)),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          const EdgeInsets.only(left: 25, right: 40, top: 15),
                      child: Text(subTitle,
                          style: TextStyles.regular.copyWith(
                              fontSize: 16,
                              color:
                                  ThemeColors.lightElement.withOpacity(0.5))),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, bottom: 25),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 23),
                            child: _buildSlideDots(widgets: [
                              DotsIndicator(
                                  position: currentPosition,
                                  dotsCount: 5,
                                  decorator: const DotsDecorator(
                                      spacing: EdgeInsets.all(3.0),
                                      color: ThemeColors.lightElement,
                                      activeColor:
                                          Color.fromRGBO(255, 159, 36, 1)))
                            ]),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: _openLoginScreen,
                            child: Text('Next \u279C',
                                style: TextStyles.regular
                                    .copyWith(color: ThemeColors.lightElement)),
                          )
                        ],
                      ),
                    )
                  ],
                ))
          ]),
        ],
      ),
    );
  }

  void _openLoginScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginParent()));
  }
}
