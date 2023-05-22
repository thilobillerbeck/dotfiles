
{ config, pkgs, lib, ... }:

let
  chromeArgs = lib.strings.concatStringsSep " " [
    "--force-dark-mode"
    "--enable-features=WebUIDarkMode"
    "--enable-smooth-scrolling"
    "--ozone-platform-hint=auto"
    "--ignore-gpu-blocklist"
    "--enable-gpu-rasterization"
    "--enable-zero-copy"
    "--force-device-scale-factor=1.0"
  ];
  codeArgs = lib.strings.concatStringsSep " " [
    "--ozone-platform-hint=auto"
    "--enable-features=WaylandWindowDecorations"
  ];
  code-wrapper = (pkgs.writeShellScriptBin "code" ''
    exec /usr/bin/code ${codeArgs} "$@"
  '');
  chrome-wrapper = (pkgs.writeShellScriptBin "google-chrome" ''
    exec /usr/bin/google-chrome ${chromeArgs} "$@"
  '');
  chrome-stable-wrapper = (pkgs.writeShellScriptBin "google-chrome-stable" ''
    exec /usr/bin/google-chrome-stable ${chromeArgs} "$@"
  '');
in {
  home.packages = with pkgs; [
    code-wrapper
    chrome-wrapper
    chrome-stable-wrapper
  ];

  home.file = {
    ".local/share/applications/google-chrome.desktop" = {
      text = ''
        [Desktop Entry]
        Version=1.0
        Name=Google Chrome
        # Only KDE 4 seems to use GenericName, so we reuse the KDE strings.
        # From Ubuntu's language-pack-kde-XX-base packages, version 9.04-20090413.
        GenericName=Web Browser
        GenericName[ar]=متصفح الشبكة
        GenericName[bg]=Уеб браузър
        GenericName[ca]=Navegador web
        GenericName[cs]=WWW prohlížeč
        GenericName[da]=Browser
        GenericName[de]=Web-Browser
        GenericName[el]=Περιηγητής ιστού
        GenericName[en_GB]=Web Browser
        GenericName[es]=Navegador web
        GenericName[et]=Veebibrauser
        GenericName[fi]=WWW-selain
        GenericName[fr]=Navigateur Web
        GenericName[gu]=વેબ બ્રાઉઝર
        GenericName[he]=דפדפן אינטרנט
        GenericName[hi]=वेब ब्राउज़र
        GenericName[hu]=Webböngésző
        GenericName[it]=Browser Web
        GenericName[ja]=ウェブブラウザ
        GenericName[kn]=ಜಾಲ ವೀಕ್ಷಕ
        GenericName[ko]=웹 브라우저
        GenericName[lt]=Žiniatinklio naršyklė
        GenericName[lv]=Tīmekļa pārlūks
        GenericName[ml]=വെബ് ബ്രൌസര്‍
        GenericName[mr]=वेब ब्राऊजर
        GenericName[nb]=Nettleser
        GenericName[nl]=Webbrowser
        GenericName[pl]=Przeglądarka WWW
        GenericName[pt]=Navegador Web
        GenericName[pt_BR]=Navegador da Internet
        GenericName[ro]=Navigator de Internet
        GenericName[ru]=Веб-браузер
        GenericName[sl]=Spletni brskalnik
        GenericName[sv]=Webbläsare
        GenericName[ta]=இணைய உலாவி
        GenericName[th]=เว็บเบราว์เซอร์
        GenericName[tr]=Web Tarayıcı
        GenericName[uk]=Навігатор Тенет
        GenericName[zh_CN]=网页浏览器
        GenericName[zh_HK]=網頁瀏覽器
        GenericName[zh_TW]=網頁瀏覽器
        # Not translated in KDE, from Epiphany 2.26.1-0ubuntu1.
        GenericName[bn]=ওয়েব ব্রাউজার
        GenericName[fil]=Web Browser
        GenericName[hr]=Web preglednik
        GenericName[id]=Browser Web
        GenericName[or]=ଓ୍ବେବ ବ୍ରାଉଜର
        GenericName[sk]=WWW prehliadač
        GenericName[sr]=Интернет прегледник
        GenericName[te]=మహాతల అన్వేషి
        GenericName[vi]=Bộ duyệt Web
        # Gnome and KDE 3 uses Comment.
        Comment=Access the Internet
        Comment[ar]=الدخول إلى الإنترنت
        Comment[bg]=Достъп до интернет
        Comment[bn]=ইন্টারনেটটি অ্যাক্সেস করুন
        Comment[ca]=Accedeix a Internet
        Comment[cs]=Přístup k internetu
        Comment[da]=Få adgang til internettet
        Comment[de]=Internetzugriff
        Comment[el]=Πρόσβαση στο Διαδίκτυο
        Comment[en_GB]=Access the Internet
        Comment[es]=Accede a Internet.
        Comment[et]=Pääs Internetti
        Comment[fi]=Käytä internetiä
        Comment[fil]=I-access ang Internet
        Comment[fr]=Accéder à Internet
        Comment[gu]=ઇંટરનેટ ઍક્સેસ કરો
        Comment[he]=גישה אל האינטרנט
        Comment[hi]=इंटरनेट तक पहुंच स्थापित करें
        Comment[hr]=Pristup Internetu
        Comment[hu]=Internetelérés
        Comment[id]=Akses Internet
        Comment[it]=Accesso a Internet
        Comment[ja]=インターネットにアクセス
        Comment[kn]=ಇಂಟರ್ನೆಟ್ ಅನ್ನು ಪ್ರವೇಶಿಸಿ
        Comment[ko]=인터넷 연결
        Comment[lt]=Interneto prieiga
        Comment[lv]=Piekļūt internetam
        Comment[ml]=ഇന്റര്‍‌നെറ്റ് ആക്‌സസ് ചെയ്യുക
        Comment[mr]=इंटरनेटमध्ये प्रवेश करा
        Comment[nb]=Gå til Internett
        Comment[nl]=Verbinding maken met internet
        Comment[or]=ଇଣ୍ଟର୍ନେଟ୍ ପ୍ରବେଶ କରନ୍ତୁ
        Comment[pl]=Skorzystaj z internetu
        Comment[pt]=Aceder à Internet
        Comment[pt_BR]=Acessar a internet
        Comment[ro]=Accesaţi Internetul
        Comment[ru]=Доступ в Интернет
        Comment[sk]=Prístup do siete Internet
        Comment[sl]=Dostop do interneta
        Comment[sr]=Приступите Интернету
        Comment[sv]=Gå ut på Internet
        Comment[ta]=இணையத்தை அணுகுதல்
        Comment[te]=ఇంటర్నెట్‌ను ఆక్సెస్ చెయ్యండి
        Comment[th]=เข้าถึงอินเทอร์เน็ต
        Comment[tr]=İnternet'e erişin
        Comment[uk]=Доступ до Інтернету
        Comment[vi]=Truy cập Internet
        Comment[zh_CN]=访问互联网
        Comment[zh_HK]=連線到網際網路
        Comment[zh_TW]=連線到網際網路
        Exec=/usr/bin/google-chrome-stable ${chromeArgs} %U
        StartupNotify=true
        Terminal=false
        Icon=google-chrome
        Type=Application
        Categories=Network;WebBrowser;
        Actions=new-window;new-private-window;

        [Desktop Action new-window]
        Name=New Window
        Name[am]=አዲስ መስኮት
        Name[ar]=نافذة جديدة
        Name[bg]=Нов прозорец
        Name[bn]=নতুন উইন্ডো
        Name[ca]=Finestra nova
        Name[cs]=Nové okno
        Name[da]=Nyt vindue
        Name[de]=Neues Fenster
        Name[el]=Νέο Παράθυρο
        Name[en_GB]=New Window
        Name[es]=Nueva ventana
        Name[et]=Uus aken
        Name[fa]=پنجره جدید
        Name[fi]=Uusi ikkuna
        Name[fil]=New Window
        Name[fr]=Nouvelle fenêtre
        Name[gu]=નવી વિંડો
        Name[hi]=नई विंडो
        Name[hr]=Novi prozor
        Name[hu]=Új ablak
        Name[id]=Jendela Baru
        Name[it]=Nuova finestra
        Name[iw]=חלון חדש
        Name[ja]=新規ウインドウ
        Name[kn]=ಹೊಸ ವಿಂಡೊ
        Name[ko]=새 창
        Name[lt]=Naujas langas
        Name[lv]=Jauns logs
        Name[ml]=പുതിയ വിന്‍ഡോ
        Name[mr]=नवीन विंडो
        Name[nl]=Nieuw venster
        Name[no]=Nytt vindu
        Name[pl]=Nowe okno
        Name[pt]=Nova janela
        Name[pt_BR]=Nova janela
        Name[ro]=Fereastră nouă
        Name[ru]=Новое окно
        Name[sk]=Nové okno
        Name[sl]=Novo okno
        Name[sr]=Нови прозор
        Name[sv]=Nytt fönster
        Name[sw]=Dirisha Jipya
        Name[ta]=புதிய சாளரம்
        Name[te]=క్రొత్త విండో
        Name[th]=หน้าต่างใหม่
        Name[tr]=Yeni Pencere
        Name[uk]=Нове вікно
        Name[vi]=Cửa sổ Mới
        Name[zh_CN]=新建窗口
        Name[zh_TW]=開新視窗
        Exec=/usr/bin/google-chrome-stable ${chromeArgs} 

        [Desktop Action new-private-window]
        Name=New Incognito Window
        Name[ar]=نافذة جديدة للتصفح المتخفي
        Name[bg]=Нов прозорец „инкогнито“
        Name[bn]=নতুন ছদ্মবেশী উইন্ডো
        Name[ca]=Finestra d'incògnit nova
        Name[cs]=Nové anonymní okno
        Name[da]=Nyt inkognitovindue
        Name[de]=Neues Inkognito-Fenster
        Name[el]=Νέο παράθυρο για ανώνυμη περιήγηση
        Name[en_GB]=New Incognito window
        Name[es]=Nueva ventana de incógnito
        Name[et]=Uus inkognito aken
        Name[fa]=پنجره جدید حالت ناشناس
        Name[fi]=Uusi incognito-ikkuna
        Name[fil]=Bagong Incognito window
        Name[fr]=Nouvelle fenêtre de navigation privée
        Name[gu]=નવી છુપી વિંડો
        Name[hi]=नई गुप्त विंडो
        Name[hr]=Novi anoniman prozor
        Name[hu]=Új Inkognitóablak
        Name[id]=Jendela Penyamaran baru
        Name[it]=Nuova finestra di navigazione in incognito
        Name[iw]=חלון חדש לגלישה בסתר
        Name[ja]=新しいシークレット ウィンドウ
        Name[kn]=ಹೊಸ ಅಜ್ಞಾತ ವಿಂಡೋ
        Name[ko]=새 시크릿 창
        Name[lt]=Naujas inkognito langas
        Name[lv]=Jauns inkognito režīma logs
        Name[ml]=പുതിയ വേഷ പ്രച്ഛന്ന വിന്‍ഡോ
        Name[mr]=नवीन गुप्त विंडो
        Name[nl]=Nieuw incognitovenster
        Name[no]=Nytt inkognitovindu
        Name[pl]=Nowe okno incognito
        Name[pt]=Nova janela de navegação anónima
        Name[pt_BR]=Nova janela anônima
        Name[ro]=Fereastră nouă incognito
        Name[ru]=Новое окно в режиме инкогнито
        Name[sk]=Nové okno inkognito
        Name[sl]=Novo okno brez beleženja zgodovine
        Name[sr]=Нови прозор за прегледање без архивирања
        Name[sv]=Nytt inkognitofönster
        Name[ta]=புதிய மறைநிலைச் சாளரம்
        Name[te]=క్రొత్త అజ్ఞాత విండో
        Name[th]=หน้าต่างใหม่ที่ไม่ระบุตัวตน
        Name[tr]=Yeni Gizli pencere
        Name[uk]=Нове вікно в режимі анонімного перегляду
        Name[vi]=Cửa sổ ẩn danh mới
        Name[zh_CN]=新建隐身窗口
        Name[zh_TW]=新增無痕式視窗
        Exec=/usr/bin/google-chrome-stable --incognito ${chromeArgs}
        MimeType=x-scheme-handler/unknown;x-scheme-handler/about;application/pdf;application/rdf+xml;application/rss+xml;application/xhtml+xml;application/xhtml_xml;application/xml;image/gif;image/jpeg;image/png;image/webp;text/html;text/xml;x-scheme-handler/http;x-scheme-handler/https;
      '';
    };
    ".local/share/applications/code.desktop" = {
      text = ''
        [Desktop Entry]
        Name=Visual Studio Code
        Comment=Code Editing. Redefined.
        GenericName=Text Editor
        Exec=/usr/share/code/code ${codeArgs} --unity-launch  %F
        Icon=vscode
        Type=Application
        StartupNotify=false
        StartupWMClass=Code
        Categories=TextEditor;Development;IDE;
        MimeType=text/plain;inode/directory;application/x-code-workspace;
        Actions=new-empty-window;
        Keywords=vscode;

        [Desktop Action new-empty-window]
        Name=New Empty Window
        Exec=/usr/share/code/code ${codeArgs} --new-window %F
        Icon=vscode
      '';
    };
    ".local/share/applications/code-url-handler.desktop" = {
      text = ''
        [Desktop Entry]
        Name=Visual Studio Code - URL Handler
        Comment=Code Editing. Redefined.
        GenericName=Text Editor
        Exec=/usr/share/code/code ${codeArgs} --open-url %U
        Icon=vscode
        Type=Application
        NoDisplay=true
        StartupNotify=true
        Categories=Utility;TextEditor;Development;IDE;
        MimeType=x-scheme-handler/vscode;
        Keywords=vscode;
      '';
    };
  };
}
