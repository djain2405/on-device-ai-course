**📘 Module 2 - TensorFlow Lite on Android (Hands-On)**

Build Your First On-Device AI App with TFLite + Jetpack Compose

Welcome to Module 2 - your first real implementation of on-device AI on Android.

You’ll learn how to load a TensorFlow Lite model, run inference entirely on the device, and build a clean Compose UI that shows predictions instantly with no network needed.

This is a foundational module. After this, you’ll be ready for advanced topics like delegates, quantization, and on-device LLMs.

🎯 **Learning Goals**

By the end of this module, you will:

* Understand how TensorFlow Lite works on Android

* Know the difference between .tflite formats (float32, INT8, quantized)

* Load & run an image classification model

* Build a small Compose app with a photo picker

* Display class labels + confidence

* Understand the basic TFLite project structure

* Run real on-device inference in under 100ms


🧩 **1. What Is TensorFlow Lite (TFLite)?**

TensorFlow Lite is Google’s ML runtime optimized for:

* low latency

* low memory

* battery efficiency

* edge/mobile inference

TFLite models are tiny binary files (.tflite), often between 1–20MB, designed to run directly on-device.

It is the default choice for Android ML.

⚙️ **2. The Model We’ll Use**

We’ll use MobileNetV1 (quantized) - small, fast, and perfect for demos.

Filename:
``` mobilenet_v1_1.0_224_quant.tflite ```

Place it under:

``` modules/02_android_tflite/starter/app/src/main/assets/model.tflite ```

You can use this Google-hosted model (it’s free, public, and stable):
Direct Download:
https://github.com/tflite-soc/tensorflow-models/blob/master/mobilenet-v1/mobilenet_v1_1.0_224_quant.tflite

📁 **3. Starter Project Structure**

```
starter/
   app/
      src/
         main/
            java/
               com.example.tflitedemo/
                  MainActivity.kt
                  Classifier.kt
            assets/
               model.tflite
            res/
               layout/
               values/
```

We provide boilerplate Compose code + photo picker.

🧠 **4. Code Walkthrough**

Classifier.kt - Running TFLite Inference

```
package com.example.tflitedemo

import android.content.Context
import android.graphics.Bitmap
import org.tensorflow.lite.support.image.TensorImage
import org.tensorflow.lite.task.vision.classifier.ImageClassifier

class Classifier(context: Context) {

    private val classifier: ImageClassifier = ImageClassifier.createFromFileAndOptions(
        context,
        "model.tflite",
        ImageClassifier.ImageClassifierOptions.builder()
            .setMaxResults(1)
            .build()
    )

    data class ClassificationResult(val label: String, val confidence: Float)

    fun classify(bitmap: Bitmap): ClassificationResult {
        val tensor = TensorImage.fromBitmap(bitmap)
        val outputs = classifier.classify(tensor)
        val top = outputs.firstOrNull()?.categories?.firstOrNull()
        return ClassificationResult(
            label = top?.label ?: "Unknown",
            confidence = top?.score ?: 0f
        )
    }
}
```
This uses the TFLite Task Library, which handles image resizing, normalization, and label mapping automatically.

MainActivity.kt - Compose UI

This includes:

* system photo picker

* loading indicator

* classifier invocation

* result card

```
package com.example.tflitedemo

import android.graphics.BitmapFactory
import android.os.Build
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.result.PickVisualMediaRequest
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.animation.*
import androidx.compose.animation.core.spring
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent { TFLiteDemoScreen() }
    }
}

@OptIn(ExperimentalAnimationApi::class)
@Composable
fun TFLiteDemoScreen() {
    var result by remember { mutableStateOf<ClassificationResult?>(null) }
    var bitmap by remember { mutableStateOf<Bitmap?>(null) }
    val classifier = remember { Classifier(this) }

    // Image picker launcher
    val imagePickerLauncher = rememberLauncherForActivityResult(
        contract = ActivityResultContracts.GetContent()
    ) { uri: Uri? ->
        uri?.let {
            bitmap = uriToBitmap(it)
            result = null // Reset result when new image is selected
        }
    }

    // Classification Result Card
    if (result != null) {
        Card(
            modifier = Modifier.fillMaxWidth(),
            shape = RoundedCornerShape(12.dp),
            colors = CardDefaults.cardColors(
                containerColor = MaterialTheme.colorScheme.primaryContainer
            )
        ) {
            Column(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                Text(
                    text = "Classification Result",
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.Bold
                )
                Spacer(Modifier.height(12.dp))
                Text(
                    text = result!!.label,
                    style = MaterialTheme.typography.headlineSmall,
                    fontWeight = FontWeight.Bold,
                    color = MaterialTheme.colorScheme.primary
                )
                Spacer(Modifier.height(8.dp))
                Text(
                    text = "Confidence: ${String.format("%.2f%%", result!!.confidence * 100)}",
                    style = MaterialTheme.typography.bodyLarge
                )
                Spacer(Modifier.height(8.dp))
                LinearProgressIndicator(
                    progress = { result!!.confidence },
                    modifier = Modifier
                        .fillMaxWidth()
                        .height(8.dp),
                )
            }
        }
        Spacer(Modifier.height(16.dp))
    }

    // Select Image Button
    Button(
        onClick = {
            imagePickerLauncher.launch("image/*")
        },
        modifier = Modifier
            .fillMaxWidth()
            .height(56.dp),
        shape = RoundedCornerShape(12.dp),
        colors = ButtonDefaults.buttonColors(
            containerColor = MaterialTheme.colorScheme.secondary
        )
    ) {
        Text(
            text = "Select Image",
            style = MaterialTheme.typography.titleMedium
        )
    }

    // Classify Button
    Button(
        onClick = {
            bitmap?.let {
                result = classifier.classify(it)
            }
        },
        enabled = bitmap != null,
        modifier = Modifier
            .fillMaxWidth()
            .height(56.dp),
        shape = RoundedCornerShape(12.dp)
    ) {
        Text(
            text = if (result == null) "Classify Image" else "Classify Again",
            style = MaterialTheme.typography.titleMedium
        )
    }
}
```

🧪 **5. Build This Task (End of Module Challenge)**

Add ONE enhancement:

✔ Confidence-based Prefix

Add:

* “Definitely”

* “Probably”

* “Maybe”

```
fun prefix(confidence: Float): String =
    when {
        confidence >= 0.8f -> "Definitely"
        confidence >= 0.5f -> "Probably"
        else -> "Maybe"
    }
```
Then change your UI to:
```
"${prefix(confidence)} ${result.label} • ${(confidence * 100).toInt()}%"
```

This prepares you for Module 4 (AI UX).

📚 **6. What’s Next (Module 3)**

In the next module, you’ll build the iOS Core ML version, mirroring this demo but with:

* SwiftUI

* Core ML pipelines

* UIImage → CVPixelBuffer conversion

* animations

* better UX

Module 3 will complete your foundation for both platforms.