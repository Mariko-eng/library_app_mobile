import 'package:attendx/views/home/home_view.dart';
import 'package:attendx/views/intro_view.dart';
import 'package:attendx/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:attendx/controllers/auth_controller.dart';

class AuthWrapperView extends StatefulWidget {
  const AuthWrapperView({super.key});

  @override
  State<AuthWrapperView> createState() => _AuthWrapperViewState();
}

class _AuthWrapperViewState extends State<AuthWrapperView> {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Provider.of<AuthController>(context);
    if (authController.isLoading) {
      return const LoadingWidget();
    } else {
      if (authController.userModel == null) {
        return const IntroView();
      } else {
        return const HomeView();
      }
    }
  }
}
