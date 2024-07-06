# 
## Razvoj Softvera 2 - BHFudbal
### Build and run
1. Clone this repo

         git clone https://github.com/mirza-k/RS2-BHFudbal.git
2. Navigate to folder where the app is located and run following command:

         docker-compose -f docker-compose.yml up --build
3. In order to open Windows app, open Visual Studio Code than navigate to cloned repo -> BHFudbal.UI -> BHFudbal.AdminUI and run following command:

         flutter pub get
4. To run Windows app, use this command because of env variables:
   
            flutter run --dart-define=RABBITMQ_HOST=localhost --dart-define=RABBITMQ_PORT=5672 --dart-define=RABBITMQ_VIRTUAL_HOST=/ --dart-define=RABBITMQ_USER=mirza --dart-define=RABBITMQ_PASSWORD=pass123
5. Start Android Studio and run emulator device
6. In order to open Android app, open Visual Studio Code than navigate to cloned repo -> BHFudbal.UI -> BHFudbal.UserUI and run following command:

         flutter pub get

### Windows application credentials:
###### Username: admin@gmail.com
###### Password: Test123!
### Android application credentials:
###### Username: user@gmail.com
###### Password: Test123!
###### Username: user1@gmail.com
###### Password: Test123!
###### Username: user2@gmail.com
###### Password: Test123!
<br/>
<br/>
