import 'package:equatable/equatable.dart';

import '../../model/reports/monthly_payment_transaction_dto.dart';

abstract class StationEvent extends Equatable{

  const StationEvent();

  @override
  List<Object?> get props => [];
}

class InitStationEvent extends StationEvent {
  const InitStationEvent();
}

class GetTotalStationPaymentTransactionsEvent extends StationEvent{
  final DateTime filterFromDate;
  final DateTime filterToDate;
  final bool filterByDate;
  const GetTotalStationPaymentTransactionsEvent(this.filterByDate, this.filterFromDate, this.filterToDate);

  @override
  List<Object?> get props => [this.filterByDate, this.filterFromDate, this.filterToDate];
}

class GetStationPaymentTransactionsEvent extends StationEvent{
  final DateTime filterFromDate;
  final DateTime filterToDate;
  final bool filterByDate;
  final int page;
  const GetStationPaymentTransactionsEvent(this.filterByDate, this.filterFromDate, this.filterToDate, this.page);

  @override
  List<Object?> get props => [this.filterByDate, this.filterFromDate, this.filterToDate, this.page];
}

class ClearStationTransactionsEvent extends StationEvent {
  const ClearStationTransactionsEvent();
}

class GetMonthlyStationPaymentTransactionsEvent extends StationEvent{
  final int page;
  const GetMonthlyStationPaymentTransactionsEvent(this.page);

  @override
  List<Object?> get props => [this.page];
}

class GetMonthlyPaymentTransactionPDFEvent extends StationEvent {
  final List<MonthlyPaymentTransactionDto> monthlyPaymentTransactionList;

  const GetMonthlyPaymentTransactionPDFEvent(this.monthlyPaymentTransactionList);

  @override
  List<Object?> get props => [this.monthlyPaymentTransactionList];
}

class GetPaymentTransactionsPDFEvent extends StationEvent{
  final DateTime filterFromDate;
  final DateTime filterToDate;
  final bool filterByDate;
  const GetPaymentTransactionsPDFEvent(this.filterByDate, this.filterFromDate, this.filterToDate);

  @override
  List<Object?> get props => [this.filterByDate, this.filterFromDate, this.filterToDate];
}

class GetAllStationsByGroup extends StationEvent{
  final int page;
  final DateTime filterFromDate;
  final DateTime filterToDate;
  final bool filterByDate;

  const GetAllStationsByGroup(this.page, this.filterByDate, this.filterFromDate, this.filterToDate);

  @override
  List<Object?> get props => [this.page, this.filterByDate, this.filterFromDate, this.filterToDate];
}


class GetTotalStationPaymentTransactionsEventByCompanyId extends StationEvent{
  final DateTime filterFromDate;
  final DateTime filterToDate;
  final bool filterByDate;
  final int companyId;
  const GetTotalStationPaymentTransactionsEventByCompanyId(this.filterByDate, this.filterFromDate, this.filterToDate, this.companyId);

  @override
  List<Object?> get props => [this.filterByDate, this.filterFromDate, this.filterToDate, this.companyId];
}

class GetStationPaymentTransactionsEventByCompanyId extends StationEvent{
  final DateTime filterFromDate;
  final DateTime filterToDate;
  final bool filterByDate;
  final int page;
  final int companyId;
  const GetStationPaymentTransactionsEventByCompanyId(this.filterByDate, this.filterFromDate, this.filterToDate, this.page, this.companyId);

  @override
  List<Object?> get props => [this.filterByDate, this.filterFromDate, this.filterToDate, this.page, this.companyId];
}


class GetMonthlyPaymentTransactionPDFByCompanyIdEvent extends StationEvent {
  final List<MonthlyPaymentTransactionDto> monthlyPaymentTransactionList;
  final int companyId;

  const GetMonthlyPaymentTransactionPDFByCompanyIdEvent(this.monthlyPaymentTransactionList, this.companyId);

  @override
  List<Object?> get props => [this.monthlyPaymentTransactionList, this.companyId];
}

class GetPaymentTransactionsPDFByCompanyIdEvent extends StationEvent{
  final DateTime filterFromDate;
  final DateTime filterToDate;
  final bool filterByDate;
  final int companyId;
  const GetPaymentTransactionsPDFByCompanyIdEvent(this.filterByDate, this.filterFromDate, this.filterToDate, this.companyId);

  @override
  List<Object?> get props => [this.filterByDate, this.filterFromDate, this.filterToDate, this.companyId];
}

class GetMonthlyStationPaymentTransactionsByCompanyIdEvent extends StationEvent{
  final int page;
  final int companyId;

  const GetMonthlyStationPaymentTransactionsByCompanyIdEvent(this.page, this.companyId);

  @override
  List<Object?> get props => [this.page, this.companyId];
}




