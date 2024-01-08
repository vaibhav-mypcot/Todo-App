// ignore_for_file: equal_keys_in_map

import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'hi': {
          'Main Screen': 'मुख्य स्क्रीन',
          'Fetch Data': 'डेटा प्राप्त करें',
          'Fetch Image Data': 'छवि डेटा प्राप्त करें',
          'Product List': 'उत्पादों की सूची',
          'Cart List': 'कार्ट सूची',
          'Wish List': 'इच्छा-सूची',
          'Login Page': 'लोग इन वाला पन्ना',
          'Translate': 'अनुवाद',
          'Change Theme': 'विषय को परिवर्तित करें',
        },
        'en': {
          'Main Screen': 'Main Screen',
          'Fetch Data': 'Fetch Data',
          'Fetch Image Data': 'Fetch Image Data',
          'Product List': 'Product List',
          'Cart List': 'Cart List',
          'Wish List': 'Wishlist',
          'Login Page': 'Login Page',
          'Translate': 'Translate',
          'Change Theme': 'Change Theme',
        }
      };
}
