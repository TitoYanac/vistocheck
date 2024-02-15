import 'dart:ui';

import 'package:flutter/material.dart';

class BannerEventAppBar extends StatefulWidget {
  const BannerEventAppBar({super.key, required this.title});

  final String title;

  @override
  State<BannerEventAppBar> createState() => _BannerEventAppBarState();
}

class _BannerEventAppBarState extends State<BannerEventAppBar> {
  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    double expandedFontSize = (32 / 390) * pageWidth;
    double collapsedFontSize = 20;
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.black,
      expandedHeight: MediaQuery.of(context).size.width*(135/390),
      shadowColor: Colors.transparent,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Calcular el tamaño de la fuente basado en la altura actual
          double currentHeight = constraints.biggest.height;
          double availableHeight = MediaQuery.of(context).size.width*(135/390);
          double fraction = (currentHeight - kToolbarHeight) /
              (availableHeight - kToolbarHeight);
          double fontSize = lerpDouble(collapsedFontSize, expandedFontSize, fraction)!;

          return FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(
              top: fontSize-4,
              left: (MediaQuery.of(context).size.width - 620) > 0
                  ? ((MediaQuery.of(context).size.width - 620) / 2)
                  : 20,
              bottom: fontSize-4,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                const Image(
                  image: AssetImage('assets/images/bannerEvent1.png'),
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.black, Colors.transparent],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
