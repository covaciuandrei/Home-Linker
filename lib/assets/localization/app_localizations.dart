import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ro.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('ro')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'HomeLinker'**
  String get appTitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'to'**
  String get to;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signup;

  /// No description provided for @listedBy.
  ///
  /// In en, this message translates to:
  /// **'Listed by'**
  String get listedBy;

  /// No description provided for @deleteListing.
  ///
  /// In en, this message translates to:
  /// **'Delete listing'**
  String get deleteListing;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @bathroom.
  ///
  /// In en, this message translates to:
  /// **'bathroom'**
  String get bathroom;

  /// No description provided for @bathrooms.
  ///
  /// In en, this message translates to:
  /// **'bathrooms'**
  String get bathrooms;

  /// No description provided for @bedroom.
  ///
  /// In en, this message translates to:
  /// **'bedroom'**
  String get bedroom;

  /// No description provided for @bedrooms.
  ///
  /// In en, this message translates to:
  /// **'bedrooms'**
  String get bedrooms;

  /// No description provided for @parkingSpace.
  ///
  /// In en, this message translates to:
  /// **'parking space'**
  String get parkingSpace;

  /// No description provided for @parkingspaces.
  ///
  /// In en, this message translates to:
  /// **'parking space'**
  String get parkingspaces;

  /// No description provided for @perntru.
  ///
  /// In en, this message translates to:
  /// **'For'**
  String get perntru;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Create one'**
  String get createNewAccount;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @pickValue.
  ///
  /// In en, this message translates to:
  /// **'Pick a value'**
  String get pickValue;

  /// No description provided for @uploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload photo'**
  String get uploadPhoto;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @propertyType.
  ///
  /// In en, this message translates to:
  /// **'Property type'**
  String get propertyType;

  /// No description provided for @listType.
  ///
  /// In en, this message translates to:
  /// **'List Type'**
  String get listType;

  /// No description provided for @constructionYear.
  ///
  /// In en, this message translates to:
  /// **'Construction Year'**
  String get constructionYear;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @areaSize.
  ///
  /// In en, this message translates to:
  /// **'Area Size'**
  String get areaSize;

  /// No description provided for @addProperty.
  ///
  /// In en, this message translates to:
  /// **'Add property'**
  String get addProperty;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'location'**
  String get location;

  /// No description provided for @enterDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter the description'**
  String get enterDescription;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @emailSentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'The confirmation mail was sent successfully'**
  String get emailSentSuccessfully;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @emailNeededForValidatingAccount.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email to recive the steps for resetting the password'**
  String get emailNeededForValidatingAccount;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @oldPassword.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get oldPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @repeatNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Repeat New Password'**
  String get repeatNewPassword;

  /// No description provided for @repeatPassword.
  ///
  /// In en, this message translates to:
  /// **'Repeat Password'**
  String get repeatPassword;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @passwordChangedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password Changed Successfully'**
  String get passwordChangedSuccessfully;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @termsAndCons.
  ///
  /// In en, this message translates to:
  /// **'Termens and conditions'**
  String get termsAndCons;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Log in'**
  String get alreadyHaveAccount;

  /// No description provided for @accountCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your account has been created successfully. Click on the link in the email you recived to finalize your account setup.'**
  String get accountCreatedSuccessfully;

  /// No description provided for @pickLocation.
  ///
  /// In en, this message translates to:
  /// **'Pick your location'**
  String get pickLocation;

  /// No description provided for @yourLocation.
  ///
  /// In en, this message translates to:
  /// **'Your location'**
  String get yourLocation;

  /// No description provided for @noLocationChosen.
  ///
  /// In en, this message translates to:
  /// **'No location selected'**
  String get noLocationChosen;

  /// No description provided for @currentLocation.
  ///
  /// In en, this message translates to:
  /// **'Current location'**
  String get currentLocation;

  /// No description provided for @selectOnMap.
  ///
  /// In en, this message translates to:
  /// **'Select on map'**
  String get selectOnMap;

  /// No description provided for @somethingWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, please try again.'**
  String get somethingWrong;

  /// No description provided for @enterCodeRecived.
  ///
  /// In en, this message translates to:
  /// **'Enter Code received on email'**
  String get enterCodeRecived;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @wrongCode.
  ///
  /// In en, this message translates to:
  /// **'Code/email address is wrong, please try again.'**
  String get wrongCode;

  /// No description provided for @sendCodeAgain.
  ///
  /// In en, this message translates to:
  /// **'Send code again'**
  String get sendCodeAgain;

  /// No description provided for @mailSent.
  ///
  /// In en, this message translates to:
  /// **'Mail Sent Successfully'**
  String get mailSent;

  /// No description provided for @mailNotSent.
  ///
  /// In en, this message translates to:
  /// **'Email not sent'**
  String get mailNotSent;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @house.
  ///
  /// In en, this message translates to:
  /// **'house'**
  String get house;

  /// No description provided for @apartment.
  ///
  /// In en, this message translates to:
  /// **'apartment'**
  String get apartment;

  /// No description provided for @rent.
  ///
  /// In en, this message translates to:
  /// **'rent'**
  String get rent;

  /// No description provided for @sale.
  ///
  /// In en, this message translates to:
  /// **'sale'**
  String get sale;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @squareMeters.
  ///
  /// In en, this message translates to:
  /// **'m²'**
  String get squareMeters;

  /// No description provided for @selectPrice.
  ///
  /// In en, this message translates to:
  /// **'Select Price'**
  String get selectPrice;

  /// No description provided for @selectedPrice.
  ///
  /// In en, this message translates to:
  /// **'Selected Price'**
  String get selectedPrice;

  /// No description provided for @removeFilter.
  ///
  /// In en, this message translates to:
  /// **'Remove Filters'**
  String get removeFilter;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @applyLabel.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get applyLabel;

  /// No description provided for @any.
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get any;

  /// No description provided for @priceRange.
  ///
  /// In en, this message translates to:
  /// **'Price range'**
  String get priceRange;

  /// No description provided for @minimumPrice.
  ///
  /// In en, this message translates to:
  /// **'Minimum price'**
  String get minimumPrice;

  /// No description provided for @selectMinimumPrice.
  ///
  /// In en, this message translates to:
  /// **'Select Min Price'**
  String get selectMinimumPrice;

  /// No description provided for @maximumPrice.
  ///
  /// In en, this message translates to:
  /// **'Maximum price'**
  String get maximumPrice;

  /// No description provided for @selectMaximumPrice.
  ///
  /// In en, this message translates to:
  /// **'Select Max Price'**
  String get selectMaximumPrice;

  /// No description provided for @listingAddedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Listing added to favorites'**
  String get listingAddedToFavorites;

  /// No description provided for @listingRemovedFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Listing removed from favorites'**
  String get listingRemovedFromFavorites;

  /// No description provided for @listingAlreadyInFavorites.
  ///
  /// In en, this message translates to:
  /// **'Listing is already in favorites.'**
  String get listingAlreadyInFavorites;

  /// No description provided for @listingAlreadyRemovedFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Listing was already removed from favorites.'**
  String get listingAlreadyRemovedFromFavorites;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalidEmail;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all required fields'**
  String get fillAllFields;

  /// No description provided for @selectPhoto.
  ///
  /// In en, this message translates to:
  /// **'Please select a photo'**
  String get selectPhoto;

  /// No description provided for @selectLocation.
  ///
  /// In en, this message translates to:
  /// **'Please select a location'**
  String get selectLocation;

  /// No description provided for @invalidPrice.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid price'**
  String get invalidPrice;

  /// No description provided for @invalidAreaSize.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid area size'**
  String get invalidAreaSize;
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
      <String>['en', 'ro'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ro':
      return AppLocalizationsRo();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
