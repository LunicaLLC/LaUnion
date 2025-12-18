import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'La Union Food Truck'**
  String get appTitle;

  /// No description provided for @heroTitle.
  ///
  /// In en, this message translates to:
  /// **'Pupuseria y Taquería'**
  String get heroTitle;

  /// No description provided for @heroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Authentic Salvadoran Street Food'**
  String get heroSubtitle;

  /// No description provided for @heroDescription.
  ///
  /// In en, this message translates to:
  /// **'Family owned and operated. Bringing the taste of home to you.'**
  String get heroDescription;

  /// No description provided for @btnOrderNow.
  ///
  /// In en, this message translates to:
  /// **'Order Now'**
  String get btnOrderNow;

  /// No description provided for @btnFindTruck.
  ///
  /// In en, this message translates to:
  /// **'Find Truck'**
  String get btnFindTruck;

  /// No description provided for @homeLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Live Truck Location'**
  String get homeLocationTitle;

  /// No description provided for @mapComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Map Integration Coming Soon'**
  String get mapComingSoon;

  /// No description provided for @currentLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Current Location:'**
  String get currentLocationLabel;

  /// No description provided for @nextDepartureLabel.
  ///
  /// In en, this message translates to:
  /// **'Next Departure:'**
  String get nextDepartureLabel;

  /// No description provided for @notifyMe.
  ///
  /// In en, this message translates to:
  /// **'Notify Me'**
  String get notifyMe;

  /// No description provided for @menuTitle.
  ///
  /// In en, this message translates to:
  /// **'Our Menu'**
  String get menuTitle;

  /// No description provided for @cartTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Cart'**
  String get cartTitle;

  /// No description provided for @checkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkoutTitle;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @orderHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Order History'**
  String get orderHistoryTitle;

  /// No description provided for @loyaltyTitle.
  ///
  /// In en, this message translates to:
  /// **'Loyalty Program'**
  String get loyaltyTitle;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @adminDashboard.
  ///
  /// In en, this message translates to:
  /// **'Admin Dashboard'**
  String get adminDashboard;

  /// No description provided for @footerRights.
  ///
  /// In en, this message translates to:
  /// **'© 2024 La Union Food Truck. All rights reserved.'**
  String get footerRights;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @restartApp.
  ///
  /// In en, this message translates to:
  /// **'Restart App'**
  String get restartApp;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get navMenu;

  /// No description provided for @navLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get navLocation;

  /// No description provided for @navLoyalty.
  ///
  /// In en, this message translates to:
  /// **'Loyalty'**
  String get navLoyalty;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @navAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get navAbout;

  /// No description provided for @signInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButton;

  /// No description provided for @cateringTitle.
  ///
  /// In en, this message translates to:
  /// **'Catering Services'**
  String get cateringTitle;

  /// No description provided for @cateringHeadline.
  ///
  /// In en, this message translates to:
  /// **'Bring La Union to Your Event'**
  String get cateringHeadline;

  /// No description provided for @cateringSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Authentic flavors for your special occasions'**
  String get cateringSubtitle;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone;

  /// No description provided for @eventDate.
  ///
  /// In en, this message translates to:
  /// **'Event Date'**
  String get eventDate;

  /// No description provided for @guestCount.
  ///
  /// In en, this message translates to:
  /// **'Number of Guests'**
  String get guestCount;

  /// No description provided for @additionalDetails.
  ///
  /// In en, this message translates to:
  /// **'Additional Details'**
  String get additionalDetails;

  /// No description provided for @requestSent.
  ///
  /// In en, this message translates to:
  /// **'Catering Request Sent!'**
  String get requestSent;

  /// No description provided for @submitRequest.
  ///
  /// In en, this message translates to:
  /// **'Submit Request'**
  String get submitRequest;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @orderReview.
  ///
  /// In en, this message translates to:
  /// **'Review Order'**
  String get orderReview;

  /// No description provided for @itemCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 Item} other{{count} Items}}'**
  String itemCount(num count);

  /// No description provided for @pickupTime.
  ///
  /// In en, this message translates to:
  /// **'Pickup Time'**
  String get pickupTime;

  /// No description provided for @customerInfo.
  ///
  /// In en, this message translates to:
  /// **'Customer Info'**
  String get customerInfo;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @placeOrder.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get placeOrder;

  /// No description provided for @continueStep.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueStep;

  /// No description provided for @yourOrder.
  ///
  /// In en, this message translates to:
  /// **'Your Order'**
  String get yourOrder;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get tax;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @specialInstructions.
  ///
  /// In en, this message translates to:
  /// **'Special Instructions'**
  String get specialInstructions;

  /// No description provided for @specialInstructionsHint.
  ///
  /// In en, this message translates to:
  /// **'Allergies, extra sauce, etc.'**
  String get specialInstructionsHint;

  /// No description provided for @pickupOptions.
  ///
  /// In en, this message translates to:
  /// **'Pickup Options'**
  String get pickupOptions;

  /// No description provided for @asap.
  ///
  /// In en, this message translates to:
  /// **'ASAP'**
  String get asap;

  /// No description provided for @readyInMinutes.
  ///
  /// In en, this message translates to:
  /// **'Ready in ~20 minutes'**
  String get readyInMinutes;

  /// No description provided for @scheduleForLater.
  ///
  /// In en, this message translates to:
  /// **'Schedule for Later'**
  String get scheduleForLater;

  /// No description provided for @choosePickupTime.
  ///
  /// In en, this message translates to:
  /// **'Choose a specific time'**
  String get choosePickupTime;

  /// No description provided for @selectPickupTime.
  ///
  /// In en, this message translates to:
  /// **'Select Pickup Time'**
  String get selectPickupTime;

  /// No description provided for @contactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactInfo;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @emailOptional.
  ///
  /// In en, this message translates to:
  /// **'Email (Optional)'**
  String get emailOptional;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @payWhenPickup.
  ///
  /// In en, this message translates to:
  /// **'Pay when you pick up'**
  String get payWhenPickup;

  /// No description provided for @useLoyaltyPoints.
  ///
  /// In en, this message translates to:
  /// **'Use Loyalty Points'**
  String get useLoyaltyPoints;

  /// No description provided for @pointsAvailable.
  ///
  /// In en, this message translates to:
  /// **'{points} points available'**
  String pointsAvailable(Object points);

  /// No description provided for @redeemPoints.
  ///
  /// In en, this message translates to:
  /// **'Redeem 1000 points for \$5.00 off'**
  String get redeemPoints;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// No description provided for @loyaltyDiscount.
  ///
  /// In en, this message translates to:
  /// **'Loyalty Discount'**
  String get loyaltyDiscount;

  /// No description provided for @methodCard.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get methodCard;

  /// No description provided for @methodCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get methodCash;

  /// No description provided for @methodApplePay.
  ///
  /// In en, this message translates to:
  /// **'Apple Pay'**
  String get methodApplePay;

  /// No description provided for @methodGooglePay.
  ///
  /// In en, this message translates to:
  /// **'Google Pay'**
  String get methodGooglePay;

  /// No description provided for @placeOrderFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to place order: {error}'**
  String placeOrderFailed(Object error);

  /// No description provided for @shareReferralLink.
  ///
  /// In en, this message translates to:
  /// **'Share Referral Link'**
  String get shareReferralLink;

  /// No description provided for @viewAllActivity.
  ///
  /// In en, this message translates to:
  /// **'View All Activity'**
  String get viewAllActivity;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard: {text}'**
  String copiedToClipboard(Object text);

  /// No description provided for @shareYourCode.
  ///
  /// In en, this message translates to:
  /// **'Share your code: {code}'**
  String shareYourCode(Object code);

  /// No description provided for @signInToAccessProfile.
  ///
  /// In en, this message translates to:
  /// **'Sign in to access your profile'**
  String get signInToAccessProfile;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @ordersCount.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get ordersCount;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member Since'**
  String get memberSince;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @quickActionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActionsLabel;

  /// No description provided for @orderHistory.
  ///
  /// In en, this message translates to:
  /// **'Order History'**
  String get orderHistory;

  /// No description provided for @findTruck.
  ///
  /// In en, this message translates to:
  /// **'Find Truck'**
  String get findTruck;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdated;

  /// No description provided for @profileUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile: {error}'**
  String profileUpdateFailed(Object error);

  /// No description provided for @signOutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get signOutConfirmation;

  /// No description provided for @pleaseSignInOrders.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to view your orders'**
  String get pleaseSignInOrders;

  /// No description provided for @noOrdersYet.
  ///
  /// In en, this message translates to:
  /// **'No orders yet'**
  String get noOrdersYet;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @reorder.
  ///
  /// In en, this message translates to:
  /// **'Reorder'**
  String get reorder;

  /// No description provided for @viewReceipt.
  ///
  /// In en, this message translates to:
  /// **'View Receipt'**
  String get viewReceipt;

  /// No description provided for @needHelpOrder.
  ///
  /// In en, this message translates to:
  /// **'Need help with this order?'**
  String get needHelpOrder;

  /// No description provided for @featuredItems.
  ///
  /// In en, this message translates to:
  /// **'Featured Items'**
  String get featuredItems;

  /// No description provided for @viewFullMenu.
  ///
  /// In en, this message translates to:
  /// **'VIEW FULL MENU'**
  String get viewFullMenu;

  /// No description provided for @customerLove.
  ///
  /// In en, this message translates to:
  /// **'Customer Love'**
  String get customerLove;

  /// No description provided for @customerReview1.
  ///
  /// In en, this message translates to:
  /// **'Best pupusas in town! Reminds me of home.'**
  String get customerReview1;

  /// No description provided for @customerReview2.
  ///
  /// In en, this message translates to:
  /// **'The tacos al pastor are incredible. A must try!'**
  String get customerReview2;

  /// No description provided for @customerReview3.
  ///
  /// In en, this message translates to:
  /// **'Great service and amazing food. Love the truck!'**
  String get customerReview3;

  /// No description provided for @joinLoyaltyProgram.
  ///
  /// In en, this message translates to:
  /// **'Join Our Loyalty Program'**
  String get joinLoyaltyProgram;

  /// No description provided for @loyaltyDescription.
  ///
  /// In en, this message translates to:
  /// **'Earn points with every purchase and get free meals!'**
  String get loyaltyDescription;

  /// No description provided for @signUpNow.
  ///
  /// In en, this message translates to:
  /// **'Sign Up Now'**
  String get signUpNow;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @noAccountSignUp.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign Up'**
  String get noAccountSignUp;

  /// No description provided for @alreadyHaveAccountSignIn.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign In'**
  String get alreadyHaveAccountSignIn;

  /// No description provided for @interactiveMap.
  ///
  /// In en, this message translates to:
  /// **'Interactive Map'**
  String get interactiveMap;

  /// No description provided for @googleMapsIntegration.
  ///
  /// In en, this message translates to:
  /// **'Google Maps integration'**
  String get googleMapsIntegration;

  /// No description provided for @currentLocationUppercase.
  ///
  /// In en, this message translates to:
  /// **'CURRENT LOCATION'**
  String get currentLocationUppercase;

  /// No description provided for @weeklyScheduleUppercase.
  ///
  /// In en, this message translates to:
  /// **'WEEKLY SCHEDULE'**
  String get weeklyScheduleUppercase;

  /// No description provided for @getNotified.
  ///
  /// In en, this message translates to:
  /// **'Get Notified'**
  String get getNotified;

  /// No description provided for @getNotifiedDescription.
  ///
  /// In en, this message translates to:
  /// **'Get notified when we arrive at your favorite spot'**
  String get getNotifiedDescription;

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get enableNotifications;

  /// No description provided for @statusOpen.
  ///
  /// In en, this message translates to:
  /// **'OPEN'**
  String get statusOpen;

  /// No description provided for @statusClosed.
  ///
  /// In en, this message translates to:
  /// **'CLOSED'**
  String get statusClosed;

  /// No description provided for @subscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get subscribe;

  /// No description provided for @notificationsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications enabled!'**
  String get notificationsEnabled;

  /// No description provided for @openingInMaps.
  ///
  /// In en, this message translates to:
  /// **'Opening {address} in maps...'**
  String openingInMaps(Object address);

  /// No description provided for @enterPhoneNumberNotification.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number to get notified when we arrive:'**
  String get enterPhoneNumberNotification;

  /// No description provided for @getNotificationsDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Get Notifications'**
  String get getNotificationsDialogTitle;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @mondayAbbr.
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get mondayAbbr;

  /// No description provided for @tuesdayAbbr.
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get tuesdayAbbr;

  /// No description provided for @wednesdayAbbr.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get wednesdayAbbr;

  /// No description provided for @thursdayAbbr.
  ///
  /// In en, this message translates to:
  /// **'Th'**
  String get thursdayAbbr;

  /// No description provided for @fridayAbbr.
  ///
  /// In en, this message translates to:
  /// **'F'**
  String get fridayAbbr;

  /// No description provided for @saturdayAbbr.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get saturdayAbbr;

  /// No description provided for @sundayAbbr.
  ///
  /// In en, this message translates to:
  /// **'Su'**
  String get sundayAbbr;

  /// No description provided for @cartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get cartEmpty;

  /// No description provided for @notePrefix.
  ///
  /// In en, this message translates to:
  /// **'Note: {note}'**
  String notePrefix(Object note);

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'La Union Food Truck brings the best of Salvadoran and Mexican cuisine to you.'**
  String get aboutDescription;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Please enter {field}'**
  String requiredField(Object field);

  /// No description provided for @orderStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get orderStatusTitle;

  /// No description provided for @estimatedPickup.
  ///
  /// In en, this message translates to:
  /// **'Estimated pickup: {time}'**
  String estimatedPickup(Object time);

  /// No description provided for @orderProgress.
  ///
  /// In en, this message translates to:
  /// **'Order Progress'**
  String get orderProgress;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order Number'**
  String get orderNumber;

  /// No description provided for @placed.
  ///
  /// In en, this message translates to:
  /// **'Placed'**
  String get placed;

  /// No description provided for @pickupTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Pickup Time'**
  String get pickupTimeLabel;

  /// No description provided for @paymentMethodLabel.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethodLabel;

  /// No description provided for @orderReceived.
  ///
  /// In en, this message translates to:
  /// **'Order Received'**
  String get orderReceived;

  /// No description provided for @orderPreparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing Your Order'**
  String get orderPreparing;

  /// No description provided for @orderReady.
  ///
  /// In en, this message translates to:
  /// **'Ready for Pickup!'**
  String get orderReady;

  /// No description provided for @orderCompleted.
  ///
  /// In en, this message translates to:
  /// **'Order Completed'**
  String get orderCompleted;

  /// No description provided for @orderCancelled.
  ///
  /// In en, this message translates to:
  /// **'Order Cancelled'**
  String get orderCancelled;

  /// No description provided for @orderAgain.
  ///
  /// In en, this message translates to:
  /// **'Order Again'**
  String get orderAgain;

  /// No description provided for @statusReceived.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get statusReceived;

  /// No description provided for @statusPreparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing'**
  String get statusPreparing;

  /// No description provided for @statusReady.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get statusReady;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// No description provided for @signInToEarnPoints.
  ///
  /// In en, this message translates to:
  /// **'Sign in to start earning points'**
  String get signInToEarnPoints;

  /// No description provided for @keepEating.
  ///
  /// In en, this message translates to:
  /// **'Keep eating, keep earning!'**
  String get keepEating;

  /// No description provided for @availableRewards.
  ///
  /// In en, this message translates to:
  /// **'AVAILABLE REWARDS'**
  String get availableRewards;

  /// No description provided for @referFriend.
  ///
  /// In en, this message translates to:
  /// **'Refer a Friend'**
  String get referFriend;

  /// No description provided for @referralDescription.
  ///
  /// In en, this message translates to:
  /// **'Share your referral code and both you and your friend get 250 points!'**
  String get referralDescription;

  /// No description provided for @yourReferralCode.
  ///
  /// In en, this message translates to:
  /// **'Your referral code:'**
  String get yourReferralCode;

  /// No description provided for @recentActivity.
  ///
  /// In en, this message translates to:
  /// **'RECENT ACTIVITY'**
  String get recentActivity;

  /// No description provided for @pointsUppercase.
  ///
  /// In en, this message translates to:
  /// **'POINTS'**
  String get pointsUppercase;

  /// No description provided for @unlocked.
  ///
  /// In en, this message translates to:
  /// **'UNLOCKED'**
  String get unlocked;

  /// No description provided for @toGo.
  ///
  /// In en, this message translates to:
  /// **'TO GO'**
  String get toGo;

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'LOCKED'**
  String get locked;

  /// No description provided for @transPurchase.
  ///
  /// In en, this message translates to:
  /// **'Order Purchase'**
  String get transPurchase;

  /// No description provided for @transReferral.
  ///
  /// In en, this message translates to:
  /// **'Friend Referral'**
  String get transReferral;

  /// No description provided for @transRedemption.
  ///
  /// In en, this message translates to:
  /// **'Reward Redemption'**
  String get transRedemption;

  /// No description provided for @transBonus.
  ///
  /// In en, this message translates to:
  /// **'Bonus Points'**
  String get transBonus;

  /// No description provided for @rewardFreeDrink.
  ///
  /// In en, this message translates to:
  /// **'Free Drink'**
  String get rewardFreeDrink;

  /// No description provided for @rewardFreePupusa.
  ///
  /// In en, this message translates to:
  /// **'Free Pupusa/Taco'**
  String get rewardFreePupusa;

  /// No description provided for @rewardTenOff.
  ///
  /// In en, this message translates to:
  /// **'\$10 Off'**
  String get rewardTenOff;

  /// No description provided for @rewardFamilyMeal.
  ///
  /// In en, this message translates to:
  /// **'Family Meal'**
  String get rewardFamilyMeal;

  /// No description provided for @searchMenuHint.
  ///
  /// In en, this message translates to:
  /// **'Search menu items...'**
  String get searchMenuHint;

  /// No description provided for @allCategories.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allCategories;

  /// No description provided for @noItemsFound.
  ///
  /// In en, this message translates to:
  /// **'No items found'**
  String get noItemsFound;

  /// No description provided for @addedToCart.
  ///
  /// In en, this message translates to:
  /// **'Added {name} to cart'**
  String addedToCart(Object name);

  /// No description provided for @welcomeBackUser.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {name}!'**
  String welcomeBackUser(Object name);

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// No description provided for @quantityLabel.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantityLabel;

  /// No description provided for @modifiersLabel.
  ///
  /// In en, this message translates to:
  /// **'Extras'**
  String get modifiersLabel;

  /// No description provided for @ingredientsLabel.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get ingredientsLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
