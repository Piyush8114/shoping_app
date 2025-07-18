import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/api_service/Cubit/product_list/product_list_cubit.dart';
import 'package:shoping_app/utils/app_style.dart';
import 'package:shoping_app/utils/check_Network.dart';
import 'package:shoping_app/utils/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductListCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Produts"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer(
            listener: (context,state){
              print("State ${state}");
            },
          builder: (context, state) {
          if(state is ProductListNetworkError)
            {
              return Center(child: Text("NetWork Error"),);
            }
          else if(state is ProductListModelError){
            return Center(child: Text("Something Went Error"),);
          }
          else if(state is ProductListLoaded){
            return ListView.builder(itemBuilder: (context, index) {
              return Container(
                height: 100,
                color: AppColors.boxBrown,
              );
            },);
          }
          return SizedBox();
        },)
      )
    );
  }
}
