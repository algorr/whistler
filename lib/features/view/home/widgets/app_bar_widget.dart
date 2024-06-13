import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whistler/core/resources/index.dart';
import 'package:whistler/features/viewmodel/language/cubit/language_cubit.dart';
import 'package:whistler/features/viewmodel/service/whistler/whistler_cubit.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, bool>(
      builder: (context, state) {
        context.read<WhistlerCubit>().isLanguageTurkish = state;
        return AppBar(
          title: Text(
            state ? AppStrings.appbarTitleEn : AppStrings.appbarTitleTr,
          ),
          actions: [
            SizedBox(
              height: size.height * 0.04,
              width: size.width * 0.2,
              child: AnimatedToggleSwitch.dual(
                current: state,
                first: false,
                second: true,
                iconBuilder: (value) => value
                    ? Image.asset(AssetsManager.englishFlagButton)
                    : Image.asset(AssetsManager.turkishFlagButton),
                onTap: (_) {
                  context.read<LanguageCubit>().updateLanguage();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
