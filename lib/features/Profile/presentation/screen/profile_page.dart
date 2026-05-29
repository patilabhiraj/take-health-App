import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_health/features/Auth/bloc/auth_bloc.dart';

import '../widgets/profile_account_form.dart';
import '../widgets/profile_expandable_section.dart';
import '../widgets/profile_floating_button.dart';
import '../widgets/profile_goal_form.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_logout_button.dart';
import '../widgets/profile_menu_card.dart';
import '../widgets/profile_metric_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // ── Scroll ─────────────────────────────────────────────────────────────────
  final _scrollCtrl = ScrollController();
  bool _showScrollTop = false;

  // ── Section visibility ──────────────────────────────────────────────────────
  bool _accountExpanded = false;
  bool _goalsExpanded = false;

  // ── Account controllers ─────────────────────────────────────────────────────
  final _nameCtrl = TextEditingController(text: 'patil');
  final _emailCtrl =
      TextEditingController(text: 'abhirajpatil0111@gmail.com');
  final _phoneCtrl = TextEditingController(text: '7709887654');
  final _ageCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _medicalCtrl = TextEditingController();
  final _allergiesCtrl = TextEditingController();

  // ── Account dropdowns ───────────────────────────────────────────────────────
  String _gender = 'Male';
  String _bloodGroup = 'Select';
  String _diabetic = 'No';
  String _region = 'Other';
  String _country = 'India';

  // ── Goal controllers / dropdowns ────────────────────────────────────────────
  String _healthObjective = 'Maintain weight';
  final _targetWeightCtrl = TextEditingController();
  String _timeframe = '12 Weeks (Sustainable)';

  // ── Menu items ──────────────────────────────────────────────────────────────
  late final List<ProfileMenuItemData> _menuItems = [
    ProfileMenuItemData(
        icon: Icons.description_outlined,
        title: 'Medical Records',
        onTap: () {}),
    ProfileMenuItemData(
        icon: Icons.trending_up_outlined,
        title: 'Progress Reports',
        onTap: () {}),
    ProfileMenuItemData(
        icon: Icons.article_outlined,
        title: 'Terms & Conditions',
        onTap: () {}),
    ProfileMenuItemData(
        icon: Icons.shield_outlined,
        title: 'Privacy Policy',
        onTap: () {}),
  ];

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(() {
      final show = _scrollCtrl.offset > 200;
      if (show != _showScrollTop) setState(() => _showScrollTop = show);
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _ageCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    _medicalCtrl.dispose();
    _allergiesCtrl.dispose();
    _targetWeightCtrl.dispose();
    super.dispose();
  }

  // ── Helpers ─────────────────────────────────────────────────────────────────

  void _scrollToTop() => _scrollCtrl.animateTo(
        0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );

  void _showSnack(String msg) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 2),
        ),
      );

  void _showLogoutDialog() {
    final cs = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Logout',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AuthBloc>().add(AuthLogoutRequested());
            },
            child: Text('Logout',
                style: TextStyle(
                    color: cs.error, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  // ── Build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(cs),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollCtrl,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
            child: Column(
              children: [
                ProfileHeader(
                  name: 'patil',
                  email: 'abhirajpatil0111@gmail.com',
                ),
                const SizedBox(height: 20),
                Row(children: [
                  Expanded(
                    child: ProfileMetricCard(
                      iconBg: const Color(0xFFE8F5E9),
                      icon: Icons.favorite_outline_rounded,
                      iconColor: const Color(0xFF4CAF50),
                      title: 'Health Score',
                      value: '92',
                      valueSuffix: '/ 100',
                      subtitle: 'Top 5% for your age',
                      subtitleColor: const Color(0xFF4CAF50),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ProfileMetricCard(
                      iconBg: const Color(0xFFE3F2FD),
                      icon: Icons.monitor_heart_outlined,
                      iconColor: const Color(0xFF2196F3),
                      title: 'Current BMI',
                      value: '22.4',
                      chip: 'N/A',
                    ),
                  ),
                ]),
                const SizedBox(height: 16),
                ProfileExpandableSection(
                  icon: Icons.person_outline_rounded,
                  title: 'Account Details',
                  expanded: _accountExpanded,
                  onToggle: () =>
                      setState(() => _accountExpanded = !_accountExpanded),
                  child: ProfileAccountForm(
                    nameController: _nameCtrl,
                    emailController: _emailCtrl,
                    phoneController: _phoneCtrl,
                    ageController: _ageCtrl,
                    heightController: _heightCtrl,
                    weightController: _weightCtrl,
                    medicalController: _medicalCtrl,
                    allergiesController: _allergiesCtrl,
                    gender: _gender,
                    bloodGroup: _bloodGroup,
                    diabetic: _diabetic,
                    region: _region,
                    country: _country,
                    onGenderChanged: (v) =>
                        setState(() => _gender = v ?? _gender),
                    onBloodGroupChanged: (v) =>
                        setState(() => _bloodGroup = v ?? _bloodGroup),
                    onDiabeticChanged: (v) =>
                        setState(() => _diabetic = v ?? _diabetic),
                    onRegionChanged: (v) =>
                        setState(() => _region = v ?? _region),
                    onCountryChanged: (v) =>
                        setState(() => _country = v ?? _country),
                    onSave: () => _showSnack('Profile updated successfully'),
                  ),
                ),
                const SizedBox(height: 12),
                ProfileExpandableSection(
                  icon: Icons.track_changes_rounded,
                  title: 'Goal Settings',
                  expanded: _goalsExpanded,
                  onToggle: () =>
                      setState(() => _goalsExpanded = !_goalsExpanded),
                  child: ProfileGoalForm(
                    healthObjective: _healthObjective,
                    targetWeightController: _targetWeightCtrl,
                    timeframe: _timeframe,
                    onObjectiveChanged: (v) =>
                        setState(() => _healthObjective = v ?? _healthObjective),
                    onTimeframeChanged: (v) =>
                        setState(() => _timeframe = v ?? _timeframe),
                    onSync: () => _showSnack('Fitness plan synced'),
                  ),
                ),
                const SizedBox(height: 12),
                ProfileMenuCard(items: _menuItems),
                const SizedBox(height: 12),
                ProfileLogoutButton(onTap: _showLogoutDialog),
              ],
            ),
          ),
          _FloatingOverlay(
            showScrollTop: _showScrollTop,
            onScrollTop: _scrollToTop,
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ColorScheme cs) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest.withValues(alpha: 0.55),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_back_ios_new_rounded,
                size: 17, color: cs.onSurface),
          ),
        ),
      ),
      title: Text(
        'My Profile',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: cs.onSurface,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_outlined, color: cs.onSurface),
          onPressed: () {},
        ),
      ],
    );
  }
}

// ── Floating overlay (extracted so build stays clean) ──────────────────────

class _FloatingOverlay extends StatelessWidget {
  final bool showScrollTop;
  final VoidCallback onScrollTop;

  const _FloatingOverlay({
    required this.showScrollTop,
    required this.onScrollTop,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Positioned(
      right: 16,
      bottom: 24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSlide(
            offset: showScrollTop ? Offset.zero : const Offset(0, 1.5),
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            child: AnimatedOpacity(
              opacity: showScrollTop ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 250),
              child: ProfileFloatingButton(
                icon: Icons.keyboard_arrow_up_rounded,
                color: const Color(0xFF2D3748),
                onTap: onScrollTop,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ProfileFloatingButton(
            icon: Icons.chat_bubble_outline_rounded,
            color: cs.primary,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
