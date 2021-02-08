import * as Localization from 'expo-localization';
import i18n from 'i18n-js';
// Set the key-value pairs for the different languages you want to support.
i18n.translations = {
  en: {
     home: 'Home',
     categories:'CATEGORIES',
     drawer_categories:'CATEGORIES',
     drawer_categories:'Search',
 },
  fr: { home: 'Home' },
};
// Set the locale once at the beginning of your app.
i18n.locale = Localization.locale;
i18n.fallbacks =true;


export default i18n; 
