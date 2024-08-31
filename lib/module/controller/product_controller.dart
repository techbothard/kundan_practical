import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kundan_practical/module/constant/api.dart';
import 'package:kundan_practical/module/model/product_model.dart';

class ProductController extends ChangeNotifier {

bool loading=false;
   List<Product> products=[];
   List<String> Categorys=[];
   List<bool> checkBox=[];
   Map<String,List<Product>> categoryData={};

  void changeLoading(bool value){
  loading=value;
  notifyListeners();
}

Future<void> getProduct()async{
    changeLoading(true);
    try{
    final result= await Api.get(endPoint: "products");
    CategoryModal productModel =   CategoryModal.fromJson(jsonDecode(result.body));
    products=productModel.products;
       productModel.products.forEach((element) {


         if(categoryData.containsKey(element.category.name)){
           categoryData[element.category.name]?.add(element);

         }else{
           Categorys.add(element.category.name);
           checkBox.add(false);
           categoryData[element.category.name]=[element];
         }
       }
       );





        log("Product::$products");
        changeLoading(false);


    }catch(e,st){
      changeLoading(false);
      print("Error::$e\n$st");
    }
  }

void changeCheckBox(int index,bool value){
    checkBox[index]=value;
    notifyListeners();
}
void resetcheckBox(){
  checkBox = checkBox.map((_) => false).toList();
  notifyListeners();
}
void setCategory(){
    if(checkBox.contains(true)){
      products.clear();
      for(int i=0;i<checkBox.length;i++){
        if(checkBox[i]){
          products.addAll(categoryData[Categorys[i]]??[]);
        }
      }
      notifyListeners();
    }
}
}