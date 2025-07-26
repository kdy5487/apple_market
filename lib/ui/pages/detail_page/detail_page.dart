import 'package:flutter/material.dart';
import 'package:flutter_apple_market/models/product.dart';
import 'package:intl/intl.dart';

/// 상품 상세 페이지 위젯
class DetailPage extends StatefulWidget {
  final Product product;

  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Product product;
  final format = NumberFormat("#,###", "ko_KR"); // 가격 포맷

  @override
  void initState() {
    super.initState();
    product = widget.product; // 전달받은 상품 데이터로 초기화
  }

  /// 좋아요 버튼 클릭 시 상태 변경
  void _toggleLike() {
    setState(() {
      if (product.isLiked) {
        product = product.copyWith(isLiked: false, likes: product.likes - 1);
      } else {
        product = product.copyWith(isLiked: true, likes: product.likes + 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###'); // 천 단위 콤마 포맷

    return Scaffold(
      appBar: AppBar(
        title: const Text('상품 상세'),
        centerTitle: false, // 타이틀 중앙 정렬 여부
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),

          onPressed: () => Navigator.pop(context, product), // 뒤로가기 시 상품 정보 반환
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상품 이미지
                ClipRRect(
                  child: Image.asset(
                    product.image,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                // 판매자 정보
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.orange,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.seller,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              product.location,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '39.3°C',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '매너온도',
                            style: TextStyle(
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(thickness: 2.0),
                ), // 디바이더 굵기
                const SizedBox(height: 8),
                // 상품 제목
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // 상품 설명
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    product.description,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
          // 하단 고정 영역 (좋아요, 가격, 채팅 버튼)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[300]!)),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 좋아요 버튼
                  Row(
                    children: [
                      IconButton(
                        onPressed: _toggleLike,
                        icon: Icon(
                          product.isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: product.isLiked ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  // 상품 가격
                  Text(
                    '${formatter.format(product.price)}원',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // 채팅하기 버튼
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("채팅하기"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
