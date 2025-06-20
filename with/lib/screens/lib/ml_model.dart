import 'package:tflite_flutter/tflite_flutter.dart';

class MLModel {
  Interpreter? _interpreter;
  bool _isModelLoaded = false;

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(
        "assets/smart_gloves_model.tflite",
      );

      _isModelLoaded = true;
      print('✅ Model loaded successfully');
    } catch (e) {
      _isModelLoaded = false;
      print('❌ Error loading model: $e');
    }
  }

  int runModel(List<double> input) {
    if (!_isModelLoaded || _interpreter == null) {
      throw Exception('Model is not loaded. Call loadModel() first.');
    }

    try {
      var inputShape = _interpreter!.getInputTensor(0).shape;
      var outputShape = _interpreter!.getOutputTensor(0).shape;

      // Validate input shape
      if (input.length != inputShape[1]) {
        throw Exception(
          'Input shape mismatch. Expected ${inputShape[1]} values, got ${input.length}.',
        );
      }

      var inputTensor = [input];
      var outputTensor = List.filled(
        outputShape[1],
        0.0,
      ).reshape([1, outputShape[1]]);

      _interpreter!.run(inputTensor, outputTensor);

      double max = outputTensor[0][0];
      int maxIndex = 0;
      for (int i = 1; i < outputTensor[0].length; i++) {
        if (outputTensor[0][i] > max) {
          max = outputTensor[0][i];
          maxIndex = i;
        }
      }

      return maxIndex;
    } catch (e) {
      print('� Dubois running model: $e');
      rethrow;
    }
  }

  void dispose() {
    _interpreter?.close();
    _interpreter = null;
    _isModelLoaded = false;
    print('🧹 Model disposed');
  }
}
