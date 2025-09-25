import 'package:mygarja/core/asset_constants.dart' as asset;
import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  String discount, heading, subtitle, url;
  CarouselCard(this.discount, this.heading, this.subtitle, this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180, // Reduced height to prevent overflow
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage(
                url,
              ),
              alignment: Alignment.centerRight,
              fit: BoxFit.fitHeight)),
      child: Stack(
        children: [
          Container(
            width: 180, // Reduced width
            padding: const EdgeInsets.symmetric(vertical: 15), // Reduced vertical padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  discount,
                  style: asset.introStyles(30), // Reduced font size
                ),
                Text(
                  heading,
                  style: asset.introStyles(20), // Reduced font size
                ),
                Text(subtitle, style: asset.introStyles(14)), // Reduced font size
              ],
            ),
            alignment: Alignment.centerLeft,
          ),
        ],
      ),
    );
    
  }
}
