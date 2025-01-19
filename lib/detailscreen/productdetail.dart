import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:r12shopprovider/firebase/firebasecart.dart';

class productdetail extends StatefulWidget {
  List productdetails;
  String herokey;

  productdetail(
      {super.key, required this.herokey, required this.productdetails});

  @override
  State<productdetail> createState() => _productdetailState();
}

class _productdetailState extends State<productdetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.productdetails[0]['images']);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                expandedHeight: 300,
                pinned: true,
                backgroundColor: Colors.orange[300],
                flexibleSpace: FlexibleSpaceBar(
                    title: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        widget.productdetails[0]['title'].toString(),
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    background: Hero(
                        tag: widget.herokey,
                        child: Container(
                          child: CarouselSlider.builder(
                            itemCount:
                                widget.productdetails[0]['images'].length - 1,
                            itemBuilder: (context, index, realIndex) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.200),
                                        BlendMode.darken),
                                    image: NetworkImage(widget.productdetails[0]
                                            ['images'][index]
                                        .toString()),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              height: 335,
                              viewportFraction: 1,
                              autoPlay: true,
                              autoPlayInterval: Duration(milliseconds: 2000),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              pauseAutoPlayOnTouch: true,
                              aspectRatio: 2.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  // _current = index;
                                });
                              },
                            ),
                          ),
                        )))),
            // Existing code...

            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productdetails[0]['title'].toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        widget.productdetails[0]['description'].toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            "Price: ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " \{" +
                                widget.productdetails[0]['price'].toString() +
                                "\}",
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          //discountprice
                          Text(
                            widget.productdetails[0]['discountPercentage']
                                    .toString() +
                                "%",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            "Rating: ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          SizedBox(width: 4),
                          Text(
                            widget.productdetails[0]['rating'].toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            "Brand: ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.productdetails[0]['brand'].toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Additional UI elements for enhanced design
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200],
                        ),
                        child: Center(
                          child: CarouselSlider.builder(
                              itemCount:
                                  widget.productdetails[0]["images"].length - 1,
                              itemBuilder: (context, index, realIndex) {
                                return Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.200),
                                          BlendMode.darken),
                                      image: NetworkImage(widget
                                          .productdetails[0]['images'][index]
                                          .toString()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                height: 200,
                                viewportFraction: 1,
                                autoPlay: false,
                                autoPlayInterval: Duration(milliseconds: 2000),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                pauseAutoPlayOnTouch: true,
                                aspectRatio: 2.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    // _current = index;
                                  });
                                },
                              )),
                        ),
                        //  child: CarouselSlider.builder(itemCount: 4, itemBuilder:  , options: options),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Customer Reviews",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text(
                          "John Doe",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.yellow,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "4.5",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Great product! Highly recommended.",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text(
                          "Jane Smith",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.yellow,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "5.0",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Excellent quality. Will buy again.",
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 60),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),

            // Remaining code...
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: -10,
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[500],
                    ),
                    onPressed: () {
                      // Buy Now action
                    },
                    child:
                        Text("Buy Now", style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      addToCart(
                          widget.productdetails[0]["title"].toString(),
                          widget.productdetails[0]["price"].toDouble(),
                          [
                            {
                              "title": widget.productdetails[0]["title"],
                              "description": widget.productdetails[0]
                                  ["description"],
                              "discountPercentage": widget.productdetails[0]
                                  ["discountPercentage"],
                              "price": widget.productdetails[0]["price"],
                              "rating": widget.productdetails[0]["rating"],
                              "brand": widget.productdetails[0]["brand"],
                              "images": widget.productdetails[0]["images"],
                            }
                          ],
                          context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[500],
                    ),
                    child: Text("Add to Cart",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
    // return
  }
}
