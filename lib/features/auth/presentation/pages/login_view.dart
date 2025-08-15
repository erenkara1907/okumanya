import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../shared/di/service_locator.dart';
import '../../../../shared/navigation/routes/app_router.gr.dart';
import '../../../../shared/resources/styles/app_colors.dart';
import '../../../../core/widgets/common/common_elevated_button.dart';
import '../../../../core/widgets/common/common_scaffold.dart';
import '../../../../core/widgets/common/common_textfield.dart';
import '../bloc/login_bloc.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      body: BlocProvider(
        create: (context) => getIt<LoginBloc>(),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.success) {
              Fluttertoast.showToast(
                msg: "Giriş başarılı! Anasayfaya yönlendiriliyorsunuz...",
                gravity: ToastGravity.CENTER,
              );
              // Navigate to home page and clear stack
              context.router.replaceAll([const MainRoute()]);
            } else if (state.status == LoginStatus.error ||
                state.status == LoginStatus.notfound) {
              Fluttertoast.showToast(
                msg: '${"error".tr()} ${state.errorMessage}',
                gravity: ToastGravity.CENTER,
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 100.h),
                      child: Image.asset(
                        'assets/images/logo.png',
                      ),
                    ),
                    CommonTextField(
                      textEditingController: emailController,
                      borderColor: AppColors.defaultAppColor.primaryColor
                          .withValues(alpha: 0.8),
                      hintText: "E-posta",
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: AppColors.defaultAppColor.primaryColor,
                      ),
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return "E-posta adresi gerekli";
                        } else if (!email.contains('@') ||
                            !email.contains('.')) {
                          return "Geçerli bir e-posta adresi girin";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                    CommonTextField(
                      textEditingController: passwordController,
                      borderColor: AppColors.defaultAppColor.primaryColor
                          .withValues(alpha: 0.8),
                      hintText: "password".tr(),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: AppColors.defaultAppColor.primaryColor,
                      ),
                      obscureText: state.obscure,
                      suffixIcon: IconButton(
                        onPressed: () {
                          context.read<LoginBloc>().add(ObscureText());
                        },
                        icon: state.obscure
                            ? Icon(
                                Icons.remove_red_eye_outlined,
                                color: AppColors.defaultAppColor.primaryColor,
                              )
                            : Icon(
                                Icons.remove_red_eye,
                                color: AppColors.defaultAppColor.primaryColor,
                              ),
                      ),
                      validator: (pass) {
                        if (pass == null || pass.isEmpty) {
                          return "passwordRequired".tr();
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 50.h),
                    CommonElevatedButton(
                      text: "login".tr(),
                      isActive: state.status != LoginStatus.loading,
                      widget: state.status == LoginStatus.loading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : null,
                      onPressed: () {
                        if (state.status != LoginStatus.loading) {
                          if (formKey.currentState?.validate() == true) {
                            // String fcmToken =
                            //     Hive.box(HiveBoxConstants.fcmToken)
                            //         .get('fcmToken', defaultValue: '');
                            context.read<LoginBloc>().add(
                                  Login(
                                    email: emailController.text.trim(),
                                    password: passwordController.text,
                                  ),
                                );
                          }
                        }
                      },
                    ),
                    SizedBox(height: 50.h),
                    // ChangeLocaleTextButtons(locale: context.locale),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
