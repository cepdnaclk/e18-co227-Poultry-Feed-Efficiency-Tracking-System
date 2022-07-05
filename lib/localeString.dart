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
          'Enter Shed Name': 'Enter Shed Name',

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
          ' branches': ' கிளைகள்',
          'Edit': 'திருத்து',
          'Delete': 'நீக்கு',
          'Change': 'மாற்றம்',
          'Edit Branch Name': 'கிளை பெயரை திருத்து',
          'Want to delete': 'நீக்க வேண்டும் ',
          'branch details?': ' கிளை விவரங்கள்?',
          'Yes': 'ஆம்',
          'No': 'இல்லை',

          // branch_reg_view
          'Add Branch': 'கிளையைச் சேர்',
          'Enter Branch Name': 'கிளை பெயரை உள்ளிடவும்',
          'Submit': 'சமர்ப்பி',

          // shed_view
          ' sheds': ' கொட்டகைகள்',
          'Edit Shed Details': 'ஷெட் விவரங்களைத் திருத்து',
          'Want to delete ': 'நீக்க வேண்டும் ',
          ' shed details?': ' விவரங்கள்?',

          // shed_reg_view
          'Add Shed': 'சேர் கொட்டகை',
          'Enter Shed Name': 'ஷெட் பெயரை உள்ளிடவும்',

          // flock_view
          ' flocks': ' மந்தை',
          'Edit Flock Details': 'மந்தை விவரங்களைத் திருத்து',
          'Want to delete ': 'நீக்க வேண்டும்',
          ' flock details?': ' மந்தை விவரங்கள்?',
          'Edit Name': 'பெயரைத் திருத்தவும்',
          'Edit Starting Date': 'தேதியைத் திருத்தவும்',
          'Edit Type': 'திருத்த வகை',
          'Edit Strain Type': 'திரிபு திருத்தவும்',
          'Edit Count': 'திருத்த எண்ணிக்கை',
          'Edit The Number Of Chickens': 'திருத்த எண்ணிக்கை',

          // flock_reg_view
          'Add Flock': 'மந்தையைச் சேர்',
          'Enter Flock Name': 'மந்தையின் பெயரை உள்ளிடவும்',
          'Enter Start Date': 'தொடக்கத்தை உள்ளிடவும் தேதி',
          'Enter the type': 'வகையை உள்ளிடவும்',
          'Enter the strain': 'எண்டர் தி ஸ்ட்ரெய்ன்',
          'Enter the number of chickens': 'கோழிகளின் எண்ணிக்கையை உள்ளிடவும்',
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
          'Edit Name': 'නම වෙනස් කරන්න',
          'Edit Starting Date': 'දිනය වෙනස් කරන්න',
          'Edit Type': 'වර්ගය වෙනස් කරන්න',
          'Edit Strain Type': 'ප්රභේද්ය වෙනස් කරන්න',
          'Edit The Number Of Chickens': 'ප්රමාණය වෙනස් කරන්න',

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
