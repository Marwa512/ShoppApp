import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/model/get_favorites_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_layout/cubit/cubit.dart';
import '../../../layout/shop_layout/cubit/states.dart';
import '../../../shared/style/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is! ShopLoadingFavoritesState,
          builder: (context) {
            return ListView.separated(
                itemBuilder: (context, index) => buildFavItem(
                    cubit.favoritesModel.data!.data![index].product, context),
                separatorBuilder: (context, index) => Divider(),
                itemCount: cubit.favoritesModel.data!.data!.length);
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFavItem(Product model, context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 150,
          child: Row(
            children: [
              Container(
                height: 250,
                width: 200,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage('${model.image}'),
                      width: 150,
                      height: 150,
                      //fit: BoxFit.cover,
                    ),
                    if (model.discount != 0)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        color: Colors.red,
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(fontSize: 8, color: Colors.white),
                        ),
                      )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${model.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(height: 1.5, fontSize: 16),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.price}',
                          style: TextStyle(color: defaultColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if (model.discount != 0)
                          Text(
                            '${model.oldPrice}',
                            style: TextStyle(
                                color: Colors.grey[400],
                                decoration: TextDecoration.lineThrough),
                          ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .changeFavorite(productID: model.id!);
                            },
                            icon: CircleAvatar(
                              radius: 15,
                              backgroundColor:
                                  ShopCubit.get(context).favorites[model.id]!
                                      ? defaultColor
                                      : Colors.grey,
                              child: Icon(
                                Icons.favorite_border,
                                size: 14,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
