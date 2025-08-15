import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import 'shimmer.dart';

/// Shimmer placeholder widgets for loading states
class ShimmerPlaceholder extends StatelessWidget {
  const ShimmerPlaceholder.rectangular({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  }) : _child = null;

  const ShimmerPlaceholder.circular({
    super.key,
    required this.width,
    required this.height,
  })  : borderRadius = null,
        _child = null;

  const ShimmerPlaceholder.custom({
    super.key,
    required Widget child,
  })  : width = 0,
        height = 0,
        borderRadius = null,
        _child = child;

  final double width;
  final double height;
  final double? borderRadius;
  final Widget? _child;

  @override
  Widget build(BuildContext context) {
    if (_child != null) {
      return Shimmer(child: _child);
    }

    return Shimmer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius != null
              ? BorderRadius.circular(borderRadius!)
              : BorderRadius.circular(AppConstants.defaultRadius),
        ),
      ),
    );
  }
}

/// Book card shimmer placeholder
class BookCardShimmer extends StatelessWidget {
  const BookCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 280,
      margin: const EdgeInsets.only(right: AppConstants.defaultPadding),
      child: Card(
        elevation: AppConstants.cardElevation,
        child: Shimmer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book cover placeholder
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(AppConstants.smallPadding),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(AppConstants.smallPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title placeholder
                    Container(
                      width: double.infinity,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    const SizedBox(height: AppConstants.smallPadding),

                    // Author placeholder
                    Container(
                      width: 100,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    const SizedBox(height: AppConstants.smallPadding),

                    // Category placeholder
                    Container(
                      width: 60,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// List shimmer for loading multiple items
class ListShimmer extends StatelessWidget {
  const ListShimmer({
    super.key,
    this.itemCount = 5,
    this.scrollDirection = Axis.vertical,
    this.itemHeight = 80,
    this.itemWidth = 200,
  });

  final int itemCount;
  final Axis scrollDirection;
  final double itemHeight;
  final double itemWidth;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: scrollDirection,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Container(
          width: scrollDirection == Axis.horizontal ? itemWidth : null,
          height: scrollDirection == Axis.vertical ? itemHeight : null,
          margin: EdgeInsets.only(
            bottom: scrollDirection == Axis.vertical
                ? AppConstants.smallPadding
                : 0,
            right: scrollDirection == Axis.horizontal
                ? AppConstants.smallPadding
                : 0,
          ),
          child: Shimmer(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
              ),
            ),
          ),
        );
      },
    );
  }
}
