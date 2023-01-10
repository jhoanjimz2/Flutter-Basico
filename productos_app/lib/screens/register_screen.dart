import 'package:flutter/material.dart';
import 'package:productos_app/providers/providers.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../themes/app_theme.dart';

class RegisterScreen extends StatelessWidget {

  static const String routerName = 'register';
   
  const RegisterScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox( height: 10 ),
                    Text('Crear Cuenta', style: Theme.of(context).textTheme.headline4),
                    const SizedBox( height: 30 ),
                    ChangeNotifierProvider(
                      create: ( _ ) => LoginFormProvider(),
                      child: const _LoginForm(),
                    ),
                  ],
                ),
              ),
              const SizedBox( height: 50 ),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, LoginScreen.routerName),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all( AppTheme.primary.withOpacity(0.1) ),
                  shape: MaterialStateProperty.all( const StadiumBorder() )
                ),
                child: const Text(
                  '¿Ya tienes una cuenta?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)
                )
              ),
              const SizedBox( height: 50 )
            ],
          ),
        )
      ),
    );
  }
}



class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'jonh.doc@gmail.com',
                labelText: 'Correo Electrónico',
                prefixIcon: Icons.alternate_email_rounded
              ),
              onChanged: ( value ) => loginForm.email = value,
              validator: ( value ) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                ? null
                : 'El valor ingresado no luce como un correo';
              }
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '******',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: ( value ) => loginForm.password = value,
              validator: ( value ) {
                return  (value != null && value.length >= 6)
                ? null 
                : 'La contraseña debe ser de 6 caracteres';
              }
            ),
            const SizedBox(height: 30),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              onPressed: loginForm.isLoading ? null : () async  {
                FocusScope.of(context).unfocus();
                final authService = Provider.of<AuthService>(context, listen: false);
                if ( !loginForm.isValidForm() ) return;
                loginForm.isLoading = true;


                final String? errorMessage = await authService.createUser(loginForm.email, loginForm.password);

                if ( errorMessage == null ) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, HomeScreen.routerName);
                } else {
                  print(errorMessage);
                }

                loginForm.isLoading = false;
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading
                  ? 'Espere'
                  : 'Ingresar',
                  style: const TextStyle( color: Colors.white ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}