## Firebase

*Install*

```bash
flutter channel master
flutter upgrade
flutter config --enable-web
```

*Create*

```bash
flutter create --project-name flutter_firebase .
```

*Run*

```bash
flutter build web
flutter run -d chrome
```

*Rule*

```csharp
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
```