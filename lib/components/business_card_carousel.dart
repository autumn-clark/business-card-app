import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/business_card.dart';
import 'package:flutter_application_1/models/card.dart';

class BusinessCardCarousel extends StatelessWidget {
  final List<BusinessCardModel> cards;
  final Function onCardUpdated;

  const BusinessCardCarousel({
    Key? key,
    required this.cards,
    required this.onCardUpdated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentPage = 0;

    return Column(
      children: [
        CarouselSlider(
          items: [
            ...cards.map((card) => BusinessCard(
              cardData: card,
              onCardUpdated: () => onCardUpdated(),
            )),
            EmptyCard(
              onCardAdded: () => onCardUpdated(),
            ),
          ],
          options: CarouselOptions(
            initialPage: 0,
            autoPlay: false,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            enableInfiniteScroll: true,
            onPageChanged: (value, _) {
              currentPage = value;
            },
          ),
        ),
        buildCarouselIndicator(cards.length, currentPage),
      ],
    );
  }

  Widget buildCarouselIndicator(int length, int currentPage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length + 1, (i) {
        return Container(
          margin: const EdgeInsets.all(5),
          height: i == currentPage ? 7 : 5,
          width: i == currentPage ? 7 : 5,
          decoration: BoxDecoration(
            color: i == currentPage ? Colors.black : Colors.black26,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
