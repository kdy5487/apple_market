class Product {
  final String image; // 이미지 파일
  final String title; // 상품명
  final String description; // 상품 소개
  final String seller; // 판매자
  final int price; // 가격
  final String location; //주소
  int likes; // 좋아요 수
  final int chats; // 채팅 수
  bool isLiked; // 좋아요 상태

  Product({
    required this.image,
    required this.title,
    required this.description,
    required this.seller,
    required this.price,
    required this.location,
    required this.likes,
    required this.chats,
    this.isLiked = false,
  });

  // 복사본 생성 (상태 전달 위해)
  Product copyWith({bool? isLiked, int? likes}) {
    return Product(
      image: image,
      title: title,
      description: description,
      seller: seller,
      price: price,
      location: location,
      likes: likes ?? this.likes,
      chats: chats,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
