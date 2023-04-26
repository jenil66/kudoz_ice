import 'dart:ui';

import 'package:flutter/cupertino.dart';

///colors
Color white70 = const Color(0xb3ffffff);
Color white50 = const Color(0x8affffff);
Color pinkcolor = const Color(0xffF42852);
Color yellowcolor = const Color(0xffF78A00);
Color lightgrey = const Color(0xffCFCFCF);
Color greycolor = const Color(0xff707070);
Color darkgreycolor = const Color(0xff333333);
Color backgroundcolor = const Color(0xff262628);
Color bluecolor = const Color(0xff2E40E9);

/// splash Screen
const String txtTwoSoul = "TwoSoul";
const String txtSocialApp = "Social App";
List<String> LanguageList = ['Spanish', 'English', 'French'];
String color = 'English';

/// Read And Write Screen
const String txtEnterDetail = "Enter Detail";
const String txtTitle = "Title";
const String txtDescription = "Description";

/// Mobile Verification Screen
const String txtMobileNumber = "Mobile Number";
const String txtEnterYourOTP = "Enter Your OTP";
const String txtBtnSubmit = "Submit";
const String txtBtnGenerateOTP = "Generate OTP";

/// Signup Screen
const String txtUsername = "Username";
const String txtEmail = "Email";
const String txtPassword = "Password";
const String txtBtnSignUp = "Sign Up";
const String txtBtnBackToLogin = "Back To Login";

/// Login Screen
const String txtUserId = "Phone number, email or username";
const String txtBtnLogin = "Login";
const String txtIfyoudonthaveanaccount = "If you don't have an account? ";

/// Login
const String txtDetail = 'orem lpsum is simply dummy text of pr \n typesetting as a industry Lorem lpsum \n  simply typesetting as a industry.' ;
const String txtLoginWithGoogle = "Login With Google";
const String txtLoginWithMobile = "Login With Mobile";
const String txtLoginWithApple = "Login With Apple";
const String txtTermcondition = 'By using up you agree to our terms of use \n and privacy policy';

/// Choose Language Screen
const String txtChooseLanguage = "Choose Language";
const String txtSpaniseLanguage = "Spanise";
const String txtEnglishLanguage = "English";
const String txtFrenchLanguage = "French";
const String txtBtnContinue = "Continue";

/// Upload Image Screen
const String txtUploadImages = "Upload Images";
const String txtUploadImageDetail = "Upload a minimum of three picture";
const String txtChoosePhotoFrom = "Choose Photo From";
const String txtGallery = "Gallery";
const String txtCamera = "Camera";

/// Enable Location Screen
const String txtEnableYourLocation = "Enable Your Location";
const String txtEnableLocationDetail = "Choose your location to start finding the \nrequest around you.";
const String txtBtnEnableLocation = "Enable Location";

/// More Information Screen
const String txtName = "Name";
const String txtGender = "Gender";
String txtSelectedGender = "man";
List<String> genderList = ['man', 'woman', 'other'];
const String txtSexuality = "Sexuality";
String txtSelectedSexuality = "A";
List<String> sexualityList = ['A', 'B', 'C'];
const String txtAge = "Age";
double startage = 18;
double endage = 50;
const String txtHeight = "Height";
double startheight = 150;
double endheight = 200;
const String txtRelationshipStatus = "Relationship Status";
String txtSelectedRelationship = "Single";
List<String> relationshipList = ['Single', 'Married'];
const String txtReligion = "Religion";
String txtSelectedreligion = 'hindu';
List<String> religionList = ['hindu', 'muslim', 'sikh', 'parsi', 'more'];
const String txtLookingfor = "Looking For";
const String txtBtnFriendship = "Friendship";
const String txtBtnDate = "Date";
const String txtBtnRelationship = "Relationship";
const String txtBtnDone = "Done";

