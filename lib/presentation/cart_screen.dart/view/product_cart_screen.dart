import 'package:e_commerce/app/theme/colors.dart';
import 'package:e_commerce/app/theme/text_styles.dart';
import 'package:e_commerce/presentation/cart_screen.dart/bloc/bloc/cart_bloc_bloc.dart';
import 'package:e_commerce/presentation/cart_screen.dart/bloc/bloc/cart_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc/cart_bloc_event.dart';

class ProductCartScreen extends StatelessWidget {
  const ProductCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: yellowClr),
            backgroundColor: whiteClr,
            title: Text('Cart',
                style:
                    AppTextStyles.textStyle_500_16.copyWith(color: blackClr))),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state.cartItems.isEmpty) {
              return Center(
                  child: Text(
                'Cart is Empty',
                style: AppTextStyles.textStyle_500_16.copyWith(color: blackClr),
              ));
            }
            double subtotal =
                state.cartItems.fold(0, (sum, item) => sum + item.price);
            double tax = 5.00;
            double total = subtotal + tax;
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                    child: Card(
                      color: fieldClr,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  final bloc = context.read<CartBloc>();
                                  final item = state.cartItems[index];
                                  return Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            bloc.add(RemoveFromCartEvent(
                                                product: item));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: teal800Clr,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(Icons.close,
                                                color: whiteClr, size: 20),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 76.21,
                                            width: 71.83,
                                            child: Image.network(
                                              item.image,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.title,
                                                    style: AppTextStyles
                                                        .textStyle_400_13
                                                        .copyWith(
                                                            color: blackClr),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    '\$ ${item.price.toString()}',
                                                    style: AppTextStyles
                                                        .textStyle_500_14
                                                        .copyWith(
                                                            color: redClr),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider();
                                },
                                itemCount: state.cartItems.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: fieldClr,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        spacing: 2,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PriceCutomRow(
                              label: 'Price :',
                              value: '\$  ${subtotal.toStringAsFixed(2)}'),
                          PriceCutomRow(
                              label: 'Tax :',
                              value: '\$ ${tax.toStringAsFixed(2)}'),
                          Divider(),
                          PriceCutomRow(
                              label: 'Total :',
                              value: '\$ ${total.toStringAsFixed(2)}'),
                          ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    backgroundColor: greenClr,
                                    behavior: SnackBarBehavior.floating,
                                    content: Text('Successfully Purchased')),
                              );
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(teal800Clr)),
                            child: Text(
                              'CheckOut',
                              style: AppTextStyles.textStyle_400_18
                                  .copyWith(color: whiteClr),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class PriceCutomRow extends StatelessWidget {
  final String label;
  final String value;

  const PriceCutomRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(
          value,
          style: AppTextStyles.textStyle_600_14,
        ),
      ],
    );
  }
}
