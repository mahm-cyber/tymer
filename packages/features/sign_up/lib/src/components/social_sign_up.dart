import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class SocialSignUp extends StatelessWidget {
  const SocialSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    return Column(
      children: [
        const SocialSigningTitle(
          title: 'او قم بالاشتراك عبر',
        ),
        const SizedBox(
          height: Spacing.medium,
        ),
        Row(
          children: [
            SizedBox(width: theme.screenMargin),
            SocialSigningButton(
              onTap: () {},
              icon: const GoogleSvgAsset(),
            ),
            const Spacer(),
            SocialSigningButton(
              onTap: () {},
              icon: const FacebookSvgAsset(),
            ),
            const Spacer(),
            SocialSigningButton(
              onTap: () {},
              icon: const AppleSvgAsset(),
            ),
            const Spacer(),
            SocialSigningButton(
              onTap: () {},
              icon: const InstagramSvgAsset(),
            ),
            SizedBox(width: theme.screenMargin),
          ].reversed.toList(),
        ),
      ],
    );
  }
}
