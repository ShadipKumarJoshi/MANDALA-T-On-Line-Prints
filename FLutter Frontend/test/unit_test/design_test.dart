import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/design/domain/entity/design_entity.dart';
import 'package:final_assignment/features/design/domain/usecases/design_usecase.dart';
import 'package:final_assignment/features/design/presentation/viewmodel/design_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'design_test.mocks.dart';
import 'test_data/design_entity_data.dart';

@GenerateNiceMocks([
  MockSpec<DesignUseCase>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late DesignUseCase mockDesignUsecase;
  late List<DesignEntity> lstDesigns;

  setUp(() {
    mockDesignUsecase = MockDesignUseCase();
    lstDesigns = DesignTestData.getDesignTestData();

    container = ProviderContainer(
      overrides: [
        designViewModelProvider.overrideWith(
          // named parameter use vako le designUseCase: mockDesignUsecase
          (ref) => DesignViewModel(designUseCase: mockDesignUsecase),
        )
      ],
    );
  });

// Test initial state
  test('check Design initial state', () async {
    when(mockDesignUsecase.getPaginationDesigns(1, 2))
        .thenAnswer((_) => Future.value(Right(lstDesigns)));
  });

  //  test('check Design initial state', () {
  //   final designViewModel = container.read(designViewModelProvider.notifier);
  //   final designState = container.read(designViewModelProvider);

  //   expect(designState, equals(DesignState.initial()));
  // });

// TEST 1
  test('fetchDesigns updates state correctly on success', () async {
    when(mockDesignUsecase.getPaginationDesigns(1, 12))
        .thenAnswer((_) async => Right(lstDesigns));

// fetch all designs
    await container.read(designViewModelProvider.notifier).fetchDesigns();

// store the state
    final designState = container.read(designViewModelProvider);

// check the state
    expect(designState.designs, equals(lstDesigns));
    expect(designState.page, equals(1));
    expect(designState.isLoading, equals(false));
    expect(designState.hasReachedMax, equals(false));
  });

// TEST 2
  test('fetchDesigns updates state correctly on empty data', () async {
    when(mockDesignUsecase.getPaginationDesigns(1, 12))
        .thenAnswer((_) async => const Right([]));

    await container.read(designViewModelProvider.notifier).fetchDesigns();

    final designState = container.read(designViewModelProvider);

    expect(designState.designs, equals([]));
    expect(designState.page, equals(0));
    expect(designState.isLoading, equals(true));
    expect(designState.hasReachedMax, equals(true));
  });

// TEST 3
  test('fetchDesigns updates state correctly on failure', () async {
    final failure = Failure(error: "Failed to fetch designs");
    when(mockDesignUsecase.getPaginationDesigns(1, 12))
        .thenAnswer((_) async => Left(failure));

    await container.read(designViewModelProvider.notifier).fetchDesigns();

    final designState = container.read(designViewModelProvider);

    expect(designState.error, equals(failure.error));
    expect(designState.isLoading, equals(false));
    expect(designState.hasReachedMax, equals(true));
  });

// dispose the container from   provider
  tearDown(
    () {
      container.dispose();
    },
  );
}
