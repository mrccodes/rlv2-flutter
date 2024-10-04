import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/utils/app_logger.dart'; // Assuming you have a logger

class MyProviderObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    super.didUpdateProvider(provider, previousValue, newValue, container);
    AppLogger.info(
        'Provider: ${provider.name ?? provider.runtimeType} updated. New value: $newValue');
  }

  @override
  void didAddProvider(
    ProviderBase<dynamic> provider,
    Object? value,
    ProviderContainer container,
  ) {
    super.didAddProvider(provider, value, container);
    AppLogger.info(
        'Provider: ${provider.name ?? provider.runtimeType} added. Value: $value');
  }

  @override
  void didDisposeProvider(
    ProviderBase<dynamic> provider,
    ProviderContainer container,
  ) {
    super.didDisposeProvider(provider, container);
    AppLogger.info(
        'Provider: ${provider.name ?? provider.runtimeType} disposed.');
  }
}
