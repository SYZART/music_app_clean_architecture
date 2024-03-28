import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:openmusic/common/constants.dart';
import 'package:openmusic/common/theme.dart';
import 'package:openmusic/common/widgets/custom_snackbar.dart';
import 'package:openmusic/data/models/login_model.dart';
import 'package:openmusic/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:openmusic/presentation/cubit/page_cubit.dart';
import 'package:openmusic/presentation/pages/register_page.dart';
import 'package:openmusic/presentation/pages/song_page.dart';

import '../../common/widgets/loading.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final ValueNotifier<bool> _checkBoxValue = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _showPassword = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    log('build');
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoginLoading) {
              LoadingScreen.instance().show(context: context);
            }
            if (state is AuthLoginFailed) {
              LoadingScreen.instance().hide();
              CustomSnackbar.showMessage(state.message, context);
            }
            if (state is AuthLoginSuccess) {
              context.read<PageCubit>().setPage(0);
              context.read<AuthBloc>().add(OnSaveUserToken(DataLoginModel(
                  accessToken: state.data.data.accessToken,
                  refreshToken: state.data.data.refreshToken)));
              LoadingScreen.instance().hide();
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'assets/images/musium_logo.png',
                  width: 200,
                ),
                usernameField(),
                const SizedBox(
                  height: 15,
                ),
                passwordFied(),
                const SizedBox(
                  height: 10,
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _checkBoxValue,
                  builder: (context, value, child) => InkWell(
                    onTap: () {
                      _checkBoxValue.value = !_checkBoxValue.value;
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 29,
                          child: Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            side: const BorderSide(
                                color: primaryColor, width: 2.0),
                            value: value,
                            onChanged: (newValue) {
                              _checkBoxValue.value = !_checkBoxValue.value;
                              // log('cek value checkbox${_checkBoxValue.value}');
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Remember me',
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              OnLoginEvent(
                                  username: _usernameController.text,
                                  password: _passwordController.text),
                            );
                      },
                      child: const Text('Login'),
                    )),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: const Text('Home'),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum punya akun?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/register'); // Navigator.push(
                        },
                        child: const Text('Daftar')),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Column usernameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Username'),
        SizedBox(
          height: 45,
          child: TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.email,
                  size: 18,
                ),
                hintText: 'Username',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                focusedBorder: OutlineInputBorder(
                  gapPadding: 1,
                  borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                  borderRadius: BorderRadius.circular(4),
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
          ),
        ),
      ],
    );
  }

  Column passwordFied() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Password'),
        SizedBox(
          height: 45,
          child: ValueListenableBuilder(
            valueListenable: _showPassword,
            builder: (context, value, child) => TextFormField(
              controller: _passwordController,
              obscureText: _showPassword.value,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Iconsax.lock,
                    size: 18,
                  ),
                  hintText: 'Password',
                  hintStyle:
                      TextStyle(color: Colors.grey.shade400, fontSize: 13),
                  suffixIcon: IconButton(
                    icon: const Icon(Iconsax.eye),
                    onPressed: () {
                      _showPassword.value = !_showPassword.value;
                      log('cek value checkbox${_showPassword.value}');
                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  focusedBorder: OutlineInputBorder(
                    gapPadding: 1,
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
          ),
        ),
      ],
    );
  }
}
