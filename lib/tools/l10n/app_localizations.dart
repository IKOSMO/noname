import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

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
    Locale('ru'),
  ];

  /// No description provided for @search_placeholder.
  ///
  /// In ru, this message translates to:
  /// **'Поиск...'**
  String get search_placeholder;

  /// No description provided for @change_image.
  ///
  /// In ru, this message translates to:
  /// **'Изменить фотографию'**
  String get change_image;

  /// No description provided for @favourites.
  ///
  /// In ru, this message translates to:
  /// **'Избранное'**
  String get favourites;

  /// No description provided for @notifications_title.
  ///
  /// In ru, this message translates to:
  /// **'Уведомления'**
  String get notifications_title;

  /// No description provided for @notification_of_message_title.
  ///
  /// In ru, this message translates to:
  /// **'Уведомления о сообщениях'**
  String get notification_of_message_title;

  /// No description provided for @notification_of_message_personal_chats.
  ///
  /// In ru, this message translates to:
  /// **'Личные чаты'**
  String get notification_of_message_personal_chats;

  /// No description provided for @notification_of_message_groups.
  ///
  /// In ru, this message translates to:
  /// **'Группы'**
  String get notification_of_message_groups;

  /// No description provided for @notification_of_message_channels.
  ///
  /// In ru, this message translates to:
  /// **'Каналы'**
  String get notification_of_message_channels;

  /// No description provided for @notification_of_message_stories.
  ///
  /// In ru, this message translates to:
  /// **'Истории'**
  String get notification_of_message_stories;

  /// No description provided for @notification_of_message_reactions.
  ///
  /// In ru, this message translates to:
  /// **'Реакции'**
  String get notification_of_message_reactions;

  /// No description provided for @notification_in_app_title.
  ///
  /// In ru, this message translates to:
  /// **'Уведомления в приложении'**
  String get notification_in_app_title;

  /// No description provided for @notification_in_app_volume.
  ///
  /// In ru, this message translates to:
  /// **'Звук'**
  String get notification_in_app_volume;

  /// No description provided for @notification_in_app_vibration.
  ///
  /// In ru, this message translates to:
  /// **'Вибрация'**
  String get notification_in_app_vibration;

  /// No description provided for @notification_in_app_show_text.
  ///
  /// In ru, this message translates to:
  /// **'Показывать текст'**
  String get notification_in_app_show_text;

  /// No description provided for @username_in_notification_title.
  ///
  /// In ru, this message translates to:
  /// **'Показывать имена в уведомлениях'**
  String get username_in_notification_title;

  /// No description provided for @username_in_notification_description.
  ///
  /// In ru, this message translates to:
  /// **'Показывать имена в оповещениях на заблокированном экране.'**
  String get username_in_notification_description;

  /// No description provided for @confidentiality_title.
  ///
  /// In ru, this message translates to:
  /// **'Конфиденциальность'**
  String get confidentiality_title;

  /// No description provided for @black_list.
  ///
  /// In ru, this message translates to:
  /// **'Чёрный список'**
  String get black_list;

  /// No description provided for @cloud_password.
  ///
  /// In ru, this message translates to:
  /// **'Облачный пароль'**
  String get cloud_password;

  /// No description provided for @auto_delete_messages.
  ///
  /// In ru, this message translates to:
  /// **'Автоудаление сообщений'**
  String get auto_delete_messages;

  /// No description provided for @button_sos_title.
  ///
  /// In ru, this message translates to:
  /// **'Кнопка SOS'**
  String get button_sos_title;

  /// No description provided for @button_sos_description.
  ///
  /// In ru, this message translates to:
  /// **'Кнопка временной замены содержимого экрана, на установленное.'**
  String get button_sos_description;

  /// No description provided for @phone_number.
  ///
  /// In ru, this message translates to:
  /// **'Номер телефона'**
  String get phone_number;

  /// No description provided for @entry_time.
  ///
  /// In ru, this message translates to:
  /// **'Время захода'**
  String get entry_time;

  /// No description provided for @profile_images.
  ///
  /// In ru, this message translates to:
  /// **'Фотографии профиля'**
  String get profile_images;

  /// No description provided for @groups_and_channels.
  ///
  /// In ru, this message translates to:
  /// **'Группы и каналы'**
  String get groups_and_channels;

  /// No description provided for @date_of_birthday.
  ///
  /// In ru, this message translates to:
  /// **'День рождения'**
  String get date_of_birthday;

  /// No description provided for @login_email.
  ///
  /// In ru, this message translates to:
  /// **'Почта для входа'**
  String get login_email;

  /// No description provided for @memory.
  ///
  /// In ru, this message translates to:
  /// **'Память'**
  String get memory;

  /// No description provided for @themes_title.
  ///
  /// In ru, this message translates to:
  /// **'Оформление'**
  String get themes_title;

  /// No description provided for @themes_subtitle.
  ///
  /// In ru, this message translates to:
  /// **'Тема приложения'**
  String get themes_subtitle;

  /// No description provided for @light_theme.
  ///
  /// In ru, this message translates to:
  /// **'Светлая тема'**
  String get light_theme;

  /// No description provided for @dark_theme.
  ///
  /// In ru, this message translates to:
  /// **'Тёмная тема'**
  String get dark_theme;

  /// No description provided for @language_title.
  ///
  /// In ru, this message translates to:
  /// **'Язык'**
  String get language_title;

  /// No description provided for @language_subtitle.
  ///
  /// In ru, this message translates to:
  /// **'Язык приложения'**
  String get language_subtitle;

  /// No description provided for @support.
  ///
  /// In ru, this message translates to:
  /// **'Помощь'**
  String get support;

  /// No description provided for @settings_edit.
  ///
  /// In ru, this message translates to:
  /// **'Изм.'**
  String get settings_edit;

  /// No description provided for @input_placeholder.
  ///
  /// In ru, this message translates to:
  /// **'Сообщение...'**
  String get input_placeholder;

  /// No description provided for @call.
  ///
  /// In ru, this message translates to:
  /// **'Звонок'**
  String get call;

  /// No description provided for @video_call.
  ///
  /// In ru, this message translates to:
  /// **'Видео'**
  String get video_call;

  /// No description provided for @profile_volume.
  ///
  /// In ru, this message translates to:
  /// **'Звук'**
  String get profile_volume;

  /// No description provided for @search.
  ///
  /// In ru, this message translates to:
  /// **'Поиск'**
  String get search;

  /// No description provided for @more.
  ///
  /// In ru, this message translates to:
  /// **'Ещё'**
  String get more;

  /// No description provided for @profile_phone_number.
  ///
  /// In ru, this message translates to:
  /// **'Мобильный'**
  String get profile_phone_number;

  /// No description provided for @username.
  ///
  /// In ru, this message translates to:
  /// **'Имя пользователя'**
  String get username;

  /// No description provided for @profile_birthday.
  ///
  /// In ru, this message translates to:
  /// **'Дата рождения'**
  String get profile_birthday;

  /// No description provided for @media.
  ///
  /// In ru, this message translates to:
  /// **'Медиа'**
  String get media;

  /// No description provided for @files.
  ///
  /// In ru, this message translates to:
  /// **'Файлы'**
  String get files;

  /// No description provided for @music.
  ///
  /// In ru, this message translates to:
  /// **'Музыка'**
  String get music;

  /// No description provided for @voice_message.
  ///
  /// In ru, this message translates to:
  /// **'Голосовые'**
  String get voice_message;

  /// No description provided for @links.
  ///
  /// In ru, this message translates to:
  /// **'Ссылки'**
  String get links;

  /// No description provided for @gif.
  ///
  /// In ru, this message translates to:
  /// **'GIF'**
  String get gif;

  /// No description provided for @groups.
  ///
  /// In ru, this message translates to:
  /// **'Группы'**
  String get groups;

  /// No description provided for @profile_edit.
  ///
  /// In ru, this message translates to:
  /// **'Изм.'**
  String get profile_edit;
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
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
