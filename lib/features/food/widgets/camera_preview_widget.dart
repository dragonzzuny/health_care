import 'package:flutter/material.dart';
// import 'package:camera/camera.dart'; // 실제 구현 시 사용

/// AI 음식 인식을 위한 카메라 프리뷰 위젯
class CameraPreviewWidget extends StatefulWidget {
  final VoidCallback? onTakePicture;
  final VoidCallback? onSwitchCamera;
  final VoidCallback? onToggleFlash;
  final bool showGuideOverlay;

  const CameraPreviewWidget({
    super.key,
    this.onTakePicture,
    this.onSwitchCamera,
    this.onToggleFlash,
    this.showGuideOverlay = true,
  });

  @override
  State<CameraPreviewWidget> createState() => _CameraPreviewWidgetState();
}

class _CameraPreviewWidgetState extends State<CameraPreviewWidget>
    with TickerProviderStateMixin {
  bool _isFlashOn = false;
  late AnimationController _focusAnimationController;
  late AnimationController _captureAnimationController;
  Animation<double>? _focusAnimation;
  Animation<double>? _captureAnimation;
  Offset? _focusPoint;

  @override
  void initState() {
    super.initState();
    _focusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _captureAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _focusAnimation = Tween<double>(
      begin: 1.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _focusAnimationController,
      curve: Curves.easeInOut,
    ));

    _captureAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _captureAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _focusAnimationController.dispose();
    _captureAnimationController.dispose();
    super.dispose();
  }

  void _onTapFocus(TapDownDetails details) {
    setState(() {
      _focusPoint = details.localPosition;
    });
    _focusAnimationController.reset();
    _focusAnimationController.forward();

    // 실제로는 여기서 카메라 포커스 설정
  }

  void _onCapture() {
    _captureAnimationController.forward().then((_) {
      _captureAnimationController.reverse();
    });
    widget.onTakePicture?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 카메라 프리뷰 (임시로 컨테이너로 대체)
        GestureDetector(
          onTapDown: _onTapFocus,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey[300]!,
                  Colors.grey[600]!,
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 80,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '카메라 프리뷰',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '실제 구현 시 카메라 플러그인 연동',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),

        // 포커스 인디케이터
        if (_focusPoint != null)
          AnimatedBuilder(
            animation: _focusAnimation!,
            builder: (context, child) {
              return Positioned(
                left: _focusPoint!.dx - 40,
                top: _focusPoint!.dy - 40,
                child: Transform.scale(
                  scale: _focusAnimation!.value,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const SizedBox(),
                  ),
                ),
              );
            },
          ),

        // 가이드 오버레이
        if (widget.showGuideOverlay) _buildGuideOverlay(),

        // 상단 컨트롤들
        _buildTopControls(),

        // 하단 컨트롤들
        _buildBottomControls(),

        // 촬영 플래시 효과
        AnimatedBuilder(
          animation: _captureAnimation!,
          builder: (context, child) {
            return _captureAnimation!.value > 0
                ? Container(
                    color: Colors.white
                        .withValues(alpha: _captureAnimation!.value * 0.5),
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildGuideOverlay() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        painter: FoodGuideOverlayPainter(),
      ),
    );
  }

  Widget _buildTopControls() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 16,
      right: 16,
      child: Row(
        children: [
          // 뒤로 가기 버튼
          _buildControlButton(
            icon: Icons.arrow_back,
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(),

          // 플래시 버튼
          _buildControlButton(
            icon: _isFlashOn ? Icons.flash_on : Icons.flash_off,
            onPressed: () {
              setState(() {
                _isFlashOn = !_isFlashOn;
              });
              widget.onToggleFlash?.call();
            },
          ),
          const SizedBox(width: 12),

          // 카메라 전환 버튼
          _buildControlButton(
            icon: Icons.flip_camera_ios,
            onPressed: widget.onSwitchCamera,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom + 32,
      left: 0,
      right: 0,
      child: Column(
        children: [
          // AI 가이드 텍스트
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.psychology,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  '음식을 가이드 안에 맞춰주세요',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 촬영 버튼과 갤러리 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 갤러리 버튼
              _buildBottomActionButton(
                icon: Icons.photo_library,
                label: '갤러리',
                onPressed: () {
                  // 갤러리에서 이미지 선택 로직
                },
              ),

              // 촬영 버튼
              GestureDetector(
                onTap: _onCapture,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),

              // AI 설정 버튼
              _buildBottomActionButton(
                icon: Icons.settings,
                label: 'AI 설정',
                onPressed: () {
                  // AI 인식 설정 페이지로 이동
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildBottomActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}

/// 음식 촬영을 위한 가이드 오버레이를 그리는 커스텀 페인터
class FoodGuideOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;

    final guidePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final guideRadius = size.width * 0.3;

    // 전체 화면을 어둡게
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // 중앙 원형 가이드 영역을 투명하게
    canvas.drawCircle(
      Offset(centerX, centerY),
      guideRadius,
      Paint()..blendMode = BlendMode.clear,
    );

    // 가이드 테두리 그리기
    canvas.drawCircle(
      Offset(centerX, centerY),
      guideRadius,
      guidePaint,
    );

    // 코너 가이드 라인들
    const cornerLength = 20.0;
    final corners = [
      Offset(centerX - guideRadius + 20, centerY - guideRadius + 20), // 좌상
      Offset(centerX + guideRadius - 20, centerY - guideRadius + 20), // 우상
      Offset(centerX - guideRadius + 20, centerY + guideRadius - 20), // 좌하
      Offset(centerX + guideRadius - 20, centerY + guideRadius - 20), // 우하
    ];

    for (final corner in corners) {
      // 수직선
      canvas.drawLine(
        corner,
        Offset(corner.dx, corner.dy + cornerLength),
        guidePaint,
      );
      // 수평선
      canvas.drawLine(
        corner,
        Offset(corner.dx + cornerLength, corner.dy),
        guidePaint,
      );
    }

    // 중앙 십자선
    canvas.drawLine(
      Offset(centerX - 10, centerY),
      Offset(centerX + 10, centerY),
      guidePaint,
    );
    canvas.drawLine(
      Offset(centerX, centerY - 10),
      Offset(centerX, centerY + 10),
      guidePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 카메라 상태를 표시하는 인디케이터 위젯
class CameraStatusIndicator extends StatelessWidget {
  final bool isReady;
  final String status;

  const CameraStatusIndicator({
    super.key,
    required this.isReady,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isReady
            ? Colors.green.withValues(alpha: 0.9)
            : Colors.orange.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isReady ? Icons.check_circle : Icons.schedule,
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            status,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
