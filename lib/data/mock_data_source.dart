import 'package:injectable/injectable.dart';
import '../models/restaurant_model.dart';
import '../models/menu_item_model.dart';

@lazySingleton
class MockDataSource {
  Future<List<RestaurantModel>> getRestaurants() async {
    await Future.delayed(const Duration(seconds: 2));

    return [
      const RestaurantModel(
        id: '1',
        name: 'The Italian Corner',
        imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5',
        rating: 4.8,
        cuisine: 'Italian',
        deliveryTime: '25-35 min',
        deliveryFee: 2.99,
        minimumOrder: 15.0,
        isOpen: true,
        tags: ['Italian', 'Pizza', 'Pasta', 'Popular'],
      ),
      const RestaurantModel(
        id: '2',
        name: 'Sushi Master',
        imageUrl:
            'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351',
        rating: 4.9,
        cuisine: 'Japanese',
        deliveryTime: '30-40 min',
        deliveryFee: 3.99,
        minimumOrder: 20.0,
        isOpen: true,
        tags: ['Japanese', 'Sushi', 'Healthy', 'Premium'],
      ),
      const RestaurantModel(
        id: '3',
        name: 'Burger Palace',
        imageUrl:
            'https://images.unsplash.com/photo-1571091718767-18b5b1457add',
        rating: 4.5,
        cuisine: 'American',
        deliveryTime: '20-30 min',
        deliveryFee: 1.99,
        minimumOrder: 10.0,
        isOpen: true,
        tags: ['American', 'Burgers', 'Fast Food', 'Popular'],
      ),
      const RestaurantModel(
        id: '4',
        name: 'Spice Garden',
        imageUrl:
            'https://images.unsplash.com/photo-1585937421612-70a008356fbe',
        rating: 4.7,
        cuisine: 'Indian',
        deliveryTime: '35-45 min',
        deliveryFee: 2.49,
        minimumOrder: 18.0,
        isOpen: true,
        tags: ['Indian', 'Curry', 'Vegetarian', 'Spicy'],
      ),
      const RestaurantModel(
        id: '5',
        name: 'Taco Fiesta',
        imageUrl:
            'https://images.unsplash.com/photo-1565299585323-38d6b0865b47',
        rating: 4.6,
        cuisine: 'Mexican',
        deliveryTime: '25-35 min',
        deliveryFee: 2.99,
        minimumOrder: 12.0,
        isOpen: false,
        tags: ['Mexican', 'Tacos', 'Spicy', 'Popular'],
      ),
    ];
  }

