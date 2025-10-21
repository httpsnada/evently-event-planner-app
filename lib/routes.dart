enum AppRoutes {
  OnboardingScreen("OnboardingScreen"),
  SplashScreen("SplashScreen"),
  RegisterScreen("Register"),
  LoginScreen("Login"),
  HomeScreen("Home"),
  AddEventScreen("AddEvent");

  final String routeName;

  const AppRoutes(this.routeName);
}
