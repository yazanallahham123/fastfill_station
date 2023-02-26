
import 'dart:io';
import 'package:fastfill_station_app/model/station/monthly_station_payment_transactions_with_pagination.dart';
import 'package:fastfill_station_app/model/station/stations_with_pagination.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

import '../model/login/login_body.dart';
import '../model/login/login_user.dart';
import '../model/notification/notification_body.dart';
import '../model/notification/notifications_with_pagination.dart';
import '../model/otp/otp_resend_response_body.dart';
import '../model/otp/otp_send_response_body.dart';
import '../model/otp/otp_verify_response_body.dart';
import '../model/reports/monthly_payment_transaction_dto.dart';
import '../model/reports/report_url.dart';
import '../model/station/station_payment_transactions_with_pagination.dart';
import '../model/station/total_station_payment_transactions.dart';
import '../model/user/reset_password_body.dart';
import '../model/user/signedup_user.dart';
import '../model/user/signup_body.dart';
import '../model/user/update_firebase_token_body.dart';
import '../model/user/update_profile_body.dart';
import '../model/user/update_user_language_body.dart';
import '../model/user/upload_result.dart';
import 'apis.dart';
import 'package:http_parser/http_parser.dart';
part 'retrofit.g.dart';


@RestApi(baseUrl: Apis.baseURL)
@Headers(<String, dynamic>{"Content-Type": "application/json"})
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  //=========== Login ==============

  @POST(Apis.login)
  Future<LoginUser> loginUser(@Body() LoginBody loginBody);

  @PUT(Apis.user+"/resetPassword")
  Future<String> resetPassword(@Body() ResetPasswordBody? resetPasswordBody);

  //User
  @PUT(Apis.updateUserProfile)
  Future<String> updateUserProfile(@Header("Authorization") String token, @Body() UpdateProfileBody updateProfileBody);

  //User
  @PUT(Apis.updateFirebaseToken)
  Future<String> updateFirebaseToken(@Header("Authorization") String token, @Body() UpdateFirebaseTokenBody updateFirebaseTokenBody);

  //User
  @POST(Apis.addNotification)
  Future<bool> addNotification(@Header("Authorization") String token, @Body() NotificationBody notificationBody);

  //User
  @GET(Apis.getNotifications)
  Future<NotificationsWithPagination> getNotifications(@Header("Authorization") String token, @Query("page") int page, @Query("pageSize") int pageSize);

  @POST(Apis.uploadProfilePhoto)
  @MultiPart()
  @Headers(<String, dynamic>{"Content-Type":"multi-part/form-data", "accept":"*/*"})
  Future<UploadResult> uploadProfilePhoto(@Header("Authorization") String token, @Part(contentType: "image/*", name: "file") File file);

  @GET(Apis.getStationPaymentTransactions)
  Future<StationPaymentTransactionsWithPagination> getStationPaymentTransactions(@Header("Authorization") String token, @Query("page") int page, @Query("pageSize") int pageSize, @Query("filterByDate") bool filterByDate, @Query("filterFromDate") String filterFromDate, @Query("filterToDate") String filterToDate);

  @PUT(Apis.updateUserLanguage)
  Future<bool> updateUserLanguage(@Header("Authorization") String token, @Body() UpdateUserLanguageBody updateUserLanguageBody);

  @GET(Apis.clearUserNotifications)
  Future<bool> clearUserNotifications(@Header("Authorization") String token);

  @GET(Apis.clearUserTransactions)
  Future<bool> clearUserTransactions(@Header("Authorization") String token);

  @GET(Apis.getMonthlyStationPaymentTransactions)
  Future<MonthlyStationPaymentTransactionsWithPagination> getMonthlyStationPaymentTransactions(@Header("Authorization") String token, @Query("page") int page, @Query("pageSize") int pageSize);

  @GET(Apis.getTotalStationPaymentTransactions)
  Future<TotalStationPaymentTransactions> getTotalStationPaymentTransactions(@Header("Authorization") String token, @Query("filterByDate") bool filterByDate, @Query("filterFromDate") String filterFromDate, @Query("filterToDate") String filterToDate);

  @POST(Apis.user+"/companyUser")
  Future<SignedUpUser> signup(@Body() SignupBody? signupBody);

  @GET(Apis.showSignupInStationApp)
  Future<bool> showSignupInStationApp();

  @POST(Apis.getMonthlyCompanyPaymentTransactionsPDF)
  Future<ReportURL> getMonthlyCompanyPaymentTransactionsPDF(@Header("Authorization") String token, @Body() List<MonthlyPaymentTransactionDto> monthlyPaymentTransactions);

  @GET(Apis.getPaymentTransactionPDF)
  Future<ReportURL> getPaymentTransactionPDF(@Header("Authorization") String token, @Query("filterByDate") bool filterByDate, @Query("filterFromDate") String filterFromDate, @Query("filterToDate") String filterToDate);

  @GET(Apis.logout)
  Future<bool> logout(@Header("Authorization") String token);


  @GET(Apis.getMonthlyStationPaymentTransactionsByCompanyId)
  Future<MonthlyStationPaymentTransactionsWithPagination> getMonthlyStationPaymentTransactionsByCompanyId(@Header("Authorization") String token, @Query("page") int page, @Query("pageSize") int pageSize, @Query("companyId") int companyId);

  @GET(Apis.getTotalStationPaymentTransactionsByCompanyId)
  Future<TotalStationPaymentTransactions> getTotalStationPaymentTransactionsByCompanyId(@Header("Authorization") String token, @Query("filterByDate") bool filterByDate, @Query("filterFromDate") String filterFromDate, @Query("filterToDate") String filterToDate, @Query("companyId") int companyId);

  @POST(Apis.getMonthlyCompanyPaymentTransactionsPDFByCompanyId)
  Future<ReportURL> getMonthlyCompanyPaymentTransactionsPDFByCompanyId(@Header("Authorization") String token, @Body() List<MonthlyPaymentTransactionDto> monthlyPaymentTransactions, @Query("companyId") int companyId);

  @GET(Apis.getPaymentTransactionPDFByCompanyId)
  Future<ReportURL> getPaymentTransactionPDFByCompanyId(@Header("Authorization") String token, @Query("filterByDate") bool filterByDate, @Query("filterFromDate") String filterFromDate, @Query("filterToDate") String filterToDate, @Query("companyId") int companyId);

  //User
  @GET(Apis.getAllCompaniesByGroup)
  Future<StationsWithPagination> getAllCompaniesByGroup(@Header("Authorization") String token, @Query("page") int page, @Query("pageSize") int pageSize, @Query("filterByDate") bool filterByDate, @Query("filterFromDate") String filterFromDate, @Query("filterToDate") String filterToDate,);

  @GET(Apis.getStationPaymentTransactionsByCompanyId)
  Future<StationPaymentTransactionsWithPagination> getStationPaymentTransactionsByCompanyId(@Header("Authorization") String token, @Query("page") int page, @Query("pageSize") int pageSize, @Query("filterByDate") bool filterByDate, @Query("filterFromDate") String filterFromDate, @Query("filterToDate") String filterToDate, @Query("companyId") int companyId);

  @GET(Apis.otpSendCode)
  Future<String> otpSendCode(@Path("mobileNumber") String mobileNumber);

  @GET(Apis.otpVerifyCode)
  Future<bool> otpVerifyCode(@Path("registerId") String registerId, @Path("otpCode") String otpCode);

  @GET(Apis.checkUserByPhone)
  Future<bool> checkUserByPhone(@Path("mobileNumber") String mobileNumber);
}
