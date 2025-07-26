import 'package:flutter/material.dart';

/// 메인 페이지에서 사용하는 플로팅 액션 버튼 위젯
class MainPageFab extends StatelessWidget {
  final bool show; // 버튼 표시 여부
  final bool isPressed; // 버튼이 눌렸는지 상태
  final VoidCallback onPressed; // 버튼 클릭 시 실행 함수

  const MainPageFab({
    super.key,
    required this.show,
    required this.isPressed,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      // show 값에 따라 버튼의 투명도 애니메이션 처리
      opacity: show ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: show
          ? FloatingActionButton(
              onPressed: onPressed,
              backgroundColor: Colors.orange,
              child: Icon(isPressed ? Icons.expand_less : Icons.arrow_upward),
            )
          : null, // show가 false면 버튼 미표시
    );
  }
}
