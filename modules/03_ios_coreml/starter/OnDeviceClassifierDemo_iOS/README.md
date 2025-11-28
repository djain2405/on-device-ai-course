# On-Device Image Classifier - iOS

An iOS app demonstrating **on-device AI** using Core ML and SwiftUI. This app performs real-time image classification completely locally on your iPhone — no cloud, no network calls, 100% private.

## What It Does

Choose any photo from your library, and the app instantly predicts what's in it with a confidence score. Everything runs locally using Apple's Core ML framework with the MobileNetV2 model.

## Features

- **Fast** ⚡ - Results appear instantly (~50ms)
- **Private** 🔒 - Everything happens locally, photos never leave your device
- **Offline** 🔋 - Works anywhere, no internet required
- **Accurate** - Uses MobileNetV2 trained on ImageNet (1000 object classes)

## Tech Stack

- **SwiftUI** - Modern declarative UI framework
- **Core ML** - Apple's machine learning framework
- **MobileNetV2** - Lightweight image classification model (~17MB)
- **iOS 14.0+** - Minimum deployment target

## How It Works

```
User selects photo → MobileNetV2 model → Prediction with confidence score
                     (runs on device)
```

The architecture is surprisingly simple:
1. **MobileNetV2 model** (~17MB) runs locally via Core ML
2. **SwiftUI** handles the UI and image picker
3. **Image → Model → Predictions** (all on device, ~50ms)

## Project Structure

```
OnDeviceClassifierDemo/
├── OnDeviceClassifierDemo/
│   ├── ContentView.swift          # Main UI
│   ├── ImagePicker.swift          # Photo picker component
│   ├── OnDeviceClassifierDemoApp.swift
│   └── Assets.xcassets
├── MobileNetV2.mlmodel            # Core ML model
└── OnDeviceClassifierDemo.xcodeproj
```

## Getting Started

### Prerequisites

- Xcode 13.0+
- iOS 14.0+ device or simulator
- macOS 11.0+ (Big Sur or later)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/OnDeviceClassifierDemo_iOS.git
cd OnDeviceClassifierDemo_iOS
```

2. Open the project in Xcode:
```bash
open OnDeviceClassifierDemo.xcodeproj
```

3. Build and run:
   - Select your target device/simulator
   - Press `Cmd + R` or click the "Run" button

## Core ML Integration

Here's the core prediction logic:

```swift
// Load the Core ML model
let model = try? MobileNetV2()

// Make prediction
if let prediction = try? model.prediction(image: pixelBuffer) {
    let label = prediction.classLabel
    let confidence = prediction.classLabelProbs[label] ?? 0

    // Display: "espresso - 92%"
    resultLabel.text = "\(label) - \(Int(confidence * 100))%"
}
```

## On-Device vs Cloud AI

| Cloud AI | On-Device AI |
|----------|--------------|
| Network required | ✅ Works offline |
| ~500ms latency | ✅ ~50ms latency |
| Privacy concerns | ✅ 100% private |
| ✅ Infinitely scalable | Battery constrained |
| ✅ Complex models | Limited model size |

## Use Cases

Perfect for:
- Real-time image recognition
- Privacy-sensitive applications
- Offline functionality
- Low-latency requirements

## Screenshots

<img src="demo.gif" width="300" alt="Demo of app classifying images">

*Tap "Choose Photo" → select any image → instant label appears with confidence score*

## Future Enhancements

- [ ] Support for custom Core ML models
- [ ] Camera integration for real-time classification
- [ ] History of predictions
- [ ] Export results
- [ ] Android version with TensorFlow Lite

## Technical Details

### Model Information
- **Model**: MobileNetV2
- **Size**: ~17MB
- **Input**: 224x224 RGB image
- **Output**: 1000 ImageNet class labels with probabilities
- **Performance**: ~50ms inference time on iPhone 12

### Minimum Requirements
- iOS 14.0+
- ~20MB storage for app + model
- No network connection required

## Blog Post

Read the full tutorial on my blog: [Running AI Locally on iPhone — No Cloud Needed](YOUR_BLOG_URL)

## License

MIT License - feel free to use this project for learning and building your own on-device AI apps!

## Author

**Divya Jain**
- Blog: [Mobile With Me](YOUR_BLOG_URL)
- LinkedIn: [Your LinkedIn](YOUR_LINKEDIN_URL)
- GitHub: [@djain2405](https://github.com/djain2405)

## Acknowledgments

- MobileNetV2 model from [Apple's Core ML Model Gallery](https://developer.apple.com/machine-learning/models/)
- Trained on [ImageNet](http://www.image-net.org/) dataset
- Built with [SwiftUI](https://developer.apple.com/xcode/swiftui/) and [Core ML](https://developer.apple.com/documentation/coreml)

---

If you found this helpful, consider starring the repo! ⭐
