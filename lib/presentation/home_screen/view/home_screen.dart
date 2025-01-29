import 'package:e_commerce/app/navigator/app_navigation.dart';
import 'package:e_commerce/app/theme/colors.dart';
import 'package:e_commerce/app/theme/text_styles.dart';
import 'package:e_commerce/presentation/cart_screen.dart/bloc/bloc/cart_bloc_bloc.dart';
import 'package:e_commerce/presentation/cart_screen.dart/view/product_cart_screen.dart';
import 'package:e_commerce/presentation/product_screen/view/product_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/model/product_model.dart';
import '../../cart_screen.dart/bloc/bloc/cart_bloc_event.dart';
import '../../cart_screen.dart/bloc/bloc/cart_bloc_state.dart';
import '../bloc/bloc/home_screen_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: yellowClr),
          backgroundColor: whiteClr,
          actions: [
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                int cartCount = state.cartItems.length;

                return Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_cart_outlined),
                      onPressed: () {
                        AppNavigator.push(context, ProductCartScreen());
                      },
                    ),
                    if (cartCount >
                        0) // Show badge only if there are items in the cart
                      Positioned(
                        right: 8,
                        top: 15,
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            cartCount.toString(),
                            style: AppTextStyles.textStyle_400_13
                                .copyWith(color: whiteClr),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                curve: Curves.easeIn,
                duration: const Duration(seconds: 1),
                builder: (context, val, child) {
                  return Opacity(
                    opacity: val,
                    child: Padding(
                      padding: EdgeInsets.only(left: (1 - val) * 100),
                      child: child,
                    ),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: "Get Your ",
                    style: AppTextStyles.textStyle_400_14
                        .copyWith(fontSize: 28, color: teal800Clr),
                    children: [
                      TextSpan(
                        text: "Products\nFrom",
                        style: AppTextStyles.textStyle_600_14
                            .copyWith(fontSize: 28, color: yellowClr),
                      ),
                      TextSpan(
                        text: " our site",
                        style: AppTextStyles.textStyle_400_14
                            .copyWith(fontSize: 28, color: teal800Clr),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: BlocProvider(
                  create: (context) =>
                      HomeScreenBloc()..add(InitialFetchEvent()),
                  child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
                    builder: (context, state) {
                      if (state is HomeScreenLoadingState) {
                        return const Center(
                            child: CupertinoActivityIndicator(
                          radius: 20.0,
                          color: yellowClr,
                        ));
                      } else if (state is HomeErrorState) {
                        return Center(
                            child: Text(
                          'Error',
                          style: AppTextStyles.textStyle_400_16,
                        ));
                      } else if (state is HomeScreenLoadedSuccessState) {
                        final bloc = context.read<CartBloc>();
                        List<ProductModel> data = state.products;
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  AppNavigator.push(context,
                                      ProductDetail(data: data[index]));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: teal800Clr),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: Hero(
                                                      tag:
                                                          'animation-image${data[index].image}',
                                                      child: SizedBox(
                                                        height: 70,
                                                        width: 60,
                                                        child: Image.network(
                                                          data[index].image,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data[index].title,
                                                        style: AppTextStyles
                                                            .textStyle_400_13
                                                            .copyWith(
                                                                color:
                                                                    blackClr),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                      ),
                                                      Text(
                                                        data[index].category,
                                                        style: AppTextStyles
                                                            .textStyle_400_13
                                                            .copyWith(
                                                                color:
                                                                    greenClr),
                                                      ),
                                                      Text(
                                                        '\$ ${data[index].price.toString()}',
                                                        style: AppTextStyles
                                                            .textStyle_400_13
                                                            .copyWith(
                                                                color: redClr),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8, right: 18),
                                            child: GestureDetector(
                                              onTap: () {
                                                bloc.add(AddToCartEvent(
                                                    product: data[index]));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    backgroundColor: greenClr,
                                                    behavior: SnackBarBehavior.floating,
                                                      content: Text(
                                                          'Added to Cart')),
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: teal800Clr,
                                                    shape: BoxShape.circle),
                                                child: Icon(Icons.add,
                                                    color: whiteClr, size: 25),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            );
                          },
                          itemCount: data.length,
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
