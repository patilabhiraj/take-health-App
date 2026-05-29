import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'profile_dropdown_field.dart';
import 'profile_form_field.dart';
import 'profile_section_label.dart';

class ProfileAccountForm extends StatelessWidget {
  // Basic info
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;

  // Health history
  final TextEditingController medicalController;
  final TextEditingController allergiesController;

  // Dropdown values
  final String gender;
  final String bloodGroup;
  final String diabetic;
  final String region;
  final String country;

  // Dropdown callbacks
  final ValueChanged<String?> onGenderChanged;
  final ValueChanged<String?> onBloodGroupChanged;
  final ValueChanged<String?> onDiabeticChanged;
  final ValueChanged<String?> onRegionChanged;
  final ValueChanged<String?> onCountryChanged;

  final VoidCallback onSave;

  const ProfileAccountForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.ageController,
    required this.heightController,
    required this.weightController,
    required this.medicalController,
    required this.allergiesController,
    required this.gender,
    required this.bloodGroup,
    required this.diabetic,
    required this.region,
    required this.country,
    required this.onGenderChanged,
    required this.onBloodGroupChanged,
    required this.onDiabeticChanged,
    required this.onRegionChanged,
    required this.onCountryChanged,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileFormField(label: 'FULL NAME', controller: nameController),
        const SizedBox(height: 12),
        ProfileFormField(
            label: 'EMAIL', controller: emailController, readOnly: true),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(
            child: ProfileFormField(
              label: 'PHONE',
              controller: phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ProfileFormField(
              label: 'AGE',
              controller: ageController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(
            child: ProfileDropdownField(
              label: 'GENDER',
              value: gender,
              items: const ['Male', 'Female', 'Other', 'Prefer not to say'],
              onChanged: onGenderChanged,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ProfileDropdownField(
              label: 'BLOOD GROUP',
              value: bloodGroup,
              items: const [
                'Select', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
              ],
              onChanged: onBloodGroupChanged,
            ),
          ),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(
            child: ProfileFormField(
              label: 'HEIGHT (CM)',
              controller: heightController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ProfileFormField(
              label: 'WEIGHT (KG)',
              controller: weightController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
          ),
        ]),
        const SizedBox(height: 22),
        const ProfileSectionLabel(label: 'COMPREHENSIVE HEALTH HISTORY'),
        const SizedBox(height: 12),
        ProfileDropdownField(
          label: 'ARE YOU DIABETIC?',
          value: diabetic,
          items: const ['No', 'Yes', 'Pre-diabetic'],
          onChanged: onDiabeticChanged,
        ),
        const SizedBox(height: 12),
        ProfileFormField(
            label: 'MEDICAL CONDITIONS', controller: medicalController),
        const SizedBox(height: 12),
        ProfileFormField(label: 'ALLERGIES', controller: allergiesController),
        const SizedBox(height: 22),
        const ProfileSectionLabel(label: 'FOOD PREFERENCES'),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(
            child: ProfileDropdownField(
              label: 'REGION',
              value: region,
              items: const [
                'Other', 'South Asian', 'East Asian',
                'Mediterranean', 'Western', 'African'
              ],
              onChanged: onRegionChanged,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ProfileDropdownField(
              label: 'COUNTRY',
              value: country,
              items: const ['India', 'USA', 'UK', 'Australia', 'Other'],
              onChanged: onCountryChanged,
            ),
          ),
        ]),
        const SizedBox(height: 22),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A2332),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              elevation: 0,
            ),
            child: const Text(
              'SAVE CHANGES',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
