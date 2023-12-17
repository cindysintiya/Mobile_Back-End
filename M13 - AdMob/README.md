- android/app/src/main/AndroidManifest.xml --> before \</application> tag

>     <meta-data android:name="com.google.android.gms.ads.APPLICATION_ID" android:value="ca-app-pub-9492642473769975~2669946669" />

- android/build.gradle

      ext.kotlin_version = '1.8.21' (optional/ or maybe not)

- android/app/build.gradle --> dependency {...} (optional)

      implementation("com.google.android.gms:play-services-ads:22.6.0")

- Documentation Link

> https://developers.google.com/admob/android/quick-start (main)

> https://firebase.google.com/docs/admob/android/quick-start

> https://apps.admob.com/v2/apps/2669946669/settings (get APP ID for AndroidManifext.xml)