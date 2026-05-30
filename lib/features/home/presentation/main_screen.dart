import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_health/core/theme/app_colors.dart';
import 'package:take_health/core/theme/theme_cubit.dart';
import 'package:take_health/features/DietPlan/presentation/screen/DietPlanPage.dart';
import 'package:take_health/features/NutritionPage/presentation/screen/NutritionPage.dart';
import 'package:take_health/features/ReportsPage/presentation/screen/ReportsPage.dart';
import 'package:take_health/features/Profile/presentation/bloc/profile_bloc.dart';
import 'package:take_health/features/Profile/presentation/bloc/profile_state.dart';
import 'package:take_health/features/Profile/presentation/screen/profile_page.dart';
import 'package:take_health/features/home/presentation/widgets/quickLogSheet.dart';
import '../../Auth/bloc/auth_bloc.dart';
import 'home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(
        onViewFullPlan: () {
          // Navigate to full diet plan
          setState(() => _currentIndex = 3);
        },
        onUploadReport: () {
          // Navigate to reports page
          setState(() => _currentIndex = 2);
        },
        onNutrition: () {
          // Navigate to nutrition page
          setState(() => _currentIndex = 1);
        },
      ),
      const NutritionPage(),
      const ReportsPage(),
      const DietPlanPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildCommonAppBar(cs),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showQuickLogSheet,
        tooltip: 'Quick Log',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(cs),
    );
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  PreferredSizeWidget _buildCommonAppBar(ColorScheme cs) {
    if (_currentIndex == 1) return _buildNutritionAppBar(cs);
    return AppBar(
      title: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (_, state) {
          final name = state is ProfileLoaded
              ? state.profile.name
              : '';
          final letter = name.isNotEmpty ? name[0].toUpperCase() : 'U';
          final greeting = _greeting();
          return Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                ),
                child: CircleAvatar(
                  backgroundColor: cs.primary,
                  child: Text(
                    letter,
                    style: TextStyle(
                      color: cs.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.isNotEmpty ? 'Hello $name!' : 'Hello!',
                    style: TextStyle(
                      color: cs.onSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    greeting,
                    style: TextStyle(
                      color: cs.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_outlined, color: cs.onSurface),
          onPressed: () {},
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: cs.onSurface),
          onSelected: (value) {
            if (value == 'logout') {
              _showLogoutDialog();
            } else if (value == 'toggle_theme') {
              context.read<ThemeCubit>().toggleTheme();
            } else if (value == 'profile') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            }
          },
          itemBuilder: (context) {
            final isDark = context.read<ThemeCubit>().isDark;
            return [
              const PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person_outline, size: 20),
                    SizedBox(width: 12),
                    Text('Profile'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings_outlined, size: 20),
                    SizedBox(width: 12),
                    Text('Settings'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'toggle_theme',
                child: Row(
                  children: [
                    Icon(
                      isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(isDark ? 'Light Mode' : 'Dark Mode'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, size: 20, color: cs.error),
                    const SizedBox(width: 12),
                    Text('Logout', style: TextStyle(color: cs.error)),
                  ],
                ),
              ),
            ];
          },
        ),
      ],
    );
  }

  PreferredSizeWidget _buildNutritionAppBar(ColorScheme cs) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 16,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nutrition Tracker',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: cs.onSurface,
            ),
          ),
          Text(
            'Achieve wellness goals..',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
      actions: [
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add, size: 15),
          label: const Text('Log Meal'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: cs.primary,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            textStyle: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        IconButton(
          icon: Icon(Icons.camera_alt_outlined, color: cs.onSurface, size: 22),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.mic_outlined, color: cs.onSurface, size: 22),
          onPressed: () {},
          padding: const EdgeInsets.only(right: 8),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(ColorScheme cs) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              label: 'Home',
              index: 0,
            ),
            _buildNavItem(
              icon: Icons.restaurant_menu_outlined,
              activeIcon: Icons.restaurant_menu,
              label: 'Nutrition',
              index: 1,
            ),
            const SizedBox(width: 40), // Space for FAB
            _buildNavItem(
              icon: Icons.description_outlined,
              activeIcon: Icons.description,
              label: 'Reports',
              index: 2,
            ),
            _buildNavItem(
              icon: Icons.apple_outlined,
              activeIcon: Icons.apple,
              label: 'Diet Plan',
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  void _showQuickLogSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: QuickLogSheet(
            onAddMealTap: _handleAddMealTap,
          ),
        );
      },
    );
  }

  void _handleAddMealTap() {
    Navigator.of(context).pop();
    setState(() {
      _currentIndex = 1;
    });
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final isActive = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? activeIcon : icon,
            color: isActive ? context.cNavBarActive : context.cNavBarInactive,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? context.cNavBarActive : context.cNavBarInactive,
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    final cs = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
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
            child: Text(
              'Logout',
              style: TextStyle(color: cs.error),
            ),
          ),
        ],
      ),
    );
  }
}
