// ignore_for_file: equal_keys_in_map

import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'welcomeTitle': 'Hello Farmers!',
          'getStart': 'GET STARTED',
          'singin': 'Sign In',
          'enterUsername': 'Enter UserName',
          'enteremail': 'Enter Email Id',
          'enterPassword': 'Enter Password',
          'signup': 'Sign Up',
          'dont_acc': "Don't have account?",
          'have_acc': 'Already have an account?',
          'feedintake': 'Feed intake',
          'farmreg': 'Farm Registration',
          'mortality': 'Mortality',

          // farm_view
          'farm_view_yourFarms': 'Your Farms',
          'Edit': 'Edit',
          'Delete': 'Delete',
          'Change': 'Change',
          'Edit Farm Reg. No.': 'Edit Farm Reg. No.',
          'Want to delete': 'Want to delete ',
          'farm details?': ' farm details?',
          'Yes': 'Yes',
          'No': 'No',

          // farmReg_screen
          'Add Farm': 'Add Farm',
          'Enter Farm Name': 'Enter Farm Name',
          'Enter Farm Registration Number': 'Enter Farm Registration Number',
          'Submit': 'Submit',

          // branch_view
          ' branches': ' branches',
          'Edit Branch Name': 'Edit Branch Name',
          'want to delete': 'Want to delete ',
          'branch details?': ' branch details?',

          // branch_reg_view
          'Add Branch': 'Add Branch',
          'Enter Branch Name': 'Enter Branch Name',

          // shed_view
          ' sheds': ' sheds',
          'Edit Shed Details': 'Edit Shed Details',
          'Want to delete ': 'Want to delete ',
          ' shed details?': ' shed details?',

          // shed_reg_view
          'Add Shed': 'Add Shed',
          'Enter Shed Name': 'Enter Farm Name',

          // flock_view
          ' flock': ' flocks',
          'Edit Flock Details': 'Edit Flock Details',
          'Want to delete ': 'Want to delete ',
          ' flock details?': ' flock details?',

          // flock_reg_view
          'Add Flock': 'Add Flock',
          'Enter Flock Name': 'Enter Flock Name',
          'Enter Start Date': 'Enter Start Date',
          'Enter the type': 'Enter the type',
          'Enter the strain': 'Enter the strain',
          'Enter the number of chickens': 'Enter the number of chickens',
        },
        'ta_IN': {
          'welcomeTitle': 'வணக்கம் விவசாயிகளே!',
          'getStart': 'தொடங்குங்கள்',
          'singin': 'உள்நுழையவும்',
          'enterUsername': 'பயனர் பெயரை உள்ளிடவும்',
          'enteremail': 'மின்னஞ்சல் ஐடியை உள்ளிடவும்',
          'enterPassword': 'கடவுச்சொல்லை உள்ளிடவும்',
          'signup': 'பதிவு செய்யவும்',
          'dont_acc': "கணக்கு இல்லையா?",
          'have_acc': 'ஏற்கனவே கணக்கு உள்ளதா?',
          'feedintake': 'உணவு உட்கொள்ளல்',
          'farmreg': 'பண்ணை பதிவு',
          'mortality': 'இறப்பு',

          // farm_view
          'farm_view_yourFarms': 'உங்கள் பண்ணைகள்',
          'Edit': 'தொகு',
          'Delete': 'அழி',
          'Change': 'மாற்றம்',
          'Edit Farm Reg. No.': 'பண்ணை பதிவு எண்ணைத் திருத்தவும்',
          'Want to delete': 'நீக்க வேண்டும் ',
          'farm details?': ' பண்ணை விவரங்கள்?',
          'Yes': 'ஆம்',
          'No': 'இல்லை',

          // farmReg_screen
          'Add Farm': 'பண்ணை சேர்க்க',
          'Enter Farm Name': 'பண்ணை பெயரை உள்ளிடவும்',
          'Enter Farm Registration Number': 'பண்ணை பதிவு எண்ணை உள்ளிடவும்',
          'Submit': 'சமர்ப்பிக்க',

          //branch_view
          'branches': 'கிளைகள்',
          'Edit': 'தொகு',
          'Delete': 'அழி',
          'Change': 'மாற்றம்',
          'Edit Branch Name': 'கிளை பெயரை திருத்தவும்',
          'Want to delete': 'நீக்க வேண்டும் ',
          'branch details?': ' கிளை விவரங்கள்?',
          'Yes': 'ஆம்',
          'No': 'இல்லை',

          // branch_reg_view
          'Add Branch': 'பண்ணை சேர்க்க',
          'Enter Branch Name': 'பண்ணை பெயரை உள்ளிடவும்',
          'Submit': 'சமர்ப்பிக்க',

          // shed_view
          'sheds': ' கொட்டகைகள்',
          'Edit': 'தொகு',
          'Delete': 'அழி',
          'Change': 'மாற்றம்',
          'Edit Shed Details': 'ஷெட் விவரங்களைத் திருத்தவும்',
          'Want to delete ': 'கொட்டகையை நீக்க வேண்டும் ',
          ' shed details?': ' விவரங்கள்?',
          'Yes': 'ஆம்',
          'No': 'இல்லை',

          // shed_reg_view
          'Add Shed': 'பண்ணை சேர்க்க',
          'Enter Shed Name': 'பண்ணை பெயரை உள்ளிடவும்',
          'Submit': 'சமர்ப்பிக்க',

          // flock_view
          ' flock': ' கொட்டகைகள்',
          'Edit Flock Details': 'ஷெட் விவரங்களைத் திருத்தவும்',
          'Want to delete ': 'கொட்டகையை நீக்க வேண்டும்',
          ' flock details?': ' விவரங்கள்?',

          // flock_reg_view
          'Add Flock': 'பண்ணை சேர்க்க',
          'Enter Flock Name': 'பண்ணை பெயரை உள்ளிடவும்',
          'Enter Start Date': 'பண்ணை பெயரை உள்ளிடவும்',
          'Enter the type': 'பண்ணை பெயரை உள்ளிடவும்',
          'Enter the strain': 'பண்ணை பெயரை உள்ளிடவும்',
          'Enter the number of chickens': 'பண்ணை பெயரை உள்ளிடவும்',
        },
        'si_SL': {
          'welcomeTitle': 'ආයුබෝවන් ගොවියන්!',
          'getStart': 'ආරම්භ කරන්න',
          'singin': 'පුරන්න',
          'enterUsername': 'පරිශීලක නාමය ඇතුළත් කරන්න',
          'enteremail': 'ඊමේල් හැඳුනුම්පත ඇතුළත් කරන්න',
          'enterPassword': 'මුරපදය ඇතුළත් කරන්න',
          'signup': 'ලියාපදිංචි වන්න',
          'dont_acc': "ගිණුමක් නැද්ද?",
          'have_acc': 'දැනටමත් ගිණුමක් තිබේද?',
          'feedintake': 'ආහාර ගැනීම',
          'farmreg': 'ගොවිපල ලියාපදිංචි කිරීම',
          'mortality': 'මරණය',

          // farm_view
          'farm_view_yourFarms': 'ඔබේ ගොවිපලවල්',
          'Edit': 'සංස්කරණය කරන්න',
          'Delete': 'මකා දමන්න',
          'Change': 'වෙනස් කිරීම',
          'Edit Farm Reg. No.': 'ගොවිපල ලියාපදිංචි අංකය වෙනස් කරන්න',
          'Want to delete': '',
          'farm details?': ' ගොවිපළ දත්ත මකාදැමීමට අවශ්‍යද?',
          'Yes': 'ඔව්',
          'No': 'නැත',

          // farmReg_screen
          'Add Farm': 'නව ගොවිපලක් එකතු කිර්‍රීම',
          'Enter Farm Name': 'ගොවිපල නම ඇතුලත් කරන්න',
          'Enter Farm Registration Number':
              'ගොවිපලේ ලියාපදිංචි අංකය ඇතුලත් කරන්න',
          'Submit': 'සුරකින්න',

          // branch_view
          ' branches': ' ශාඛා',
          'Edit': 'වෙනස් කිරීම',
          'Delete': 'මකා දමන්න',
          'Change': 'වෙනස් කරන්න',
          'Edit Branch Name': 'ශාඛාවේ නම වෙනස් කරන්න',
          'want to delete': '',
          'branch details?': ' ශාඛාවේ දත්ත මකාදැමීමට අවශ්‍යද?',
          'Yes': 'ඔව්',
          'No': 'නැත',

          // branch_reg_view
          'Add Branch': 'නව ශාඛාවක් එකතු කිර්‍රීම',
          'Enter Branch Name': 'ශාඛාවේ නම ඇතුළත් කරන්න',
          'Submit': 'සුරකින්න',

          // shed_view
          ' sheds': ' මඩු',
          'Edit': 'වෙනස් කිරීම',
          'Delete': 'මකා දමන්න',
          'Change': 'වෙනස් කරන්න',
          'Edit Shed Details': 'මඩු විස්තර වෙනස් කරන්න',
          'Want to delete ': '',
          ' shed details?': ' මඩු විස්තර මැකීමට අවශ්‍යද?',
          'Yes': 'ඔව්',
          'No': 'නැත',

          // shed_reg_view
          'Add Shed': 'නව මඩුවක් එකතු කරන්න',
          'Enter Shed Name': 'මඩුවේ නම ඇතුල් කරන්න',
          'Submit': 'සුරකින්න',

          // flock_view
          ' flocks': ' රැළ',
          'Edit Flock Details': 'රැළේ විස්තර වෙනස් කරන්න',
          'Want to delete ': '',
          ' flock details?': ' රැළේ විස්තර මකා දැමීමට අවශ්‍යද?',

          // flock_reg_view
          'Add Flock': 'රැළේ විස්තර එකතු කරන්න',
          'Enter Flock Name': 'රැළේ නම ඇතුළත් කරන්න',
          'Enter Start Date': 'ආරම්භක දිනය ඇතුළත් කරන්න',
          'Enter the type': 'වර්ගය ඇතුලත් කරන්න',
          'Enter the strain': 'ප්රභේද්ය ඇතුලත් කරන්න',
          'Enter the number of chickens': 'කුකුළන් සංඛ්යාව ඇතුළත් කරන්න',
        }
      };
}
