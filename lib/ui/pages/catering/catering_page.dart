import 'package:flutter/material.dart';
import '../../../config/constants.dart';
import '../../../config/theme.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';

import '../../widgets/web_footer.dart';

class CateringPage extends StatefulWidget {
  const CateringPage({super.key});

  @override
  State<CateringPage> createState() => _CateringPageState();
}

class _CateringPageState extends State<CateringPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppConstants.xl),
            child: Center(
              child: Text(
                l10n.cateringTitle,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.lg),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.cateringHeadline,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.charcoal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConstants.md),
                  Text(
                    l10n.cateringSubtitle,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: AppConstants.xl),

                  _buildTextField(l10n.fullName, Icons.person),
                  const SizedBox(height: AppConstants.md),
                  _buildTextField(
                    l10n.email, // reusing existing email key
                    Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: AppConstants.md),
                  _buildTextField(
                    l10n.phone, // reusing existing phone key (or phoneNumber)
                    Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: AppConstants.md),
                  _buildTextField(l10n.eventDate, Icons.calendar_today),
                  const SizedBox(height: AppConstants.md),
                  _buildTextField(
                    l10n.guestCount,
                    Icons.group,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: AppConstants.md),
                  _buildTextField(
                    l10n.additionalDetails,
                    Icons.note,
                    maxLines: 4,
                  ),

                  const SizedBox(height: AppConstants.xl),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.requestSent),
                              backgroundColor: AppTheme.avocadoGreen,
                            ),
                          );
                          context.pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.spicyRed,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        l10n.submitRequest,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const WebFooter(),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    IconData icon, {
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    // ... same as before but helper method doesn't need changes if passed localized strings
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppTheme.citrusOrange),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        alignLabelWithHint: maxLines > 1,
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.requiredField(label);
        }
        return null;
      },
    );
  }
}
