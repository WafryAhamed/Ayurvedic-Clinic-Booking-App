import 'package:flutter/material.dart';
import '../../../domain/entities/doctor.dart';
import '../../../domain/repositories/doctor_repository.dart'; // Restored
import '../../../data/repositories/doctor_repository_impl.dart';

/// Doctor provider state enum
enum DoctorState { initial, loading, success, empty, error }

/// Provider for managing doctor list and operations
class DoctorProvider extends ChangeNotifier {
  final DoctorRepository _repository = DoctorRepositoryImpl();

  // State
  DoctorState _state = DoctorState.initial;
  List<Doctor> _doctors = [];
  List<Doctor> _filteredDoctors = [];
  String? _errorMessage;

  // Getters
  DoctorState get state => _state;
  List<Doctor> get doctors =>
      _filteredDoctors.isEmpty ? _doctors : _filteredDoctors;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == DoctorState.loading;
  bool get isEmpty => _state == DoctorState.empty;
  bool get hasError => _state == DoctorState.error;

  /// Load all doctors
  Future<void> loadDoctors() async {
    _setState(DoctorState.loading);
    _errorMessage = null;

    try {
      final result = await _repository.getAllDoctors();

      if (result.isEmpty) {
        _setState(DoctorState.empty);
      } else {
        _doctors = result;
        _filteredDoctors = [];
        _setState(DoctorState.success);
      }
    } catch (e) {
      _errorMessage = 'Failed to load doctors. Please try again.';
      _setState(DoctorState.error);
    }
  }

  /// Search doctors by query
  Future<void> searchDoctors(String query) async {
    if (query.isEmpty) {
      _filteredDoctors = [];
      _setState(_doctors.isEmpty ? DoctorState.empty : DoctorState.success);
      return;
    }

    _setState(DoctorState.loading);
    _errorMessage = null;

    try {
      final result = await _repository.searchDoctors(query);

      if (result.isEmpty) {
        _filteredDoctors = [];
        _setState(DoctorState.empty);
      } else {
        _filteredDoctors = result;
        _setState(DoctorState.success);
      }
    } catch (e) {
      _errorMessage = 'Search failed. Please try again.';
      _setState(DoctorState.error);
    }
  }

  /// Filter doctors with criteria
  Future<void> filterDoctors({
    List<String>? specializations,
    int? minExperience,
    int? maxExperience,
    double? minFee,
    double? maxFee,
    double? minRating,
  }) async {
    _setState(DoctorState.loading);
    _errorMessage = null;

    try {
      final result = await _repository.filterDoctors(
        specializations: specializations,
        minExperience: minExperience,
        maxExperience: maxExperience,
        minFee: minFee,
        maxFee: maxFee,
        minRating: minRating,
      );

      if (result.isEmpty) {
        _filteredDoctors = [];
        _setState(DoctorState.empty);
      } else {
        _filteredDoctors = result;
        _setState(DoctorState.success);
      }
    } catch (e) {
      _errorMessage = 'Filter failed. Please try again.';
      _setState(DoctorState.error);
    }
  }

  /// Sort doctors
  void sortDoctors(DoctorSortBy sortBy, {bool ascending = true}) {
    final currentList = _filteredDoctors.isEmpty ? _doctors : _filteredDoctors;
    final sorted = _repository.sortDoctors(
      currentList,
      sortBy: sortBy,
      ascending: ascending,
    );

    if (_filteredDoctors.isEmpty) {
      _doctors = sorted;
    } else {
      _filteredDoctors = sorted;
    }

    notifyListeners();
  }

  /// Clear filters
  void clearFilters() {
    _filteredDoctors = [];
    _setState(_doctors.isEmpty ? DoctorState.empty : DoctorState.success);
  }

  /// Reset to initial state
  void reset() {
    _state = DoctorState.initial;
    _doctors = [];
    _filteredDoctors = [];
    _errorMessage = null;
    notifyListeners();
  }

  /// Set state and notify listeners
  void _setState(DoctorState newState) {
    _state = newState;
    notifyListeners();
  }
}
