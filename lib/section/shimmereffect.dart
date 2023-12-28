import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffectimagename extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 6, // Number of shimmer items
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8),
          color: Colors.white,
          width: 200,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  color: Colors.white,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 15,
                        width: 150,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 12,
                        width: 80,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
