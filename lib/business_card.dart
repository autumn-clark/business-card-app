import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class BusinessCard extends StatelessWidget {
  const BusinessCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      color: Colors.black26,
                      height: 80,
                      width: 80,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('М. Төгс-Эрдэм'),
                                Text('График Дизайнер'),
                                Text('Freelancer'),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Row(
                              children: [
                                Text('Fb '),
                                Text('IG '),
                                Text('Ln '),
                                Text('Yt'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('М. Төгс-Эрдэм'),
                        Text('График Дизайнер'),
                        Text('Freelancer'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/cloud.svg',
              width: 150,
              height: 225,
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 50,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }
}
