import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whistler/features/viewmodel/language/cubit/language_cubit.dart';
import 'package:whistler/features/viewmodel/service/whistler/whistler_cubit.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, bool>(
      builder: (context, state) {
        print('Appbarda language : $state');
        context.read<WhistlerCubit>().isLanguageTurkish = state;
        print(
            'Whistler daki langugae : ${context.read<WhistlerCubit>().isLanguageTurkish}');
        return AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            state ? 'English -> Turkish' : 'Turkish -> English',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          actions: [
            SizedBox(
              height: 30,
              width: 70,
              child: AnimatedToggleSwitch.dual(
                current: state,
                first: false,
                second: true,
                iconBuilder: (value) => value
                    ? Image.asset('assets/icons/ic_english.png')
                    : Image.asset('assets/icons/ic_turkish.png'),
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
