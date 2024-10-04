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
    final nameOrType = provider.name ?? provider.runtimeType;
    AppLogger.info('Provider: $nameOrType updated. New value: $newValue');
  }

  @override
  void didAddProvider(
    ProviderBase<dynamic> provider,
    Object? value,
    ProviderContainer container,
  ) {
    super.didAddProvider(provider, value, container);
    final nameOrType = provider.name ?? provider.runtimeType;

    AppLogger.info('Provider: $nameOrType added. Value: $value');
  }

  @override
  void didDisposeProvider(
    ProviderBase<dynamic> provider,
    ProviderContainer container,
  ) {
    super.didDisposeProvider(provider, container);
    final nameOrType = provider.name ?? provider.runtimeType;
    AppLogger.info('Provider: $nameOrType disposed.');
  }
}
