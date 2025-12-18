class NotificationService {
  Future<void> sendOrderConfirmation(String orderId, String phone, String email) async {
    // Mock implementation
    print('Sending confirmation for order $orderId to $phone, $email');
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> sendOrderReadyNotification(String orderId, String phone) async {
    // Mock implementation
    print('Sending ready notification for order $orderId to $phone');
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> sendLoyaltyPointsUpdate(String userId, int points, String phone) async {
    // Mock implementation
    print('Sending loyalty update: $points points to user $userId');
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> sendTruckLocationNotification(String location, String phone) async {
    // Mock implementation
    print('Sending truck location notification: $location to $phone');
    await Future.delayed(const Duration(seconds: 1));
  }
}