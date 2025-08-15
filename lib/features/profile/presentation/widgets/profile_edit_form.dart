import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/common/common_textfield.dart';
import '../../../../core/widgets/common/common_elevated_button.dart';
import '../../../../core/utils/validation_utils.dart';
import '../../../../core/utils/string_extensions.dart';
import '../../../../core/monitoring/app_monitor.dart';
import '../../../../shared/di/service_locator.dart';

/// Comprehensive profile edit form demonstrating validation system integration
class ProfileEditForm extends StatefulWidget {
  const ProfileEditForm({super.key});

  @override
  State<ProfileEditForm> createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _turkishIdController = TextEditingController();
  final _bioController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Track form opened
    final appMonitor = getIt<AppMonitor>();
    appMonitor.trackUserInteraction(
      'profile_edit_form_opened',
      screen: 'ProfileEditForm',
      element: 'form',
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _turkishIdController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      // Track validation failure
      final appMonitor = getIt<AppMonitor>();
      appMonitor.trackUserInteraction(
        'form_validation_failed',
        screen: 'ProfileEditForm',
        element: 'submit_button',
        additionalData: {
          'full_name_length': _fullNameController.text.length,
          'email_valid': _emailController.text.isValidEmail,
          'phone_valid': _phoneController.text.isValidTurkishPhone,
          'turkish_id_valid': _turkishIdController.text.isValidTurkishId,
        },
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Track successful submission
      final appMonitor = getIt<AppMonitor>();
      appMonitor.trackUserInteraction(
        'profile_updated_successfully',
        screen: 'ProfileEditForm',
        element: 'submit_button',
        additionalData: {
          'form_completion_time': DateTime.now().toIso8601String(),
          'fields_completed': _getCompletedFieldsCount(),
        },
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profil başarıyla güncellendi!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      // Track submission error
      final appMonitor = getIt<AppMonitor>();
      appMonitor.trackException(
        e,
        StackTrace.current,
        context: 'profile_form_submission',
        additionalData: {
          'form_data_length': _getTotalFormDataLength(),
        },
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profil güncellenirken hata oluştu!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  int _getCompletedFieldsCount() {
    int count = 0;
    if (_fullNameController.text.isNotEmpty) count++;
    if (_emailController.text.isNotEmpty) count++;
    if (_phoneController.text.isNotEmpty) count++;
    if (_turkishIdController.text.isNotEmpty) count++;
    if (_bioController.text.isNotEmpty) count++;
    return count;
  }

  int _getTotalFormDataLength() {
    return _fullNameController.text.length +
        _emailController.text.length +
        _phoneController.text.length +
        _turkishIdController.text.length +
        _bioController.text.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Düzenle'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Full Name Field with auto-formatting
              CommonTextField(
                textEditingController: _fullNameController,
                hintText: "Ad Soyad",
                fieldType: TextFieldType.name,
                autoValidate: true,
                prefixIcon: const Icon(Icons.person_outline),
              ),

              SizedBox(height: 20.h),

              // Email Field with validation
              CommonTextField(
                textEditingController: _emailController,
                hintText: "E-posta",
                fieldType: TextFieldType.email,
                autoValidate: true,
                prefixIcon: const Icon(Icons.email_outlined),
              ),

              SizedBox(height: 20.h),

              // Phone Field with Turkish formatting
              CommonTextField(
                textEditingController: _phoneController,
                hintText: "Telefon Numarası",
                fieldType: TextFieldType.phone,
                autoValidate: true,
                prefixIcon: const Icon(Icons.phone_outlined),
              ),

              SizedBox(height: 20.h),

              // Turkish ID Field with validation
              CommonTextField(
                textEditingController: _turkishIdController,
                hintText: "TC Kimlik Numarası",
                fieldType: TextFieldType.turkishId,
                autoValidate: true,
                prefixIcon: const Icon(Icons.badge_outlined),
              ),

              SizedBox(height: 20.h),

              // Bio Field with character limit
              CommonTextField(
                textEditingController: _bioController,
                hintText: "Hakkımda (Opsiyonel)",
                maxLines: 3,
                validator: (value) {
                  if (value != null && value.length > 200) {
                    return 'Bio en fazla 200 karakter olabilir';
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.info_outline),
              ),

              SizedBox(height: 20.h),

              // Character count for bio
              if (_bioController.text.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Text(
                    '${_bioController.text.length}/200 karakter',
                    style: TextStyle(
                      color: _bioController.text.length > 200
                          ? Colors.red
                          : Colors.grey,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),

              SizedBox(height: 30.h),

              // Submit Button
              CommonElevatedButton(
                text: "Profili Güncelle",
                isActive: !_isLoading,
                onPressed: _submitForm,
                widget: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : null,
              ),

              SizedBox(height: 20.h),

              // Form validation summary
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Form Özellikleri:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    _buildFeatureItem('✅ Otomatik isim formatlama (Eren Kara)'),
                    _buildFeatureItem('✅ E-posta doğrulama'),
                    _buildFeatureItem(
                        '✅ Türkçe telefon formatı (05XX XXX XX XX)'),
                    _buildFeatureItem('✅ TC Kimlik doğrulama algoritması'),
                    _buildFeatureItem('✅ Karakter limiti kontrolü'),
                    _buildFeatureItem('✅ Gerçek zamanlı validasyon'),
                    _buildFeatureItem('✅ Kullanıcı etkileşimi takibi'),
                    _buildFeatureItem('✅ Hata raporlama sistemi'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: Colors.blue[700],
        ),
      ),
    );
  }
}
