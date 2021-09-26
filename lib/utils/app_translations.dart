import 'package:get/get.dart';

class AppTranslations extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US':{
      'currentLan': 'En',
      'messWelcome': 'Welcome to your new wallet',
      'haveAlreadyWallet': 'I already have a wallet',
      'newWall': 'New wallet',
      'titleBackup': 'Backup your wallet now',
      'messBackup': 'In the next step you will see 12 words that allow you to recover your wallet',
      'messAcceptingCon': 'I will understanding if I lose my recovery words, I will not be able to access my wallet.',
      'proceed': 'Proceed',
      'letsCreateWall': "Let's create your wallet",
      'keepSafe': "Keep your phrases safe",
      'copyPhrases': "Copy your phrases",
      'copied': "Copied",
      'skip': "Skip",
      'yes': "Yes",
      'no': "No",
      'cancel': "Cancel",
      'confPhrases': "Confirm your phrases",
      'selectPhrasesRight': "select your phrases in the right order",
      'confirmation': "Confirmation",
      'messConfPhrases': "Are you sure you want to back up your statements?",
      'enterSelf': "Enter your",
      'please': "Please",
      'number': "Number",
      'name': "Name",
      'phrase': "Phrase",
      'invalid': "Invalid",
      'import': "Import",
      'paste': "PASTE",
      'descImportWall': "Typically 12(sometimes 24) words separated by single spaces",
      "cameraDenied": "Camera access denied",
      "failedBarcodeScan": "Error scanning barcode, try again",
      "failureRecBarcode": "Failure to identify and recognize the barcode",
      "importDesc": "Your wallet was created successfully",
      "ok": "OK",
      "warning": "Warning",
      "storagePermission": "To save your wallet details by the app and the proper functioning of the app, requires access to the device memory, do you allow?",
      "enterPassCode": "Enter passcode",
      "enterNewPass": "Enter a new passcode",
      "reEnterPass": "Please re-enter your passcode",
      "invalidRepeatPass": "The passcode and its repetition do not match!",
      "invalidPass": "The passcode is incorrect!",
      "localizedReason": "Scan your fingerprint to authenticate",
      "touchSensor": "Touch Sensor",
      "fingerprintNotRecognized": "Fingerprint not recognized. Try again.",
      "fingerprintRequiredTitle": "Fingerprint required",
      "fingerprintSuccess": "Fingerprint recognized.",
      "goToSettingsButton": "Go to settings",
      "goToSettingsDescription": "Fingerprint is not set up on your device. Go to 'Settings > Security' to add your fingerprint.",
      "signInTitle": "Fingerprint Authentication",
      "lockOut": "Biometric authentication is disabled. Please lock and unlock your screen to enable it.",
      "descShowRecPhrase": "If you lose access to this device, your funds will be lost. unless you backup!",
      "con1RecPh": "The recovery phrase is the master key to your funds. Never share with anyone else!",
      "con2RecPh": "DIGIT41 will never ask you to share your recovery phrase!",
      "con3RecPh": "If your recovery phrase lost, not even DIGIT41 can recover your funds",
      "descYourRecPh": "Write down or copy these words in the right order and save them somewhere safe.",
      "qImportWallet":"What is recovery phrase?",
      "emptyData": "No information to display",
      "DeacNetDelete": "Are you sure you want to delete the network?",
    },
    'tr_TU':{
      'currentLan': 'Tr',
      'messWelcome': 'Yeni cüzdanınıza hoş geldiniz',
      'haveAlreadyWallet': 'zaten cüzdanım var',
      'newWall': 'Yeni cüzdan',
      'titleBackup': 'Cüzdanınızı hemen yedekleyin',
      'messBackup': 'Bir sonraki adımda cüzdanınızı kurtarmanıza izin verecek 12 kelime göreceksiniz.',
      'messAcceptingCon': 'Hatırlatma sözlerimi kaybedersem cüzdanıma erişemeyeceğim.',
      'proceed': 'devam',
      'letsCreateWall': 'Cüzdanınızı oluşturalım',
      'keepSafe': 'İfadelerinizi güvende tutun',
      'copyPhrases': "İfadelerinizi kopyalayın",
      'copied': "kopyalandı",
      'skip': "atla",
      'yes': "Evet",
      'no': "Hayır",
      'cancel': "İptal etmek",
      'confPhrases': "İfadelerinizi onaylayın",
      'selectPhrasesRight': "cümleleri doğru sırayla seçin",
      'confirmation': "Onayla",
      'messConfPhrases': "İfadelerinizi yedeklemek istediğinizden emin misiniz?",
      'enterSelf': "Girin",
      'please': "Lütfen",
      'number': "Numara",
      'name': "isim",
      'phrase': "İfade",
      'invalid': "Geçersiz",
      'import': "İthalat",
      'paste': "YAPIŞTIRMAK",
      'descImportWall': "Tipik olarak, tek boşluklarla ayrılmış 12 (bazen 24) kelime",
      "cameraDenied": "Kamera erişimi reddedildi",
      "failedBarcodeScan": "Barkod taranırken hata oluştu, tekrar deneyin",
      "failureRecBarcode": "Barkodun tanınmaması ve tanınmaması",
      "Flash off": "Işıklar kapalı",
      "Flash on": "Işıklar açık",
      "importDesc": "Cüzdanınız başarıyla oluşturuldu",
      "ok": "TAMAM MI",
      "warning": "Uyarı",
      "storagePermission": "Cüzdan bilgilerinizi uygulamaya göre kaydetmek ve uygulamanın düzgün çalışması için cihaz hafızasına erişim gerekiyor, izin veriyor musunuz?",
      "Wallet": "cüzdan",
      "Wallets": "Cüzdanlar",
      "Swap": "takas",
      "ON": "ÜZERİNDE",
      "OFF": "KAPALI",
      "Settings": "Ayarlar",
      "SETTINGS": "AYARLAR",
      "Currency": "Para birimi",
      "Language": "Dilim",
      "Dark Mode": "Karanlık Mod",
      "Notifications": "Bildirimler",
      "COMMUNITY": "TOPLUM",
      "Twitter": "heyecan",
      "Telegram": "Telgraf",
      "About Us": "Hakkımızda",
      "Your Wallets": "Cüzdanlarınız",
      "Add Wallet": "Cüzdan Ekle",
      "Passcode": "şifre",
      "Close": "Kapat",
      "Delete": "Silmek",
      "Save": "Kaydetmek",
      "Pin": "Toplu iğne",
      "enterPassCode": "Şifreyi gir",
      "enterNewPass": "Yeni bir şifre girin",
      "reEnterPass": "Lütfen şifrenizi tekrar girin",
      "invalidRepeatPass": "Şifre ve tekrarı uyuşmuyor!",
      "invalidPass": "Şifre yanlış!",
      "localizedReason": "Kimlik doğrulaması için parmak izinizi tarayın",
      "touchSensor": "Dokunma sensörü",
      "fingerprintNotRecognized": "Parmak izi tanınmadı. Tekrar deneyin.",
      "fingerprintRequiredTitle": "Parmak izi gerekli",
      "fingerprintSuccess": "Parmak izi tanındı.",
      "goToSettingsButton": "Ayarlara git",
      "goToSettingsDescription": "Cihazınızda parmak izi kurulu değil. Parmak izinizi eklemek için 'Ayarlar > Güvenlik'e gidin.",
      "signInTitle": "Parmak İzi Kimlik Doğrulaması",
      "lockOut": "Biyometrik kimlik doğrulama devre dışı. Etkinleştirmek için lütfen ekranınızı kilitleyin ve kilidini açın.",
      "Assets Value": "Varlık Değeri",
      "Assets": "Varlıklar",
      "COIN": "MADENİ PARA",
      "TOKEN": "JETON",
      "Available": "Mevcut",
      "Convert": "Dönüştürmek",
      "SUCCESS": "BAŞARI",
      "FAILED": "BAŞARISIZ OLDU",
      "Send": "Göndermek",
      "Receive": "Almak",
      "Share": "Paylaşmak",
      "Copy Address": "Adresi kopyala",
      "Set Amount": "Tutarı Ayarla",
      "Recipient Address": "Alıcı adresi",
      "Amount": "Miktar",
      "Scan QR": "QR'yi tarayın",
      "Max Amount": "Maksimum Tutar",
      "Continue": "Devam etmek",
      "COMPLETED": "TAMAMLANDI",
      "From": "İtibaren",
      "Rate": "Oran",
      "FEE": "ÜCRET",
      "Transaction Hash": "İşlem Karması",
      "Date": "Tarih",
      "IN PROGRESS": "DEVAM ETMEKTE",
      "Sending": "gönderme",
      "Browser": "Tarayıcı",
      "Wallet Name": "Cüzdan Adı",
      "Backup Options": "Yedekleme Seçenekleri",
      "Show Recovery Phrase": "Kurtarma İfadesini Göster",
      "descShowRecPhrase": "Bu cihaza erişiminizi kaybederseniz, paranız kaybolur. yedeklemediğiniz sürece!",
      "Account Public Keys": "Hesap Genel Anahtarları",
      "Export Account Public Keys": "Hesap Ortak Anahtarlarını Dışa Aktar",
      "Recovery Phrase": "Kurtarma İfadesi",
      "con1RecPh": "Kurtarma ifadesi, paranızın ana anahtarıdır. Asla başkasıyla paylaşmayın!",
      "con2RecPh": "DIGIT41, asla kurtarma ifadenizi paylaşmanızı istemez!",
      "con3RecPh": "Kurtarma ifadeniz kaybolursa, DIGIT41 bile paranızı geri alamaz",
      "I understand the risks": "riskleri anlıyorum",
      "Your recovery phrase": "Kurtarma ifadeniz",
      "descYourRecPh": "Bu kelimeleri doğru sırayla yazın veya kopyalayın ve güvenli bir yere kaydedin.",
      "qImportWallet":"Kurtarma ifadesi nedir?",
      "emptyData": "Görüntülenecek bilgi yok",
      "Balance": "Denge",
      "Value": "Değer",
      "An error has occurred": "bir hata oluştu",
      "to": "ile",
          "try again": "Tekrar deneyin",
          "Networks": "Ağlar",
          "Add Network": "Ağ ekle",
          "Network Name": "Ağ Adı",
          "New RPC URL": "Yeni RPC URL'si",
          "Chain id": "zincir kimliği",
          "Currency Symbol": "Para Birimi Sembolü",
          "Block Explorer URL": "Gezgin URL'sini Engelle",
          "Detail": "Detay",
          "DeacNetDelete": "Ağı silmek istediğinizden emin misiniz?",
          "Invalid Address": "Detay",
          "Address": "Adres",
          "Done successfully": "Başarıyla yapıldı",
        },
  };

}