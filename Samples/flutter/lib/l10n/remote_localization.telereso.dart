import 'package:flutter/widgets.dart';
import 'package:telereso/remote_localization.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';
class RemoteLocalizationsDefault {
final RemoteLocalizations remote;
final GalleryLocalizations local;
RemoteLocalizationsDefault(this.remote, this.local);
static RemoteLocalizationsDefault of(BuildContext context) {
return RemoteLocalizationsDefault(RemoteLocalizations.of(context), GalleryLocalizations.of(context));
}
String githubRepo(Object repoName){return remote.translateOrDefault('githubRepo', local.githubRepo(repoName));
}
String aboutDialogDescription(Object repoLink){return remote.translateOrDefault('aboutDialogDescription', local.aboutDialogDescription(repoLink));
}
String get signIn =>
remote.translateOrDefault('signIn', local.signIn);
String get bannerDemoText =>
remote.translateOrDefault('bannerDemoText', local.bannerDemoText);
String get bannerDemoResetText =>
remote.translateOrDefault('bannerDemoResetText', local.bannerDemoResetText);
String get bannerDemoMultipleText =>
remote.translateOrDefault('bannerDemoMultipleText', local.bannerDemoMultipleText);
String get bannerDemoLeadingText =>
remote.translateOrDefault('bannerDemoLeadingText', local.bannerDemoLeadingText);
String get dismiss =>
remote.translateOrDefault('dismiss', local.dismiss);
String get backToGallery =>
remote.translateOrDefault('backToGallery', local.backToGallery);
String get cardsDemoTappable =>
remote.translateOrDefault('cardsDemoTappable', local.cardsDemoTappable);
String get cardsDemoSelectable =>
remote.translateOrDefault('cardsDemoSelectable', local.cardsDemoSelectable);
String get cardsDemoExplore =>
remote.translateOrDefault('cardsDemoExplore', local.cardsDemoExplore);
String cardsDemoExploreSemantics(Object destinationName){return remote.translateOrDefault('cardsDemoExploreSemantics', local.cardsDemoExploreSemantics(destinationName));
}
String cardsDemoShareSemantics(Object destinationName){return remote.translateOrDefault('cardsDemoShareSemantics', local.cardsDemoShareSemantics(destinationName));
}
String get cardsDemoTravelDestinationTitle1 =>
remote.translateOrDefault('cardsDemoTravelDestinationTitle1', local.cardsDemoTravelDestinationTitle1);
String get cardsDemoTravelDestinationDescription1 =>
remote.translateOrDefault('cardsDemoTravelDestinationDescription1', local.cardsDemoTravelDestinationDescription1);
String get cardsDemoTravelDestinationCity1 =>
remote.translateOrDefault('cardsDemoTravelDestinationCity1', local.cardsDemoTravelDestinationCity1);
String get cardsDemoTravelDestinationLocation1 =>
remote.translateOrDefault('cardsDemoTravelDestinationLocation1', local.cardsDemoTravelDestinationLocation1);
String get cardsDemoTravelDestinationTitle2 =>
remote.translateOrDefault('cardsDemoTravelDestinationTitle2', local.cardsDemoTravelDestinationTitle2);
String get cardsDemoTravelDestinationDescription2 =>
remote.translateOrDefault('cardsDemoTravelDestinationDescription2', local.cardsDemoTravelDestinationDescription2);
String get cardsDemoTravelDestinationCity2 =>
remote.translateOrDefault('cardsDemoTravelDestinationCity2', local.cardsDemoTravelDestinationCity2);
String get cardsDemoTravelDestinationLocation2 =>
remote.translateOrDefault('cardsDemoTravelDestinationLocation2', local.cardsDemoTravelDestinationLocation2);
String get cardsDemoTravelDestinationTitle3 =>
remote.translateOrDefault('cardsDemoTravelDestinationTitle3', local.cardsDemoTravelDestinationTitle3);
String get cardsDemoTravelDestinationDescription3 =>
remote.translateOrDefault('cardsDemoTravelDestinationDescription3', local.cardsDemoTravelDestinationDescription3);
String get homeHeaderGallery =>
remote.translateOrDefault('homeHeaderGallery', local.homeHeaderGallery);
String get homeHeaderCategories =>
remote.translateOrDefault('homeHeaderCategories', local.homeHeaderCategories);
String get shrineDescription =>
remote.translateOrDefault('shrineDescription', local.shrineDescription);
String get fortnightlyDescription =>
remote.translateOrDefault('fortnightlyDescription', local.fortnightlyDescription);
String get rallyDescription =>
remote.translateOrDefault('rallyDescription', local.rallyDescription);
String get replyDescription =>
remote.translateOrDefault('replyDescription', local.replyDescription);
String get rallyAccountDataChecking =>
remote.translateOrDefault('rallyAccountDataChecking', local.rallyAccountDataChecking);
String get rallyAccountDataHomeSavings =>
remote.translateOrDefault('rallyAccountDataHomeSavings', local.rallyAccountDataHomeSavings);
String get rallyAccountDataCarSavings =>
remote.translateOrDefault('rallyAccountDataCarSavings', local.rallyAccountDataCarSavings);
String get rallyAccountDataVacation =>
remote.translateOrDefault('rallyAccountDataVacation', local.rallyAccountDataVacation);
String get rallyAccountDetailDataAnnualPercentageYield =>
remote.translateOrDefault('rallyAccountDetailDataAnnualPercentageYield', local.rallyAccountDetailDataAnnualPercentageYield);
String get rallyAccountDetailDataInterestRate =>
remote.translateOrDefault('rallyAccountDetailDataInterestRate', local.rallyAccountDetailDataInterestRate);
String get rallyAccountDetailDataInterestYtd =>
remote.translateOrDefault('rallyAccountDetailDataInterestYtd', local.rallyAccountDetailDataInterestYtd);
String get rallyAccountDetailDataInterestPaidLastYear =>
remote.translateOrDefault('rallyAccountDetailDataInterestPaidLastYear', local.rallyAccountDetailDataInterestPaidLastYear);
String get rallyAccountDetailDataNextStatement =>
remote.translateOrDefault('rallyAccountDetailDataNextStatement', local.rallyAccountDetailDataNextStatement);
String get rallyAccountDetailDataAccountOwner =>
remote.translateOrDefault('rallyAccountDetailDataAccountOwner', local.rallyAccountDetailDataAccountOwner);
String get rallyBillDetailTotalAmount =>
remote.translateOrDefault('rallyBillDetailTotalAmount', local.rallyBillDetailTotalAmount);
String get rallyBillDetailAmountPaid =>
remote.translateOrDefault('rallyBillDetailAmountPaid', local.rallyBillDetailAmountPaid);
String get rallyBillDetailAmountDue =>
remote.translateOrDefault('rallyBillDetailAmountDue', local.rallyBillDetailAmountDue);
String get rallyBudgetCategoryCoffeeShops =>
remote.translateOrDefault('rallyBudgetCategoryCoffeeShops', local.rallyBudgetCategoryCoffeeShops);
String get rallyBudgetCategoryGroceries =>
remote.translateOrDefault('rallyBudgetCategoryGroceries', local.rallyBudgetCategoryGroceries);
String get rallyBudgetCategoryRestaurants =>
remote.translateOrDefault('rallyBudgetCategoryRestaurants', local.rallyBudgetCategoryRestaurants);
String get rallyBudgetCategoryClothing =>
remote.translateOrDefault('rallyBudgetCategoryClothing', local.rallyBudgetCategoryClothing);
String get rallyBudgetDetailTotalCap =>
remote.translateOrDefault('rallyBudgetDetailTotalCap', local.rallyBudgetDetailTotalCap);
String get rallyBudgetDetailAmountUsed =>
remote.translateOrDefault('rallyBudgetDetailAmountUsed', local.rallyBudgetDetailAmountUsed);
String get rallyBudgetDetailAmountLeft =>
remote.translateOrDefault('rallyBudgetDetailAmountLeft', local.rallyBudgetDetailAmountLeft);
String get rallySettingsManageAccounts =>
remote.translateOrDefault('rallySettingsManageAccounts', local.rallySettingsManageAccounts);
String get rallySettingsTaxDocuments =>
remote.translateOrDefault('rallySettingsTaxDocuments', local.rallySettingsTaxDocuments);
String get rallySettingsPasscodeAndTouchId =>
remote.translateOrDefault('rallySettingsPasscodeAndTouchId', local.rallySettingsPasscodeAndTouchId);
String get rallySettingsNotifications =>
remote.translateOrDefault('rallySettingsNotifications', local.rallySettingsNotifications);
String get rallySettingsPersonalInformation =>
remote.translateOrDefault('rallySettingsPersonalInformation', local.rallySettingsPersonalInformation);
String get rallySettingsPaperlessSettings =>
remote.translateOrDefault('rallySettingsPaperlessSettings', local.rallySettingsPaperlessSettings);
String get rallySettingsFindAtms =>
remote.translateOrDefault('rallySettingsFindAtms', local.rallySettingsFindAtms);
String get rallySettingsHelp =>
remote.translateOrDefault('rallySettingsHelp', local.rallySettingsHelp);
String get rallySettingsSignOut =>
remote.translateOrDefault('rallySettingsSignOut', local.rallySettingsSignOut);
String get rallyAccountTotal =>
remote.translateOrDefault('rallyAccountTotal', local.rallyAccountTotal);
String get rallyBillsDue =>
remote.translateOrDefault('rallyBillsDue', local.rallyBillsDue);
String get rallyBudgetLeft =>
remote.translateOrDefault('rallyBudgetLeft', local.rallyBudgetLeft);
String get rallyAccounts =>
remote.translateOrDefault('rallyAccounts', local.rallyAccounts);
String get rallyBills =>
remote.translateOrDefault('rallyBills', local.rallyBills);
String get rallyBudgets =>
remote.translateOrDefault('rallyBudgets', local.rallyBudgets);
String get rallyAlerts =>
remote.translateOrDefault('rallyAlerts', local.rallyAlerts);
String get rallySeeAll =>
remote.translateOrDefault('rallySeeAll', local.rallySeeAll);
String get rallyFinanceLeft =>
remote.translateOrDefault('rallyFinanceLeft', local.rallyFinanceLeft);
String get rallyTitleOverview =>
remote.translateOrDefault('rallyTitleOverview', local.rallyTitleOverview);
String get rallyTitleAccounts =>
remote.translateOrDefault('rallyTitleAccounts', local.rallyTitleAccounts);
String get rallyTitleBills =>
remote.translateOrDefault('rallyTitleBills', local.rallyTitleBills);
String get rallyTitleBudgets =>
remote.translateOrDefault('rallyTitleBudgets', local.rallyTitleBudgets);
String get rallyTitleSettings =>
remote.translateOrDefault('rallyTitleSettings', local.rallyTitleSettings);
String get rallyLoginLoginToRally =>
remote.translateOrDefault('rallyLoginLoginToRally', local.rallyLoginLoginToRally);
String get rallyLoginNoAccount =>
remote.translateOrDefault('rallyLoginNoAccount', local.rallyLoginNoAccount);
String get rallyLoginSignUp =>
remote.translateOrDefault('rallyLoginSignUp', local.rallyLoginSignUp);
String get rallyLoginUsername =>
remote.translateOrDefault('rallyLoginUsername', local.rallyLoginUsername);
String get rallyLoginPassword =>
remote.translateOrDefault('rallyLoginPassword', local.rallyLoginPassword);
String get rallyLoginLabelLogin =>
remote.translateOrDefault('rallyLoginLabelLogin', local.rallyLoginLabelLogin);
String get rallyLoginRememberMe =>
remote.translateOrDefault('rallyLoginRememberMe', local.rallyLoginRememberMe);
String get rallyLoginButtonLogin =>
remote.translateOrDefault('rallyLoginButtonLogin', local.rallyLoginButtonLogin);
String rallyAlertsMessageHeadsUpShopping(Object percent){return remote.translateOrDefault('rallyAlertsMessageHeadsUpShopping', local.rallyAlertsMessageHeadsUpShopping(percent));
}
String rallyAlertsMessageSpentOnRestaurants(Object amount){return remote.translateOrDefault('rallyAlertsMessageSpentOnRestaurants', local.rallyAlertsMessageSpentOnRestaurants(amount));
}
String rallyAlertsMessageATMFees(int amount){return remote.translateOrDefault('rallyAlertsMessageATMFees', local.rallyAlertsMessageATMFees(amount));
}
String rallyAlertsMessageCheckingAccount(Object percent){return remote.translateOrDefault('rallyAlertsMessageCheckingAccount', local.rallyAlertsMessageCheckingAccount(percent));
}
String rallyAlertsMessageUnassignedTransactions(int count){return remote.translateOrDefault('rallyAlertsMessageUnassignedTransactions', local.rallyAlertsMessageUnassignedTransactions(count));
}
String get rallySeeAllAccounts =>
remote.translateOrDefault('rallySeeAllAccounts', local.rallySeeAllAccounts);
String get rallySeeAllBills =>
remote.translateOrDefault('rallySeeAllBills', local.rallySeeAllBills);
String get rallySeeAllBudgets =>
remote.translateOrDefault('rallySeeAllBudgets', local.rallySeeAllBudgets);
String rallyAccountAmount(Object accountName,int accountNumber,Object amount){return remote.translateOrDefault('rallyAccountAmount', local.rallyAccountAmount(accountName,accountNumber,amount));
}
String rallyBillAmount(Object billName,Object date,Object amount){return remote.translateOrDefault('rallyBillAmount', local.rallyBillAmount(billName,date,amount));
}
String rallyBudgetAmount(Object budgetName,Object amountUsed,Object amountTotal,Object amountLeft){return remote.translateOrDefault('rallyBudgetAmount', local.rallyBudgetAmount(budgetName,amountUsed,amountTotal,amountLeft));
}
String get craneDescription =>
remote.translateOrDefault('craneDescription', local.craneDescription);
String get homeCategoryReference =>
remote.translateOrDefault('homeCategoryReference', local.homeCategoryReference);
String get demoInvalidURL =>
remote.translateOrDefault('demoInvalidURL', local.demoInvalidURL);
String get demoOptionsTooltip =>
remote.translateOrDefault('demoOptionsTooltip', local.demoOptionsTooltip);
String get demoInfoTooltip =>
remote.translateOrDefault('demoInfoTooltip', local.demoInfoTooltip);
String get demoCodeTooltip =>
remote.translateOrDefault('demoCodeTooltip', local.demoCodeTooltip);
String get demoDocumentationTooltip =>
remote.translateOrDefault('demoDocumentationTooltip', local.demoDocumentationTooltip);
String get demoFullscreenTooltip =>
remote.translateOrDefault('demoFullscreenTooltip', local.demoFullscreenTooltip);
String get demoCodeViewerCopyAll =>
remote.translateOrDefault('demoCodeViewerCopyAll', local.demoCodeViewerCopyAll);
String get demoCodeViewerCopiedToClipboardMessage =>
remote.translateOrDefault('demoCodeViewerCopiedToClipboardMessage', local.demoCodeViewerCopiedToClipboardMessage);
String demoCodeViewerFailedToCopyToClipboardMessage(Object error){return remote.translateOrDefault('demoCodeViewerFailedToCopyToClipboardMessage', local.demoCodeViewerFailedToCopyToClipboardMessage(error));
}
String get demoOptionsFeatureTitle =>
remote.translateOrDefault('demoOptionsFeatureTitle', local.demoOptionsFeatureTitle);
String get demoOptionsFeatureDescription =>
remote.translateOrDefault('demoOptionsFeatureDescription', local.demoOptionsFeatureDescription);
String get settingsTitle =>
remote.translateOrDefault('settingsTitle', local.settingsTitle);
String get settingsButtonLabel =>
remote.translateOrDefault('settingsButtonLabel', local.settingsButtonLabel);
String get settingsButtonCloseLabel =>
remote.translateOrDefault('settingsButtonCloseLabel', local.settingsButtonCloseLabel);
String get settingsSystemDefault =>
remote.translateOrDefault('settingsSystemDefault', local.settingsSystemDefault);
String get settingsTextScaling =>
remote.translateOrDefault('settingsTextScaling', local.settingsTextScaling);
String get settingsTextScalingSmall =>
remote.translateOrDefault('settingsTextScalingSmall', local.settingsTextScalingSmall);
String get settingsTextScalingNormal =>
remote.translateOrDefault('settingsTextScalingNormal', local.settingsTextScalingNormal);
String get settingsTextScalingLarge =>
remote.translateOrDefault('settingsTextScalingLarge', local.settingsTextScalingLarge);
String get settingsTextScalingHuge =>
remote.translateOrDefault('settingsTextScalingHuge', local.settingsTextScalingHuge);
String get settingsTextDirection =>
remote.translateOrDefault('settingsTextDirection', local.settingsTextDirection);
String get settingsTextDirectionLocaleBased =>
remote.translateOrDefault('settingsTextDirectionLocaleBased', local.settingsTextDirectionLocaleBased);
String get settingsTextDirectionLTR =>
remote.translateOrDefault('settingsTextDirectionLTR', local.settingsTextDirectionLTR);
String get settingsTextDirectionRTL =>
remote.translateOrDefault('settingsTextDirectionRTL', local.settingsTextDirectionRTL);
String get settingsLocale =>
remote.translateOrDefault('settingsLocale', local.settingsLocale);
String get settingsPlatformMechanics =>
remote.translateOrDefault('settingsPlatformMechanics', local.settingsPlatformMechanics);
String get settingsTheme =>
remote.translateOrDefault('settingsTheme', local.settingsTheme);
String get settingsDarkTheme =>
remote.translateOrDefault('settingsDarkTheme', local.settingsDarkTheme);
String get settingsLightTheme =>
remote.translateOrDefault('settingsLightTheme', local.settingsLightTheme);
String get settingsSlowMotion =>
remote.translateOrDefault('settingsSlowMotion', local.settingsSlowMotion);
String get settingsAbout =>
remote.translateOrDefault('settingsAbout', local.settingsAbout);
String get settingsFeedback =>
remote.translateOrDefault('settingsFeedback', local.settingsFeedback);
String get settingsAttribution =>
remote.translateOrDefault('settingsAttribution', local.settingsAttribution);
String get demoAppBarTitle =>
remote.translateOrDefault('demoAppBarTitle', local.demoAppBarTitle);
String get demoAppBarSubtitle =>
remote.translateOrDefault('demoAppBarSubtitle', local.demoAppBarSubtitle);
String get demoAppBarDescription =>
remote.translateOrDefault('demoAppBarDescription', local.demoAppBarDescription);
String get demoBottomAppBarTitle =>
remote.translateOrDefault('demoBottomAppBarTitle', local.demoBottomAppBarTitle);
String get demoBottomAppBarSubtitle =>
remote.translateOrDefault('demoBottomAppBarSubtitle', local.demoBottomAppBarSubtitle);
String get demoBottomAppBarDescription =>
remote.translateOrDefault('demoBottomAppBarDescription', local.demoBottomAppBarDescription);
String get bottomAppBarNotch =>
remote.translateOrDefault('bottomAppBarNotch', local.bottomAppBarNotch);
String get bottomAppBarPosition =>
remote.translateOrDefault('bottomAppBarPosition', local.bottomAppBarPosition);
String get bottomAppBarPositionDockedEnd =>
remote.translateOrDefault('bottomAppBarPositionDockedEnd', local.bottomAppBarPositionDockedEnd);
String get bottomAppBarPositionDockedCenter =>
remote.translateOrDefault('bottomAppBarPositionDockedCenter', local.bottomAppBarPositionDockedCenter);
String get bottomAppBarPositionFloatingEnd =>
remote.translateOrDefault('bottomAppBarPositionFloatingEnd', local.bottomAppBarPositionFloatingEnd);
String get bottomAppBarPositionFloatingCenter =>
remote.translateOrDefault('bottomAppBarPositionFloatingCenter', local.bottomAppBarPositionFloatingCenter);
String get demoBannerTitle =>
remote.translateOrDefault('demoBannerTitle', local.demoBannerTitle);
String get demoBannerSubtitle =>
remote.translateOrDefault('demoBannerSubtitle', local.demoBannerSubtitle);
String get demoBannerDescription =>
remote.translateOrDefault('demoBannerDescription', local.demoBannerDescription);
String get demoBottomNavigationTitle =>
remote.translateOrDefault('demoBottomNavigationTitle', local.demoBottomNavigationTitle);
String get demoBottomNavigationSubtitle =>
remote.translateOrDefault('demoBottomNavigationSubtitle', local.demoBottomNavigationSubtitle);
String get demoBottomNavigationPersistentLabels =>
remote.translateOrDefault('demoBottomNavigationPersistentLabels', local.demoBottomNavigationPersistentLabels);
String get demoBottomNavigationSelectedLabel =>
remote.translateOrDefault('demoBottomNavigationSelectedLabel', local.demoBottomNavigationSelectedLabel);
String get demoBottomNavigationDescription =>
remote.translateOrDefault('demoBottomNavigationDescription', local.demoBottomNavigationDescription);
String get demoButtonTitle =>
remote.translateOrDefault('demoButtonTitle', local.demoButtonTitle);
String get demoButtonSubtitle =>
remote.translateOrDefault('demoButtonSubtitle', local.demoButtonSubtitle);
String get demoTextButtonTitle =>
remote.translateOrDefault('demoTextButtonTitle', local.demoTextButtonTitle);
String get demoTextButtonDescription =>
remote.translateOrDefault('demoTextButtonDescription', local.demoTextButtonDescription);
String get demoElevatedButtonTitle =>
remote.translateOrDefault('demoElevatedButtonTitle', local.demoElevatedButtonTitle);
String get demoElevatedButtonDescription =>
remote.translateOrDefault('demoElevatedButtonDescription', local.demoElevatedButtonDescription);
String get demoOutlinedButtonTitle =>
remote.translateOrDefault('demoOutlinedButtonTitle', local.demoOutlinedButtonTitle);
String get demoOutlinedButtonDescription =>
remote.translateOrDefault('demoOutlinedButtonDescription', local.demoOutlinedButtonDescription);
String get demoToggleButtonTitle =>
remote.translateOrDefault('demoToggleButtonTitle', local.demoToggleButtonTitle);
String get demoToggleButtonDescription =>
remote.translateOrDefault('demoToggleButtonDescription', local.demoToggleButtonDescription);
String get demoFloatingButtonTitle =>
remote.translateOrDefault('demoFloatingButtonTitle', local.demoFloatingButtonTitle);
String get demoFloatingButtonDescription =>
remote.translateOrDefault('demoFloatingButtonDescription', local.demoFloatingButtonDescription);
String get demoCardTitle =>
remote.translateOrDefault('demoCardTitle', local.demoCardTitle);
String get demoCardSubtitle =>
remote.translateOrDefault('demoCardSubtitle', local.demoCardSubtitle);
String get demoChipTitle =>
remote.translateOrDefault('demoChipTitle', local.demoChipTitle);
String get demoCardDescription =>
remote.translateOrDefault('demoCardDescription', local.demoCardDescription);
String get demoChipSubtitle =>
remote.translateOrDefault('demoChipSubtitle', local.demoChipSubtitle);
String get demoActionChipTitle =>
remote.translateOrDefault('demoActionChipTitle', local.demoActionChipTitle);
String get demoActionChipDescription =>
remote.translateOrDefault('demoActionChipDescription', local.demoActionChipDescription);
String get demoChoiceChipTitle =>
remote.translateOrDefault('demoChoiceChipTitle', local.demoChoiceChipTitle);
String get demoChoiceChipDescription =>
remote.translateOrDefault('demoChoiceChipDescription', local.demoChoiceChipDescription);
String get demoFilterChipTitle =>
remote.translateOrDefault('demoFilterChipTitle', local.demoFilterChipTitle);
String get demoFilterChipDescription =>
remote.translateOrDefault('demoFilterChipDescription', local.demoFilterChipDescription);
String get demoInputChipTitle =>
remote.translateOrDefault('demoInputChipTitle', local.demoInputChipTitle);
String get demoInputChipDescription =>
remote.translateOrDefault('demoInputChipDescription', local.demoInputChipDescription);
String get demoDataTableTitle =>
remote.translateOrDefault('demoDataTableTitle', local.demoDataTableTitle);
String get demoDataTableSubtitle =>
remote.translateOrDefault('demoDataTableSubtitle', local.demoDataTableSubtitle);
String get demoDataTableDescription =>
remote.translateOrDefault('demoDataTableDescription', local.demoDataTableDescription);
String get dataTableHeader =>
remote.translateOrDefault('dataTableHeader', local.dataTableHeader);
String get dataTableColumnDessert =>
remote.translateOrDefault('dataTableColumnDessert', local.dataTableColumnDessert);
String get dataTableColumnCalories =>
remote.translateOrDefault('dataTableColumnCalories', local.dataTableColumnCalories);
String get dataTableColumnFat =>
remote.translateOrDefault('dataTableColumnFat', local.dataTableColumnFat);
String get dataTableColumnCarbs =>
remote.translateOrDefault('dataTableColumnCarbs', local.dataTableColumnCarbs);
String get dataTableColumnProtein =>
remote.translateOrDefault('dataTableColumnProtein', local.dataTableColumnProtein);
String get dataTableColumnSodium =>
remote.translateOrDefault('dataTableColumnSodium', local.dataTableColumnSodium);
String get dataTableColumnCalcium =>
remote.translateOrDefault('dataTableColumnCalcium', local.dataTableColumnCalcium);
String get dataTableColumnIron =>
remote.translateOrDefault('dataTableColumnIron', local.dataTableColumnIron);
String get dataTableRowFrozenYogurt =>
remote.translateOrDefault('dataTableRowFrozenYogurt', local.dataTableRowFrozenYogurt);
String get dataTableRowIceCreamSandwich =>
remote.translateOrDefault('dataTableRowIceCreamSandwich', local.dataTableRowIceCreamSandwich);
String get dataTableRowEclair =>
remote.translateOrDefault('dataTableRowEclair', local.dataTableRowEclair);
String get dataTableRowCupcake =>
remote.translateOrDefault('dataTableRowCupcake', local.dataTableRowCupcake);
String get dataTableRowGingerbread =>
remote.translateOrDefault('dataTableRowGingerbread', local.dataTableRowGingerbread);
String get dataTableRowJellyBean =>
remote.translateOrDefault('dataTableRowJellyBean', local.dataTableRowJellyBean);
String get dataTableRowLollipop =>
remote.translateOrDefault('dataTableRowLollipop', local.dataTableRowLollipop);
String get dataTableRowHoneycomb =>
remote.translateOrDefault('dataTableRowHoneycomb', local.dataTableRowHoneycomb);
String get dataTableRowDonut =>
remote.translateOrDefault('dataTableRowDonut', local.dataTableRowDonut);
String get dataTableRowApplePie =>
remote.translateOrDefault('dataTableRowApplePie', local.dataTableRowApplePie);
String dataTableRowWithSugar(Object value){return remote.translateOrDefault('dataTableRowWithSugar', local.dataTableRowWithSugar(value));
}
String dataTableRowWithHoney(Object value){return remote.translateOrDefault('dataTableRowWithHoney', local.dataTableRowWithHoney(value));
}
String get demoDialogTitle =>
remote.translateOrDefault('demoDialogTitle', local.demoDialogTitle);
String get demoDialogSubtitle =>
remote.translateOrDefault('demoDialogSubtitle', local.demoDialogSubtitle);
String get demoAlertDialogTitle =>
remote.translateOrDefault('demoAlertDialogTitle', local.demoAlertDialogTitle);
String get demoAlertDialogDescription =>
remote.translateOrDefault('demoAlertDialogDescription', local.demoAlertDialogDescription);
String get demoAlertTitleDialogTitle =>
remote.translateOrDefault('demoAlertTitleDialogTitle', local.demoAlertTitleDialogTitle);
String get demoSimpleDialogTitle =>
remote.translateOrDefault('demoSimpleDialogTitle', local.demoSimpleDialogTitle);
String get demoSimpleDialogDescription =>
remote.translateOrDefault('demoSimpleDialogDescription', local.demoSimpleDialogDescription);
String get demoGridListsTitle =>
remote.translateOrDefault('demoGridListsTitle', local.demoGridListsTitle);
String get demoGridListsSubtitle =>
remote.translateOrDefault('demoGridListsSubtitle', local.demoGridListsSubtitle);
String get demoGridListsDescription =>
remote.translateOrDefault('demoGridListsDescription', local.demoGridListsDescription);
String get demoGridListsImageOnlyTitle =>
remote.translateOrDefault('demoGridListsImageOnlyTitle', local.demoGridListsImageOnlyTitle);
String get demoGridListsHeaderTitle =>
remote.translateOrDefault('demoGridListsHeaderTitle', local.demoGridListsHeaderTitle);
String get demoGridListsFooterTitle =>
remote.translateOrDefault('demoGridListsFooterTitle', local.demoGridListsFooterTitle);
String get demoSlidersTitle =>
remote.translateOrDefault('demoSlidersTitle', local.demoSlidersTitle);
String get demoSlidersSubtitle =>
remote.translateOrDefault('demoSlidersSubtitle', local.demoSlidersSubtitle);
String get demoSlidersDescription =>
remote.translateOrDefault('demoSlidersDescription', local.demoSlidersDescription);
String get demoRangeSlidersTitle =>
remote.translateOrDefault('demoRangeSlidersTitle', local.demoRangeSlidersTitle);
String get demoRangeSlidersDescription =>
remote.translateOrDefault('demoRangeSlidersDescription', local.demoRangeSlidersDescription);
String get demoCustomSlidersTitle =>
remote.translateOrDefault('demoCustomSlidersTitle', local.demoCustomSlidersTitle);
String get demoCustomSlidersDescription =>
remote.translateOrDefault('demoCustomSlidersDescription', local.demoCustomSlidersDescription);
String get demoSlidersContinuousWithEditableNumericalValue =>
remote.translateOrDefault('demoSlidersContinuousWithEditableNumericalValue', local.demoSlidersContinuousWithEditableNumericalValue);
String get demoSlidersDiscrete =>
remote.translateOrDefault('demoSlidersDiscrete', local.demoSlidersDiscrete);
String get demoSlidersDiscreteSliderWithCustomTheme =>
remote.translateOrDefault('demoSlidersDiscreteSliderWithCustomTheme', local.demoSlidersDiscreteSliderWithCustomTheme);
String get demoSlidersContinuousRangeSliderWithCustomTheme =>
remote.translateOrDefault('demoSlidersContinuousRangeSliderWithCustomTheme', local.demoSlidersContinuousRangeSliderWithCustomTheme);
String get demoSlidersContinuous =>
remote.translateOrDefault('demoSlidersContinuous', local.demoSlidersContinuous);
String get demoSlidersEditableNumericalValue =>
remote.translateOrDefault('demoSlidersEditableNumericalValue', local.demoSlidersEditableNumericalValue);
String get demoMenuTitle =>
remote.translateOrDefault('demoMenuTitle', local.demoMenuTitle);
String get demoContextMenuTitle =>
remote.translateOrDefault('demoContextMenuTitle', local.demoContextMenuTitle);
String get demoSectionedMenuTitle =>
remote.translateOrDefault('demoSectionedMenuTitle', local.demoSectionedMenuTitle);
String get demoSimpleMenuTitle =>
remote.translateOrDefault('demoSimpleMenuTitle', local.demoSimpleMenuTitle);
String get demoChecklistMenuTitle =>
remote.translateOrDefault('demoChecklistMenuTitle', local.demoChecklistMenuTitle);
String get demoMenuSubtitle =>
remote.translateOrDefault('demoMenuSubtitle', local.demoMenuSubtitle);
String get demoMenuDescription =>
remote.translateOrDefault('demoMenuDescription', local.demoMenuDescription);
String get demoMenuItemValueOne =>
remote.translateOrDefault('demoMenuItemValueOne', local.demoMenuItemValueOne);
String get demoMenuItemValueTwo =>
remote.translateOrDefault('demoMenuItemValueTwo', local.demoMenuItemValueTwo);
String get demoMenuItemValueThree =>
remote.translateOrDefault('demoMenuItemValueThree', local.demoMenuItemValueThree);
String get demoMenuOne =>
remote.translateOrDefault('demoMenuOne', local.demoMenuOne);
String get demoMenuTwo =>
remote.translateOrDefault('demoMenuTwo', local.demoMenuTwo);
String get demoMenuThree =>
remote.translateOrDefault('demoMenuThree', local.demoMenuThree);
String get demoMenuFour =>
remote.translateOrDefault('demoMenuFour', local.demoMenuFour);
String get demoMenuAnItemWithAContextMenuButton =>
remote.translateOrDefault('demoMenuAnItemWithAContextMenuButton', local.demoMenuAnItemWithAContextMenuButton);
String get demoMenuContextMenuItemOne =>
remote.translateOrDefault('demoMenuContextMenuItemOne', local.demoMenuContextMenuItemOne);
String get demoMenuADisabledMenuItem =>
remote.translateOrDefault('demoMenuADisabledMenuItem', local.demoMenuADisabledMenuItem);
String get demoMenuContextMenuItemThree =>
remote.translateOrDefault('demoMenuContextMenuItemThree', local.demoMenuContextMenuItemThree);
String get demoMenuAnItemWithASectionedMenu =>
remote.translateOrDefault('demoMenuAnItemWithASectionedMenu', local.demoMenuAnItemWithASectionedMenu);
String get demoMenuPreview =>
remote.translateOrDefault('demoMenuPreview', local.demoMenuPreview);
String get demoMenuShare =>
remote.translateOrDefault('demoMenuShare', local.demoMenuShare);
String get demoMenuGetLink =>
remote.translateOrDefault('demoMenuGetLink', local.demoMenuGetLink);
String get demoMenuRemove =>
remote.translateOrDefault('demoMenuRemove', local.demoMenuRemove);
String demoMenuSelected(int value){return remote.translateOrDefault('demoMenuSelected', local.demoMenuSelected(value));
}
String demoMenuChecked(int value){return remote.translateOrDefault('demoMenuChecked', local.demoMenuChecked(value));
}
String get demoNavigationDrawerTitle =>
remote.translateOrDefault('demoNavigationDrawerTitle', local.demoNavigationDrawerTitle);
String get demoNavigationDrawerSubtitle =>
remote.translateOrDefault('demoNavigationDrawerSubtitle', local.demoNavigationDrawerSubtitle);
String get demoNavigationDrawerDescription =>
remote.translateOrDefault('demoNavigationDrawerDescription', local.demoNavigationDrawerDescription);
String get demoNavigationDrawerUserName =>
remote.translateOrDefault('demoNavigationDrawerUserName', local.demoNavigationDrawerUserName);
String get demoNavigationDrawerUserEmail =>
remote.translateOrDefault('demoNavigationDrawerUserEmail', local.demoNavigationDrawerUserEmail);
String get demoNavigationDrawerToPageOne =>
remote.translateOrDefault('demoNavigationDrawerToPageOne', local.demoNavigationDrawerToPageOne);
String get demoNavigationDrawerToPageTwo =>
remote.translateOrDefault('demoNavigationDrawerToPageTwo', local.demoNavigationDrawerToPageTwo);
String get demoNavigationDrawerText =>
remote.translateOrDefault('demoNavigationDrawerText', local.demoNavigationDrawerText);
String get demoNavigationRailTitle =>
remote.translateOrDefault('demoNavigationRailTitle', local.demoNavigationRailTitle);
String get demoNavigationRailSubtitle =>
remote.translateOrDefault('demoNavigationRailSubtitle', local.demoNavigationRailSubtitle);
String get demoNavigationRailDescription =>
remote.translateOrDefault('demoNavigationRailDescription', local.demoNavigationRailDescription);
String get demoNavigationRailFirst =>
remote.translateOrDefault('demoNavigationRailFirst', local.demoNavigationRailFirst);
String get demoNavigationRailSecond =>
remote.translateOrDefault('demoNavigationRailSecond', local.demoNavigationRailSecond);
String get demoNavigationRailThird =>
remote.translateOrDefault('demoNavigationRailThird', local.demoNavigationRailThird);
String get demoMenuAnItemWithASimpleMenu =>
remote.translateOrDefault('demoMenuAnItemWithASimpleMenu', local.demoMenuAnItemWithASimpleMenu);
String get demoMenuAnItemWithAChecklistMenu =>
remote.translateOrDefault('demoMenuAnItemWithAChecklistMenu', local.demoMenuAnItemWithAChecklistMenu);
String get demoFullscreenDialogTitle =>
remote.translateOrDefault('demoFullscreenDialogTitle', local.demoFullscreenDialogTitle);
String get demoFullscreenDialogDescription =>
remote.translateOrDefault('demoFullscreenDialogDescription', local.demoFullscreenDialogDescription);
String get demoCupertinoActivityIndicatorTitle =>
remote.translateOrDefault('demoCupertinoActivityIndicatorTitle', local.demoCupertinoActivityIndicatorTitle);
String get demoCupertinoActivityIndicatorSubtitle =>
remote.translateOrDefault('demoCupertinoActivityIndicatorSubtitle', local.demoCupertinoActivityIndicatorSubtitle);
String get demoCupertinoActivityIndicatorDescription =>
remote.translateOrDefault('demoCupertinoActivityIndicatorDescription', local.demoCupertinoActivityIndicatorDescription);
String get demoCupertinoButtonsTitle =>
remote.translateOrDefault('demoCupertinoButtonsTitle', local.demoCupertinoButtonsTitle);
String get demoCupertinoButtonsSubtitle =>
remote.translateOrDefault('demoCupertinoButtonsSubtitle', local.demoCupertinoButtonsSubtitle);
String get demoCupertinoButtonsDescription =>
remote.translateOrDefault('demoCupertinoButtonsDescription', local.demoCupertinoButtonsDescription);
String get demoCupertinoContextMenuTitle =>
remote.translateOrDefault('demoCupertinoContextMenuTitle', local.demoCupertinoContextMenuTitle);
String get demoCupertinoContextMenuSubtitle =>
remote.translateOrDefault('demoCupertinoContextMenuSubtitle', local.demoCupertinoContextMenuSubtitle);
String get demoCupertinoContextMenuDescription =>
remote.translateOrDefault('demoCupertinoContextMenuDescription', local.demoCupertinoContextMenuDescription);
String get demoCupertinoContextMenuActionOne =>
remote.translateOrDefault('demoCupertinoContextMenuActionOne', local.demoCupertinoContextMenuActionOne);
String get demoCupertinoContextMenuActionTwo =>
remote.translateOrDefault('demoCupertinoContextMenuActionTwo', local.demoCupertinoContextMenuActionTwo);
String get demoCupertinoContextMenuActionText =>
remote.translateOrDefault('demoCupertinoContextMenuActionText', local.demoCupertinoContextMenuActionText);
String get demoCupertinoAlertsTitle =>
remote.translateOrDefault('demoCupertinoAlertsTitle', local.demoCupertinoAlertsTitle);
String get demoCupertinoAlertsSubtitle =>
remote.translateOrDefault('demoCupertinoAlertsSubtitle', local.demoCupertinoAlertsSubtitle);
String get demoCupertinoAlertTitle =>
remote.translateOrDefault('demoCupertinoAlertTitle', local.demoCupertinoAlertTitle);
String get demoCupertinoAlertDescription =>
remote.translateOrDefault('demoCupertinoAlertDescription', local.demoCupertinoAlertDescription);
String get demoCupertinoAlertWithTitleTitle =>
remote.translateOrDefault('demoCupertinoAlertWithTitleTitle', local.demoCupertinoAlertWithTitleTitle);
String get demoCupertinoAlertButtonsTitle =>
remote.translateOrDefault('demoCupertinoAlertButtonsTitle', local.demoCupertinoAlertButtonsTitle);
String get demoCupertinoAlertButtonsOnlyTitle =>
remote.translateOrDefault('demoCupertinoAlertButtonsOnlyTitle', local.demoCupertinoAlertButtonsOnlyTitle);
String get demoCupertinoActionSheetTitle =>
remote.translateOrDefault('demoCupertinoActionSheetTitle', local.demoCupertinoActionSheetTitle);
String get demoCupertinoActionSheetDescription =>
remote.translateOrDefault('demoCupertinoActionSheetDescription', local.demoCupertinoActionSheetDescription);
String get demoCupertinoNavigationBarTitle =>
remote.translateOrDefault('demoCupertinoNavigationBarTitle', local.demoCupertinoNavigationBarTitle);
String get demoCupertinoNavigationBarSubtitle =>
remote.translateOrDefault('demoCupertinoNavigationBarSubtitle', local.demoCupertinoNavigationBarSubtitle);
String get demoCupertinoNavigationBarDescription =>
remote.translateOrDefault('demoCupertinoNavigationBarDescription', local.demoCupertinoNavigationBarDescription);
String get demoCupertinoPickerTitle =>
remote.translateOrDefault('demoCupertinoPickerTitle', local.demoCupertinoPickerTitle);
String get demoCupertinoPickerSubtitle =>
remote.translateOrDefault('demoCupertinoPickerSubtitle', local.demoCupertinoPickerSubtitle);
String get demoCupertinoPickerDescription =>
remote.translateOrDefault('demoCupertinoPickerDescription', local.demoCupertinoPickerDescription);
String get demoCupertinoPickerTimer =>
remote.translateOrDefault('demoCupertinoPickerTimer', local.demoCupertinoPickerTimer);
String get demoCupertinoPickerDate =>
remote.translateOrDefault('demoCupertinoPickerDate', local.demoCupertinoPickerDate);
String get demoCupertinoPickerTime =>
remote.translateOrDefault('demoCupertinoPickerTime', local.demoCupertinoPickerTime);
String get demoCupertinoPickerDateTime =>
remote.translateOrDefault('demoCupertinoPickerDateTime', local.demoCupertinoPickerDateTime);
String get demoCupertinoPullToRefreshTitle =>
remote.translateOrDefault('demoCupertinoPullToRefreshTitle', local.demoCupertinoPullToRefreshTitle);
String get demoCupertinoPullToRefreshSubtitle =>
remote.translateOrDefault('demoCupertinoPullToRefreshSubtitle', local.demoCupertinoPullToRefreshSubtitle);
String get demoCupertinoPullToRefreshDescription =>
remote.translateOrDefault('demoCupertinoPullToRefreshDescription', local.demoCupertinoPullToRefreshDescription);
String get demoCupertinoSegmentedControlTitle =>
remote.translateOrDefault('demoCupertinoSegmentedControlTitle', local.demoCupertinoSegmentedControlTitle);
String get demoCupertinoSegmentedControlSubtitle =>
remote.translateOrDefault('demoCupertinoSegmentedControlSubtitle', local.demoCupertinoSegmentedControlSubtitle);
String get demoCupertinoSegmentedControlDescription =>
remote.translateOrDefault('demoCupertinoSegmentedControlDescription', local.demoCupertinoSegmentedControlDescription);
String get demoCupertinoSliderTitle =>
remote.translateOrDefault('demoCupertinoSliderTitle', local.demoCupertinoSliderTitle);
String get demoCupertinoSliderSubtitle =>
remote.translateOrDefault('demoCupertinoSliderSubtitle', local.demoCupertinoSliderSubtitle);
String get demoCupertinoSliderDescription =>
remote.translateOrDefault('demoCupertinoSliderDescription', local.demoCupertinoSliderDescription);
String demoCupertinoSliderContinuous(int value){return remote.translateOrDefault('demoCupertinoSliderContinuous', local.demoCupertinoSliderContinuous(value));
}
String demoCupertinoSliderDiscrete(int value){return remote.translateOrDefault('demoCupertinoSliderDiscrete', local.demoCupertinoSliderDiscrete(value));
}
String get demoCupertinoSwitchSubtitle =>
remote.translateOrDefault('demoCupertinoSwitchSubtitle', local.demoCupertinoSwitchSubtitle);
String get demoCupertinoSwitchDescription =>
remote.translateOrDefault('demoCupertinoSwitchDescription', local.demoCupertinoSwitchDescription);
String get demoCupertinoTabBarTitle =>
remote.translateOrDefault('demoCupertinoTabBarTitle', local.demoCupertinoTabBarTitle);
String get demoCupertinoTabBarSubtitle =>
remote.translateOrDefault('demoCupertinoTabBarSubtitle', local.demoCupertinoTabBarSubtitle);
String get demoCupertinoTabBarDescription =>
remote.translateOrDefault('demoCupertinoTabBarDescription', local.demoCupertinoTabBarDescription);
String get cupertinoTabBarHomeTab =>
remote.translateOrDefault('cupertinoTabBarHomeTab', local.cupertinoTabBarHomeTab);
String get cupertinoTabBarChatTab =>
remote.translateOrDefault('cupertinoTabBarChatTab', local.cupertinoTabBarChatTab);
String get cupertinoTabBarProfileTab =>
remote.translateOrDefault('cupertinoTabBarProfileTab', local.cupertinoTabBarProfileTab);
String get demoCupertinoTextFieldTitle =>
remote.translateOrDefault('demoCupertinoTextFieldTitle', local.demoCupertinoTextFieldTitle);
String get demoCupertinoTextFieldSubtitle =>
remote.translateOrDefault('demoCupertinoTextFieldSubtitle', local.demoCupertinoTextFieldSubtitle);
String get demoCupertinoTextFieldDescription =>
remote.translateOrDefault('demoCupertinoTextFieldDescription', local.demoCupertinoTextFieldDescription);
String get demoCupertinoTextFieldPIN =>
remote.translateOrDefault('demoCupertinoTextFieldPIN', local.demoCupertinoTextFieldPIN);
String get demoMotionTitle =>
remote.translateOrDefault('demoMotionTitle', local.demoMotionTitle);
String get demoMotionSubtitle =>
remote.translateOrDefault('demoMotionSubtitle', local.demoMotionSubtitle);
String get demoContainerTransformDemoInstructions =>
remote.translateOrDefault('demoContainerTransformDemoInstructions', local.demoContainerTransformDemoInstructions);
String get demoSharedXAxisDemoInstructions =>
remote.translateOrDefault('demoSharedXAxisDemoInstructions', local.demoSharedXAxisDemoInstructions);
String get demoSharedYAxisDemoInstructions =>
remote.translateOrDefault('demoSharedYAxisDemoInstructions', local.demoSharedYAxisDemoInstructions);
String get demoSharedZAxisDemoInstructions =>
remote.translateOrDefault('demoSharedZAxisDemoInstructions', local.demoSharedZAxisDemoInstructions);
String get demoFadeThroughDemoInstructions =>
remote.translateOrDefault('demoFadeThroughDemoInstructions', local.demoFadeThroughDemoInstructions);
String get demoFadeScaleDemoInstructions =>
remote.translateOrDefault('demoFadeScaleDemoInstructions', local.demoFadeScaleDemoInstructions);
String get demoContainerTransformTitle =>
remote.translateOrDefault('demoContainerTransformTitle', local.demoContainerTransformTitle);
String get demoContainerTransformDescription =>
remote.translateOrDefault('demoContainerTransformDescription', local.demoContainerTransformDescription);
String get demoContainerTransformModalBottomSheetTitle =>
remote.translateOrDefault('demoContainerTransformModalBottomSheetTitle', local.demoContainerTransformModalBottomSheetTitle);
String get demoContainerTransformTypeFade =>
remote.translateOrDefault('demoContainerTransformTypeFade', local.demoContainerTransformTypeFade);
String get demoContainerTransformTypeFadeThrough =>
remote.translateOrDefault('demoContainerTransformTypeFadeThrough', local.demoContainerTransformTypeFadeThrough);
String get demoMotionPlaceholderTitle =>
remote.translateOrDefault('demoMotionPlaceholderTitle', local.demoMotionPlaceholderTitle);
String get demoMotionPlaceholderSubtitle =>
remote.translateOrDefault('demoMotionPlaceholderSubtitle', local.demoMotionPlaceholderSubtitle);
String get demoMotionSmallPlaceholderSubtitle =>
remote.translateOrDefault('demoMotionSmallPlaceholderSubtitle', local.demoMotionSmallPlaceholderSubtitle);
String get demoMotionDetailsPageTitle =>
remote.translateOrDefault('demoMotionDetailsPageTitle', local.demoMotionDetailsPageTitle);
String get demoMotionListTileTitle =>
remote.translateOrDefault('demoMotionListTileTitle', local.demoMotionListTileTitle);
String get demoSharedAxisDescription =>
remote.translateOrDefault('demoSharedAxisDescription', local.demoSharedAxisDescription);
String get demoSharedXAxisTitle =>
remote.translateOrDefault('demoSharedXAxisTitle', local.demoSharedXAxisTitle);
String get demoSharedXAxisBackButtonText =>
remote.translateOrDefault('demoSharedXAxisBackButtonText', local.demoSharedXAxisBackButtonText);
String get demoSharedXAxisNextButtonText =>
remote.translateOrDefault('demoSharedXAxisNextButtonText', local.demoSharedXAxisNextButtonText);
String get demoSharedXAxisCoursePageTitle =>
remote.translateOrDefault('demoSharedXAxisCoursePageTitle', local.demoSharedXAxisCoursePageTitle);
String get demoSharedXAxisCoursePageSubtitle =>
remote.translateOrDefault('demoSharedXAxisCoursePageSubtitle', local.demoSharedXAxisCoursePageSubtitle);
String get demoSharedXAxisArtsAndCraftsCourseTitle =>
remote.translateOrDefault('demoSharedXAxisArtsAndCraftsCourseTitle', local.demoSharedXAxisArtsAndCraftsCourseTitle);
String get demoSharedXAxisBusinessCourseTitle =>
remote.translateOrDefault('demoSharedXAxisBusinessCourseTitle', local.demoSharedXAxisBusinessCourseTitle);
String get demoSharedXAxisIllustrationCourseTitle =>
remote.translateOrDefault('demoSharedXAxisIllustrationCourseTitle', local.demoSharedXAxisIllustrationCourseTitle);
String get demoSharedXAxisDesignCourseTitle =>
remote.translateOrDefault('demoSharedXAxisDesignCourseTitle', local.demoSharedXAxisDesignCourseTitle);
String get demoSharedXAxisCulinaryCourseTitle =>
remote.translateOrDefault('demoSharedXAxisCulinaryCourseTitle', local.demoSharedXAxisCulinaryCourseTitle);
String get demoSharedXAxisBundledCourseSubtitle =>
remote.translateOrDefault('demoSharedXAxisBundledCourseSubtitle', local.demoSharedXAxisBundledCourseSubtitle);
String get demoSharedXAxisIndividualCourseSubtitle =>
remote.translateOrDefault('demoSharedXAxisIndividualCourseSubtitle', local.demoSharedXAxisIndividualCourseSubtitle);
String get demoSharedXAxisSignInWelcomeText =>
remote.translateOrDefault('demoSharedXAxisSignInWelcomeText', local.demoSharedXAxisSignInWelcomeText);
String get demoSharedXAxisSignInSubtitleText =>
remote.translateOrDefault('demoSharedXAxisSignInSubtitleText', local.demoSharedXAxisSignInSubtitleText);
String get demoSharedXAxisSignInTextFieldLabel =>
remote.translateOrDefault('demoSharedXAxisSignInTextFieldLabel', local.demoSharedXAxisSignInTextFieldLabel);
String get demoSharedXAxisForgotEmailButtonText =>
remote.translateOrDefault('demoSharedXAxisForgotEmailButtonText', local.demoSharedXAxisForgotEmailButtonText);
String get demoSharedXAxisCreateAccountButtonText =>
remote.translateOrDefault('demoSharedXAxisCreateAccountButtonText', local.demoSharedXAxisCreateAccountButtonText);
String get demoSharedYAxisTitle =>
remote.translateOrDefault('demoSharedYAxisTitle', local.demoSharedYAxisTitle);
String get demoSharedYAxisAlbumCount =>
remote.translateOrDefault('demoSharedYAxisAlbumCount', local.demoSharedYAxisAlbumCount);
String get demoSharedYAxisAlphabeticalSortTitle =>
remote.translateOrDefault('demoSharedYAxisAlphabeticalSortTitle', local.demoSharedYAxisAlphabeticalSortTitle);
String get demoSharedYAxisRecentSortTitle =>
remote.translateOrDefault('demoSharedYAxisRecentSortTitle', local.demoSharedYAxisRecentSortTitle);
String get demoSharedYAxisAlbumTileTitle =>
remote.translateOrDefault('demoSharedYAxisAlbumTileTitle', local.demoSharedYAxisAlbumTileTitle);
String get demoSharedYAxisAlbumTileSubtitle =>
remote.translateOrDefault('demoSharedYAxisAlbumTileSubtitle', local.demoSharedYAxisAlbumTileSubtitle);
String get demoSharedYAxisAlbumTileDurationUnit =>
remote.translateOrDefault('demoSharedYAxisAlbumTileDurationUnit', local.demoSharedYAxisAlbumTileDurationUnit);
String get demoSharedZAxisTitle =>
remote.translateOrDefault('demoSharedZAxisTitle', local.demoSharedZAxisTitle);
String get demoSharedZAxisSettingsPageTitle =>
remote.translateOrDefault('demoSharedZAxisSettingsPageTitle', local.demoSharedZAxisSettingsPageTitle);
String get demoSharedZAxisBurgerRecipeTitle =>
remote.translateOrDefault('demoSharedZAxisBurgerRecipeTitle', local.demoSharedZAxisBurgerRecipeTitle);
String get demoSharedZAxisBurgerRecipeDescription =>
remote.translateOrDefault('demoSharedZAxisBurgerRecipeDescription', local.demoSharedZAxisBurgerRecipeDescription);
String get demoSharedZAxisSandwichRecipeTitle =>
remote.translateOrDefault('demoSharedZAxisSandwichRecipeTitle', local.demoSharedZAxisSandwichRecipeTitle);
String get demoSharedZAxisSandwichRecipeDescription =>
remote.translateOrDefault('demoSharedZAxisSandwichRecipeDescription', local.demoSharedZAxisSandwichRecipeDescription);
String get demoSharedZAxisDessertRecipeTitle =>
remote.translateOrDefault('demoSharedZAxisDessertRecipeTitle', local.demoSharedZAxisDessertRecipeTitle);
String get demoSharedZAxisDessertRecipeDescription =>
remote.translateOrDefault('demoSharedZAxisDessertRecipeDescription', local.demoSharedZAxisDessertRecipeDescription);
String get demoSharedZAxisShrimpPlateRecipeTitle =>
remote.translateOrDefault('demoSharedZAxisShrimpPlateRecipeTitle', local.demoSharedZAxisShrimpPlateRecipeTitle);
String get demoSharedZAxisShrimpPlateRecipeDescription =>
remote.translateOrDefault('demoSharedZAxisShrimpPlateRecipeDescription', local.demoSharedZAxisShrimpPlateRecipeDescription);
String get demoSharedZAxisCrabPlateRecipeTitle =>
remote.translateOrDefault('demoSharedZAxisCrabPlateRecipeTitle', local.demoSharedZAxisCrabPlateRecipeTitle);
String get demoSharedZAxisCrabPlateRecipeDescription =>
remote.translateOrDefault('demoSharedZAxisCrabPlateRecipeDescription', local.demoSharedZAxisCrabPlateRecipeDescription);
String get demoSharedZAxisBeefSandwichRecipeTitle =>
remote.translateOrDefault('demoSharedZAxisBeefSandwichRecipeTitle', local.demoSharedZAxisBeefSandwichRecipeTitle);
String get demoSharedZAxisBeefSandwichRecipeDescription =>
remote.translateOrDefault('demoSharedZAxisBeefSandwichRecipeDescription', local.demoSharedZAxisBeefSandwichRecipeDescription);
String get demoSharedZAxisSavedRecipesListTitle =>
remote.translateOrDefault('demoSharedZAxisSavedRecipesListTitle', local.demoSharedZAxisSavedRecipesListTitle);
String get demoSharedZAxisProfileSettingLabel =>
remote.translateOrDefault('demoSharedZAxisProfileSettingLabel', local.demoSharedZAxisProfileSettingLabel);
String get demoSharedZAxisNotificationSettingLabel =>
remote.translateOrDefault('demoSharedZAxisNotificationSettingLabel', local.demoSharedZAxisNotificationSettingLabel);
String get demoSharedZAxisPrivacySettingLabel =>
remote.translateOrDefault('demoSharedZAxisPrivacySettingLabel', local.demoSharedZAxisPrivacySettingLabel);
String get demoSharedZAxisHelpSettingLabel =>
remote.translateOrDefault('demoSharedZAxisHelpSettingLabel', local.demoSharedZAxisHelpSettingLabel);
String get demoFadeThroughTitle =>
remote.translateOrDefault('demoFadeThroughTitle', local.demoFadeThroughTitle);
String get demoFadeThroughDescription =>
remote.translateOrDefault('demoFadeThroughDescription', local.demoFadeThroughDescription);
String get demoFadeThroughAlbumsDestination =>
remote.translateOrDefault('demoFadeThroughAlbumsDestination', local.demoFadeThroughAlbumsDestination);
String get demoFadeThroughPhotosDestination =>
remote.translateOrDefault('demoFadeThroughPhotosDestination', local.demoFadeThroughPhotosDestination);
String get demoFadeThroughSearchDestination =>
remote.translateOrDefault('demoFadeThroughSearchDestination', local.demoFadeThroughSearchDestination);
String get demoFadeThroughTextPlaceholder =>
remote.translateOrDefault('demoFadeThroughTextPlaceholder', local.demoFadeThroughTextPlaceholder);
String get demoFadeScaleTitle =>
remote.translateOrDefault('demoFadeScaleTitle', local.demoFadeScaleTitle);
String get demoFadeScaleDescription =>
remote.translateOrDefault('demoFadeScaleDescription', local.demoFadeScaleDescription);
String get demoFadeScaleShowAlertDialogButton =>
remote.translateOrDefault('demoFadeScaleShowAlertDialogButton', local.demoFadeScaleShowAlertDialogButton);
String get demoFadeScaleShowFabButton =>
remote.translateOrDefault('demoFadeScaleShowFabButton', local.demoFadeScaleShowFabButton);
String get demoFadeScaleHideFabButton =>
remote.translateOrDefault('demoFadeScaleHideFabButton', local.demoFadeScaleHideFabButton);
String get demoFadeScaleAlertDialogHeader =>
remote.translateOrDefault('demoFadeScaleAlertDialogHeader', local.demoFadeScaleAlertDialogHeader);
String get demoFadeScaleAlertDialogCancelButton =>
remote.translateOrDefault('demoFadeScaleAlertDialogCancelButton', local.demoFadeScaleAlertDialogCancelButton);
String get demoFadeScaleAlertDialogDiscardButton =>
remote.translateOrDefault('demoFadeScaleAlertDialogDiscardButton', local.demoFadeScaleAlertDialogDiscardButton);
String get demoColorsTitle =>
remote.translateOrDefault('demoColorsTitle', local.demoColorsTitle);
String get demoColorsSubtitle =>
remote.translateOrDefault('demoColorsSubtitle', local.demoColorsSubtitle);
String get demoColorsDescription =>
remote.translateOrDefault('demoColorsDescription', local.demoColorsDescription);
String get demoTypographyTitle =>
remote.translateOrDefault('demoTypographyTitle', local.demoTypographyTitle);
String get demoTypographySubtitle =>
remote.translateOrDefault('demoTypographySubtitle', local.demoTypographySubtitle);
String get demoTypographyDescription =>
remote.translateOrDefault('demoTypographyDescription', local.demoTypographyDescription);
String get demo2dTransformationsTitle =>
remote.translateOrDefault('demo2dTransformationsTitle', local.demo2dTransformationsTitle);
String get demo2dTransformationsSubtitle =>
remote.translateOrDefault('demo2dTransformationsSubtitle', local.demo2dTransformationsSubtitle);
String get demo2dTransformationsDescription =>
remote.translateOrDefault('demo2dTransformationsDescription', local.demo2dTransformationsDescription);
String get demo2dTransformationsResetTooltip =>
remote.translateOrDefault('demo2dTransformationsResetTooltip', local.demo2dTransformationsResetTooltip);
String get demo2dTransformationsEditTooltip =>
remote.translateOrDefault('demo2dTransformationsEditTooltip', local.demo2dTransformationsEditTooltip);
String get buttonText =>
remote.translateOrDefault('buttonText', local.buttonText);
String get demoBottomSheetTitle =>
remote.translateOrDefault('demoBottomSheetTitle', local.demoBottomSheetTitle);
String get demoBottomSheetSubtitle =>
remote.translateOrDefault('demoBottomSheetSubtitle', local.demoBottomSheetSubtitle);
String get demoBottomSheetPersistentTitle =>
remote.translateOrDefault('demoBottomSheetPersistentTitle', local.demoBottomSheetPersistentTitle);
String get demoBottomSheetPersistentDescription =>
remote.translateOrDefault('demoBottomSheetPersistentDescription', local.demoBottomSheetPersistentDescription);
String get demoBottomSheetModalTitle =>
remote.translateOrDefault('demoBottomSheetModalTitle', local.demoBottomSheetModalTitle);
String get demoBottomSheetModalDescription =>
remote.translateOrDefault('demoBottomSheetModalDescription', local.demoBottomSheetModalDescription);
String get demoBottomSheetAddLabel =>
remote.translateOrDefault('demoBottomSheetAddLabel', local.demoBottomSheetAddLabel);
String get demoBottomSheetButtonText =>
remote.translateOrDefault('demoBottomSheetButtonText', local.demoBottomSheetButtonText);
String get demoBottomSheetHeader =>
remote.translateOrDefault('demoBottomSheetHeader', local.demoBottomSheetHeader);
String demoBottomSheetItem(int value){return remote.translateOrDefault('demoBottomSheetItem', local.demoBottomSheetItem(value));
}
String get demoListsTitle =>
remote.translateOrDefault('demoListsTitle', local.demoListsTitle);
String get demoListsSubtitle =>
remote.translateOrDefault('demoListsSubtitle', local.demoListsSubtitle);
String get demoListsDescription =>
remote.translateOrDefault('demoListsDescription', local.demoListsDescription);
String get demoOneLineListsTitle =>
remote.translateOrDefault('demoOneLineListsTitle', local.demoOneLineListsTitle);
String get demoTwoLineListsTitle =>
remote.translateOrDefault('demoTwoLineListsTitle', local.demoTwoLineListsTitle);
String get demoListsSecondary =>
remote.translateOrDefault('demoListsSecondary', local.demoListsSecondary);
String get demoProgressIndicatorTitle =>
remote.translateOrDefault('demoProgressIndicatorTitle', local.demoProgressIndicatorTitle);
String get demoProgressIndicatorSubtitle =>
remote.translateOrDefault('demoProgressIndicatorSubtitle', local.demoProgressIndicatorSubtitle);
String get demoCircularProgressIndicatorTitle =>
remote.translateOrDefault('demoCircularProgressIndicatorTitle', local.demoCircularProgressIndicatorTitle);
String get demoCircularProgressIndicatorDescription =>
remote.translateOrDefault('demoCircularProgressIndicatorDescription', local.demoCircularProgressIndicatorDescription);
String get demoLinearProgressIndicatorTitle =>
remote.translateOrDefault('demoLinearProgressIndicatorTitle', local.demoLinearProgressIndicatorTitle);
String get demoLinearProgressIndicatorDescription =>
remote.translateOrDefault('demoLinearProgressIndicatorDescription', local.demoLinearProgressIndicatorDescription);
String get demoPickersTitle =>
remote.translateOrDefault('demoPickersTitle', local.demoPickersTitle);
String get demoPickersSubtitle =>
remote.translateOrDefault('demoPickersSubtitle', local.demoPickersSubtitle);
String get demoDatePickerTitle =>
remote.translateOrDefault('demoDatePickerTitle', local.demoDatePickerTitle);
String get demoDatePickerDescription =>
remote.translateOrDefault('demoDatePickerDescription', local.demoDatePickerDescription);
String get demoTimePickerTitle =>
remote.translateOrDefault('demoTimePickerTitle', local.demoTimePickerTitle);
String get demoTimePickerDescription =>
remote.translateOrDefault('demoTimePickerDescription', local.demoTimePickerDescription);
String get demoDateRangePickerTitle =>
remote.translateOrDefault('demoDateRangePickerTitle', local.demoDateRangePickerTitle);
String get demoDateRangePickerDescription =>
remote.translateOrDefault('demoDateRangePickerDescription', local.demoDateRangePickerDescription);
String get demoPickersShowPicker =>
remote.translateOrDefault('demoPickersShowPicker', local.demoPickersShowPicker);
String get demoTabsTitle =>
remote.translateOrDefault('demoTabsTitle', local.demoTabsTitle);
String get demoTabsScrollingTitle =>
remote.translateOrDefault('demoTabsScrollingTitle', local.demoTabsScrollingTitle);
String get demoTabsNonScrollingTitle =>
remote.translateOrDefault('demoTabsNonScrollingTitle', local.demoTabsNonScrollingTitle);
String get demoTabsSubtitle =>
remote.translateOrDefault('demoTabsSubtitle', local.demoTabsSubtitle);
String get demoTabsDescription =>
remote.translateOrDefault('demoTabsDescription', local.demoTabsDescription);
String get demoSnackbarsTitle =>
remote.translateOrDefault('demoSnackbarsTitle', local.demoSnackbarsTitle);
String get demoSnackbarsSubtitle =>
remote.translateOrDefault('demoSnackbarsSubtitle', local.demoSnackbarsSubtitle);
String get demoSnackbarsDescription =>
remote.translateOrDefault('demoSnackbarsDescription', local.demoSnackbarsDescription);
String get demoSnackbarsButtonLabel =>
remote.translateOrDefault('demoSnackbarsButtonLabel', local.demoSnackbarsButtonLabel);
String get demoSnackbarsText =>
remote.translateOrDefault('demoSnackbarsText', local.demoSnackbarsText);
String get demoSnackbarsActionButtonLabel =>
remote.translateOrDefault('demoSnackbarsActionButtonLabel', local.demoSnackbarsActionButtonLabel);
String get demoSnackbarsAction =>
remote.translateOrDefault('demoSnackbarsAction', local.demoSnackbarsAction);
String get demoSelectionControlsTitle =>
remote.translateOrDefault('demoSelectionControlsTitle', local.demoSelectionControlsTitle);
String get demoSelectionControlsSubtitle =>
remote.translateOrDefault('demoSelectionControlsSubtitle', local.demoSelectionControlsSubtitle);
String get demoSelectionControlsCheckboxTitle =>
remote.translateOrDefault('demoSelectionControlsCheckboxTitle', local.demoSelectionControlsCheckboxTitle);
String get demoSelectionControlsCheckboxDescription =>
remote.translateOrDefault('demoSelectionControlsCheckboxDescription', local.demoSelectionControlsCheckboxDescription);
String get demoSelectionControlsRadioTitle =>
remote.translateOrDefault('demoSelectionControlsRadioTitle', local.demoSelectionControlsRadioTitle);
String get demoSelectionControlsRadioDescription =>
remote.translateOrDefault('demoSelectionControlsRadioDescription', local.demoSelectionControlsRadioDescription);
String get demoSelectionControlsSwitchTitle =>
remote.translateOrDefault('demoSelectionControlsSwitchTitle', local.demoSelectionControlsSwitchTitle);
String get demoSelectionControlsSwitchDescription =>
remote.translateOrDefault('demoSelectionControlsSwitchDescription', local.demoSelectionControlsSwitchDescription);
String get demoBottomTextFieldsTitle =>
remote.translateOrDefault('demoBottomTextFieldsTitle', local.demoBottomTextFieldsTitle);
String get demoTextFieldTitle =>
remote.translateOrDefault('demoTextFieldTitle', local.demoTextFieldTitle);
String get demoTextFieldSubtitle =>
remote.translateOrDefault('demoTextFieldSubtitle', local.demoTextFieldSubtitle);
String get demoTextFieldDescription =>
remote.translateOrDefault('demoTextFieldDescription', local.demoTextFieldDescription);
String get demoTextFieldShowPasswordLabel =>
remote.translateOrDefault('demoTextFieldShowPasswordLabel', local.demoTextFieldShowPasswordLabel);
String get demoTextFieldHidePasswordLabel =>
remote.translateOrDefault('demoTextFieldHidePasswordLabel', local.demoTextFieldHidePasswordLabel);
String get demoTextFieldFormErrors =>
remote.translateOrDefault('demoTextFieldFormErrors', local.demoTextFieldFormErrors);
String get demoTextFieldNameRequired =>
remote.translateOrDefault('demoTextFieldNameRequired', local.demoTextFieldNameRequired);
String get demoTextFieldOnlyAlphabeticalChars =>
remote.translateOrDefault('demoTextFieldOnlyAlphabeticalChars', local.demoTextFieldOnlyAlphabeticalChars);
String get demoTextFieldEnterUSPhoneNumber =>
remote.translateOrDefault('demoTextFieldEnterUSPhoneNumber', local.demoTextFieldEnterUSPhoneNumber);
String get demoTextFieldEnterPassword =>
remote.translateOrDefault('demoTextFieldEnterPassword', local.demoTextFieldEnterPassword);
String get demoTextFieldPasswordsDoNotMatch =>
remote.translateOrDefault('demoTextFieldPasswordsDoNotMatch', local.demoTextFieldPasswordsDoNotMatch);
String get demoTextFieldWhatDoPeopleCallYou =>
remote.translateOrDefault('demoTextFieldWhatDoPeopleCallYou', local.demoTextFieldWhatDoPeopleCallYou);
String get demoTextFieldNameField =>
remote.translateOrDefault('demoTextFieldNameField', local.demoTextFieldNameField);
String get demoTextFieldWhereCanWeReachYou =>
remote.translateOrDefault('demoTextFieldWhereCanWeReachYou', local.demoTextFieldWhereCanWeReachYou);
String get demoTextFieldPhoneNumber =>
remote.translateOrDefault('demoTextFieldPhoneNumber', local.demoTextFieldPhoneNumber);
String get demoTextFieldYourEmailAddress =>
remote.translateOrDefault('demoTextFieldYourEmailAddress', local.demoTextFieldYourEmailAddress);
String get demoTextFieldEmail =>
remote.translateOrDefault('demoTextFieldEmail', local.demoTextFieldEmail);
String get demoTextFieldTellUsAboutYourself =>
remote.translateOrDefault('demoTextFieldTellUsAboutYourself', local.demoTextFieldTellUsAboutYourself);
String get demoTextFieldKeepItShort =>
remote.translateOrDefault('demoTextFieldKeepItShort', local.demoTextFieldKeepItShort);
String get demoTextFieldLifeStory =>
remote.translateOrDefault('demoTextFieldLifeStory', local.demoTextFieldLifeStory);
String get demoTextFieldSalary =>
remote.translateOrDefault('demoTextFieldSalary', local.demoTextFieldSalary);
String get demoTextFieldUSD =>
remote.translateOrDefault('demoTextFieldUSD', local.demoTextFieldUSD);
String get demoTextFieldNoMoreThan =>
remote.translateOrDefault('demoTextFieldNoMoreThan', local.demoTextFieldNoMoreThan);
String get demoTextFieldPassword =>
remote.translateOrDefault('demoTextFieldPassword', local.demoTextFieldPassword);
String get demoTextFieldRetypePassword =>
remote.translateOrDefault('demoTextFieldRetypePassword', local.demoTextFieldRetypePassword);
String get demoTextFieldSubmit =>
remote.translateOrDefault('demoTextFieldSubmit', local.demoTextFieldSubmit);
String demoTextFieldNameHasPhoneNumber(Object name,Object phoneNumber){return remote.translateOrDefault('demoTextFieldNameHasPhoneNumber', local.demoTextFieldNameHasPhoneNumber(name,phoneNumber));
}
String get demoTextFieldRequiredField =>
remote.translateOrDefault('demoTextFieldRequiredField', local.demoTextFieldRequiredField);
String get demoTooltipTitle =>
remote.translateOrDefault('demoTooltipTitle', local.demoTooltipTitle);
String get demoTooltipSubtitle =>
remote.translateOrDefault('demoTooltipSubtitle', local.demoTooltipSubtitle);
String get demoTooltipDescription =>
remote.translateOrDefault('demoTooltipDescription', local.demoTooltipDescription);
String get demoTooltipInstructions =>
remote.translateOrDefault('demoTooltipInstructions', local.demoTooltipInstructions);
String get bottomNavigationCommentsTab =>
remote.translateOrDefault('bottomNavigationCommentsTab', local.bottomNavigationCommentsTab);
String get bottomNavigationCalendarTab =>
remote.translateOrDefault('bottomNavigationCalendarTab', local.bottomNavigationCalendarTab);
String get bottomNavigationAccountTab =>
remote.translateOrDefault('bottomNavigationAccountTab', local.bottomNavigationAccountTab);
String get bottomNavigationAlarmTab =>
remote.translateOrDefault('bottomNavigationAlarmTab', local.bottomNavigationAlarmTab);
String get bottomNavigationCameraTab =>
remote.translateOrDefault('bottomNavigationCameraTab', local.bottomNavigationCameraTab);
String bottomNavigationContentPlaceholder(Object title){return remote.translateOrDefault('bottomNavigationContentPlaceholder', local.bottomNavigationContentPlaceholder(title));
}
String get buttonTextCreate =>
remote.translateOrDefault('buttonTextCreate', local.buttonTextCreate);
String dialogSelectedOption(Object value){return remote.translateOrDefault('dialogSelectedOption', local.dialogSelectedOption(value));
}
String get chipTurnOnLights =>
remote.translateOrDefault('chipTurnOnLights', local.chipTurnOnLights);
String get chipSmall =>
remote.translateOrDefault('chipSmall', local.chipSmall);
String get chipMedium =>
remote.translateOrDefault('chipMedium', local.chipMedium);
String get chipLarge =>
remote.translateOrDefault('chipLarge', local.chipLarge);
String get chipElevator =>
remote.translateOrDefault('chipElevator', local.chipElevator);
String get chipWasher =>
remote.translateOrDefault('chipWasher', local.chipWasher);
String get chipFireplace =>
remote.translateOrDefault('chipFireplace', local.chipFireplace);
String get chipBiking =>
remote.translateOrDefault('chipBiking', local.chipBiking);
String get dialogDiscardTitle =>
remote.translateOrDefault('dialogDiscardTitle', local.dialogDiscardTitle);
String get dialogLocationTitle =>
remote.translateOrDefault('dialogLocationTitle', local.dialogLocationTitle);
String get dialogLocationDescription =>
remote.translateOrDefault('dialogLocationDescription', local.dialogLocationDescription);
String get dialogCancel =>
remote.translateOrDefault('dialogCancel', local.dialogCancel);
String get dialogDiscard =>
remote.translateOrDefault('dialogDiscard', local.dialogDiscard);
String get dialogDisagree =>
remote.translateOrDefault('dialogDisagree', local.dialogDisagree);
String get dialogAgree =>
remote.translateOrDefault('dialogAgree', local.dialogAgree);
String get dialogSetBackup =>
remote.translateOrDefault('dialogSetBackup', local.dialogSetBackup);
String get dialogAddAccount =>
remote.translateOrDefault('dialogAddAccount', local.dialogAddAccount);
String get dialogShow =>
remote.translateOrDefault('dialogShow', local.dialogShow);
String get dialogFullscreenTitle =>
remote.translateOrDefault('dialogFullscreenTitle', local.dialogFullscreenTitle);
String get dialogFullscreenSave =>
remote.translateOrDefault('dialogFullscreenSave', local.dialogFullscreenSave);
String get dialogFullscreenDescription =>
remote.translateOrDefault('dialogFullscreenDescription', local.dialogFullscreenDescription);
String get cupertinoButton =>
remote.translateOrDefault('cupertinoButton', local.cupertinoButton);
String get cupertinoButtonWithBackground =>
remote.translateOrDefault('cupertinoButtonWithBackground', local.cupertinoButtonWithBackground);
String get cupertinoAlertCancel =>
remote.translateOrDefault('cupertinoAlertCancel', local.cupertinoAlertCancel);
String get cupertinoAlertDiscard =>
remote.translateOrDefault('cupertinoAlertDiscard', local.cupertinoAlertDiscard);
String get cupertinoAlertLocationTitle =>
remote.translateOrDefault('cupertinoAlertLocationTitle', local.cupertinoAlertLocationTitle);
String get cupertinoAlertLocationDescription =>
remote.translateOrDefault('cupertinoAlertLocationDescription', local.cupertinoAlertLocationDescription);
String get cupertinoAlertAllow =>
remote.translateOrDefault('cupertinoAlertAllow', local.cupertinoAlertAllow);
String get cupertinoAlertDontAllow =>
remote.translateOrDefault('cupertinoAlertDontAllow', local.cupertinoAlertDontAllow);
String get cupertinoAlertFavoriteDessert =>
remote.translateOrDefault('cupertinoAlertFavoriteDessert', local.cupertinoAlertFavoriteDessert);
String get cupertinoAlertDessertDescription =>
remote.translateOrDefault('cupertinoAlertDessertDescription', local.cupertinoAlertDessertDescription);
String get cupertinoAlertCheesecake =>
remote.translateOrDefault('cupertinoAlertCheesecake', local.cupertinoAlertCheesecake);
String get cupertinoAlertTiramisu =>
remote.translateOrDefault('cupertinoAlertTiramisu', local.cupertinoAlertTiramisu);
String get cupertinoAlertApplePie =>
remote.translateOrDefault('cupertinoAlertApplePie', local.cupertinoAlertApplePie);
String get cupertinoAlertChocolateBrownie =>
remote.translateOrDefault('cupertinoAlertChocolateBrownie', local.cupertinoAlertChocolateBrownie);
String get cupertinoShowAlert =>
remote.translateOrDefault('cupertinoShowAlert', local.cupertinoShowAlert);
String get colorsRed =>
remote.translateOrDefault('colorsRed', local.colorsRed);
String get colorsPink =>
remote.translateOrDefault('colorsPink', local.colorsPink);
String get colorsPurple =>
remote.translateOrDefault('colorsPurple', local.colorsPurple);
String get colorsDeepPurple =>
remote.translateOrDefault('colorsDeepPurple', local.colorsDeepPurple);
String get colorsIndigo =>
remote.translateOrDefault('colorsIndigo', local.colorsIndigo);
String get colorsBlue =>
remote.translateOrDefault('colorsBlue', local.colorsBlue);
String get colorsLightBlue =>
remote.translateOrDefault('colorsLightBlue', local.colorsLightBlue);
String get colorsCyan =>
remote.translateOrDefault('colorsCyan', local.colorsCyan);
String get colorsTeal =>
remote.translateOrDefault('colorsTeal', local.colorsTeal);
String get colorsGreen =>
remote.translateOrDefault('colorsGreen', local.colorsGreen);
String get colorsLightGreen =>
remote.translateOrDefault('colorsLightGreen', local.colorsLightGreen);
String get colorsLime =>
remote.translateOrDefault('colorsLime', local.colorsLime);
String get colorsYellow =>
remote.translateOrDefault('colorsYellow', local.colorsYellow);
String get colorsAmber =>
remote.translateOrDefault('colorsAmber', local.colorsAmber);
String get colorsOrange =>
remote.translateOrDefault('colorsOrange', local.colorsOrange);
String get colorsDeepOrange =>
remote.translateOrDefault('colorsDeepOrange', local.colorsDeepOrange);
String get colorsBrown =>
remote.translateOrDefault('colorsBrown', local.colorsBrown);
String get colorsGrey =>
remote.translateOrDefault('colorsGrey', local.colorsGrey);
String get colorsBlueGrey =>
remote.translateOrDefault('colorsBlueGrey', local.colorsBlueGrey);
String get placeChennai =>
remote.translateOrDefault('placeChennai', local.placeChennai);
String get placeTanjore =>
remote.translateOrDefault('placeTanjore', local.placeTanjore);
String get placeChettinad =>
remote.translateOrDefault('placeChettinad', local.placeChettinad);
String get placePondicherry =>
remote.translateOrDefault('placePondicherry', local.placePondicherry);
String get placeFlowerMarket =>
remote.translateOrDefault('placeFlowerMarket', local.placeFlowerMarket);
String get placeBronzeWorks =>
remote.translateOrDefault('placeBronzeWorks', local.placeBronzeWorks);
String get placeMarket =>
remote.translateOrDefault('placeMarket', local.placeMarket);
String get placeThanjavurTemple =>
remote.translateOrDefault('placeThanjavurTemple', local.placeThanjavurTemple);
String get placeSaltFarm =>
remote.translateOrDefault('placeSaltFarm', local.placeSaltFarm);
String get placeScooters =>
remote.translateOrDefault('placeScooters', local.placeScooters);
String get placeSilkMaker =>
remote.translateOrDefault('placeSilkMaker', local.placeSilkMaker);
String get placeLunchPrep =>
remote.translateOrDefault('placeLunchPrep', local.placeLunchPrep);
String get placeBeach =>
remote.translateOrDefault('placeBeach', local.placeBeach);
String get placeFisherman =>
remote.translateOrDefault('placeFisherman', local.placeFisherman);
String get starterAppTitle =>
remote.translateOrDefault('starterAppTitle', local.starterAppTitle);
String get starterAppDescription =>
remote.translateOrDefault('starterAppDescription', local.starterAppDescription);
String get starterAppGenericButton =>
remote.translateOrDefault('starterAppGenericButton', local.starterAppGenericButton);
String get starterAppTooltipAdd =>
remote.translateOrDefault('starterAppTooltipAdd', local.starterAppTooltipAdd);
String get starterAppTooltipFavorite =>
remote.translateOrDefault('starterAppTooltipFavorite', local.starterAppTooltipFavorite);
String get starterAppTooltipShare =>
remote.translateOrDefault('starterAppTooltipShare', local.starterAppTooltipShare);
String get starterAppTooltipSearch =>
remote.translateOrDefault('starterAppTooltipSearch', local.starterAppTooltipSearch);
String get starterAppGenericTitle =>
remote.translateOrDefault('starterAppGenericTitle', local.starterAppGenericTitle);
String get starterAppGenericSubtitle =>
remote.translateOrDefault('starterAppGenericSubtitle', local.starterAppGenericSubtitle);
String get starterAppGenericHeadline =>
remote.translateOrDefault('starterAppGenericHeadline', local.starterAppGenericHeadline);
String get starterAppGenericBody =>
remote.translateOrDefault('starterAppGenericBody', local.starterAppGenericBody);
String starterAppDrawerItem(int value){return remote.translateOrDefault('starterAppDrawerItem', local.starterAppDrawerItem(value));
}
String get shrineMenuCaption =>
remote.translateOrDefault('shrineMenuCaption', local.shrineMenuCaption);
String get shrineCategoryNameAll =>
remote.translateOrDefault('shrineCategoryNameAll', local.shrineCategoryNameAll);
String get shrineCategoryNameAccessories =>
remote.translateOrDefault('shrineCategoryNameAccessories', local.shrineCategoryNameAccessories);
String get shrineCategoryNameClothing =>
remote.translateOrDefault('shrineCategoryNameClothing', local.shrineCategoryNameClothing);
String get shrineCategoryNameHome =>
remote.translateOrDefault('shrineCategoryNameHome', local.shrineCategoryNameHome);
String get shrineLogoutButtonCaption =>
remote.translateOrDefault('shrineLogoutButtonCaption', local.shrineLogoutButtonCaption);
String get shrineLoginUsernameLabel =>
remote.translateOrDefault('shrineLoginUsernameLabel', local.shrineLoginUsernameLabel);
String get shrineLoginPasswordLabel =>
remote.translateOrDefault('shrineLoginPasswordLabel', local.shrineLoginPasswordLabel);
String get shrineCancelButtonCaption =>
remote.translateOrDefault('shrineCancelButtonCaption', local.shrineCancelButtonCaption);
String get shrineNextButtonCaption =>
remote.translateOrDefault('shrineNextButtonCaption', local.shrineNextButtonCaption);
String get shrineCartPageCaption =>
remote.translateOrDefault('shrineCartPageCaption', local.shrineCartPageCaption);
String shrineProductQuantity(int quantity){return remote.translateOrDefault('shrineProductQuantity', local.shrineProductQuantity(quantity));
}
String shrineProductPrice(Object price){return remote.translateOrDefault('shrineProductPrice', local.shrineProductPrice(price));
}
String shrineCartItemCount(int quantity){return remote.translateOrDefault('shrineCartItemCount', local.shrineCartItemCount(quantity));
}
String get shrineCartClearButtonCaption =>
remote.translateOrDefault('shrineCartClearButtonCaption', local.shrineCartClearButtonCaption);
String get shrineCartTotalCaption =>
remote.translateOrDefault('shrineCartTotalCaption', local.shrineCartTotalCaption);
String get shrineCartSubtotalCaption =>
remote.translateOrDefault('shrineCartSubtotalCaption', local.shrineCartSubtotalCaption);
String get shrineCartShippingCaption =>
remote.translateOrDefault('shrineCartShippingCaption', local.shrineCartShippingCaption);
String get shrineCartTaxCaption =>
remote.translateOrDefault('shrineCartTaxCaption', local.shrineCartTaxCaption);
String get shrineProductVagabondSack =>
remote.translateOrDefault('shrineProductVagabondSack', local.shrineProductVagabondSack);
String get shrineProductStellaSunglasses =>
remote.translateOrDefault('shrineProductStellaSunglasses', local.shrineProductStellaSunglasses);
String get shrineProductWhitneyBelt =>
remote.translateOrDefault('shrineProductWhitneyBelt', local.shrineProductWhitneyBelt);
String get shrineProductGardenStrand =>
remote.translateOrDefault('shrineProductGardenStrand', local.shrineProductGardenStrand);
String get shrineProductStrutEarrings =>
remote.translateOrDefault('shrineProductStrutEarrings', local.shrineProductStrutEarrings);
String get shrineProductVarsitySocks =>
remote.translateOrDefault('shrineProductVarsitySocks', local.shrineProductVarsitySocks);
String get shrineProductWeaveKeyring =>
remote.translateOrDefault('shrineProductWeaveKeyring', local.shrineProductWeaveKeyring);
String get shrineProductGatsbyHat =>
remote.translateOrDefault('shrineProductGatsbyHat', local.shrineProductGatsbyHat);
String get shrineProductShrugBag =>
remote.translateOrDefault('shrineProductShrugBag', local.shrineProductShrugBag);
String get shrineProductGiltDeskTrio =>
remote.translateOrDefault('shrineProductGiltDeskTrio', local.shrineProductGiltDeskTrio);
String get shrineProductCopperWireRack =>
remote.translateOrDefault('shrineProductCopperWireRack', local.shrineProductCopperWireRack);
String get shrineProductSootheCeramicSet =>
remote.translateOrDefault('shrineProductSootheCeramicSet', local.shrineProductSootheCeramicSet);
String get shrineProductHurrahsTeaSet =>
remote.translateOrDefault('shrineProductHurrahsTeaSet', local.shrineProductHurrahsTeaSet);
String get shrineProductBlueStoneMug =>
remote.translateOrDefault('shrineProductBlueStoneMug', local.shrineProductBlueStoneMug);
String get shrineProductRainwaterTray =>
remote.translateOrDefault('shrineProductRainwaterTray', local.shrineProductRainwaterTray);
String get shrineProductChambrayNapkins =>
remote.translateOrDefault('shrineProductChambrayNapkins', local.shrineProductChambrayNapkins);
String get shrineProductSucculentPlanters =>
remote.translateOrDefault('shrineProductSucculentPlanters', local.shrineProductSucculentPlanters);
String get shrineProductQuartetTable =>
remote.translateOrDefault('shrineProductQuartetTable', local.shrineProductQuartetTable);
String get shrineProductKitchenQuattro =>
remote.translateOrDefault('shrineProductKitchenQuattro', local.shrineProductKitchenQuattro);
String get shrineProductClaySweater =>
remote.translateOrDefault('shrineProductClaySweater', local.shrineProductClaySweater);
String get shrineProductSeaTunic =>
remote.translateOrDefault('shrineProductSeaTunic', local.shrineProductSeaTunic);
String get shrineProductPlasterTunic =>
remote.translateOrDefault('shrineProductPlasterTunic', local.shrineProductPlasterTunic);
String get shrineProductWhitePinstripeShirt =>
remote.translateOrDefault('shrineProductWhitePinstripeShirt', local.shrineProductWhitePinstripeShirt);
String get shrineProductChambrayShirt =>
remote.translateOrDefault('shrineProductChambrayShirt', local.shrineProductChambrayShirt);
String get shrineProductSeabreezeSweater =>
remote.translateOrDefault('shrineProductSeabreezeSweater', local.shrineProductSeabreezeSweater);
String get shrineProductGentryJacket =>
remote.translateOrDefault('shrineProductGentryJacket', local.shrineProductGentryJacket);
String get shrineProductNavyTrousers =>
remote.translateOrDefault('shrineProductNavyTrousers', local.shrineProductNavyTrousers);
String get shrineProductWalterHenleyWhite =>
remote.translateOrDefault('shrineProductWalterHenleyWhite', local.shrineProductWalterHenleyWhite);
String get shrineProductSurfAndPerfShirt =>
remote.translateOrDefault('shrineProductSurfAndPerfShirt', local.shrineProductSurfAndPerfShirt);
String get shrineProductGingerScarf =>
remote.translateOrDefault('shrineProductGingerScarf', local.shrineProductGingerScarf);
String get shrineProductRamonaCrossover =>
remote.translateOrDefault('shrineProductRamonaCrossover', local.shrineProductRamonaCrossover);
String get shrineProductClassicWhiteCollar =>
remote.translateOrDefault('shrineProductClassicWhiteCollar', local.shrineProductClassicWhiteCollar);
String get shrineProductCeriseScallopTee =>
remote.translateOrDefault('shrineProductCeriseScallopTee', local.shrineProductCeriseScallopTee);
String get shrineProductShoulderRollsTee =>
remote.translateOrDefault('shrineProductShoulderRollsTee', local.shrineProductShoulderRollsTee);
String get shrineProductGreySlouchTank =>
remote.translateOrDefault('shrineProductGreySlouchTank', local.shrineProductGreySlouchTank);
String get shrineProductSunshirtDress =>
remote.translateOrDefault('shrineProductSunshirtDress', local.shrineProductSunshirtDress);
String get shrineProductFineLinesTee =>
remote.translateOrDefault('shrineProductFineLinesTee', local.shrineProductFineLinesTee);
String get shrineTooltipSearch =>
remote.translateOrDefault('shrineTooltipSearch', local.shrineTooltipSearch);
String get shrineTooltipSettings =>
remote.translateOrDefault('shrineTooltipSettings', local.shrineTooltipSettings);
String get shrineTooltipOpenMenu =>
remote.translateOrDefault('shrineTooltipOpenMenu', local.shrineTooltipOpenMenu);
String get shrineTooltipCloseMenu =>
remote.translateOrDefault('shrineTooltipCloseMenu', local.shrineTooltipCloseMenu);
String get shrineTooltipCloseCart =>
remote.translateOrDefault('shrineTooltipCloseCart', local.shrineTooltipCloseCart);
String shrineScreenReaderCart(int quantity){return remote.translateOrDefault('shrineScreenReaderCart', local.shrineScreenReaderCart(quantity));
}
String get shrineScreenReaderProductAddToCart =>
remote.translateOrDefault('shrineScreenReaderProductAddToCart', local.shrineScreenReaderProductAddToCart);
String shrineScreenReaderRemoveProductButton(Object product){return remote.translateOrDefault('shrineScreenReaderRemoveProductButton', local.shrineScreenReaderRemoveProductButton(product));
}
String get shrineTooltipRemoveItem =>
remote.translateOrDefault('shrineTooltipRemoveItem', local.shrineTooltipRemoveItem);
String get craneFormDiners =>
remote.translateOrDefault('craneFormDiners', local.craneFormDiners);
String get craneFormDate =>
remote.translateOrDefault('craneFormDate', local.craneFormDate);
String get craneFormTime =>
remote.translateOrDefault('craneFormTime', local.craneFormTime);
String get craneFormLocation =>
remote.translateOrDefault('craneFormLocation', local.craneFormLocation);
String get craneFormTravelers =>
remote.translateOrDefault('craneFormTravelers', local.craneFormTravelers);
String get craneFormOrigin =>
remote.translateOrDefault('craneFormOrigin', local.craneFormOrigin);
String get craneFormDestination =>
remote.translateOrDefault('craneFormDestination', local.craneFormDestination);
String get craneFormDates =>
remote.translateOrDefault('craneFormDates', local.craneFormDates);
String craneHours(int hours){return remote.translateOrDefault('craneHours', local.craneHours(hours));
}
String craneMinutes(int minutes){return remote.translateOrDefault('craneMinutes', local.craneMinutes(minutes));
}
String craneFlightDuration(Object hoursShortForm,Object minutesShortForm){return remote.translateOrDefault('craneFlightDuration', local.craneFlightDuration(hoursShortForm,minutesShortForm));
}
String get craneFly =>
remote.translateOrDefault('craneFly', local.craneFly);
String get craneSleep =>
remote.translateOrDefault('craneSleep', local.craneSleep);
String get craneEat =>
remote.translateOrDefault('craneEat', local.craneEat);
String get craneFlySubhead =>
remote.translateOrDefault('craneFlySubhead', local.craneFlySubhead);
String get craneSleepSubhead =>
remote.translateOrDefault('craneSleepSubhead', local.craneSleepSubhead);
String get craneEatSubhead =>
remote.translateOrDefault('craneEatSubhead', local.craneEatSubhead);
String craneFlyStops(int numberOfStops){return remote.translateOrDefault('craneFlyStops', local.craneFlyStops(numberOfStops));
}
String craneSleepProperties(int totalProperties){return remote.translateOrDefault('craneSleepProperties', local.craneSleepProperties(totalProperties));
}
String craneEatRestaurants(int totalRestaurants){return remote.translateOrDefault('craneEatRestaurants', local.craneEatRestaurants(totalRestaurants));
}
String get craneFly0 =>
remote.translateOrDefault('craneFly0', local.craneFly0);
String get craneFly1 =>
remote.translateOrDefault('craneFly1', local.craneFly1);
String get craneFly2 =>
remote.translateOrDefault('craneFly2', local.craneFly2);
String get craneFly3 =>
remote.translateOrDefault('craneFly3', local.craneFly3);
String get craneFly4 =>
remote.translateOrDefault('craneFly4', local.craneFly4);
String get craneFly5 =>
remote.translateOrDefault('craneFly5', local.craneFly5);
String get craneFly6 =>
remote.translateOrDefault('craneFly6', local.craneFly6);
String get craneFly7 =>
remote.translateOrDefault('craneFly7', local.craneFly7);
String get craneFly8 =>
remote.translateOrDefault('craneFly8', local.craneFly8);
String get craneFly9 =>
remote.translateOrDefault('craneFly9', local.craneFly9);
String get craneFly10 =>
remote.translateOrDefault('craneFly10', local.craneFly10);
String get craneFly11 =>
remote.translateOrDefault('craneFly11', local.craneFly11);
String get craneFly12 =>
remote.translateOrDefault('craneFly12', local.craneFly12);
String get craneFly13 =>
remote.translateOrDefault('craneFly13', local.craneFly13);
String get craneSleep0 =>
remote.translateOrDefault('craneSleep0', local.craneSleep0);
String get craneSleep1 =>
remote.translateOrDefault('craneSleep1', local.craneSleep1);
String get craneSleep2 =>
remote.translateOrDefault('craneSleep2', local.craneSleep2);
String get craneSleep3 =>
remote.translateOrDefault('craneSleep3', local.craneSleep3);
String get craneSleep4 =>
remote.translateOrDefault('craneSleep4', local.craneSleep4);
String get craneSleep5 =>
remote.translateOrDefault('craneSleep5', local.craneSleep5);
String get craneSleep6 =>
remote.translateOrDefault('craneSleep6', local.craneSleep6);
String get craneSleep7 =>
remote.translateOrDefault('craneSleep7', local.craneSleep7);
String get craneSleep8 =>
remote.translateOrDefault('craneSleep8', local.craneSleep8);
String get craneSleep9 =>
remote.translateOrDefault('craneSleep9', local.craneSleep9);
String get craneSleep10 =>
remote.translateOrDefault('craneSleep10', local.craneSleep10);
String get craneSleep11 =>
remote.translateOrDefault('craneSleep11', local.craneSleep11);
String get craneEat0 =>
remote.translateOrDefault('craneEat0', local.craneEat0);
String get craneEat1 =>
remote.translateOrDefault('craneEat1', local.craneEat1);
String get craneEat2 =>
remote.translateOrDefault('craneEat2', local.craneEat2);
String get craneEat3 =>
remote.translateOrDefault('craneEat3', local.craneEat3);
String get craneEat4 =>
remote.translateOrDefault('craneEat4', local.craneEat4);
String get craneEat5 =>
remote.translateOrDefault('craneEat5', local.craneEat5);
String get craneEat6 =>
remote.translateOrDefault('craneEat6', local.craneEat6);
String get craneEat7 =>
remote.translateOrDefault('craneEat7', local.craneEat7);
String get craneEat8 =>
remote.translateOrDefault('craneEat8', local.craneEat8);
String get craneEat9 =>
remote.translateOrDefault('craneEat9', local.craneEat9);
String get craneEat10 =>
remote.translateOrDefault('craneEat10', local.craneEat10);
String get craneFly0SemanticLabel =>
remote.translateOrDefault('craneFly0SemanticLabel', local.craneFly0SemanticLabel);
String get craneFly1SemanticLabel =>
remote.translateOrDefault('craneFly1SemanticLabel', local.craneFly1SemanticLabel);
String get craneFly2SemanticLabel =>
remote.translateOrDefault('craneFly2SemanticLabel', local.craneFly2SemanticLabel);
String get craneFly3SemanticLabel =>
remote.translateOrDefault('craneFly3SemanticLabel', local.craneFly3SemanticLabel);
String get craneFly4SemanticLabel =>
remote.translateOrDefault('craneFly4SemanticLabel', local.craneFly4SemanticLabel);
String get craneFly5SemanticLabel =>
remote.translateOrDefault('craneFly5SemanticLabel', local.craneFly5SemanticLabel);
String get craneFly6SemanticLabel =>
remote.translateOrDefault('craneFly6SemanticLabel', local.craneFly6SemanticLabel);
String get craneFly7SemanticLabel =>
remote.translateOrDefault('craneFly7SemanticLabel', local.craneFly7SemanticLabel);
String get craneFly8SemanticLabel =>
remote.translateOrDefault('craneFly8SemanticLabel', local.craneFly8SemanticLabel);
String get craneFly9SemanticLabel =>
remote.translateOrDefault('craneFly9SemanticLabel', local.craneFly9SemanticLabel);
String get craneFly10SemanticLabel =>
remote.translateOrDefault('craneFly10SemanticLabel', local.craneFly10SemanticLabel);
String get craneFly11SemanticLabel =>
remote.translateOrDefault('craneFly11SemanticLabel', local.craneFly11SemanticLabel);
String get craneFly12SemanticLabel =>
remote.translateOrDefault('craneFly12SemanticLabel', local.craneFly12SemanticLabel);
String get craneFly13SemanticLabel =>
remote.translateOrDefault('craneFly13SemanticLabel', local.craneFly13SemanticLabel);
String get craneSleep0SemanticLabel =>
remote.translateOrDefault('craneSleep0SemanticLabel', local.craneSleep0SemanticLabel);
String get craneSleep1SemanticLabel =>
remote.translateOrDefault('craneSleep1SemanticLabel', local.craneSleep1SemanticLabel);
String get craneSleep2SemanticLabel =>
remote.translateOrDefault('craneSleep2SemanticLabel', local.craneSleep2SemanticLabel);
String get craneSleep3SemanticLabel =>
remote.translateOrDefault('craneSleep3SemanticLabel', local.craneSleep3SemanticLabel);
String get craneSleep4SemanticLabel =>
remote.translateOrDefault('craneSleep4SemanticLabel', local.craneSleep4SemanticLabel);
String get craneSleep5SemanticLabel =>
remote.translateOrDefault('craneSleep5SemanticLabel', local.craneSleep5SemanticLabel);
String get craneSleep6SemanticLabel =>
remote.translateOrDefault('craneSleep6SemanticLabel', local.craneSleep6SemanticLabel);
String get craneSleep7SemanticLabel =>
remote.translateOrDefault('craneSleep7SemanticLabel', local.craneSleep7SemanticLabel);
String get craneSleep8SemanticLabel =>
remote.translateOrDefault('craneSleep8SemanticLabel', local.craneSleep8SemanticLabel);
String get craneSleep9SemanticLabel =>
remote.translateOrDefault('craneSleep9SemanticLabel', local.craneSleep9SemanticLabel);
String get craneSleep10SemanticLabel =>
remote.translateOrDefault('craneSleep10SemanticLabel', local.craneSleep10SemanticLabel);
String get craneSleep11SemanticLabel =>
remote.translateOrDefault('craneSleep11SemanticLabel', local.craneSleep11SemanticLabel);
String get craneEat0SemanticLabel =>
remote.translateOrDefault('craneEat0SemanticLabel', local.craneEat0SemanticLabel);
String get craneEat1SemanticLabel =>
remote.translateOrDefault('craneEat1SemanticLabel', local.craneEat1SemanticLabel);
String get craneEat2SemanticLabel =>
remote.translateOrDefault('craneEat2SemanticLabel', local.craneEat2SemanticLabel);
String get craneEat3SemanticLabel =>
remote.translateOrDefault('craneEat3SemanticLabel', local.craneEat3SemanticLabel);
String get craneEat4SemanticLabel =>
remote.translateOrDefault('craneEat4SemanticLabel', local.craneEat4SemanticLabel);
String get craneEat5SemanticLabel =>
remote.translateOrDefault('craneEat5SemanticLabel', local.craneEat5SemanticLabel);
String get craneEat6SemanticLabel =>
remote.translateOrDefault('craneEat6SemanticLabel', local.craneEat6SemanticLabel);
String get craneEat7SemanticLabel =>
remote.translateOrDefault('craneEat7SemanticLabel', local.craneEat7SemanticLabel);
String get craneEat8SemanticLabel =>
remote.translateOrDefault('craneEat8SemanticLabel', local.craneEat8SemanticLabel);
String get craneEat9SemanticLabel =>
remote.translateOrDefault('craneEat9SemanticLabel', local.craneEat9SemanticLabel);
String get craneEat10SemanticLabel =>
remote.translateOrDefault('craneEat10SemanticLabel', local.craneEat10SemanticLabel);
String get fortnightlyMenuFrontPage =>
remote.translateOrDefault('fortnightlyMenuFrontPage', local.fortnightlyMenuFrontPage);
String get fortnightlyMenuWorld =>
remote.translateOrDefault('fortnightlyMenuWorld', local.fortnightlyMenuWorld);
String get fortnightlyMenuUS =>
remote.translateOrDefault('fortnightlyMenuUS', local.fortnightlyMenuUS);
String get fortnightlyMenuPolitics =>
remote.translateOrDefault('fortnightlyMenuPolitics', local.fortnightlyMenuPolitics);
String get fortnightlyMenuBusiness =>
remote.translateOrDefault('fortnightlyMenuBusiness', local.fortnightlyMenuBusiness);
String get fortnightlyMenuTech =>
remote.translateOrDefault('fortnightlyMenuTech', local.fortnightlyMenuTech);
String get fortnightlyMenuScience =>
remote.translateOrDefault('fortnightlyMenuScience', local.fortnightlyMenuScience);
String get fortnightlyMenuSports =>
remote.translateOrDefault('fortnightlyMenuSports', local.fortnightlyMenuSports);
String get fortnightlyMenuTravel =>
remote.translateOrDefault('fortnightlyMenuTravel', local.fortnightlyMenuTravel);
String get fortnightlyMenuCulture =>
remote.translateOrDefault('fortnightlyMenuCulture', local.fortnightlyMenuCulture);
String get fortnightlyTrendingTechDesign =>
remote.translateOrDefault('fortnightlyTrendingTechDesign', local.fortnightlyTrendingTechDesign);
String get fortnightlyTrendingReform =>
remote.translateOrDefault('fortnightlyTrendingReform', local.fortnightlyTrendingReform);
String get fortnightlyTrendingHealthcareRevolution =>
remote.translateOrDefault('fortnightlyTrendingHealthcareRevolution', local.fortnightlyTrendingHealthcareRevolution);
String get fortnightlyTrendingGreenArmy =>
remote.translateOrDefault('fortnightlyTrendingGreenArmy', local.fortnightlyTrendingGreenArmy);
String get fortnightlyTrendingStocks =>
remote.translateOrDefault('fortnightlyTrendingStocks', local.fortnightlyTrendingStocks);
String get fortnightlyLatestUpdates =>
remote.translateOrDefault('fortnightlyLatestUpdates', local.fortnightlyLatestUpdates);
String get fortnightlyHeadlineHealthcare =>
remote.translateOrDefault('fortnightlyHeadlineHealthcare', local.fortnightlyHeadlineHealthcare);
String get fortnightlyHeadlineWar =>
remote.translateOrDefault('fortnightlyHeadlineWar', local.fortnightlyHeadlineWar);
String get fortnightlyHeadlineGasoline =>
remote.translateOrDefault('fortnightlyHeadlineGasoline', local.fortnightlyHeadlineGasoline);
String get fortnightlyHeadlineArmy =>
remote.translateOrDefault('fortnightlyHeadlineArmy', local.fortnightlyHeadlineArmy);
String get fortnightlyHeadlineStocks =>
remote.translateOrDefault('fortnightlyHeadlineStocks', local.fortnightlyHeadlineStocks);
String get fortnightlyHeadlineFabrics =>
remote.translateOrDefault('fortnightlyHeadlineFabrics', local.fortnightlyHeadlineFabrics);
String get fortnightlyHeadlineFeminists =>
remote.translateOrDefault('fortnightlyHeadlineFeminists', local.fortnightlyHeadlineFeminists);
String get fortnightlyHeadlineBees =>
remote.translateOrDefault('fortnightlyHeadlineBees', local.fortnightlyHeadlineBees);
String get replyInboxLabel =>
remote.translateOrDefault('replyInboxLabel', local.replyInboxLabel);
String get replyStarredLabel =>
remote.translateOrDefault('replyStarredLabel', local.replyStarredLabel);
String get replySentLabel =>
remote.translateOrDefault('replySentLabel', local.replySentLabel);
String get replyTrashLabel =>
remote.translateOrDefault('replyTrashLabel', local.replyTrashLabel);
String get replySpamLabel =>
remote.translateOrDefault('replySpamLabel', local.replySpamLabel);
String get replyDraftsLabel =>
remote.translateOrDefault('replyDraftsLabel', local.replyDraftsLabel);
}
