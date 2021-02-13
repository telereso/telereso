import i18n from 'i18n-js';

// Set the key-value pairs for the different languages you want to support.
i18n.translations = {
    en: {
        company_name: 'Company nameeeeee',
        sign_up: 'SIGN UP FOR FREE',
        get_Started: 'GET STARTED',
    },
    fr: {company_name: 'Company name'},
};
// Set the locale once at the beginning of your app.
const windowUrl = window.location.search;
const params = new URLSearchParams(windowUrl)
i18n.locale = params.get("language")
i18n.fallbacks = true;


export default i18n;
