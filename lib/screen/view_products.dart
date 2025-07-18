import 'package:flutter/material.dart';
import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shoping_app/api_service/Model/product_model.dart';

class ViewProducts extends StatefulWidget {
  final Products product;
   ViewProducts({super.key, required this.product});

  @override
  State<ViewProducts> createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {

  Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }


  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment Success")));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment Failed")));

  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment External Wallet")));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.product.title.toString()),
      ),

      body: ListView(
        children: [
          SizedBox(
            height: 250,
            child: Carousel(
              autoplay: false,
              showIndicator: false,
              images: widget.product.images!.map((e){
                return Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(e))
                  ),
                );
              }).toList()
            ),
          ),

          Padding(padding: EdgeInsets.all(15),
          child: Text(widget.product.title.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),
          ),

          Padding(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: Text("Brand : ${widget.product.brand.toString()}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.black),),
          ),

          Padding(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: Text("Price : ${widget.product.price.toString()}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.black),),
          ),

          Padding(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: Text("Discount Percentage : ${widget.product.discountPercentage.toString()}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.red),),
          ),

          Padding(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: Text("${widget.product.description.toString()}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.black),),
          ),

          Padding(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: Text("Status : ${widget.product.availabilityStatus.toString()}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.black),),
          ),

          Padding(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: Text("Category : ${widget.product.category.toString()}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.black),),
          ),

          Padding(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: Text("Return Policy : ${widget.product.returnPolicy.toString()}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.black),),
          ),
          
        ],
      ),

      bottomSheet: Container(
        height: 70,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 10,bottom: 30,left: 20,right: 20),
          child: ElevatedButton(onPressed: (){
            var options = {
              'key': '<YOUR_KEY_HERE>',
              'amount': widget.product.price,
              'name': 'Acme Corp.',
              'description': 'Fine T-Shirt',
              'prefill': {
                'contact': '8888888888',
                'email': 'test@razorpay.com'
              }
            };

            _razorpay.open(options);

          }, child: Text("Buy Now",style: TextStyle(color: Colors.white),)),
        ),
      ),
    );
  }
}
