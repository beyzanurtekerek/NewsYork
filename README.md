# News York App
News York App, kullanıcıların New York Times API üzerinden en güncel başlıkları ve detaylı makaleleri görüntüleyebileceği bir haber agregatörü uygulamasıdır. Kullanıcılar, e-posta ve şifre ile giriş yapabilir, haberleri görüntüleyebilir ve makaleleri favorilerine ekleyebilirler. Ayrıca, kategori filtreleme ve arama fonksiyonu ile kullanıcı deneyimini zenginleştirir.

Uygulama, UIKit kullanılarak geliştirilmiş ve MVVM mimarisi takip edilerek sürdürülebilir bir kod yapısı sağlanmıştır. Kullanıcı kimlik doğrulaması ve veri yönetimi için Firebase kullanılmıştır.

## Özellikler
- Kullanıcı girişi (E-posta ve Şifre)
- Şifre sıfırlama fonksiyonu (“Şifremi Unuttum”)
- “Beni Hatırla” özelliği ile otomatik giriş
- Kullanıcı kaydı
- Haber listesi ve detay ekranı
- Haberleri favorilere ekleme ve favoriler ekranı
- Kategorilere göre haber filtreleme
- Haber arama fonksiyonu
- New York Times API’sinden haber çekme (Top Stories ve Article Search)

## Kurulum
1. Projeyi klonlayın:
   ```bash
   git clone https://github.com/your-repository/NewYorkApp.git
2. Projeyi Xcode’da açın.
3. Tüm bağımlılıkları indirmek için projeyi senkronize edin.
4. Uygulamayı gerçek bir iOS cihazında veya simülatörde çalıştırın.

## Kullanım
- Uygulama açıldığında, kullanıcılar e-posta ve şifre ile giriş yapabilir.
- Kullanıcılar şifrelerini unuttuklarında “Şifremi Unuttum” linki üzerinden şifre sıfırlama işlemi gerçekleştirebilirler.
- “Beni Hatırla” özelliği ile kullanıcılar bir sonraki girişlerinde otomatik olarak tanınır.
- Kayıtlı olmayan kullanıcılar yeni bir hesap oluşturabilir ve giriş yapabilir.
- Ana ekran, New York Times’tan çekilen haberleri listelemektedir.
- Kategoriler ekranında, kullanıcılar haberleri farklı kategorilere göre filtreleyebilir.
- Bir haberin üzerine tıklayarak detay sayfasına ulaşabilir ve haberi favorilerine ekleyebilir.
- Favori haberlere favoriler ekranından erişilebilir.
- Kullanıcılar, haber arama fonksiyonunu kullanarak makale araması yapabilirler.
- Haberin tamamını görüntülemek için “Read More” butonuna tıklanarak, cihazın varsayılan tarayıcısında haberin tam sayfasına yönlendirilir.

## Kullanılan Teknolojiler
- **UIKit**: iOS geliştirmede kullanılan kullanıcı arayüzü tasarım aracıdır.
- **MVVM Mimarisi**: Temiz ve modüler bir kod yapısı sağlar.
- **Firebase Authentication**: Kullanıcı girişi ve kaydını yönetir.
- **Firebase Storage**: Kullanıcı verilerini yönetir.
- **New York Times API**: En güncel haberleri çekmek için kullanılır.
- **Swift**: iOS uygulama geliştirme dili.

## Karşılaşılan Sorunlar
- **CollectionView ve TableView Kaydırma Sorunu**: Xcode’da yaşadığım bir hata nedeniyle CollectionView ve TableView kaydırma işlevi beklenildiği gibi **çalışmamaktadır**. Bazı durumlarda kaydırma işlevi düzgün çalışmamaktadır.
- **DetailVC (Detail View Controller) Sorunu**: DetailVC doğru şekilde açılamamaktadır, bu da kullanıcıların makale detaylarını görüntülemelerini engellemektedir. Bu sorun scroll hatasından kaynaklı olup *didSelectItemAt* ve *didSelectRowAt* tetiklenmediğinden kaynaklanmaktadır.
- Maalesef, bu sorunlar Xcode hataları nedeniyle bu projede çözüme kavuşturulamadı. Fakat hala sorunun çözümü için uğraşmaktayım.

## Ekran Görüntüleri
### Launchscreen, Signup ve Login Ekranları
![start](https://github.com/user-attachments/assets/0f8c8898-d057-440e-b57f-ac1940953c2f)
### Feed Ekranları
![content](https://github.com/user-attachments/assets/16e895b9-8ffa-487f-b83d-1b6dd64d8d15)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# News York App
The News York App is a news aggregator application that allows users to view the latest headlines and detailed articles from the New York Times API. Users can log in with email and password, view news articles, and add them to their favorites. Additionally, the app enriches the user experience with category filtering and a search function.

The app is developed using UIKit and follows the MVVM architecture to ensure a sustainable code structure. Firebase is used for user authentication and data management.

## Features
- User login (Email and Password)
- Password reset function (“Forgot My Password”)
- “Remember Me” feature for automatic login
- User registration
- News list and detail screen
- Add articles to favorites and favorites screen
- Filter news by categories
- News search function
- Fetch news from New York Times API (Top Stories and Article Search)

## Setup
1. Clone the project:
   ```bash
   git clone https://github.com/your-repository/NewYorkApp.git
2. Open the project in Xcode.
3. Synchronize the project to download all dependencies.
4. Run the app on a real iOS device or simulator.

## Usage
- Upon opening the app, users can log in with their email and password.
- Users who forget their password can reset it through the “Forgot My Password” link.
- With the “Remember Me” feature, users are automatically recognized during their next login.
- Users who are not registered can create a new account and log in.
- The main screen lists news articles fetched from the New York Times.
- In the categories screen, users can filter news by different categories.
- Tapping on a news article will open the detail page where users can add the article to their favorites.
- Favorite articles can be accessed from the favorites screen.
- Users can use the search function to find specific articles.
- To view the full article, users can click the “Read More” button, which will redirect them to the full article on their device’s default browser.

## Technologies Used
- **UIKit**: A user interface design framework for iOS development.
- **MVVM Architecture**: Ensures clean and modular code structure.
- **Firebase Authentication**: Manages user login and registration.
- **Firebase Storage**: Manages user data.
- **New York Times API**: Used to fetch the latest news.
- **Swift**: The iOS app development language.

## Issues Encountered
- **CollectionView and TableView Scrolling Issue**: Due to an error in Xcode, the scrolling functionality for CollectionView and TableView **is not working** as expected. In some cases, scrolling does not function correctly.
- **DetailVC (Detail View Controller) Issue**: DetailVC is not opening correctly, which prevents users from viewing article details. This issue is caused by a scroll error, where *didSelectItemAt* and *didSelectRowAt* are not being triggered.
- Unfortunately, these issues could not be resolved due to Xcode bugs. However, I am still working on fixing them.

## Screenshots

### Launch, Signup and Login Screens
![start](https://github.com/user-attachments/assets/271f6a79-b770-461c-962e-d863fd1d14ec)
### Feed Screens
![content](https://github.com/user-attachments/assets/4e1639ad-edc4-471b-a8af-b61d9cb38d49)


