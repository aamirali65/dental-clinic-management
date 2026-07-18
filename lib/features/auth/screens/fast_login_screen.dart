import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';

enum _AuthStep { social, email, password, registerName, registerPassword }

class FastLoginScreen extends ConsumerStatefulWidget {
  const FastLoginScreen({super.key});

  @override
  ConsumerState<FastLoginScreen> createState() => _FastLoginScreenState();
}

class _FastLoginScreenState extends ConsumerState<FastLoginScreen> {
  _AuthStep _currentStep = _AuthStep.social;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureRegisterPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _registerPasswordController.dispose();
    super.dispose();
  }

  void _goToStep(_AuthStep step) {
    setState(() => _currentStep = step);
  }

  void _onContinueToPassword() {
    final email = _emailController.text.trim();
    if (email.contains('@') && email.contains('.')) {
      _goToStep(_AuthStep.password);
    }
  }

  void _onSignIn() {
    if (_passwordController.text.isNotEmpty) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(milliseconds: 1200), () {
        if (mounted) {
          setState(() => _isLoading = false);
          context.go('/dashboard');
        }
      });
    }
  }

  void _onContinueToRegisterPassword() {
    if (_nameController.text.trim().isNotEmpty) {
      _goToStep(_AuthStep.registerPassword);
    }
  }

  void _onRegister() {
    if (_registerPasswordController.text.length >= 6) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(milliseconds: 1200), () {
        if (mounted) {
          setState(() => _isLoading = false);
          context.go('/complete-profile');
        }
      });
    }
  }

  void _goBack() {
    switch (_currentStep) {
      case _AuthStep.email:
        _goToStep(_AuthStep.social);
      case _AuthStep.password:
        _goToStep(_AuthStep.email);
      case _AuthStep.registerName:
        _goToStep(_AuthStep.social);
      case _AuthStep.registerPassword:
        _goToStep(_AuthStep.registerName);
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.textDark;
    final subTextColor = isDark ? AppColors.textLight : AppColors.textGrey;
    final fillColor = isDark ? AppColors.darkCard : AppColors.borderLight;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.border;
    final dividerColor = isDark ? AppColors.darkBorder : AppColors.border;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.md),
              _buildHeader(isDark, textColor, borderColor),
              const SizedBox(height: AppSpacing.xxl),
              _buildBrand(isDark),
              const SizedBox(height: AppSpacing.xxxl),
              Expanded(
                child: AnimatedSwitcher(
                  duration: 350.ms,
                  switchInCurve: Curves.easeOutBack,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: Tween(begin: 0.92, end: 1.0).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: _buildStepContent(ValueKey(_currentStep), isDark, textColor, subTextColor, fillColor, borderColor, dividerColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark, Color textColor, Color borderColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_currentStep != _AuthStep.social)
          GestureDetector(
            onTap: _goBack,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Icon(Icons.arrow_back_rounded, size: 18, color: textColor),
            ),
          )
        else
          const SizedBox(width: 38),
        Text(
          'DentalFix',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 38),
      ],
    );
  }

  Widget _buildBrand(bool isDark) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          ),
          child: const Icon(Icons.medical_services_rounded, color: AppColors.primary, size: 26),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'dental care, reimagined.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isDark ? AppColors.textLight : AppColors.textGrey,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStepContent(ValueKey key, bool isDark, Color textColor, Color subTextColor, Color fillColor, Color borderColor, Color dividerColor) {
    switch (_currentStep) {
      case _AuthStep.social:
        return _buildSocialStep(key, isDark, textColor, subTextColor, borderColor, dividerColor);
      case _AuthStep.email:
        return _buildEmailStep(key, textColor, subTextColor, fillColor, borderColor);
      case _AuthStep.password:
        return _buildPasswordStep(key, textColor, subTextColor, fillColor, borderColor);
      case _AuthStep.registerName:
        return _buildRegisterNameStep(key, textColor, subTextColor, fillColor, borderColor);
      case _AuthStep.registerPassword:
        return _buildRegisterPasswordStep(key, textColor, subTextColor, fillColor, borderColor);
    }
  }

  Widget _buildSocialStep(ValueKey key, bool isDark, Color textColor, Color subTextColor, Color borderColor, Color dividerColor) {
    return SingleChildScrollView(
      key: key,
      child: Column(
        children: [
          Text(
            "Get started",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: textColor,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Manage your practice in seconds.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: subTextColor,
            ),
          ),
          const SizedBox(height: 44),
          _SocialButton(
            icon: Icons.g_mobiledata_rounded,
            label: 'Continue with Google',
            onTap: () {},
            iconColor: const Color(0xFF4285F4),
            borderColor: borderColor,
            textColor: textColor,
          ),
          const SizedBox(height: AppSpacing.md),
          _SocialButton(
            icon: Icons.facebook,
            label: 'Continue with Facebook',
            onTap: () {},
            iconColor: const Color(0xFF1877F2),
            borderColor: borderColor,
            textColor: textColor,
          ),
          const SizedBox(height: AppSpacing.md),
          _SocialButton(
            icon: Icons.apple_rounded,
            label: 'Continue with Apple',
            onTap: () {},
            iconColor: isDark ? Colors.white : Colors.black,
            borderColor: borderColor,
            textColor: textColor,
          ),
          const SizedBox(height: AppSpacing.xxl),
          Row(
            children: [
              Expanded(child: Divider(color: dividerColor)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Text(
                  'or',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(child: Divider(color: dividerColor)),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
          _EmailOptionButton(onTap: () => _goToStep(_AuthStep.email), borderColor: borderColor),
          const SizedBox(height: AppSpacing.xxl),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "New to DentalFix? ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: subTextColor,
                ),
              ),
              GestureDetector(
                onTap: () => _goToStep(_AuthStep.registerName),
                child: const Text(
                  'Create account',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }

  Widget _buildEmailStep(ValueKey key, Color textColor, Color subTextColor, Color fillColor, Color borderColor) {
    return SingleChildScrollView(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What's your\nemail?",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: textColor,
              height: 1.15,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Enter your email',
              filled: true,
              fillColor: fillColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
              prefixIcon: const Icon(Icons.email_outlined, size: 20, color: AppColors.textGrey),
            ),
            style: TextStyle(fontSize: 17, color: textColor),
            onSubmitted: (_) => _onContinueToPassword(),
          ),
          const SizedBox(height: AppSpacing.xxxl),
          AppButton(
            label: 'Continue',
            onPressed: _onContinueToPassword,
            isFullWidth: true,
            isLarge: true,
          ),
          SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }

  Widget _buildPasswordStep(ValueKey key, Color textColor, Color subTextColor, Color fillColor, Color borderColor) {
    return SingleChildScrollView(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome back.",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: textColor,
              height: 1.15,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.email_outlined, size: 14, color: subTextColor),
              const SizedBox(width: 6),
              Text(
                _emailController.text,
                style: TextStyle(
                  fontSize: 14,
                  color: subTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => _goToStep(_AuthStep.email),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
                  ),
                  child: const Icon(Icons.edit, size: 14, color: AppColors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text(
            "Enter your\npassword",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: textColor,
              height: 1.15,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              filled: true,
              fillColor: fillColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
              prefixIcon: const Icon(Icons.lock_outlined, size: 20, color: AppColors.textGrey),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                  size: 20,
                  color: AppColors.textGrey,
                ),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            style: TextStyle(fontSize: 17, color: textColor),
            onSubmitted: (_) => _onSignIn(),
          ),
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => context.go('/forgot-password'),
              child: const Text('Forgot password?'),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            label: 'Sign In',
            onPressed: _onSignIn,
            isFullWidth: true,
            isLarge: true,
            isLoading: _isLoading,
          ),
          SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }

  Widget _buildRegisterNameStep(ValueKey key, Color textColor, Color subTextColor, Color fillColor, Color borderColor) {
    return SingleChildScrollView(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Let's get\nto know you",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: textColor,
              height: 1.15,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            "What should we call you?",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: subTextColor,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          TextField(
            controller: _nameController,
            textInputAction: TextInputAction.next,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Your full name',
              filled: true,
              fillColor: fillColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
              prefixIcon: const Icon(Icons.person_outlined, size: 20, color: AppColors.textGrey),
            ),
            style: TextStyle(fontSize: 17, color: textColor),
            onSubmitted: (_) => _onContinueToRegisterPassword(),
          ),
          const SizedBox(height: AppSpacing.xxxl),
          AppButton(
            label: 'Continue',
            onPressed: _onContinueToRegisterPassword,
            isFullWidth: true,
            isLarge: true,
          ),
          SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }

  Widget _buildRegisterPasswordStep(ValueKey key, Color textColor, Color subTextColor, Color fillColor, Color borderColor) {
    final firstName = _nameController.text.trim().split(' ').first;
    return SingleChildScrollView(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: const Text(
              'Step 2 of 2',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.success,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            "Create your\npassword",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: textColor,
              height: 1.15,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            firstName.isNotEmpty ? "Hi, $firstName!" : "Let's do this!",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          TextField(
            controller: _registerPasswordController,
            obscureText: _obscureRegisterPassword,
            textInputAction: TextInputAction.done,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Create a password',
              filled: true,
              fillColor: fillColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
              prefixIcon: const Icon(Icons.lock_outlined, size: 20, color: AppColors.textGrey),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureRegisterPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                  size: 20,
                  color: AppColors.textGrey,
                ),
                onPressed: () => setState(() => _obscureRegisterPassword = !_obscureRegisterPassword),
              ),
            ),
            style: TextStyle(fontSize: 17, color: textColor),
            onSubmitted: (_) => _onRegister(),
          ),
          const SizedBox(height: AppSpacing.xxxl),
          AppButton(
            label: 'Create Account',
            onPressed: _onRegister,
            isFullWidth: true,
            isLarge: true,
            isLoading: _isLoading,
          ),
          SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color iconColor;
  final Color borderColor;
  final Color textColor;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.iconColor,
    required this.borderColor,
    required this.textColor,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isPressed ? 0.97 : 1.0,
      duration: 100.ms,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: widget.borderColor),
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, size: 22, color: widget.iconColor),
              const SizedBox(width: AppSpacing.md),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: widget.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailOptionButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color borderColor;
  const _EmailOptionButton({required this.onTap, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.email_outlined, size: 20, color: AppColors.primary),
            const SizedBox(width: AppSpacing.sm),
            const Text(
              'Sign in with email',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
