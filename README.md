# Food Delivery App
A Flutter-based food delivery application with a complete ordering workflow, built using BLoC architecture and following SOLID principles.
Screenshots
<table>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/3d620162-f7f6-4645-97bf-c79d5f712248" width="250" alt="Cart Screen"/>
      <br/>
      <sub><b>Cart Screen</b></sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/f548b561-e94c-4408-9c81-5624b999dbf8" width="250" alt="Checkout Screen"/>
      <br/>
      <sub><b>Checkout Screen</b></sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/f95ad559-6a2b-4a16-9971-df84d2901838" width="250" alt="Track Order Screen"/>
      <br/>
      <sub><b>Track Order Screen</b></sub>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/89e8e734-3492-4f56-a52a-0001eee039c3" width="250" alt="Home Screen"/>
      <br/>
      <sub><b>Home Screen</b></sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/3f1b0bc7-faac-4c94-85ec-ba9047c44a79" width="250" alt="Restaurant Details Screen"/>
      <br/>
      <sub><b>Restaurant Details Screen</b></sub>
    </td>
    <td align="center">
      <!-- Add more screenshots here if needed -->
    </td>
  </tr>
</table>

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