/// Discover Screen
const String txtDiscover = "Discover";
const String txtAhmedabadIndia = "Ahmedabad,India";
const String txt21km = "21km";
const String txtDishaSmith24 = "Disha Smith,24";
List<String> discoverImagesList = [
  'assets/discover_one.png',
  'assets/discover_two.png',
  'assets/discover_three.png',
  'assets/discover_four.png',
];

/// Discover One Screen
const String txtLoreumIssupe = "Loreum Issupe";
const String imageSuperLike = 'assets/ic_superlike.png';
const String imageRefresh = 'assets/ic_refresh.png';
const String imageLike = "assets/ic_like.png";
const String imageRemove = "assets/ic_remove.png";

/// Other Profile Screen
const String txtFemale = "Female";
const String txtLocation = "Location";
const String txtCity = "Houstan, Hindustan";
const String txtAbout = "About";
const String txtAboutDetail = 'Lorem ipsum is simply dummy text of printing setting a industry. Lorem ipsum is simply dummy text of printingtypeseting as a industry';
const String txtReadMore = "Read More";
const String txt172cm = "172cm";
const String txtCityUnitedStates = "Houstan, United States";
const String txtSee = "See";
List<String> OtherProfileImageList = ['assets/otherpageone.png', 'assets/otherpagetwo.png', 'assets/otherpagethree.png', 'assets/otherpagefour.png'];

/// Filter Screen
const String txtFilters = "Filters";
const String txtClear = "Clear";
const String txtLocationDetail = "25, Loreum Issupe";
const String txtInterestedIn = "Interested In";
const String txtBtnGirls = "Girls";
const String txtBtnBoys = "Boys";
const String txtBtnBoth = "Both";
const String txtDistance = "Distance";
double startDistance = 0;
double endDistance = 100;
const String txtKm = " Km";
double startageFilter = 18;
double endageFilter = 50;
double startheightFilter = 150;
double endheightFilter = 200;
const String txtCm = " Cm";
String txtSelectedSexualityFilter = "A";
List<String> sexualityListFilter = ['A', 'B', 'C'];
String txtSelectedreligionFilter = 'hindu';
List<String> religionListFilter = ['hindu', 'muslim', 'sikh', 'parsi', 'more'];
const String txtBtnApply = "Apply";

/// Community Screen
const String txtCommunity = "Community";
const String txtCommunityAppbarDetail = "Marbau users near by you";
List<String> communityImageList = ['assets/c1.png', 'assets/c2.png','assets/c1.png', 'assets/c4.png', 'assets/c5.png', 'assets/c6.png', 'assets/c7.png', 'assets/c8.png', 'assets/c9.png', 'assets/c10.png', 'assets/c11.png', 'assets/c12.png',];

/// Chat Screen
const String txtMessages = "Messages";
const String txtSearch = "Search";
const String txtNewMatches = "New Matches";
const String txtRoma = "Roma";
const String txtFemale25 = "Female,25";
const String txtConversation = "Conversation";
const String txtPattni = "Pattni";
const String txtHowAreYou = "How are you";
const String txt5min = "5 min";
const String txt5 = '5';
List<String> chatImageList = ['assets/chattwo.png', 'assets/chatthree.png', 'assets/chatone.png', 'assets/chattwo.png', 'assets/chatthree.png', 'assets/chatone.png',];

/// Profile Screen
const String txtSelfemployed = "Self employed";
const String txtSettings = "Settings";
const String txtAddMedia = "Add Media";
const String txtEditProfile = "Edit Profile";
const String txtGetCredits = "Get Credits!";
const String txtGetCreditsDetails = "Get free credits by watching videos";
const String txt22 = '22';
const String txtLikes = "Likes";
const String txtSuperLikes = "Super \n    Likes";
const String txt8 = '8';
const String txtRewinds = "Rewinds";
const String txtUpgrade = "Upgrade";
const String txtTwosoulForFree = "What you get in Twosoul \nFor free :";
List<String> txtTwosoulFreelist = ['200 Wipes', '500 km', '10 rewinds', '5 super likes'];
const String txtTwosoulForpremium = "What you get in Twosoul \nFor premium :";
List<String> txtTwosoulPremiumlist = ['Unlimited swipes', 'Unlimited Distance', 'Unlimited Rewinds', 'Unlimited Swipesuper'];

