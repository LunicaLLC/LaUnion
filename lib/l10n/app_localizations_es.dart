// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'La Unión Food Truck';

  @override
  String get heroTitle => 'Pupusería y Taquería';

  @override
  String get heroSubtitle => 'Auténtica Comida Salvadoreña';

  @override
  String get heroDescription =>
      'Negocio familiar. Llevando el sabor de casa a ti.';

  @override
  String get btnOrderNow => 'Ordenar Ahora';

  @override
  String get btnFindTruck => 'Ubicar Camión';

  @override
  String get homeLocationTitle => 'Ubicación en Vivo';

  @override
  String get mapComingSoon => 'Integración de Mapa Próximamente';

  @override
  String get currentLocationLabel => 'Ubicación Actual:';

  @override
  String get nextDepartureLabel => 'Próxima Salida:';

  @override
  String get notifyMe => 'Notificarme';

  @override
  String get menuTitle => 'Nuestro Menú';

  @override
  String get cartTitle => 'Tu Carrito';

  @override
  String get checkoutTitle => 'Pagar';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get orderHistoryTitle => 'Historial de Pedidos';

  @override
  String get loyaltyTitle => 'Programa de Lealtad';

  @override
  String get signIn => 'Iniciar Sesión';

  @override
  String get signUp => 'Registrarse';

  @override
  String get signOut => 'Cerrar Sesión';

  @override
  String get adminDashboard => 'Panel de Administración';

  @override
  String get footerRights =>
      '© 2024 La Unión Food Truck. Todos los derechos reservados.';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get termsOfService => 'Términos de Servicio';

  @override
  String get restartApp => 'Reiniciar Aplicación';

  @override
  String get navHome => 'Inicio';

  @override
  String get navMenu => 'Menú';

  @override
  String get navLocation => 'Ubicación';

  @override
  String get navLoyalty => 'Lealtad';

  @override
  String get navProfile => 'Perfil';

  @override
  String get navAbout => 'Nosotros';

  @override
  String get signInButton => 'Iniciar Sesión';

  @override
  String get cateringTitle => 'Servicios de Catering';

  @override
  String get cateringHeadline => 'Lleva La Unión a Tu Evento';

  @override
  String get cateringSubtitle =>
      'Sabores auténticos para tus ocasiones especiales';

  @override
  String get fullName => 'Nombre Completo';

  @override
  String get email => 'Correo Electrónico';

  @override
  String get phone => 'Teléfono';

  @override
  String get eventDate => 'Fecha del Evento';

  @override
  String get guestCount => 'Número de Invitados';

  @override
  String get additionalDetails => 'Detalles Adicionales';

  @override
  String get requestSent => '¡Solicitud de Catering Enviada!';

  @override
  String get submitRequest => 'Enviar Solicitud';

  @override
  String get checkout => 'Pagar';

  @override
  String get orderReview => 'Revisar Orden';

  @override
  String itemCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Artículos',
      one: '1 Artículo',
    );
    return '$_temp0';
  }

  @override
  String get pickupTime => 'Hora de Recogida';

  @override
  String get customerInfo => 'Información del Cliente';

  @override
  String get payment => 'Pago';

  @override
  String get cancel => 'Cancelar';

  @override
  String get back => 'Atrás';

  @override
  String get placeOrder => 'Realizar Orden';

  @override
  String get continueStep => 'Continuar';

  @override
  String get yourOrder => 'Tu Orden';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get tax => 'Impuesto';

  @override
  String get total => 'Total';

  @override
  String get specialInstructions => 'Instrucciones Especiales';

  @override
  String get specialInstructionsHint => 'Alergias, salsa extra, etc.';

  @override
  String get pickupOptions => 'Opciones de Recogida';

  @override
  String get asap => 'Lo antes posible';

  @override
  String get readyInMinutes => 'Listo en ~20 minutos';

  @override
  String get scheduleForLater => 'Programar para después';

  @override
  String get choosePickupTime => 'Elige una hora específica';

  @override
  String get selectPickupTime => 'Seleccionar Hora';

  @override
  String get contactInfo => 'Información de Contacto';

  @override
  String get phoneNumber => 'Número de Teléfono';

  @override
  String get emailOptional => 'Correo Electrónico (Opcional)';

  @override
  String get paymentMethod => 'Método de Pago';

  @override
  String get payWhenPickup => 'Pagar al recoger';

  @override
  String get useLoyaltyPoints => 'Usar Puntos de Lealtad';

  @override
  String pointsAvailable(Object points) {
    return '$points puntos disponibles';
  }

  @override
  String get redeemPoints => 'Canjear 1000 puntos por \$5.00 de descuento';

  @override
  String get orderSummary => 'Resumen de la Orden';

  @override
  String get loyaltyDiscount => 'Descuento por Lealtad';

  @override
  String get methodCard => 'Tarjeta';

  @override
  String get methodCash => 'Efectivo';

  @override
  String get methodApplePay => 'Apple Pay';

  @override
  String get methodGooglePay => 'Google Pay';

  @override
  String placeOrderFailed(Object error) {
    return 'Error al realizar la orden: $error';
  }

  @override
  String get shareReferralLink => 'Compartir enlace de referencia';

  @override
  String get viewAllActivity => 'Ver toda la actividad';

  @override
  String copiedToClipboard(Object text) {
    return 'Copiado al portapapeles: $text';
  }

  @override
  String shareYourCode(Object code) {
    return 'Comparte tu código: $code';
  }

  @override
  String get signInToAccessProfile => 'Inicia sesión para acceder a tu perfil';

  @override
  String get createAccount => 'Crear Cuenta';

  @override
  String get customer => 'Cliente';

  @override
  String get ordersCount => 'Pedidos';

  @override
  String get points => 'Puntos';

  @override
  String get memberSince => 'Miembro Desde';

  @override
  String get personalInformation => 'Información Personal';

  @override
  String get quickActionsLabel => 'Acciones Rápidas';

  @override
  String get orderHistory => 'Historial de Pedidos';

  @override
  String get findTruck => 'Buscar Camión';

  @override
  String get settings => 'Configuración';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get helpSupport => 'Ayuda y Soporte';

  @override
  String get profileUpdated => 'Perfil actualizado exitosamente';

  @override
  String profileUpdateFailed(Object error) {
    return 'Error al actualizar perfil: $error';
  }

  @override
  String get signOutConfirmation =>
      '¿Estás seguro de que quieres cerrar sesión?';

  @override
  String get pleaseSignInOrders => 'Inicia sesión para ver tus pedidos';

  @override
  String get noOrdersYet => 'Aún no hay pedidos';

  @override
  String get viewDetails => 'Ver Detalles';

  @override
  String get reorder => 'Pedir de Nuevo';

  @override
  String get viewReceipt => 'Ver Recibo';

  @override
  String get needHelpOrder => '¿Necesitas ayuda con este pedido?';

  @override
  String get featuredItems => 'Platos Destacados';

  @override
  String get viewFullMenu => 'VER MENÚ COMPLETO';

  @override
  String get customerLove => 'Amor de Clientes';

  @override
  String get customerReview1 =>
      '¡Las mejores pupusas de la ciudad! Me recuerda a casa.';

  @override
  String get customerReview2 =>
      'Los tacos al pastor son increíbles. ¡Tienes que probarlos!';

  @override
  String get customerReview3 =>
      'Gran servicio y comida increíble. ¡Amo este camión!';

  @override
  String get joinLoyaltyProgram => 'Únete a Nuestro Programa de Lealtad';

  @override
  String get loyaltyDescription =>
      '¡Gana puntos con cada compra y obtén comidas gratis!';

  @override
  String get signUpNow => 'Regístrate Ahora';

  @override
  String get welcomeBack => 'Bienvenido de Nuevo';

  @override
  String get password => 'Contraseña';

  @override
  String get noAccountSignUp => '¿No tienes una cuenta? Regístrate';

  @override
  String get alreadyHaveAccountSignIn => '¿Ya tienes una cuenta? Inicia Sesión';

  @override
  String get interactiveMap => 'Mapa Interactivo';

  @override
  String get googleMapsIntegration => 'Integración con Google Maps';

  @override
  String get currentLocationUppercase => 'UBICACIÓN ACTUAL';

  @override
  String get weeklyScheduleUppercase => 'HORARIO SEMANAL';

  @override
  String get getNotified => 'Recibir Notificaciones';

  @override
  String get getNotifiedDescription =>
      'Recibe una notificación cuando lleguemos a tu lugar favorito';

  @override
  String get enableNotifications => 'Habilitar Notificaciones';

  @override
  String get statusOpen => 'ABIERTO';

  @override
  String get statusClosed => 'CERRADO';

  @override
  String get subscribe => 'Suscribirse';

  @override
  String get notificationsEnabled => '¡Notificaciones habilitadas!';

  @override
  String openingInMaps(Object address) {
    return 'Abriendo $address en mapas...';
  }

  @override
  String get enterPhoneNumberNotification =>
      'Ingresa tu número de teléfono para recibir notificaciones cuando lleguemos:';

  @override
  String get getNotificationsDialogTitle => 'Obtener Notificaciones';

  @override
  String get monday => 'Lunes';

  @override
  String get tuesday => 'Martes';

  @override
  String get wednesday => 'Miércoles';

  @override
  String get thursday => 'Jueves';

  @override
  String get friday => 'Viernes';

  @override
  String get saturday => 'Sábado';

  @override
  String get sunday => 'Domingo';

  @override
  String get mondayAbbr => 'L';

  @override
  String get tuesdayAbbr => 'M';

  @override
  String get wednesdayAbbr => 'X';

  @override
  String get thursdayAbbr => 'J';

  @override
  String get fridayAbbr => 'V';

  @override
  String get saturdayAbbr => 'S';

  @override
  String get sundayAbbr => 'D';

  @override
  String get cartEmpty => 'Tu carrito está vacío';

  @override
  String notePrefix(Object note) {
    return 'Nota: $note';
  }

  @override
  String get aboutUs => 'Sobre Nosotros';

  @override
  String get aboutDescription =>
      'La Union Food Truck trae lo mejor de la cocina salvadoreña y mexicana para ti.';

  @override
  String requiredField(Object field) {
    return 'Por favor ingrese $field';
  }

  @override
  String get orderStatusTitle => 'Estado del Pedido';

  @override
  String estimatedPickup(Object time) {
    return 'Hora estimada de recogida: $time';
  }

  @override
  String get orderProgress => 'Progreso del Pedido';

  @override
  String get orderDetails => 'Detalles del Pedido';

  @override
  String get orderNumber => 'Número de Pedido';

  @override
  String get placed => 'Realizado';

  @override
  String get pickupTimeLabel => 'Hora de Recogida';

  @override
  String get paymentMethodLabel => 'Método de Pago';

  @override
  String get orderReceived => 'Pedido Recibido';

  @override
  String get orderPreparing => 'Preparando tu Pedido';

  @override
  String get orderReady => '¡Listo para Recoger!';

  @override
  String get orderCompleted => 'Pedido Completado';

  @override
  String get orderCancelled => 'Pedido Cancelado';

  @override
  String get orderAgain => 'Pedir de Nuevo';

  @override
  String get statusReceived => 'Recibido';

  @override
  String get statusPreparing => 'Preparando';

  @override
  String get statusReady => 'Listo';

  @override
  String get statusCompleted => 'Completado';

  @override
  String get signInToEarnPoints => 'Inicia sesión para comenzar a ganar puntos';

  @override
  String get keepEating => '¡Sigue comiendo, sigue ganando!';

  @override
  String get availableRewards => 'RECOMPENSAS DISPONIBLES';

  @override
  String get referFriend => 'Refiere a un Amigo';

  @override
  String get referralDescription =>
      '¡Comparte tu código de referencia y ambos obtendrán 250 puntos!';

  @override
  String get yourReferralCode => 'Tu código de referencia:';

  @override
  String get recentActivity => 'ACTIVIDAD RECIENTE';

  @override
  String get pointsUppercase => 'PUNTOS';

  @override
  String get unlocked => 'DESBLOQUEADO';

  @override
  String get toGo => 'FALTAN';

  @override
  String get locked => 'BLOQUEADO';

  @override
  String get transPurchase => 'Compra de Pedido';

  @override
  String get transReferral => 'Referencia de Amigo';

  @override
  String get transRedemption => 'Canje de Recompensa';

  @override
  String get transBonus => 'Puntos de Bonificación';

  @override
  String get rewardFreeDrink => 'Bebida Gratis';

  @override
  String get rewardFreePupusa => 'Pupusa/Taco Gratis';

  @override
  String get rewardTenOff => '\$10 de Descuento';

  @override
  String get rewardFamilyMeal => 'Comida Familiar';

  @override
  String get searchMenuHint => 'Buscar en el menú...';

  @override
  String get allCategories => 'Todos';

  @override
  String get noItemsFound => 'No se encontraron artículos';

  @override
  String addedToCart(Object name) {
    return 'Se añadió $name al carrito';
  }

  @override
  String welcomeBackUser(Object name) {
    return '¡Bienvenido de nuevo, $name!';
  }

  @override
  String get addToCart => 'Agregar al Carrito';

  @override
  String get quantityLabel => 'Cantidad';

  @override
  String get modifiersLabel => 'Extras';

  @override
  String get ingredientsLabel => 'Ingredientes';
}
