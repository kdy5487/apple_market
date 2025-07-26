import 'package:flutter/material.dart';
import 'package:flutter_apple_market/data/dummy_data.dart';
import 'package:flutter_apple_market/ui/pages/main_page/widgets/main_page_fab.dart';
import 'package:flutter_apple_market/ui/pages/main_page/widgets/product_list_item.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('르탄동'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              //알림 기능 구현
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: dummyProducts.length, // 더미 데이터의 길이
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 8.0,
        ), //패딩 ui에 적절하게 수정
        itemBuilder: (context, index) {
          return ProductListItem(
            product: dummyProducts[index],
          ); // 더미 데이터에서 상품을 가져와서 리스트 아이템으로 표시
        },
      ),
      floatingActionButton: MainPageFab(), //플로팅 버튼 위젯 수정해야함
    );
  }
}
