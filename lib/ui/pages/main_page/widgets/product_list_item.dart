import 'package:flutter/material.dart';
import 'package:flutter_apple_market/models/product.dart';
import 'package:flutter_apple_market/ui/pages/detail_page/detail_page.dart';

class ProductListItem extends StatelessWidget {
  final Product product;
  const ProductListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailPage(product: product),
          ), // 상품 클릭 시 상세 페이지로 이동
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8.0),
              child: Image.asset(
                product.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    product.location,
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 6.0),
                  Text('${product.price}', style: TextStyle(fontSize: 16.0)),
                  SizedBox(height: 6.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,

                    children: [
                      Icon(Icons.chat),
                      Text(
                        '${product.chats}',
                        style: TextStyle(fontSize: 16.0),
                      ),

                      Icon(Icons.favorite, color: Colors.red),
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
