import 'package:flutter/material.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Terms of Service',
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
              'Terms of Service',
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
              '1. Acceptance of Terms',
              'By accessing and using the Yaaha motorcycle riding sharing app, you accept and agree to be bound by the terms and provision of this agreement.',
            ),
            
            _buildSection(
              '2. Use License',
              'Permission is granted to temporarily download one copy of the app per device for personal, non-commercial transitory viewing only.',
            ),
            
            _buildSection(
              '3. Ride Sharing Guidelines',
              'Users must follow all local traffic laws and regulations when sharing rides. All content must be accurate and not misleading.',
            ),
            
            _buildSection(
              '4. User Responsibilities',
              'You are responsible for maintaining the confidentiality of your account and for all activities that occur under your account.',
            ),
            
            _buildSection(
              '5. Content Guidelines',
              'All shared rides must be real experiences. Users are prohibited from posting fake or misleading content.',
            ),
            
            _buildSection(
              '6. Safety First',
              'Yaaha promotes safe riding practices. Users must not encourage dangerous or illegal riding behavior.',
            ),
            
            _buildSection(
              '7. Privacy Protection',
              'We respect your privacy and will protect your personal information in accordance with our Privacy Policy.',
            ),
            
            _buildSection(
              '8. Community Guidelines',
              'Be respectful to other riders. Harassment, hate speech, or inappropriate content will not be tolerated.',
            ),
            
            _buildSection(
              '9. Intellectual Property',
              'The app and its original content, features, and functionality are owned by Yaaha and are protected by international copyright, trademark, patent, trade secret, and other intellectual property laws.',
            ),
            
            _buildSection(
              '10. Termination',
              'We may terminate or suspend your account and bar access to the service immediately, without prior notice or liability, under our sole discretion, for any reason whatsoever.',
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
              'If you have any questions about these Terms of Service, please contact us at:',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Email: support@yaaha.com',
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