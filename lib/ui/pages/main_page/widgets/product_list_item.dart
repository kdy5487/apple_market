import 'package:flutter/material.dart';
import 'package:flutter_apple_market/models/product.dart';
import 'package:intl/intl.dart';

///상품목록 리스트 아이템 위젯
class ProductListItem extends StatelessWidget {
  final Product product;
  const ProductListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###'); // 천 단위 콤마하기 위함
    return Padding(
      //상품 목록 아이템 간격 조정
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),

        child: Row(
          children: [
            // 상품 이미지
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8.0),
              child: Image.asset(
                product.image,
                width: 110,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 상품 제목
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 6.0),

                  // 상품 위치
                  Text(
                    product.location,
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 6.0),

                  // 상품 가격
                  Text(
                    '${formatter.format(product.price)} 원',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.0),

                  // 채팅, 좋아요 정보
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,

                    children: [
                      // 채팅 아이콘 및 개수
                      Icon(Icons.chat),
                      Text(
                        '${product.chats}',
                        style: TextStyle(fontSize: 16.0),
                      ),

                      // 좋아요 아이콘 및 개수
                      Icon(
                        product.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: product.isLiked ? Colors.red : Colors.grey,
                      ),
                      Text(
                        '${product.likes}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
