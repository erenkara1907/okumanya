import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:okumanya/src/domain/repository/auth_repository.dart';
import 'package:okumanya/src/shared/di/service_locator.dart';
import '../../../../resource/styles/app_colors.dart';
import '../../../components/common/common_elevated_button.dart';
import '../../../components/common/common_scaffold.dart';
import '../../../components/common/common_textfield.dart';
import '../bloc/login_bloc.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _HomePageState();
}

class _HomePageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      body: BlocProvider(
        create: (context) => LoginBloc(sl<AuthRepository>()),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.success) {
              // context.router.push(const HomeRoute());
            } else if (state.status == LoginStatus.error || state.status == LoginStatus.notfound) {
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
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 100.h),
                      child: Image.asset(
                        'assets/images/logo.png',
                      ),
                    ),
                    CommonTextField(
                      textEditingController: usernameController,
                      borderColor: AppColors.defaultAppColor.primaryColor.withOpacity(0.8),
                      hintText: "username".tr(),
                      prefixIcon: Icon(
                        Icons.person_outline_outlined,
                        color: AppColors.defaultAppColor.primaryColor,
                      ),
                      validator: (name) {
                        if (name == null || name.isEmpty) {
                          return "usernameRequired".tr();
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                    CommonTextField(
                      textEditingController: passwordController,
                      borderColor: AppColors.defaultAppColor.primaryColor.withOpacity(0.8),
                      hintText: "password".tr(),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: AppColors.defaultAppColor.primaryColor,
                      ),
                      obsureText: state.obscure,
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
                                    user: usernameController.text,
                                    pass: passwordController.text,
                                    // pushToken: fcmToken,
                                    pushToken: '',
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