  Future<List<MenuItemModel>> getMenuItems(String restaurantId) async {
    await Future.delayed(const Duration(seconds: 1));

    final menuItems = {
      '1': [
        const MenuItemModel(
          id: '1-1',
          restaurantId: '1',
          name: 'Margherita Pizza',
          description:
              'Fresh mozzarella, tomato sauce, basil, extra virgin olive oil',
          imageUrl:
              'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
          price: 12.99,
          category: 'Pizza',
          isVegetarian: true,
          isAvailable: true,
          customizationOptions: [
            'Extra Cheese',
            'No Basil',
            'Gluten Free Crust'
          ],
        ),
        const MenuItemModel(
          id: '1-2',
          restaurantId: '1',
          name: 'Pepperoni Pizza',
          description: 'Pepperoni, mozzarella cheese, tomato sauce',
          imageUrl:
              'https://images.unsplash.com/photo-1628840042765-356cda07504e',
          price: 14.99,
          category: 'Pizza',
          isVegetarian: false,
          isAvailable: true,
          customizationOptions: [
            'Extra Pepperoni',
            'Light Cheese',
            'Thick Crust'
          ],
        ),
        const MenuItemModel(
          id: '1-3',
          restaurantId: '1',
          name: 'Fettuccine Alfredo',
          description: 'Creamy parmesan sauce with fettuccine pasta',
          imageUrl:
              'https://images.unsplash.com/photo-1645112411341-6c4fd023714a',
          price: 13.99,
          category: 'Pasta',
          isVegetarian: true,
          isAvailable: true,
          customizationOptions: [
            'Add Chicken',
            'Extra Sauce',
            'Gluten Free Pasta'
          ],
        ),
        const MenuItemModel(
          id: '1-4',
          restaurantId: '1',
          name: 'Caesar Salad',
          description: 'Romaine lettuce, parmesan, croutons, caesar dressing',
          imageUrl: 'https://images.unsplash.com/photo-1550304943-4f24f54ddde9',
          price: 8.99,
          category: 'Salads',
          isVegetarian: true,
          isAvailable: true,
          customizationOptions: [
            'Add Grilled Chicken',
            'No Croutons',
            'Extra Dressing'
          ],
        ),
      ],
      '2': [
        const MenuItemModel(
          id: '2-1',
          restaurantId: '2',
          name: 'Salmon Sashimi',
          description: 'Fresh Atlantic salmon, 6 pieces',
          imageUrl: 'https://images.unsplash.com/photo-1534482421-64566f976cfa',
          price: 16.99,
          category: 'Sashimi',
          isVegetarian: false,
          isAvailable: true,
          customizationOptions: [
            'Extra Wasabi',
            'No Ginger',
            'Extra Soy Sauce'
          ],
        ),
        const MenuItemModel(
          id: '2-2',
          restaurantId: '2',
          name: 'California Roll',
          description: 'Crab, avocado, cucumber, 8 pieces',
          imageUrl:
              'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351',
          price: 12.99,
          category: 'Rolls',
          isVegetarian: false,
          isAvailable: true,
          customizationOptions: ['Inside Out', 'No Cucumber', 'Spicy Mayo'],
        ),
        const MenuItemModel(
          id: '2-3',
          restaurantId: '2',
          name: 'Vegetable Tempura',
          description: 'Assorted vegetables, lightly battered and fried',
          imageUrl:
              'https://images.unsplash.com/photo-1604259597308-5321e8e4789c',
          price: 9.99,
          category: 'Appetizers',
          isVegetarian: true,
          isAvailable: true,
          customizationOptions: ['Extra Sauce', 'No Broccoli', 'Light Batter'],
        ),
      ],
      '3': [
        const MenuItemModel(
          id: '3-1',
          restaurantId: '3',
          name: 'Classic Cheeseburger',
          description: 'Beef patty, cheddar cheese, lettuce, tomato, onion',
          imageUrl:
              'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
          price: 10.99,
          category: 'Burgers',
          isVegetarian: false,
          isAvailable: true,
          customizationOptions: ['Double Patty', 'No Onions', 'Add Bacon'],
        ),
        const MenuItemModel(
          id: '3-2',
          restaurantId: '3',
          name: 'Crispy Chicken Sandwich',
          description: 'Fried chicken breast, coleslaw, pickles, mayo',
          imageUrl:
              'https://images.unsplash.com/photo-1606755962773-d324e0a13086',
          price: 11.99,
          category: 'Sandwiches',
          isVegetarian: false,
          isAvailable: true,
          customizationOptions: [
            'Grilled Instead',
            'Extra Pickles',
            'Spicy Mayo'
          ],
        ),
        const MenuItemModel(
          id: '3-3',
          restaurantId: '3',
          name: 'Sweet Potato Fries',
          description: 'Crispy sweet potato fries with chipotle aioli',
          imageUrl:
              'https://images.unsplash.com/photo-1630431341973-02e1b662ec35',
          price: 5.99,
          category: 'Sides',
          isVegetarian: true,
          isAvailable: true,
          customizationOptions: ['Extra Crispy', 'No Salt', 'Ranch Instead'],
        ),
      ],
    };

    return menuItems[restaurantId] ?? [];
  }
}
