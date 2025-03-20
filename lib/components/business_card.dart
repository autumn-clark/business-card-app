import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BusinessCard extends StatelessWidget {
  const BusinessCard({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          width: screenWidth - 50,
          child: Card(
            elevation: 8,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container( //logo or avatar
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            color: Colors.black26,
                            height: 80,
                            width: 80,
                          ),
                          Expanded( //main info and social links
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
                      Row( //contact information
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
                Positioned( //
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
            ), // Adjust the number (20) to your preference
          ),
        ),
      ],
    );
  }
}

class EmptyCard extends StatelessWidget {
  const EmptyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 3,
      child: InkWell(
        onTap: (){},
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 200, // Adjust height as needed
          width: double.infinity, // Takes full width
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[500], // Light grey background
          ),
          child: Center(
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blueAccent, // Button color
              child: Icon(Icons.add, size: 40, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
