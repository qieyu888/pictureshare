import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';
import 'legal_document_screen.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const LoginScreen({super.key, required this.onComplete});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final StorageService _storage = StorageService();
  bool _agreed = false;

  Future<void> _enterApp() async {
    if (!_agreed) return;
    await _storage.setAgreedToTerms(true);
    widget.onComplete();
  }

  void _openDocument(LegalDocumentType type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LegalDocumentScreen(type: type),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Logo area
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: AppTheme.black,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  size: 44,
                  color: AppTheme.white,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                '光影志',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.gray900,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '记录光影，分享灵感',
                style: TextStyle(
                  fontSize: 15,
                  color: AppTheme.gray400,
                ),
              ),

              const Spacer(flex: 3),

              // Agreement checkbox
              GestureDetector(
                onTap: () => setState(() => _agreed = !_agreed),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 22,
                      height: 22,
                      margin: const EdgeInsets.only(top: 1),
                      decoration: BoxDecoration(
                        color: _agreed ? AppTheme.black : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: _agreed ? AppTheme.black : AppTheme.gray300,
                          width: 1.5,
                        ),
                      ),
                      child: _agreed
                          ? const Icon(Icons.check, size: 14, color: AppTheme.white)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Text(
                            '我已阅读并同意 ',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.gray500,
                              height: 1.5,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _openDocument(LegalDocumentType.userAgreement),
                            child: const Text(
                              '《用户协议》',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.gray900,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                              ),
                            ),
                          ),
                          const Text(
                            ' 和 ',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.gray500,
                              height: 1.5,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _openDocument(LegalDocumentType.privacyPolicy),
                            child: const Text(
                              '《隐私政策》',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.gray900,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Enter button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _agreed ? _enterApp : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.black,
                    foregroundColor: AppTheme.white,
                    disabledBackgroundColor: AppTheme.gray200,
                    disabledForegroundColor: AppTheme.gray400,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    '进入光影志',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
