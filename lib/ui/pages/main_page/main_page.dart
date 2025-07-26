import 'package:flutter/material.dart';
import 'package:flutter_apple_market/data/dummy_data.dart';
import 'package:flutter_apple_market/models/product.dart';
import 'package:flutter_apple_market/ui/pages/detail_page/detail_page.dart';
import 'package:flutter_apple_market/ui/pages/main_page/widgets/main_page_fab.dart';
import 'package:flutter_apple_market/ui/pages/main_page/widgets/product_list_item.dart';
import 'package:intl/intl.dart';

/// 사과마켓 메인 페이지
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController(); // 리스트 스크롤 제어용
  final format = NumberFormat("#,###", "ko_KR"); // 가격 포맷
  List<Product> _products = List.from(dummyProducts); // 상품 데이터 리스트

  bool _showScrollToTop = false; // 상단 이동 버튼 표시 여부
  bool _scrollButtonPressed = false; // 버튼 눌림 상태

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener); // 스크롤 이벤트 등록
  }

  /// 스크롤 위치에 따라 상단 이동 버튼 표시/숨김 처리
  void _scrollListener() {
    if (_scrollController.offset > 100 && !_showScrollToTop) {
      setState(() => _showScrollToTop = true);
    } else if (_scrollController.offset <= 100 && _showScrollToTop) {
      setState(() => _showScrollToTop = false);
    }
  }

  /// 알림 아이콘 클릭 시 스낵바 표시
  void _showNotification(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("알림이 없습니다.")));
  }

  /// 상단 이동 버튼 클릭 시 리스트 최상단으로 스크롤
  void _scrollToTop() {
    setState(() => _scrollButtonPressed = true);
    _scrollController
        .animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        )
        .then((_) {
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() => _scrollButtonPressed = false);
          });
        });
  }

  /// 상품 롱프레스 시 삭제 확인 다이얼로그 표시
  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('삭제 확인'),
        content: const Text('정말 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _products.removeAt(index));
              Navigator.pop(context);
            },
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }

  /// 상품 클릭 시 상세 페이지로 이동
  void _navigateToDetail(Product product, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailPage(product: product)),
    );
    // 상세 페이지에서 수정된 상품 정보가 반환되면 리스트에 반영
    if (result != null && result is Product) {
      setState(() => _products[index] = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('르탄동'),
        centerTitle: false, // 타이틀 중앙 정렬 여부
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            iconSize: 32,
            //알림 기능 구현
            onPressed: () => _showNotification(context),
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _products.length,
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 2.0),
        itemBuilder: (context, index) {
          final product = _products[index];
          return GestureDetector(
            onLongPress: () => _confirmDelete(index),
            onTap: () => _navigateToDetail(product, index),
            child: ProductListItem(product: product),
          );
        },
      ),
      floatingActionButton: MainPageFab(
        show: _showScrollToTop, // 버튼 표시 여부
        isPressed: _scrollButtonPressed, // 버튼 눌림 상태
        onPressed: _scrollToTop, // 버튼 클릭 시 실행 함수
      ),
    );
  }
}
