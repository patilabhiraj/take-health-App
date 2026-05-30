import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:take_health/features/Auth/bloc/auth_bloc.dart';
import 'package:take_health/features/ai_chat/presentation/screen/ai_chat_page.dart';
import 'package:take_health/features/Profile/domain/entities/profile_update_data.dart';
import 'package:take_health/features/Profile/domain/entities/user_profile.dart';
import 'package:take_health/features/Profile/presentation/bloc/profile_bloc.dart';
import 'package:take_health/features/Profile/presentation/bloc/profile_event.dart';
import 'package:take_health/features/Profile/presentation/bloc/profile_state.dart';

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
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
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

  // ── Lifecycle ───────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(() {
      final show = _scrollCtrl.offset > 200;
      if (show != _showScrollTop) setState(() => _showScrollTop = show);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileBloc>().add(ProfileLoadRequested());
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

  void _populateFromProfile(UserProfile p) {
    _nameCtrl.text = p.name;
    _emailCtrl.text = p.email;
    if (p.phone != null) _phoneCtrl.text = p.phone!;
    if (p.age != null) _ageCtrl.text = '${p.age}';
    if (p.height != null && p.height! > 0) {
      _heightCtrl.text = p.height!.toStringAsFixed(0);
    }
    if (p.weight != null && p.weight! > 0) {
      _weightCtrl.text = p.weight!.toStringAsFixed(1);
    }
    if (p.allergies.isNotEmpty) {
      _allergiesCtrl.text = p.allergies.join(', ');
    }
    if (p.chronicConditions.isNotEmpty) {
      _medicalCtrl.text = p.chronicConditions.join(', ');
    }
    if (!mounted) return;
    setState(() {
      if (p.gender != null && p.gender!.isNotEmpty) {
        _gender = '${p.gender![0].toUpperCase()}${p.gender!.substring(1)}';
      }
      if (p.bloodGroup != null && p.bloodGroup!.isNotEmpty) {
        _bloodGroup = p.bloodGroup!;
      }
      _diabetic = p.isDiabetic ? 'Yes' : 'No';
      if (p.targetWeight != null && p.targetWeight! > 0) {
        _targetWeightCtrl.text = p.targetWeight!.toStringAsFixed(1);
      }
      if (p.primaryGoal != null && p.primaryGoal!.isNotEmpty) {
        _healthObjective = p.primaryGoal!;
      }
    });
  }

  void _scrollToTop() => _scrollCtrl.animateTo(
        0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );

  void _showSnack(String msg, {bool isError = false}) {
    final cs = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? cs.error : cs.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _saveProfile() {
    final data = ProfileUpdateData(
      name: _nameCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      age: int.tryParse(_ageCtrl.text.trim()),
      gender: _gender.toLowerCase(),
      height: double.tryParse(_heightCtrl.text.trim()),
      weight: double.tryParse(_weightCtrl.text.trim()),
      bloodGroup: _bloodGroup,
      allergies: _allergiesCtrl.text.trim().isEmpty
          ? []
          : _allergiesCtrl.text
              .split(',')
              .map((s) => s.trim())
              .where((s) => s.isNotEmpty)
              .toList(),
      chronicConditions: _medicalCtrl.text.trim().isEmpty
          ? []
          : _medicalCtrl.text
              .split(',')
              .map((s) => s.trim())
              .where((s) => s.isNotEmpty)
              .toList(),
      isDiabetic: _diabetic.toLowerCase() == 'yes',
    );
    context.read<ProfileBloc>().add(ProfileUpdateRequested(data));
  }

  Future<void> _pickAndUploadPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 800,
    );
    if (picked == null || !mounted) return;
    context
        .read<ProfileBloc>()
        .add(ProfilePictureUploadRequested(picked.path));
  }

  void _showLogoutDialog() {
    final cs = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                style: TextStyle(color: cs.error, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  // ── Build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (_, state) {
        if (state is ProfileLoaded) {
          _populateFromProfile(state.profile);
          if (state.saveSuccess) {
            _showSnack('Profile updated successfully ✓');
          } else if (state.saveError != null) {
            _showSnack(state.saveError!, isError: true);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: _buildAppBar(cs),
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollCtrl,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              child: Column(
                children: [
                  // ── Header (real name/email/stats) ──────────────────────
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (_, state) {
                      final p = state is ProfileLoaded
                          ? state.profile
                          : state is ProfileSaving
                              ? state.current
                              : null;
                      if (state is ProfileLoading && p == null) {
                        return const _LoadingHeader();
                      }
                      return ProfileHeader(
                        name: p?.name ?? '',
                        email: p?.email ?? '',
                        profilePicture: p?.profilePicture,
                        age: p?.ageLabel,
                        gender: p?.genderLabel,
                        height: p?.heightLabel,
                        onCameraTab: state is ProfileSaving
                            ? null
                            : _pickAndUploadPhoto,
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // ── Metric Cards (real BMI / health score) ──────────────
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (_, state) {
                      final p =
                          state is ProfileLoaded ? state.profile : null;
                      final score = p?.healthScore ?? 0;
                      final bmi = p?.displayBmi ?? '—';
                      return Row(
                        children: [
                          Expanded(
                            child: ProfileMetricCard(
                              iconBg: const Color(0xFFE8F5E9),
                              icon: Icons.favorite_outline_rounded,
                              iconColor: const Color(0xFF4CAF50),
                              title: 'Health Score',
                              value: score > 0 ? '$score' : '—',
                              valueSuffix: '/ 100',
                              subtitle: score >= 90
                                  ? 'Top 5% for your age'
                                  : score > 0
                                      ? 'Keep improving!'
                                      : 'Not calculated',
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
                              value: bmi,
                              chip: bmi == '—' ? 'N/A' : null,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // ── Account Details ─────────────────────────────────────
                  ProfileExpandableSection(
                    icon: Icons.person_outline_rounded,
                    title: 'Account Details',
                    expanded: _accountExpanded,
                    onToggle: () =>
                        setState(() => _accountExpanded = !_accountExpanded),
                    child: BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (_, state) => ProfileAccountForm(
                        isSaving: state is ProfileSaving,
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
                        onSave: _saveProfile,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── Goal Settings ───────────────────────────────────────
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
                      onObjectiveChanged: (v) => setState(
                          () => _healthObjective = v ?? _healthObjective),
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
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (ctx, state) => IconButton(
            icon: Icon(Icons.refresh_rounded,
                color: state is ProfileLoading
                    ? cs.onSurfaceVariant
                    : cs.onSurface),
            onPressed: state is ProfileLoading
                ? null
                : () => ctx
                    .read<ProfileBloc>()
                    .add(ProfileRefreshRequested()),
            tooltip: 'Refresh profile',
          ),
        ),
      ],
    );
  }
}

// ── Loading placeholder ────────────────────────────────────────────────────

class _LoadingHeader extends StatelessWidget {
  const _LoadingHeader();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        CircleAvatar(
          radius: 38,
          backgroundColor: cs.surfaceContainerHighest,
          child: CircularProgressIndicator(
              strokeWidth: 2, color: cs.primary),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 100,
                height: 14,
                decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(6))),
            const SizedBox(height: 8),
            Container(
                width: 160,
                height: 11,
                decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(6))),
          ],
        ),
      ],
    );
  }
}

// ── Floating overlay ───────────────────────────────────────────────────────

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
            onTap: () => Navigator.push(context, AiChatPage.route()),
          ),
        ],
      ),
    );
  }
}
