# 📦 Demo Library
A simple internal Java library project built with Java 17.  
Supports both **Maven** and **Gradle** builds.
---

## 🚀 Getting Started

This project is designed to be flexible and portable. You can build and publish it using either:
- [Gradle](./build.gradle)
- [Maven](./pom.xml)
> 💡 This project was tested with Java 17. Make sure `JAVA_HOME` is correctly configured.

## ⚙️ With Gradle
Build the JAR and sources:
```bash
./gradlew clean build
```
Publish the artifacts to Nexus:
```bash
./gradlew publish
```
> 🔎 See full configuration in **build.gradle**

## ⚙️ With Maven
Build the JAR and sources:
```bash
mvn clean install
```
Publish the artifacts to Nexus:
```bash
mvn deploy
```
> 🔎 Requires a valid **settings.xml** with your Nexus credentials.

## 📁 Project Structure
```pgsql
demo/
├── src/main/java/       -> Library source code
├── scripts/             -> Custom deployment scripts (.sh / .bat)
├── build.gradle         -> Gradle build script
├── settings.gradle      -> Gradle project config
└── pom.xml              -> Maven support
```

## 📝 License
This project is licensed under the [MIT License](../LICENSE).
