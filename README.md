# Yaaha - Motorcycle Riding Sharing App

A modern Flutter application for motorcycle enthusiasts to share and discover amazing rides.

## Features

- **Splash Screen**: Beautiful motorcycle-themed launch screen with terms acceptance
- **Four Modules**: Home, Explore, Share, and Profile modules
- **Custom Tab Icons**: Unique motorcycle-themed navigation icons
- **Dark Theme**: Beautiful dark UI with #222222 primary color
- **Modern UI**: Clean and intuitive interface designed for riders
- **Responsive Design**: Works on various screen sizes

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── ride.dart            # Ride data model
├── screens/
│   ├── splash_screen.dart   # Launch screen with background image
│   ├── main_navigation.dart # Bottom navigation management
│   ├── home_screen.dart     # Home module (placeholder)
│   ├── explore_screen.dart  # Explore module (placeholder)
│   ├── share_screen.dart    # Share module (placeholder)
│   ├── profile_screen.dart  # Profile module (placeholder)
│   ├── terms_of_service_screen.dart # Terms of service page
│   └── privacy_policy_screen.dart   # Privacy policy page
├── services/
│   └── ride_service.dart    # Data management and sample data
├── theme/
│   └── app_theme.dart       # App theme configuration
└── widgets/
    ├── ride_card.dart       # Ride display component
    └── bottom_navigation.dart # Custom bottom navigation

assets/
└── images/
    ├── yaaha_login_shadow.png # Splash screen background
    ├── tab_1/                 # Normal tab icons
    │   ├── yaaha_tab_1_nor.png
    │   ├── yaaha_tab_2_nor.png
    │   ├── yaaha_tab_3_nor.png
    │   └── yaaha_tab_4_nor.png
    └── tab_2/                 # Selected tab icons
        ├── yaaha_tab_1_pre.png
        ├── yaaha_tab_2_pre.png
        ├── yaaha_tab_3_pre.png
        └── yaaha_tab_4_pre.png
```

## Screens

### Splash Screen
- Motorcycle-themed background image
- App branding: "RIDE FOR VIEWS"
- Terms of Service and Privacy Policy acceptance
- "Enter Yaaha" button with validation
- Status bar with time and system icons

### Four Main Modules
- **Home Module**: Main dashboard (placeholder)
- **Explore Module**: Discovery and search (placeholder)
- **Share Module**: Content sharing (placeholder)
- **Profile Module**: User profile and settings (placeholder)

### Navigation
- Custom motorcycle-themed tab icons
- White background with shadow
- No text labels, icon-only design
- Smooth transitions between modules

### Legal Pages
- **Terms of Service**: Detailed service terms with clickable links
- **Privacy Policy**: Comprehensive privacy information
- Professional formatting and contact information

## Data Model

The `Ride` model includes:
- Basic info (title, description, image)
- Rider details
- Route information (distance, duration)
- Metadata (tags, rating, likes)
- Technical details (motorcycle model, weather, difficulty)

## Theme

- **Primary Color**: #222222
- **Background**: Dark theme (#1A1A1A)
- **Cards**: #2A2A2A
- **Text**: White and grey variations
- **Tab Bar**: White background with custom icons
- **Material 3**: Modern design system

## Getting Started

1. Ensure you have Flutter installed (Dart >= 3.0)
2. Clone the repository
3. Add the required images:
   - Place `yaaha_login_shadow.png` in `assets/images/`
   - Tab icons are already included in `assets/images/tab_1/` and `assets/images/tab_2/`
4. Run `flutter pub get`
5. Run `flutter run`

## Assets Setup

### Required Images
- **Background**: `assets/images/yaaha_login_shadow.png`
- **Tab Icons**: 
  - Normal state: `assets/images/tab_1/yaaha_tab_X_nor.png`
  - Selected state: `assets/images/tab_2/yaaha_tab_X_pre.png`

### Tab Icon Features
- **Tab 1**: Home icon
- **Tab 2**: Explore icon  
- **Tab 3**: Share icon
- **Tab 4**: Profile icon
- White background with subtle shadow
- No text labels for clean design

## Future Enhancements

- User authentication
- Real-time ride sharing
- GPS tracking and route mapping
- Social features (likes, comments, follows)
- Push notifications
- Offline support
- Advanced filtering and sorting
- Module-specific functionality implementation

## Dependencies

- Flutter SDK
- Material Design components
- Network image loading (built-in)

## Development Notes

- All business logic is separated into service classes
- UI components are modular and reusable
- Theme is centralized for easy customization
- Sample data is provided for testing
- Code follows Flutter best practices
- Splash screen includes terms acceptance validation
- Custom tab navigation with motorcycle-themed icons
