import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF222222),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Last updated: December 2025',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            
            _buildSection(
              '1. Information We Collect',
              'We collect information you provide directly to us, such as when you create an account, share rides, or contact us for support. This may include your name, email address, profile information, and ride data.',
            ),
            
            _buildSection(
              '2. How We Use Your Information',
              'We use the information we collect to provide, maintain, and improve our services, communicate with you, and ensure the safety of our community.',
            ),
            
            _buildSection(
              '3. Location Data',
              'With your permission, we may collect and use your location data to show nearby rides, track your routes, and provide location-based features. You can control location permissions in your device settings.',
            ),
            
            _buildSection(
              '4. Ride Sharing Data',
              'When you share rides, we collect information about your routes, photos, and descriptions. This information is shared with the community as part of our ride sharing features.',
            ),
            
            _buildSection(
              '5. Data Security',
              'We implement appropriate security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.',
            ),
            
            _buildSection(
              '6. Data Sharing',
              'We do not sell your personal information. We may share your information with service providers who assist us in operating our app, or when required by law.',
            ),
            
            _buildSection(
              '7. Your Rights',
              'You have the right to access, correct, or delete your personal information. You can also control your privacy settings through the app.',
            ),
            
            _buildSection(
              '8. Cookies and Tracking',
              'We use cookies and similar technologies to enhance your experience, analyze app usage, and provide personalized content.',
            ),
            
            _buildSection(
              '9. Children\'s Privacy',
              'Our app is not intended for children under 13. We do not knowingly collect personal information from children under 13.',
            ),
            
            _buildSection(
              '10. International Transfers',
              'Your information may be transferred to and processed in countries other than your own. We ensure appropriate safeguards are in place.',
            ),
            
            _buildSection(
              '11. Changes to This Policy',
              'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new policy on this page.',
            ),
            
            _buildSection(
              '12. Contact Us',
              'If you have any questions about this Privacy Policy, please contact us using the information provided below.',
            ),
            
            const SizedBox(height: 30),
            const Text(
              'Contact Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'For privacy-related questions or concerns:',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Email: privacy@yaaha.com\n',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
} 