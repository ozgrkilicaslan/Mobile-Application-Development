Erciyes Üniversitesi Bilgisayar Mühendisliği

Mobile Application Development 

Asst. Prof. FEHİM KÖYLÜ

1030520970 Özgür Kılıçaslan

# Kelime Ezberleme Uygulaması

Bu proje, kelime ezberleme ve öğrenme sürecini desteklemek amacıyla geliştirilmiş bir mobil uygulamadır. Kullanıcılar, farklı dillerdeki kelimeleri ezberleyebilir, kelime listeleri oluşturabilir ve farklı öğrenme modları ile kelime bilgilerini pekiştirebilir.

## Proje Hedefleri

- Kullanıcılara kelime ezberleme imkanı sağlamak.
- Öğrenilen ve öğrenilmeyen kelimeleri takip etmek.
- Farklı öğrenme modları sunarak kelime bilgisini pekiştirmek.

## Özellikler

- *Kelime Listesi Yönetimi*: Kelime listeleri oluşturma, düzenleme ve silme.
- *Öğrenme ve Test Modları*: Kelime kartları ve çoktan seçmeli testler.
- *Kelime Durum Takibi*: Öğrenilen ve öğrenilmeyen kelimeleri işaretleme.
- *Kullanıcı Dostu Arayüz*: Kullanımı kolay ve modern tasarım.
- *Animasyon ve Geçişler*: Ekranlar arasında yumuşak geçişler ve animasyonlar.

## Kurulum

Proje, Flutter çerçevesi kullanılarak geliştirilmiştir. Kurulum adımları aşağıdaki gibidir:

1. Flutter SDK'sını indirip kurun: [Flutter Kurulum Kılavuzu](https://flutter.dev/docs/get-started/install)
2. Bu projeyi klonlayın:
    sh
    git clone https://github.com/kullaniciadi/proje-adi.git
    
3. Proje dizinine gidin:
    sh
    cd proje-adi
    
4. Gerekli paketleri yükleyin:
    sh
    flutter pub get
    
5. Uygulamayı çalıştırın:
    sh
    flutter run
    

## Kullanım

1. *Ana Sayfa*: Uygulamayı açtığınızda ana sayfadan kelime listelerine, test modlarına ve kelime kartlarına erişebilirsiniz.
2. *Kelime Listesi Oluşturma*: Yeni bir kelime listesi oluşturabilir ve bu listeye kelime çiftleri ekleyebilirsiniz.
3. *Kelime Kartları*: Kelimeleri kartlar şeklinde görüntüleyerek ezber yapabilirsiniz.
4. *Çoktan Seçmeli Testler*: Kelimeler üzerinde çoktan seçmeli testler yaparak bilginizi sınayabilirsiniz.
5. *Öğrenilen Kelimeleri İşaretleme*: Öğrendiğiniz kelimeleri işaretleyerek öğrenme sürecinizi takip edebilirsiniz.

## Proje Yapısı

- *main.dart*: Uygulamanın ana giriş noktası.
- *pages/*: Farklı sayfaları içeren dizin (ana sayfa, kelime listesi sayfası, test sayfası, vs.).
- *global_widget/*: Uygulama genelinde kullanılan özel bileşenler.
- *db/*: SQLite veritabanı ile ilgili işlemleri içeren dizin.

# Word Memorization Application

This project is a mobile application developed to support the word memorization and learning process. Users can memorize words in different languages, create word lists, and reinforce their vocabulary knowledge with different learning modes.

## Project Goals

- To provide users with the opportunity to memorize words.
- Keeping track of learned and unlearned words.
- To reinforce vocabulary by offering different learning modes.

## Features

- *Word List Management*: Creating, editing and deleting word lists.
- *Learning and Testing Modes*: Word cards and multiple choice tests.
- *Word Status Tracking*: Marking learned and unlearned words.
- *User-Friendly Interface*: Easy to use and modern design.
- *Animation and Transitions*: Smooth transitions and animations between screens.

## Setup

The project was developed using the Flutter framework. The installation steps are as follows:

1. Download and install Flutter SDK: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
2. Clone this project:
    sh
    git clone https://github.com/username/proje-name.git
    
3. Go to the project directory:
    sh
    cd project-name
    
4. Install the required packages:
    sh
    get flutter pub
    
5. Run the application:
    sh
    flutter run
    

## Use

1. *Home Page*: When you open the application, you can access word lists, test modes and word cards from the home page.
2. *Creating a Word List*: You can create a new word list and add word pairs to this list.
3. *Word Cards*: You can memorize words by viewing them as cards.
4. *Multiple Choice Tests*: You can test your knowledge by doing multiple choice tests on words.
5. *Marking Learned Words*: You can follow your learning process by marking the words you have learned.

## Project Structure

- *main.dart*: The main entry point of the application.
- *pages/*: Directory containing different pages (home page, word list page, test page, etc.).
- *global_widget/*: Special widgets used throughout the application.
- *db/*: Directory containing operations related to the SQLite database.
