// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'La Union Food Truck';

  @override
  String get heroTitle => 'Pupuseria y Taquería';

  @override
  String get heroSubtitle => 'Authentic Salvadoran Street Food';

  @override
  String get heroDescription =>
      'Family owned and operated. Bringing the taste of home to you.';

  @override
  String get btnOrderNow => 'Order Now';

  @override
  String get btnFindTruck => 'Find Truck';

  @override
  String get homeLocationTitle => 'Live Truck Location';

  @override
  String get mapComingSoon => 'Map Integration Coming Soon';

  @override
  String get currentLocationLabel => 'Current Location:';

  @override
  String get nextDepartureLabel => 'Next Departure:';

  @override
  String get notifyMe => 'Notify Me';

  @override
  String get menuTitle => 'Our Menu';

  @override
  String get cartTitle => 'Your Cart';

  @override
  String get checkoutTitle => 'Checkout';

  @override
  String get profileTitle => 'Profile';

  @override
  String get orderHistoryTitle => 'Order History';

  @override
  String get loyaltyTitle => 'Loyalty Program';

  @override
  String get signIn => 'Sign In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get signOut => 'Sign Out';

  @override
  String get adminDashboard => 'Admin Dashboard';

  @override
  String get footerRights => '© 2024 La Union Food Truck. All rights reserved.';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get restartApp => 'Restart App';

  @override
  String get navHome => 'Home';

  @override
  String get navMenu => 'Menu';

  @override
  String get navLocation => 'Location';

  @override
  String get navLoyalty => 'Loyalty';

  @override
  String get navProfile => 'Profile';

  @override
  String get navAbout => 'About';

  @override
  String get signInButton => 'Sign In';

  @override
  String get cateringTitle => 'Catering Services';

  @override
  String get cateringHeadline => 'Bring La Union to Your Event';

  @override
  String get cateringSubtitle => 'Authentic flavors for your special occasions';

  @override
  String get fullName => 'Full Name';

  @override
  String get email => 'Email Address';

  @override
  String get phone => 'Phone Number';

  @override
  String get eventDate => 'Event Date';

  @override
  String get guestCount => 'Number of Guests';

  @override
  String get additionalDetails => 'Additional Details';

  @override
  String get requestSent => 'Catering Request Sent!';

  @override
  String get submitRequest => 'Submit Request';

  @override
  String get checkout => 'Checkout';

  @override
  String get orderReview => 'Review Order';

  @override
  String itemCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Items',
      one: '1 Item',
    );
    return '$_temp0';
  }

  @override
  String get pickupTime => 'Pickup Time';

  @override
  String get customerInfo => 'Customer Info';

  @override
  String get payment => 'Payment';

  @override
  String get cancel => 'Cancel';

  @override
  String get back => 'Back';

  @override
  String get placeOrder => 'Place Order';

  @override
  String get continueStep => 'Continue';

  @override
  String get yourOrder => 'Your Order';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get tax => 'Tax';

  @override
  String get total => 'Total';

  @override
  String get specialInstructions => 'Special Instructions';

  @override
  String get specialInstructionsHint => 'Allergies, extra sauce, etc.';

  @override
  String get pickupOptions => 'Pickup Options';

  @override
  String get asap => 'ASAP';

  @override
  String get readyInMinutes => 'Ready in ~20 minutes';

  @override
  String get scheduleForLater => 'Schedule for Later';

  @override
  String get choosePickupTime => 'Choose a specific time';

  @override
  String get selectPickupTime => 'Select Pickup Time';

  @override
  String get contactInfo => 'Contact Information';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get emailOptional => 'Email (Optional)';

  @override
  String get paymentMethod => 'Payment Method';

  @override
  String get payWhenPickup => 'Pay when you pick up';

  @override
  String get useLoyaltyPoints => 'Use Loyalty Points';

  @override
  String pointsAvailable(Object points) {
    return '$points points available';
  }

  @override
  String get redeemPoints => 'Redeem 1000 points for \$5.00 off';

  @override
  String get orderSummary => 'Order Summary';

  @override
  String get loyaltyDiscount => 'Loyalty Discount';

  @override
  String get methodCard => 'Card';

  @override
  String get methodCash => 'Cash';

  @override
  String get methodApplePay => 'Apple Pay';

  @override
  String get methodGooglePay => 'Google Pay';

  @override
  String placeOrderFailed(Object error) {
    return 'Failed to place order: $error';
  }

  @override
  String get shareReferralLink => 'Share Referral Link';

  @override
  String get viewAllActivity => 'View All Activity';

  @override
  String copiedToClipboard(Object text) {
    return 'Copied to clipboard: $text';
  }

  @override
  String shareYourCode(Object code) {
    return 'Share your code: $code';
  }

  @override
  String get signInToAccessProfile => 'Sign in to access your profile';

  @override
  String get createAccount => 'Create Account';

  @override
  String get customer => 'Customer';

  @override
  String get ordersCount => 'Orders';

  @override
  String get points => 'Points';

  @override
  String get memberSince => 'Member Since';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get quickActionsLabel => 'Quick Actions';

  @override
  String get orderHistory => 'Order History';

  @override
  String get findTruck => 'Find Truck';

  @override
  String get settings => 'Settings';

  @override
  String get notifications => 'Notifications';

  @override
  String get helpSupport => 'Help & Support';

  @override
  String get profileUpdated => 'Profile updated successfully';

  @override
  String profileUpdateFailed(Object error) {
    return 'Failed to update profile: $error';
  }

  @override
  String get signOutConfirmation => 'Are you sure you want to sign out?';

  @override
  String get pleaseSignInOrders => 'Please sign in to view your orders';

  @override
  String get noOrdersYet => 'No orders yet';

  @override
  String get viewDetails => 'View Details';

  @override
  String get reorder => 'Reorder';

  @override
  String get viewReceipt => 'View Receipt';

  @override
  String get needHelpOrder => 'Need help with this order?';

  @override
  String get featuredItems => 'Featured Items';

  @override
  String get viewFullMenu => 'VIEW FULL MENU';

  @override
  String get customerLove => 'Customer Love';

  @override
  String get customerReview1 => 'Best pupusas in town! Reminds me of home.';

  @override
  String get customerReview2 =>
      'The tacos al pastor are incredible. A must try!';

  @override
  String get customerReview3 =>
      'Great service and amazing food. Love the truck!';

  @override
  String get joinLoyaltyProgram => 'Join Our Loyalty Program';

  @override
  String get loyaltyDescription =>
      'Earn points with every purchase and get free meals!';

  @override
  String get signUpNow => 'Sign Up Now';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get password => 'Password';

  @override
  String get noAccountSignUp => 'Don\'t have an account? Sign Up';

  @override
  String get alreadyHaveAccountSignIn => 'Already have an account? Sign In';

  @override
  String get interactiveMap => 'Interactive Map';

  @override
  String get googleMapsIntegration => 'Google Maps integration';

  @override
  String get currentLocationUppercase => 'CURRENT LOCATION';

  @override
  String get weeklyScheduleUppercase => 'WEEKLY SCHEDULE';

  @override
  String get getNotified => 'Get Notified';

  @override
  String get getNotifiedDescription =>
      'Get notified when we arrive at your favorite spot';

  @override
  String get enableNotifications => 'Enable Notifications';

  @override
  String get statusOpen => 'OPEN';

  @override
  String get statusClosed => 'CLOSED';

  @override
  String get subscribe => 'Subscribe';

  @override
  String get notificationsEnabled => 'Notifications enabled!';

  @override
  String openingInMaps(Object address) {
    return 'Opening $address in maps...';
  }

  @override
  String get enterPhoneNumberNotification =>
      'Enter your phone number to get notified when we arrive:';

  @override
  String get getNotificationsDialogTitle => 'Get Notifications';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get mondayAbbr => 'M';

  @override
  String get tuesdayAbbr => 'T';

  @override
  String get wednesdayAbbr => 'W';

  @override
  String get thursdayAbbr => 'Th';

  @override
  String get fridayAbbr => 'F';

  @override
  String get saturdayAbbr => 'S';

  @override
  String get sundayAbbr => 'Su';

  @override
  String get cartEmpty => 'Your cart is empty';

  @override
  String notePrefix(Object note) {
    return 'Note: $note';
  }

  @override
  String get aboutUs => 'About Us';

  @override
  String get aboutDescription =>
      'La Union Food Truck brings the best of Salvadoran and Mexican cuisine to you.';

  @override
  String requiredField(Object field) {
    return 'Please enter $field';
  }

  @override
  String get orderStatusTitle => 'Order Status';

  @override
  String estimatedPickup(Object time) {
    return 'Estimated pickup: $time';
  }

  @override
  String get orderProgress => 'Order Progress';

  @override
  String get orderDetails => 'Order Details';

  @override
  String get orderNumber => 'Order Number';

  @override
  String get placed => 'Placed';

  @override
  String get pickupTimeLabel => 'Pickup Time';

  @override
  String get paymentMethodLabel => 'Payment Method';

  @override
  String get orderReceived => 'Order Received';

  @override
  String get orderPreparing => 'Preparing Your Order';

  @override
  String get orderReady => 'Ready for Pickup!';

  @override
  String get orderCompleted => 'Order Completed';

  @override
  String get orderCancelled => 'Order Cancelled';

  @override
  String get orderAgain => 'Order Again';

  @override
  String get statusReceived => 'Received';

  @override
  String get statusPreparing => 'Preparing';

  @override
  String get statusReady => 'Ready';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get signInToEarnPoints => 'Sign in to start earning points';

  @override
  String get keepEating => 'Keep eating, keep earning!';

  @override
  String get availableRewards => 'AVAILABLE REWARDS';

  @override
  String get referFriend => 'Refer a Friend';

  @override
  String get referralDescription =>
      'Share your referral code and both you and your friend get 250 points!';

  @override
  String get yourReferralCode => 'Your referral code:';

  @override
  String get recentActivity => 'RECENT ACTIVITY';

  @override
  String get pointsUppercase => 'POINTS';

  @override
  String get unlocked => 'UNLOCKED';

  @override
  String get toGo => 'TO GO';

  @override
  String get locked => 'LOCKED';

  @override
  String get transPurchase => 'Order Purchase';

  @override
  String get transReferral => 'Friend Referral';

  @override
  String get transRedemption => 'Reward Redemption';

  @override
  String get transBonus => 'Bonus Points';

  @override
  String get rewardFreeDrink => 'Free Drink';

  @override
  String get rewardFreePupusa => 'Free Pupusa/Taco';

  @override
  String get rewardTenOff => '\$10 Off';

  @override
  String get rewardFamilyMeal => 'Family Meal';

  @override
  String get searchMenuHint => 'Search menu items...';

  @override
  String get allCategories => 'All';

  @override
  String get noItemsFound => 'No items found';

  @override
  String addedToCart(Object name) {
    return 'Added $name to cart';
  }

  @override
  String welcomeBackUser(Object name) {
    return 'Welcome back, $name!';
  }

  @override
  String get addToCart => 'Add to Cart';

  @override
  String get quantityLabel => 'Quantity';

  @override
  String get modifiersLabel => 'Extras';

  @override
  String get ingredientsLabel => 'Ingredients';
}
