# Food Delivery App

A Flutter-based food delivery application with a complete ordering workflow, built using BLoC architecture and following SOLID principles.

## Features

- Browse restaurants with search functionality
- View restaurant menus with categories
- Add items to cart with customizations
- Complete checkout process with address and payment
- Order tracking with status updates
- Beautiful animations and UI transitions
- Shimmer loading effects
- Cached network images
- Comprehensive error handling

## Architecture

This app follows Clean Architecture principles with the following layers:

### Domain Layer
- Entities: Core business objects
- Repositories: Abstract interfaces
- Use Cases: Business logic

### Data Layer
- Models: Data transfer objects
- Repositories Implementation
- Data Sources: Mock data for demonstration

### Presentation Layer
- BLoC: State management
- Pages: Screen widgets
- Widgets: Reusable UI components

## State Management

The app uses BLoC (Business Logic Component) pattern for state management:
- `RestaurantBloc`: Manages restaurant and menu data
- `CartBloc`: Handles shopping cart operations
- `OrderBloc`: Manages order placement and tracking

## Key Dependencies

- `flutter_bloc`: State management
- `cached_network_image`: Image caching
- `shimmer`: Loading animations
- `flutter_animate`: UI animations
- `get_it` & `injectable`: Dependency injection
- `dartz`: Functional programming
- `freezed`: Code generation for models
- `equatable`: Value equality

## Getting Started

1. Clone the repository
2. Run `flutter pub get`
3. Run `flutter pub run build_runner build --delete-conflicting-outputs`
4. Run the app using `flutter run`

## Testing

The app includes unit tests for BLoCs and widget tests:

