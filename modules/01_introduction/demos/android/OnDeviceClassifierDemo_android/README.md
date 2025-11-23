# On-Device Image Classifier Demo

A basic Android image classifier app that uses TensorFlow Lite to perform on-device AI inference.

## Features

- **On-Device AI**: Uses TensorFlow Lite for fast, privacy-friendly image classification
- **Modern UI**: Built with Jetpack Compose and Material 3 Design
- **Confidence Scores**: Shows classification results with confidence percentages
- **Error Handling**: Robust error handling for model loading and inference
- **Resource Management**: Properly manages classifier lifecycle

## Architecture

### Key Components

1. **MainActivity.kt** (`/app/src/main/java/com/example/ondeviceclassifierdemo/MainActivity.kt:38`)
   - Main entry point with Jetpack Compose UI
   - Displays image and classification results
   - Shows confidence scores with visual progress indicator

2. **CatDogClassifier.kt** (`/app/src/main/java/com/example/ondeviceclassifierdemo/CatDogClassifier.kt:14`)
   - Wraps TensorFlow Lite ImageClassifier API
   - Handles model loading from assets
   - Returns structured classification results with confidence scores

3. **ClassificationResult** (`/app/src/main/java/com/example/ondeviceclassifierdemo/CatDogClassifier.kt:9`)
   - Data class containing label and confidence score

## Technical Details

### Dependencies

- **TensorFlow Lite**: 2.12.0
- **TensorFlow Lite Support**: 0.4.3
- **TensorFlow Lite Task Vision**: 0.4.3
- **Jetpack Compose**: Latest stable
- **Material 3**: Latest stable

### ML Model

The app expects a TensorFlow Lite model file at:
```
app/src/main/assets/model.tflite
```

The model should be compatible with TensorFlow Lite Task Vision API's ImageClassifier.

### Labels File

The app uses a labels file to map class indices to human-readable names:
```
app/src/main/assets/labels.txt
```

Each line in the labels file corresponds to a class index (starting from 0). For example:
```
Cat
Dog
```

This ensures that instead of seeing "0" or "1", you'll see meaningful labels like "Cat" or "Dog".

### Build Configuration

Key build configurations in `app/build.gradle.kts`:
- **minSdk**: 24 (Android 7.0)
- **targetSdk**: 36
- **aaptOptions**: Prevents compression of .tflite files

## How to Use

1. Open the project in Android Studio
2. Ensure you have a model file at `app/src/main/assets/model.tflite`
3. Add sample images to `app/src/main/res/drawable/` (currently uses `sample_cat.png`)
4. Build and run on an Android device or emulator

## Extending the App

### Adding Image Selection

To allow users to pick images from their gallery, add:

1. Permission in `AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
```

2. Use `rememberLauncherForActivityResult` with `ActivityResultContracts.PickVisualMedia()`:
```kotlin
val photoPickerLauncher = rememberLauncherForActivityResult(
    contract = ActivityResultContracts.PickVisualMedia()
) { uri ->
    // Load bitmap from uri
}
```

### Using a Different Model

1. Replace `model.tflite` in the assets folder
2. Update the model name in `CatDogClassifier.kt:23` if needed
3. Adjust `setMaxResults()` and `setScoreThreshold()` based on your model

### Adding Camera Support

1. Add camera permission to manifest
2. Use `ActivityResultContracts.TakePicture()` to capture images
3. Pass the captured bitmap to the classifier

## Code Improvements Made

1. **ML Model Configuration**: Added `aaptOptions` to prevent TFLite model compression
2. **Label Mapping**: Added label file support to map class indices to human-readable names (`CatDogClassifier.kt:35-46`)
3. **Error Handling**: Added try-catch blocks and null safety
4. **Confidence Scores**: Display classification confidence as percentage
5. **Better UI**: Modern Material 3 design with cards and progress indicators
6. **Resource Management**: Added `close()` method and `DisposableEffect` for cleanup
7. **Structured Results**: Created `ClassificationResult` data class

## Building the App

```bash
./gradlew assembleDebug
```

## Running Tests

```bash
./gradlew test
./gradlew connectedAndroidTest
```

## Troubleshooting

### Model Not Found Error
- Ensure `model.tflite` exists in `app/src/main/assets/`
- Check that `aaptOptions.noCompress("tflite")` is in build.gradle

### ClassNotFoundException
- Verify TensorFlow Lite dependencies are correctly added
- Sync Gradle and rebuild the project

### Out of Memory
- Reduce image resolution before classification
- Consider using a smaller model

## Next Steps

- Add image picker for gallery selection
- Add camera capture functionality
- Support multiple image formats
- Add batch processing
- Implement model download from Firebase ML
- Add performance metrics (inference time)

## License

This is a demo project for learning purposes.
