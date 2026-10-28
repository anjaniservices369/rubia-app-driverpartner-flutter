/// The kind of location permission to ask about.
enum LocationPermissionLevel {
  /// The platform's default location permission.
  location,

  /// Location access only while the app is in use.
  locationWhenInUse,

  /// Location access at all times, including in the background.
  locationAlways,
}

/// Whether the user has granted a [LocationPermissionLevel].
enum PermissionStatus {
  /// The status could not be determined.
  unknown,

  /// The user denied the permission.
  denied,

  /// The user granted the permission.
  granted,

  /// The OS restricts the permission and the user cannot change it.
  restricted,
}

/// Whether the device's location services are switched on.
enum ServiceStatus {
  /// The status could not be determined.
  unknown,

  /// Location services are switched off.
  disabled,

  /// Location services are switched on.
  enabled,

  /// Location services do not apply on this platform or device.
  notApplicable,
}
