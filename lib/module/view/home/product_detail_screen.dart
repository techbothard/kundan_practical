import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  Product product;
    ProductDetailsScreen({Key? key,required this.product}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title,overflow: TextOverflow.ellipsis,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.product.thumbnail,fit: BoxFit.cover,),
            Text("Description:",style: TextStyle(fontSize: 22),),
              Text(widget.product.description),
              SizedBox(height: 8,),
              Text("Reviews:",style: TextStyle(fontSize: 22),),
              ListView.separated(
                shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                Review review=widget.product.reviews[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${review.reviewerName} On ${formatDate(review.date)}"),
                      Text("${review.rating} Star"),
                      Text(review.comment)
                    ],
                  ),
                );
              }, separatorBuilder:  (context, index) => SizedBox(height: 10   ,),
                  itemCount: widget.product.reviews.length)
          ],),
        ),
      ),
    );
  }
  String formatDate(DateTime date) {
    // Format the date to "22 Aug 2024"
    String formattedDate = DateFormat('d MMM yyyy').format(date);

    // Get the day number (e.g., 22)
    int day = date.day;

    // Determine the ordinal suffix
    String suffix;
    if (day >= 11 && day <= 13) {
      suffix = 'th';
    } else {
      switch (day % 10) {
        case 1:
          suffix = 'st';
          break;
        case 2:
          suffix = 'nd';
          break;
        case 3:
          suffix = 'rd';
          break;
        default:
          suffix = 'th';
      }
    }

    // Combine the formatted date with the suffix
    return formattedDate.replaceFirst(
        RegExp(r'\d+'),
        '$day$suffix'
    );
  }
}
