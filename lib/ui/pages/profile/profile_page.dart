import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:launionweb/l10n/app_localizations.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/loyalty_provider.dart';
import '../../../providers/order_provider.dart';
import '../../../ui/shared/app_button.dart';
import '../../../ui/shared/app_card.dart';
import '../../../config/constants.dart';
import '../../../config/theme.dart';
import '../../../utils/formatters.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final user = ref.read(authProvider);
    if (user != null) {
      _nameController.text = user.name ?? '';
      _phoneController.text = user.phone ?? '';
      _emailController.text = user.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(authProvider);
    final loyaltyState = ref.watch(loyaltyProvider);
    final orders = ref.watch(orderProvider);

    if (user == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_outline, size: 64, color: AppTheme.lightGrey),
            const SizedBox(height: AppConstants.lg),
            Text(
              AppLocalizations.of(context)!.signInToAccessProfile,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: AppConstants.xl),
            AppButton(
              text: AppLocalizations.of(context)!.signIn,
              onPressed: () {
                // Navigate to sign in
              },
              primary: true,
              width: 200,
            ),
            const SizedBox(height: AppConstants.md),
            TextButton(
              onPressed: () {
                // Create account
              },
              child: Text(AppLocalizations.of(context)!.createAccount),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.lg),
      child: Column(
        children: [
          // Profile header
          AppCard(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppTheme.spicyRed,
                  child: Text(
                    user.name?.substring(0, 1).toUpperCase() ?? 'U',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.md),
                Text(
                  user.name ?? AppLocalizations.of(context)!.customer,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  user.email,
                  style: TextStyle(
                    color: AppTheme.charcoal.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: AppConstants.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatColumn(
                      AppLocalizations.of(context)!.ordersCount,
                      '${orders.length}',
                    ),
                    _buildStatColumn(
                      AppLocalizations.of(context)!.points,
                      '${loyaltyState.points}',
                    ),
                    _buildStatColumn(
                      AppLocalizations.of(context)!.memberSince,
                      Formatters.formatDate(DateTime.parse(user.createdAt)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.xl),
          // Profile form
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.personalInformation,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() => _isEditing = !_isEditing);
                        if (!_isEditing) {
                          _saveProfile();
                        }
                      },
                      icon: Icon(
                        _isEditing ? Icons.save : Icons.edit,
                        color: AppTheme.spicyRed,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.lg),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.fullName,
                    border: const OutlineInputBorder(),
                  ),
                  enabled: _isEditing,
                ),
                const SizedBox(height: AppConstants.md),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.email,
                    border: const OutlineInputBorder(),
                  ),
                  enabled: false, // Email cannot be changed
                ),
                const SizedBox(height: AppConstants.md),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.phoneNumber,
                    border: const OutlineInputBorder(),
                  ),
                  enabled: _isEditing,
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.xl),
          // Quick actions
          Text(
            AppLocalizations.of(context)!.quickActionsLabel,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppTheme.citrusOrange),
          ),
          const SizedBox(height: AppConstants.md),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: AppConstants.md,
            mainAxisSpacing: AppConstants.md,
            childAspectRatio: 1.5,
            children: [
              _buildActionCard(
                icon: Icons.history,
                label: AppLocalizations.of(context)!.orderHistory,
                onTap: () => context.go('/orders'),
              ),
              _buildActionCard(
                icon: Icons.loyalty,
                label: AppLocalizations.of(context)!.navLoyalty,
                onTap: () => context.go('/loyalty'),
              ),
              _buildActionCard(
                icon: Icons.location_on,
                label: AppLocalizations.of(context)!.findTruck,
                onTap: () => context.go('/location'),
              ),
              _buildActionCard(
                icon: Icons.settings,
                label: AppLocalizations.of(context)!.settings,
                onTap: () {
                  // Open settings
                },
              ),
            ],
          ),
          const SizedBox(height: AppConstants.xl),
          // Account actions
          AppCard(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: Text(AppLocalizations.of(context)!.notifications),
                  trailing: Switch(value: true, onChanged: (value) {}),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.privacy_tip),
                  title: Text(AppLocalizations.of(context)!.privacyPolicy),
                  onTap: () {
                    // Open privacy policy
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: Text(AppLocalizations.of(context)!.helpSupport),
                  onTap: () {
                    // Open help
                  },
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.logout, color: AppTheme.spicyRed),
                  title: Text(
                    AppLocalizations.of(context)!.signOut,
                    style: TextStyle(color: AppTheme.spicyRed),
                  ),
                  onTap: () {
                    _signOut();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.xxl),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppTheme.spicyRed,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppTheme.charcoal.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: AppTheme.spicyRed),
              const SizedBox(height: AppConstants.md),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveProfile() async {
    try {
      await ref
          .read(authProvider.notifier)
          .updateProfile(_nameController.text, _phoneController.text);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.profileUpdated),
          backgroundColor: AppTheme.avocadoGreen,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.profileUpdateFailed(e.toString()),
          ),
          backgroundColor: AppTheme.spicyRed,
        ),
      );
    }
  }

  void _signOut() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.signOut),
        content: Text(AppLocalizations.of(context)!.signOutConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(authProvider.notifier).signOut();
              Navigator.pop(context);
              context.go('/');
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.spicyRed),
            child: Text(AppLocalizations.of(context)!.signOut),
          ),
        ],
      ),
    );
  }
}
