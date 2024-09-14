import 'package:flutter/material.dart';
import 'package:shoppingapp/models/dummy_colors_product_images.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    super.key, 
  });

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  final ScrollController _scrollController = ScrollController();
  double itemno = 0;
  bool _isButtonEnabled = true;

  void _onButtonPressed(double scrollwidth, int num) {
    if (!_isButtonEnabled) return;

    setState(() {
      _isButtonEnabled = false;
    });
   

    // Scroll by screen width
    _scrollController.animateTo(
      _scrollController.offset + scrollwidth,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    // Re-enable the button after the animation
    Future.delayed(const Duration(milliseconds: 550), () {
       if (num == 1)
        itemno++;
      else if (itemno > 0) itemno--;
      if (mounted) {
        setState(() {
          _isButtonEnabled = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (context, index) {
            Color color = colors[index % colors.length];
            return Container(
              width: screenWidth,
              decoration: BoxDecoration(
                color: color,
              ),
            );
          },
          scrollDirection: Axis.horizontal,
          itemCount: 10,
        ),
        if (itemno != 0)
          Positioned(
            bottom: 130.0,
            left: 20.0,
            child: SizedBox(
              height: 40,
              width: 40,
              child: FloatingActionButton(
                key: const ValueKey('left_button'),  // Unique key for left button
                splashColor: Colors.white,
                backgroundColor: const Color.fromARGB(150, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: () {
                  _onButtonPressed(-screenWidth, 2);
                },
                child: const Icon(Icons.navigate_before),
              ),
            ),
          ),
        if(itemno != colors.length -1) Positioned(
          bottom: 130.0,
          right: 20.0,
          child: SizedBox(
            height: 40,
            width: 40,
            child: FloatingActionButton(
              key: const ValueKey('right_button'),  // Unique key for right button
              splashColor: Colors.white,
              backgroundColor: const Color.fromARGB(150, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: () {
                _onButtonPressed(screenWidth, 1);
              },
              child: const Icon(Icons.navigate_next),
            ),
          ),
        ),
      ],
    );
  }
}
