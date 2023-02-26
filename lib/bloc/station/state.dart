import 'package:equatable/equatable.dart';
import 'package:fastfill_station_app/model/station/stations_with_pagination.dart';

import '../../model/reports/report_url.dart';
import '../../model/station/monthly_station_payment_transactions_with_pagination.dart';
import '../../model/station/station_payment_transactions_with_pagination.dart';
import '../../model/station/total_station_payment_transactions.dart';

abstract class StationState extends Equatable{

  const StationState();

  @override
  List<Object?> get props => [];
}

class InitStationState extends StationState{
  const InitStationState();
}

class LoadingStationState extends StationState{
  const LoadingStationState();
}


class ErrorStationState extends StationState{
  final String error;

  const ErrorStationState(this.error);

  @override
  List<Object?> get props => [this.error];
}

class GotTotalStationPaymentTransactionsState extends StationState{
  final TotalStationPaymentTransactions totalStationPaymentTransactions;

  const GotTotalStationPaymentTransactionsState(this.totalStationPaymentTransactions);

  @override
  List<Object?> get props => [this.totalStationPaymentTransactions];
}

class GotStationPaymentTransactionsState extends StationState{
  final StationPaymentTransactionsWithPagination stationPaymentTransactionsWithPagination;

  const GotStationPaymentTransactionsState(this.stationPaymentTransactionsWithPagination);

  @override
  List<Object?> get props => [this.stationPaymentTransactionsWithPagination];
}

class ClearedStationTransactionsState extends StationState {
  final bool result;

  const ClearedStationTransactionsState(this.result);

  @override
  List<Object?> get props => [this.result];
}

class GotMonthlyStationPaymentTransactionsState extends StationState{
  final MonthlyStationPaymentTransactionsWithPagination monthlyStationPaymentTransactionsWithPagination;

  const GotMonthlyStationPaymentTransactionsState(this.monthlyStationPaymentTransactionsWithPagination);

  @override
  List<Object?> get props => [this.monthlyStationPaymentTransactionsWithPagination];
}

class GotMonthlyPaymentTransactionPDFState extends StationState {
  final ReportURL reportURL;

  const GotMonthlyPaymentTransactionPDFState(this.reportURL);

  @override
  List<Object?> get props => [this.reportURL];
}

class GotPaymentTransactionPDFState extends StationState {
  final ReportURL reportURL;

  const GotPaymentTransactionPDFState(this.reportURL);

  @override
  List<Object?> get props => [this.reportURL];
}

class GotAllStationsByGroup extends StationState {
  final StationsWithPagination stationsWithPagination;

  const GotAllStationsByGroup(this.stationsWithPagination);

  @override
  List<Object?> get props => [this.stationsWithPagination];
}