/// Profile page Dialog Screen
const String txtStandoutwithlikes = "Stand out with likes";
const String txtStandoutwithlikesDetail = "You are 3x more likely to make get a match!";
const String txtDialog25 = '25';
const String txtDialog50 = '50';
const String txtDialog75 = '75';
const String txt$25a = "\$25/ea";
const String txtBtnGetSuperLikes = "Get Super Likes";
const String txtNoThanks = "No Thanks";

/// Card Detail Screen
const String txtPaymentMethod = 'Payment Method';
const String txtDebitCreditCards = 'Debit, Credit Cards';
const String txtPayPal = 'Pay Pal';
const String txtNetBanking = 'Net Banking';

/// Add card Screen
const String txtCardNumber = 'Card Number';
const String txtExpiry = 'Expiry';
const String txtMm = 'MM';
const String txtYy = 'YY';
const String txtCvv = 'CVV';
const String txtFirstName = 'First Name';
const String txtLastName = 'Last Name';
const String txtYouCanRemove = 'You can remove \nthis card';
const String txtBtnBuyNow = 'Buy Now';

/// Setting Screen
const String txtChooseMode = 'Choose Mode';
const String txtDate = 'Date';
const String txtDateMode = 'Date Mode';
const String txtSettingDetail = 'Lorem lpsum is simply dummy text of printing simply dummy \ntypesetting as a industry. Lorem lpsum.';
const String txtSnooze = 'Snooze';
const String txtIncognitoMode = 'Incognito Mode';
bool light = true;
bool lights = true;
const String txtCurrentLocation = 'Current Location';
const String txtSuratIndia = 'Surat,India';
const String txtChangeLanguage = 'Change Language';
const String txtSecurityAndPrivacy = 'Security & Privacy';
const String txtContactAndInfo = 'Contact & Info';
const String txtLogout = 'Logout';
const String txtDeleteAccount = 'Delete Account';

/// Choose Mode Screen
const String txtChooseModeQustion = 'What kind of connection are you  \nLooking for ?';
const String txtBtnContinueWithDate = 'Continue With Date';
const String txtChooseModeDetail = 'Loream ipsum is a simply dummy text of printing \ntypesetting as a industry.';


/// Setting Screen Snooze Dialog
const String txtSnoozeDetail = 'How Long Do You Want to be invisible for ?';
const String txt24hours = '24 hours';
const String txt72hours = '72 hours';
const String txtAWeek = 'A Week';
const String txtUndefinetely = 'Undefinetely';
const String txtBtnCancel = 'Cancel';

/// Setting Screen Incognito Mode Dialog
const String txtIncognitoDetail = 'Do You Want to go Incognito ?';
const String txtIncognitoDetailAns = 'Lorem ipsum is simply dummy text of printing \ntypesetting as a industry. lorem ipsum is simply \ndummy text of printingtypesetting as a industry.';
const String txtBtnTurnOnIncognitoMode = 'Turn On Incognito Mode';

/// Contact & Faq Screen
const String txtFAQ = 'FAQ';
const String txtContactUs = 'Contact Us';
const String txtTearmsOfService = 'Tearms Of Service';
const String txtPrivacyPolicy = 'Privacy Policy';
const String txtAdvertising = 'Advertising';

/// Edit Profile Screen
double startageEditProfile = 18;
double endageEditProfile = 50;
double startheightEditProfile = 150;
double endheightEditProfile = 200;
List<String> sexualityListEditProfile = ['A', 'B', 'C'];
List<String> religionListEditProfile = ['hindu', 'muslim', 'sikh', 'parsi', 'more'];
List<String> relationshipListEditProfile = ['Single', 'Married'];
List<String> genderListEditProfile = ['man', 'woman', 'other'];