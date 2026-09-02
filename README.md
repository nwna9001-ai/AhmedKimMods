# Ahmed Kim Mods

Real-project starter for a Minecraft Bedrock & Java mods/addons platform.

## Stack
- Flutter mobile app (Android/iOS)
- Node.js + TypeScript backend API
- PostgreSQL database
- Admin dashboard starter
- Docker Compose for local PostgreSQL

## Included
- Dark red / black visual identity
- Smooth navigation structure
- Home, Explore, Favorites, Upload, Profile
- Mod/Add-on detail model
- Copyright/reporting model and API route structure
- Authentication API structure
- Database schema starter
- Environment examples

## Run
### Backend
```bash
cd backend
npm install
npm run dev
```

### Database
```bash
docker compose up -d postgres
```

### Flutter
Install Flutter, then:
```bash
cd mobile
flutter pub get
flutter run
```

This is a production-oriented foundation; production deployment still requires real credentials, cloud storage, authentication hardening, moderation operations, and store configuration.
