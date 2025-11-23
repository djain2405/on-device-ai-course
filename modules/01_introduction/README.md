📘 Module 1 - Understanding On-Device AI
What it is, why it matters, and your first hands-on demo

Welcome to Module 1 of the On-Device AI Course - the foundation for everything you’ll build next.

This module helps you understand what on-device AI really is, why it’s suddenly exploding in relevance, and how to run your first on-device AI classifier in under 5 minutes.

Let’s get started.

🎯 Learning Goals

By the end of this module, you’ll be able to explain:

What on-device AI means

How it differs from cloud AI

Why mobile hardware now supports real ML inference

The advantages (speed, privacy, offline, reliability)

The tradeoffs (model size, constraints)

The basic inference flow: Image → Model → Output

And you’ll run your first lightweight classifier using a pre-built demo.

🧠 1. What Is On-Device AI?

On-device AI means running machine learning models locally on the phone instead of calling a remote server.

Examples you already use:

iPhone photos auto-categorizing your pictures

Pixel phones transcribing calls live

WhatsApp doing client-side encryption and safety checks

Offline translation

Snapchat filters

On-device spam detection

All of these use local ML inference.

✔ No server
✔ No network
✔ No data leaves your device
✔ Results in milliseconds

This is why on-device AI is having a moment now.

⚡ 2. Why Now? (Hardware + Software Shift)

For years, phones weren’t strong enough to run ML models efficiently.

Today:

iPhones

16-core Apple Neural Engine (ANE)

Highly optimized Core ML runtime

Unified memory architecture

Android

NNAPI and GPU/Hexagon delegates

TensorFlow Lite optimized for mobile ops

NPU (Neural Processing Unit) hardware on flagship chips

This hardware is designed specifically for ML inference.
That’s why models that used to require servers can now run instantly on-device.

☁️ vs 📱 3. Cloud AI vs On-Device AI
| Cloud AI             | On-Device AI                 |
| -------------------- | ---------------------------- |
| Requires network     | Works offline                |
| Great for large LLMs | Great for fast, small models |
| Privacy concerns     | Data stays on device         |
| High latency         | ~50ms latency                |
| Expensive to scale   | Free after install           |
| Centralized          | Personalized                 |


Neither replaces the other.
Modern apps combine both.

🔄 4. The Basic Inference Flow

No matter the platform (iOS / Android), the flow looks like this:

Image → Preprocessing → Model → Probabilities → Label

Step-by-step:

User selects a photo

App converts image → pixel buffer / tensor

Model runs locally (Core ML / TFLite)

Output is a list of labels + confidence

App shows the result

Everything happens inside the device.
Nothing leaves the phone.

🖼 5. Your First Demo (Ready to Run)

Below are starter apps you can run immediately.

iOS Demo (Core ML)

Folder:

modules/01_introduction/demos/ios/


This includes:

basic SwiftUI app

MobileNetV2.mlmodel

photo picker

result label

To run:

Open Xcode

Run on Simulator or device

Choose any photo

See instant prediction

Android Demo (TensorFlow Lite)

Folder:

modules/01_introduction/demos/android/


This includes:

Jetpack Compose app

TFLite MobileNetV1 model

photo picker

simple output label

To run:

Open Android Studio

Install on device/simulator

Pick a photo

Get instant classification

🧪 6. Hands-On Task ("Build This")

To complete this module, do this:

✔ Add a confidence score (percentage)
✔ Change the UI colors based on confidence
✔ Add a small “Analyzing…” loading indicator

These tiny additions will help you prepare for Module 4 (AI UX).

📚 7. Further Reading (Optional)

If you want to go deeper:

Apple: Core ML overview

Google: TensorFlow Lite basics

Qualcomm: Understanding NPUs

EfficientNet: modern image classification

(Add links in the final repo.)

🌱 8. What’s Next (Module 2 & 3)

You now understand:

what on-device AI is,

why it matters,

how the inference pipeline works,

and you’ve run your first demo.

Next, we go platform-specific.