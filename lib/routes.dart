enum AppRoutes {
  OnboardingScreen("OnboardingScreen"),
  AppOnboardingScreen("AppOnboardingScreen"),
  SplashScreen("SplashScreen"),
  RegisterScreen("Register"),
  LoginScreen("Login"),
  HomeScreen("Home"),
  EventDetails("EventDetails"),
  AddEventScreen("AddEvent");

  final String routeName;

  const AppRoutes(this.routeName);
}
