part of 'contact_manager_cubit.dart';

sealed class ContactManagerState extends Equatable {
  const ContactManagerState();

  @override
  List<Object> get props => [];
}

final class ContactManagerInitial extends ContactManagerState {}

final class ContactDataLoading extends ContactManagerState {}

final class ContactDataLoadingSuccess extends ContactManagerState {}

final class ContactDataLoadingFailed extends ContactManagerState {}

final class ContactCrudOptInitiate extends ContactManagerState {}

final class ContactCrudOptSuccess extends ContactManagerState {}

final class ContactCrudOptFailed extends ContactManagerState {}
