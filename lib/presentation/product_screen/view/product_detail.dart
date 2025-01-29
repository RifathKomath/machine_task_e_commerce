import 'package:e_commerce/app/theme/colors.dart';
import 'package:e_commerce/app/theme/text_styles.dart';
import 'package:e_commerce/domain/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final ProductModel data;
  const ProductDetail({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: yellowClr),
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Hero(
                  tag: 'animation-image${data.image}',
                  child: Image.network(
                    data.image,
                    height: 350,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Text(
                        data.title,
                        style: AppTextStyles.textStyle_500_20
                            .copyWith(color: teal800Clr),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            '\$ ${data.price.toString()}',
                            style: AppTextStyles.textStyle_400_13
                                .copyWith(color: redClr, fontSize: 15),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                                decoration: BoxDecoration(
                                    color: teal800Clr, shape: BoxShape.circle),
                                child: Icon(
                                  Icons.add,
                                  color: whiteClr,
                                  size: 25,
                                )),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: yellowClr, size: 20),
                          SizedBox(width: 5),
                          Text(
                            '${data.rating.rate} (${data.rating.count} reviews)',
                            style: AppTextStyles.textStyle_400_13
                                .copyWith(color: blackClr),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data.description,
                        style: AppTextStyles.textStyle_400_16
                            .copyWith(color: blackClr, height: 1.6),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
