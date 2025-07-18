import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/api_service/Cubit/product_list/product_list_cubit.dart';
import 'package:shoping_app/api_service/Model/product_model.dart';
import 'package:shoping_app/screen/view_products.dart';
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
            final productList = state.productModel;
            return _ProductList(productList);
          }
          return SizedBox();
        },)
      )
    );
  }

  Widget _ProductList(ProductModel productList) {
    return ListView.builder(
      itemCount: productList.products!.length,
      itemBuilder: (context, index) {
        final product = productList.products![index];
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProducts(
              product : productList.products![index]
            ),));
          },
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product.thumbnail ?? '',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.broken_image, size: 100, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Product Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          product.brand ?? '',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Price and Discount
                        Row(
                          children: [
                            Text(
                              "₹${product.price?.toStringAsFixed(2) ?? '0'}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (product.discountPercentage != null)
                              Text(
                                "${product.discountPercentage}% off",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.redAccent,
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        // Rating and stock
                        Row(
                          children: [
                            Icon(Icons.star, size: 14, color: Colors.amber),
                            Text(
                              " ${product.rating ?? 0}",
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.check_circle,
                              size: 14,
                              color: Colors.green,
                            ),
                            Text(
                              " ${product.availabilityStatus ?? 'Available'}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        // Action Button
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              // TODO: Navigate to product details screen
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              backgroundColor: Colors.deepOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "View Details",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
