import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/module/ShopApp/search/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/style/colors.dart';
import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var formkey = GlobalKey<FormState>();

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopSearchCubit, ShopSearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopSearchCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: searchController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'search cant be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      cubit.searchData(text: value);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (state is ShopSearchLoadingState)
                    LinearProgressIndicator(),
                  if (state is ShopSearchSucessState)
                    Expanded(
                        child: ListView.separated(
                      itemBuilder: (context, index) => buildFavItem(
                          cubit.search!.data!.data![index], context),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: cubit.search!.data!.data!.length,
                    ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildFavItem(model, context) => Padding(
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
                      image: NetworkImage(
                        "${model.image}",
                      ),
                      height: 120,
                      width: 120,
                    ),
                    /* CachedNetworkImage(
                      height: 120,
                      width: 120,
                      imageUrl: '${model.image}',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ), */
                    //fit: BoxFit.cover,
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
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              /* ShopCubit.get(context)
                                  .changeFavorite(productID: model.id!); */
                            },
                            icon: CircleAvatar(
                              radius: 15,
                              backgroundColor: /* ShopSearchCubit.get(context)
                                      .search
                                      .data[model.id] */
                                  true ? defaultColor : Colors.grey,
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
