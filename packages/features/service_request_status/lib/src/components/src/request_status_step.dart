import 'package:flutter/cupertino.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';



class RequestStatusStep extends StatelessWidget {
  const RequestStatusStep({
    super.key,
    required this.title,
    required this.status,
  });

  final String title;
  final RequestStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isLoading = status == RequestStatus.loading;
    final isIdle = status == RequestStatus.idle;
    final isDone = status == RequestStatus.done;

    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(
        horizontal: theme.screenMargin,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: isLoading || isIdle ? theme.borderColor : theme.primaryColor,
        ),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: textTheme.bodyMedium?.copyWith(
                color: isLoading || isIdle
                    ? theme.dimmedTextColor
                    : theme.primaryColor),
          ),
          Spacer(),
          if (isDone) SvgAsset(AssetPathConstants.tickSquarePath),
          if (isLoading || isIdle)
            CupertinoActivityIndicator(
              animating: isLoading,
            ),
        ],
      ),
    );
  }
}

enum RequestStatus {
  loading,
  done,
  idle,
}
