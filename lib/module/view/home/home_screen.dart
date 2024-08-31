import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:kundan_practical/module/controller/product_controller.dart';
import 'package:kundan_practical/module/model/product_model.dart';
import 'package:kundan_practical/module/view/home/product_detail_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => context.read<ProductController>().getProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            context.read<ProductController>().resetcheckBox();
            showDialog(context: context, builder: (context) => Dialog(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.center,
                      child: Text("Categories",style: TextStyle(fontSize: 22),)),
                  SizedBox(height: 30,),
                  Consumer<ProductController>(builder:  (context, value, child) {
                    return  ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Row(
                        children: [
                          Checkbox(value: value.checkBox[index], onChanged: (values) {
                            value.changeCheckBox(index,values!);
                          },),
                          Text( context.read<ProductController>().Categorys[index])
                        ],
                      ),
                      itemCount: context.read<ProductController>().Categorys.length ,
                    );
                  },),

                  SizedBox(height: 30,),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(onPressed: () {
                      context.read<ProductController>().setCategory();
                      Navigator.pop(context);

                    }, child: Text("Submit")),
                  )
                ],
              ),
            ),);
          }, icon: Icon(Icons.filter_alt_outlined))
        ],
      ),
      body: SafeArea(
        child: Consumer<ProductController>(
          builder: (context, value, child) {
            return value.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 45,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                String name = value.Categorys[index];
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 1.2)),
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 20,
                                  ),
                              itemCount: value.Categorys.length),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: ListView.separated(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: value.products.length ?? 0,
                            itemBuilder: (context, index1) {
                              Product product = value.products[index1];
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product),));
                                  },
                                child: Container(
                                  height: 140,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Row(children: [
                                      SizedBox(
                                          height: 140,
                                          child: Banner(
                                            message: product.discountPercentage
                                                .toString(),
                                            location: BannerLocation.topStart,
                                            child: Image.network(
                                              product.thumbnail,
                                              height: 140,width: 130,
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(

                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(product.title),

                                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(product.brand ?? ""),
                                                  Text("${product.price}")
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ])),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              height: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
