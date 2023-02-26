class Apis{

  //Base url
  static const String baseURL = "https://fastfillpro.developitech.com/api/";

  //  LOGIN
  static const String login = "Login";
  static const String showSignupInStationApp = "Login/ShowSignupInStationApp";

  //  USER
  static const String user = "User";
  static const String updateUserProfile = "User/UpdateUserProfile";
  static const String updateFirebaseToken = "User/UpdateFirebaseToken";
  static const String addNotification = "User/AddNotification";
  static const String getNotifications = "User/GetNotifications";
  static const String addPaymentTransaction = "User/AddPaymentTransaction";
  static const String getPaymentTransactions = "User/GetPaymentTransactions";
  static const String uploadProfilePhoto = "User/UploadLogo";
  //  OTP
  static const String otpSendCode = "User/SendOTP/{mobileNumber}";
  static const String otpVerifyCode = "User/VerifyOTP/{registerId}/{otpCode}";
  static const String checkUserByPhone = "User/CheckByPhone/{mobileNumber}";

  // Stations
  static const String station = "station";

  //Companies
  static const String company = "Company";
  static const String allCompanies = "Company/AllCompanies";
  static const String companyByText = "Company/CompaniesByText";
  static const String companiesByName = "Company/CompaniesByName";
  static const String allCompaniesBranches = "Company/AllCompaniesBranches";
  static const String companyBranches = "Company/CompanyBranches";
  static const String companyBranchByText = "Company/CompaniesBranchesByText";
  static const String companyBranchesByAddress = "Company/CompanyBranchesByAddress";
  static const String addCompanyToFavorite = "Company/AddToFavorite";
  static const String removeCompanyFromFavorite = "Company/RemoveFromFavorite";
  static const String favoriteCompaniesBranches = "Company/FavoriteCompaniesBranches";
  static const String frequentlyVisitedCompaniesBranches = "Company/FrequentlyVisitedCompaniesBranches";

  static const String favoriteCompanies = "Company/FavoriteCompanies";
  static const String frequentlyVisitedCompanies = "Company/FrequentlyVisitedCompanies";

  static const String addCompanyBranchToFavorite = "Company/AddBranchToFavorite";
  static const String removeCompanyBranchFromFavorite = "Company/RemoveBranchFromFavorite";

  static const String getStationPaymentTransactions = "Company/GetStationPaymentTransactions";
  static const String clearUserNotifications = "User/ClearNotifications";
  static const String updateUserLanguage = "User/UpdateUserLanguage";

  static const String clearUserTransactions = "User/ClearTransactions";
  static const String getMonthlyStationPaymentTransactions = "Company/GetMonthlyStationPaymentTransactions";
  static const String getTotalStationPaymentTransactions = "Company/GetTotalStationPaymentTransactions";

  static const String getMonthlyCompanyPaymentTransactionsPDF = "Company/GetMonthlyCompanyPaymentTransactionsPDF";
  static const String getPaymentTransactionPDF = "Company/GetStationPaymentTransactionsPDF";

  static const String logout = "User/Logout";

  static const String getMonthlyStationPaymentTransactionsByCompanyId = "Company/GetMonthlyStationPaymentTransactionsByCompanyId";
  static const String getTotalStationPaymentTransactionsByCompanyId = "Company/GetTotalStationPaymentTransactionsByCompanyId";
  static const String getMonthlyCompanyPaymentTransactionsPDFByCompanyId = "Company/GetMonthlyCompanyPaymentTransactionsPDFByCompanyId";
  static const String getPaymentTransactionPDFByCompanyId = "Company/GetStationPaymentTransactionsPDFByCompanyId";

  static const String getAllCompaniesByGroup = "Company/AllCompaniesByGroup";

  static const String getStationPaymentTransactionsByCompanyId = "Company/GetStationPaymentTransactionsByCompanyId";

}