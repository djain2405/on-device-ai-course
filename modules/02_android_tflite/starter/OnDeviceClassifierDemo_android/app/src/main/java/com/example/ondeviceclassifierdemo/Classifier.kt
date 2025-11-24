package com.example.ondeviceclassifierdemo

import android.content.Context
import android.graphics.Bitmap
import org.tensorflow.lite.support.image.TensorImage
import org.tensorflow.lite.task.vision.classifier.ImageClassifier
import java.io.BufferedReader
import java.io.InputStreamReader

data class ClassificationResult(
    val label: String,
    val confidence: Float
)

class Classifier(private val context: Context) {
    private var classifier: ImageClassifier? = null
    private var labels: List<String> = emptyList()

    init {
        try {
            // Load labels from labels.txt
            labels = loadLabels()

            val options = ImageClassifier.ImageClassifierOptions.builder()
                .setMaxResults(3)
                .setScoreThreshold(0.1f)
                .build()
            classifier = ImageClassifier.createFromFileAndOptions(context, "model.tflite", options)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun loadLabels(): List<String> {
        return try {
            val inputStream = context.assets.open("labels.txt")
            val reader = BufferedReader(InputStreamReader(inputStream))
            reader.readLines().also {
                reader.close()
            }
        } catch (e: Exception) {
            e.printStackTrace()
            emptyList()
        }
    }

    fun classify(bitmap: Bitmap): ClassificationResult {
        return try {
            classifier?.let {
                val tensorImage = TensorImage.fromBitmap(bitmap)
                val results = it.classify(tensorImage)
                val topCategory = results.firstOrNull()?.categories?.firstOrNull()

                if (topCategory != null) {
                    // Try to map the label to a human-readable name
                    val labelText = mapLabel(topCategory.label)

                    ClassificationResult(
                        label = labelText,
                        confidence = topCategory.score
                    )
                } else {
                    ClassificationResult("No result", 0f)
                }
            } ?: ClassificationResult("Classifier not initialized", 0f)
        } catch (e: Exception) {
            e.printStackTrace()
            ClassificationResult("Error: ${e.message}", 0f)
        }
    }

    private fun mapLabel(rawLabel: String): String {
        // If the label is a number (index), map it to the labels list
        return try {
            val index = rawLabel.toIntOrNull()
            if (index != null && index >= 0 && index < labels.size) {
                labels[index]
            } else {
                // If it's already a text label, return it as-is
                rawLabel
            }
        } catch (e: Exception) {
            rawLabel
        }
    }

    fun close() {
        classifier?.close()
        classifier = null
    }
}
