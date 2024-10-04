import 'package:rlv2_flutter/utils/app_logger.dart';

class Subscription {
  Subscription({
    required this.id,
    required this.created,
    required this.currency,
    required this.currentPeriodEnd,
    required this.currentPeriodStart,
    required this.customer,
    required this.items,
    required this.latestInvoice,
    required this.pendingSetupIntent,
    required this.startDate,
    required this.status,
    this.pendingInvoiceItemInterval,
    this.pendingUpdate,
    this.trialEnd,
    this.trialStart,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    AppLogger.info('Subscription.fromJson: $json');
    return Subscription(
      id: json['id'] as String,
      created: json['created'] as int,
      currency: json['currency'] as String,
      currentPeriodEnd: json['current_period_end'] as int,
      currentPeriodStart: json['current_period_start'] as int,
      customer: json['customer'] as String,
      items: (json['items'] as List<dynamic>)
          .map(
              (item) => SubscriptionItem.fromJson(item as Map<String, dynamic>),
              )
          .toList(),
      latestInvoice: json['latest_invoice'] as String,
      pendingInvoiceItemInterval: json['pending_invoice_item_interval'],
      pendingSetupIntent: json['pending_setup_intent'],
      pendingUpdate: json['pending_update'],
      startDate: json['start_date'] as int,
      status: json['status'] as String,
      trialEnd: json['trial_end'],
      trialStart: json['trial_start'],
    );
  }
  final String id;
  final int created; // timestamp
  final String currency;
  final int currentPeriodEnd; // timestamp
  final int currentPeriodStart; // timestamp
  final String customer; // customer id
  final List<SubscriptionItem> items;
  final String latestInvoice; // invoice id
  final dynamic pendingInvoiceItemInterval;
  final dynamic pendingSetupIntent;
  final dynamic pendingUpdate;
  final int startDate; // timestamp
  final String status; // subscription status
  final dynamic trialEnd;
  final dynamic trialStart;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created': created,
      'currency': currency,
      'current_period_end': currentPeriodEnd,
      'current_period_start': currentPeriodStart,
      'customer': customer,
      'items': items.map((item) => item.toJson()).toList(),
      'latest_invoice': latestInvoice,
      'pending_invoice_item_interval': pendingInvoiceItemInterval,
      'pending_setup_intent': pendingSetupIntent,
      'pending_update': pendingUpdate,
      'start_date': startDate,
      'status': status,
      'trial_end': trialEnd,
      'trial_start': trialStart,
    };
  }
}

class SubscriptionItem {
  SubscriptionItem({
    required this.id,
    required this.object,
    required this.created,
    required this.plan,
    required this.price,
    required this.quantity,
    required this.subscription,
    this.billingThresholds,
  });
  factory SubscriptionItem.fromJson(Map<String, dynamic> json) {
    return SubscriptionItem(
      id: json['id'] as String,
      object: json['object'] as String,
      billingThresholds: json['billing_thresholds'] as dynamic,
      created: json['created'] as int,
      plan: Plan.fromJson(json['plan'] as Map<String, dynamic>),
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      subscription: json['subscription'] as String,
    );
  }
  final String id;
  final String object;
  final dynamic billingThresholds;
  final int created;
  final Plan plan;
  final Price price;
  final int quantity;
  final String subscription;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'object': object,
      'billing_thresholds': billingThresholds,
      'created': created,
      'plan': plan.toJson(),
      'price': price.toJson(),
      'quantity': quantity,
      'subscription': subscription,
    };
  }
}

class Price {
  Price({
    required this.id,
    required this.active,
    required this.billingScheme,
    required this.created,
    required this.currency,
    required this.product,
    required this.type,
    required this.unitAmount,
    required this.unitAmountDecimal,
  });
  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      id: json['id'] as String,
      active: json['active'] as bool,
      billingScheme: json['billing_scheme'] as String,
      created: json['created'] as int,
      currency: json['currency'] as String,
      product: json['product'] as String,
      type: json['type'] as String,
      unitAmount: json['unit_amount'] as int,
      unitAmountDecimal: json['unit_amount_decimal'] as String,
    );
  }
  final String id;
  final bool active;
  final String billingScheme;
  final int created;
  final String currency;
  final String product;
  final String type;
  final int unitAmount;
  final String unitAmountDecimal;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'active': active,
      'billing_scheme': billingScheme,
      'created': created,
      'currency': currency,
      'product': product,
      'type': type,
      'unit_amount': unitAmount,
      'unit_amount_decimal': unitAmountDecimal,
    };
  }
}

class Plan {
  Plan({
    required this.id,
    required this.active,
    required this.amount,
    required this.amountDecimal,
    required this.billingScheme,
    required this.created,
    required this.currency,
    required this.interval,
    required this.intervalCount,
    required this.product,
  });
  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'] as String,
      active: json['active'] as bool,
      amount: json['amount'] as int,
      amountDecimal: json['amount_decimal'] as String,
      billingScheme: json['billing_scheme'] as String,
      created: json['created'] as int,
      currency: json['currency'] as String,
      interval: json['interval'] as String,
      intervalCount: json['interval_count'] as int,
      product: json['product'] as String,
    );
  }
  final String id;
  final bool active;
  final int amount;
  final String amountDecimal;
  final String billingScheme;
  final int created;
  final String currency;
  final String interval;
  final int intervalCount;
  final String product;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'active': active,
      'amount': amount,
      'amount_decimal': amountDecimal,
      'billing_scheme': billingScheme,
      'created': created,
      'currency': currency,
      'interval': interval,
      'interval_count': intervalCount,
      'product': product,
    };
  }
}
