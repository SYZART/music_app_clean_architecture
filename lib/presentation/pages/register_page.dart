import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openmusic/common/widgets/custom_snackbar.dart';
import 'package:openmusic/presentation/bloc/auth%20bloc/auth_bloc.dart';
import 'package:openmusic/presentation/pages/login_page.dart';
import 'package:openmusic/presentation/pages/song_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullnameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthRegisterFailed) {
              CustomSnackbar.showMessage(state.message, context);
            }
            if (state is AuthRegisterSuccess) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
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
                fullnameField(),
                const SizedBox(
                  height: 15,
                ),
                passwordFied(),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () {
                    context.read<AuthBloc>().add(OnRegisterEvent(
                        username: _usernameController.text,
                        fullname: _fullnameController.text,
                        password: _passwordController.text));
                  }, child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthRegisterLoading) {
                        return const SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ));
                      }
                      return const Text('Register');
                    },
                  )),
                )
              ],
            ),
          ),
        ));
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

  Column fullnameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Full name'),
        SizedBox(
          height: 40,
          child: TextFormField(
            controller: _fullnameController,
            decoration: InputDecoration(
                hintText: 'Full name',
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
}
