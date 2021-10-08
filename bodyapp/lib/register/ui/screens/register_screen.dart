import 'package:flutter/material.dart';
import 'package:bodyapp/shared/colors.dart';
import 'package:fluttericon/brandico_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RegisterFormWidget(),
            Divider(
              indent: 32,
              endIndent: 32,
              thickness: 4,
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: null,
                  icon: Icon(Brandico.facebook_1),
                  iconSize: 32,
                ),
                IconButton(
                  onPressed: null,
                  icon: Icon(Brandico.twitter_bird),
                  iconSize: 32,
                ),
                IconButton(
                  onPressed: null,
                  icon: Icon(Brandico.googleplus_rect),
                  iconSize: 32,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterFormWidgetState createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final _formKey = GlobalKey<FormState>();
  RegExp _upper = RegExp(r'[A-Z]');
  RegExp _lower = RegExp(r'[a-z]');
  RegExp _numeric = RegExp(r'[0-9]');
  bool isPasswordObscured = true;
  bool isConfirmObscured = true;
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * (12 / 568),
          ),
          CircleAvatar(
              radius: MediaQuery.of(context).size.height * (45 / 568),
              backgroundColor: Colors.grey[300],
              child: Container(
                  child: Icon(
                Icons.person_add_alt,
                size: MediaQuery.of(context).size.height * (45 / 568),
                color: Colors.teal,
              ))),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 60),
            child: InputWidget(
              hintText: 'Nome',
              prefixIcon: Icons.person_outline,
              validator: (value) {
                if (value != null && !isEmail(value)) {
                  return 'Preencha um e-mail válido.';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 60),
            child: InputWidget(
              hintText: 'Email',
              prefixIcon: Icons.email_outlined,
              validator: (value) {
                if (value != null && !isEmail(value)) {
                  return 'Preencha um e-mail válido.';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 60),
            child: InputWidget(
              hintText: 'Senha',
              prefixIcon: Icons.lock_outline,
              sufixIcon:
                  isPasswordObscured ? Icons.visibility_off : Icons.visibility,
              obscureText: isPasswordObscured,
              suffixIconOnPressed: () {
                setState(() {
                  isPasswordObscured = !isPasswordObscured;
                });
              },
              validator: (value) {
                if (value != null && value.length < 6) {
                  return 'A senha deve conter no mínimo 6 caracteres';
                }
                if (value != null && !value.contains(_upper)) {
                  return 'A senha deve conter pelo menos um caractere uppercase.';
                }
                if (value != null && !value.contains(_lower)) {
                  return 'A senha deve conter pelo menos um caractere lowercase.';
                }
                if (value != null && !value.contains(_numeric)) {
                  return 'A senha deve conter pelo menos um caractere numerico.';
                }
                return null;
              },
              onChanged: (value) {
                _password = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 60),
            child: InputWidget(
              hintText: 'Confirmar Senha',
              prefixIcon: Icons.lock_outline,
              sufixIcon:
                  isConfirmObscured ? Icons.visibility_off : Icons.visibility,
              obscureText: isConfirmObscured,
              suffixIconOnPressed: () {
                setState(() {
                  isConfirmObscured = !isConfirmObscured;
                });
              },
              validator: (value) {
                if (value != _password) {
                  return 'As senhas não coincidem, por favor digite novamente';
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 60),
            child: ElevatedButton(
              onPressed: () {},
              child: Center(
                child: Text(
                  'Criar conta',
                  style: GoogleFonts.rokkitt(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InputWidget extends StatelessWidget {
  String? hintText;
  IconData? prefixIcon;
  IconData? sufixIcon;
  bool obscureText;
  VoidCallback? suffixIconOnPressed;
  String? Function(String?)? validator;
  void Function(String)? onChanged;

  InputWidget({
    this.hintText,
    this.prefixIcon,
    this.sufixIcon,
    this.obscureText = false,
    this.suffixIconOnPressed,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        fillColor: Colors.grey[300],
        filled: true,
        focusColor: Colors.grey[300],
        hoverColor: Colors.grey[300],
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[800]),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: AppColors.teal,
        ),
        suffixIcon: IconButton(
          icon: Icon(sufixIcon),
          color: AppColors.teal,
          onPressed: suffixIconOnPressed,
        ),
      ),
      validator: validator,
    );
  }
}

class ColoredTabBar extends ColoredBox implements PreferredSizeWidget {
  ColoredTabBar({this.color = AppColors.teal, required this.tabBar})
      : super(color: color, child: tabBar);

  final Color color;
  final TabBar tabBar;

  @override
  Size get preferredSize => tabBar.preferredSize;
}
