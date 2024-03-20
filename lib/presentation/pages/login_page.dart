import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openmusic/common/widgets/custom_snackbar.dart';
import 'package:openmusic/data/datasources/db/database_helper.dart';
import 'package:openmusic/presentation/bloc/auth%20bloc/auth_bloc.dart';
import 'package:openmusic/presentation/pages/register_page.dart';
import 'package:openmusic/presentation/pages/song_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final ValueNotifier<bool> _checkBoxValue = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoginFailed) {
              CustomSnackbar.showMessage(state.message, context);
            }
            if (state is AuthLoginSuccess) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SongPage(),
                  ));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                usernameField(),
                const SizedBox(
                  height: 15,
                ),
                passwordFied(),
                ValueListenableBuilder<bool>(
                  valueListenable: _checkBoxValue,
                  builder: (context, value, child) => CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    checkColor: Colors.white,
                    // activeColor: Colors.grey[200],
                    title: const Text("Remember me"),
                    value: value,
                    onChanged: (newValue) {
                      _checkBoxValue.value = !_checkBoxValue.value;
                      log('cek value checkbox${_checkBoxValue.value}');
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () {
                    context.read<AuthBloc>().add(
                          OnLoginEvent(
                              username: _usernameController.text,
                              password: _passwordController.text),
                        );
                  }, child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoginLoading) {
                        return const SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        );
                      }
                      return const Text('Login');
                    },
                  )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Belum punya akun? '),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ));
                        },
                        child: Text('Masuk')),
                  ],
                ),
                TextButton(
                    onPressed: () async {
                      final tkn = await DatabaseHelper().getAccessToken();
                      log(tkn ?? '-');
                    },
                    child: const Text('Get Tokens')),
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
          height: 40,
          child: TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
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
          height: 40,
          child: TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.remove_red_eye),
                  onPressed: () {},
                ),
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
}
