# SIGNING APP

- Generate keystore dari terminal dengan perintah:
> keytool -genkey -v -keystore D:/\<lokasi folder apk>/my-key.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias key

- Masukkan data yang diperlukan/ diminta

      Enter keystore password: ***************
      Re-enter new password: ***************
      What is your first and last name?
        [Unknown]:  Cindy Sintiya
      What is the name of your organizational unit?
        [Unknown]:  Mikroskil
      What is the name of your organization?
        [Unknown]:  University
      What is the name of your City or Locality?
        [Unknown]:  Medan
      What is the name of your State or Province?
        [Unknown]:  Sumatera Utara
      What is the two-letter country code for this unit?
        [Unknown]:  ID
      Is CN=Cindy Sintiya, OU=Mikroskil, O=University, L=Medan, ST=Sumatera Utara, C=ID correct?
        [no]:  yes

      Generating 2,048 bit RSA key pair and self-signed certificate (SHA256withRSA) with a validity of 10,000 days
        for: CN=Cindy Sintiya, OU=Mikroskil, O=University, L=Medan, ST=Sumatera Utara, C=ID
      [Storing D:/21/my-key.keystore]

- Buat file baru dengan nama "key.properties" didalam folder android

      storePassword=csl_pertemuan15
      keyPassword=csl_pertemuan15
      keyAlias=key
      storeFile=D:/\<lokasi folder key>/my-key.keystore

- Pada file "app/build.gradle", tambahkan:
```javascript
def keyStoreProperties = new Properties()
def keyStorePropertiesFile = rootProject.file('key.properties')
if (keyStorePropertiesFile.exists()) {
    keyStoreProperties.load(new FileInputStream(keyStorePropertiesFile))
}

android {
    ...
}
```
- Masih pada file yang sama, di "buildTypes", ubah "signingConfigs.debug" menjadi "signingConfigs.release", dan tambahkan:
```javascript
    signingConfigs {
        release {
            keyAlias keyStoreProperties['keyAlias']
            keyPassword keyStoreProperties['keyPassword']
            storeFile keyStoreProperties['storeFile'] ? file(keyStoreProperties['storeFile']) : null
            storePassword keyStoreProperties['storePassword']
        }
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig signingConfigs.release
        }
    }
```
- Jalankan perinta di terminal:
>  flutter build apk atau flutter run --release

- Ambil file apk yang telah dibuat di "build\app\outputs\flutter-apk\app-release.apk" untuk diterbitkan di PlayStore