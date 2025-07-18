import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoping_app/api_service/Model/product_model.dart';
import 'package:shoping_app/api_service/api_client.dart';
import 'package:shoping_app/utils/check_Network.dart';
import 'package:shoping_app/utils/common_toast.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(ProductListInitial());

  getProducts()async{



    if(await isNetworkAvaliable()){
      emit(ProductListLoading());

      try{
        ApiClient().getProducts().then((value){
          emit(ProductListLoaded(value!));
        });
      }
      catch(e){
        CommonToast("Something Error : ${e}");
        emit(ProductListModelError());
      }
    }else{
      CommonToast("Network Error");
      emit(ProductListNetworkError());
    }
  }
}
