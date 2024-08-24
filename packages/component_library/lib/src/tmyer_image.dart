import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class TymerImage extends StatelessWidget {
  final String? imageUrl;

  const TymerImage({
    super.key,
    this.imageUrl,
    this.isLoadingInProgress,
  });

  final ValueSetter<bool>? isLoadingInProgress;

  @override
  Widget build(BuildContext context) {
    return imageUrl == null
        ? const ImageLoadingErrorIndicator()
        : Image.network(
            imageUrl!,
            fit: BoxFit.cover,
            alignment: Alignment.center,
            height: double.maxFinite,
            errorBuilder: (ctx, obj, strace) {
              return const ImageLoadingErrorIndicator();
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (isLoadingInProgress != null) {
                isLoadingInProgress!(loadingProgress != null);
              }
              if (loadingProgress == null) return child;
              return const ImageLoadingFlasher();
            },
          );
  }
}

class ImageLoadingErrorIndicator extends StatelessWidget {
  const ImageLoadingErrorIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = TymerTheme.of(context).materialThemeData.colorScheme;

    return Center(
      child: Container(
        color: colorScheme.primary.withOpacity(0.1),
        height: double.maxFinite,
        width: double.maxFinite,
        child: Icon(
          Icons.image,
          color: colorScheme.primary,
        ),
      ),
    );
  }
}

class ImageLoadingFlasher extends StatefulWidget {
  const ImageLoadingFlasher({
    super.key,
  });

  @override
  State<ImageLoadingFlasher> createState() => _ImageLoadingFlasherState();
}

class _ImageLoadingFlasherState extends State<ImageLoadingFlasher>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      lowerBound: 0.2,
      upperBound: 0.4,
      duration: const Duration(seconds: 3),
      vsync: this,
    )
      ..drive(CurveTween(curve: Curves.linearToEaseOut))
      ..forward()
      ..addListener(() {
        if (controller.value == controller.upperBound) {
          controller.reverse();
        }
        if (controller.value == controller.lowerBound) {
          controller.forward();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = TymerTheme.of(context).materialThemeData.colorScheme;

    return Center(
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return LinearProgressIndicator(
              minHeight: double.maxFinite,
              backgroundColor:
                  colorScheme.primary.withOpacity(controller.value * 0.5),
              valueColor: AlwaysStoppedAnimation<Color>(
                  colorScheme.primary.withOpacity(controller.value * 0.05)),
            );
          }),
    );
  }
}
