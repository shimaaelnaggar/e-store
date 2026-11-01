# E-Store – Flutter E-commerce App

## 📱 Project Overview
e-Store is a Flutter-based e-commerce application designed to provide users with a complete online shopping experience, from browsing products to placing orders and completing payments.

## ✨Features

### Products
- Browse available products.
- Browse products by category.
- Search for products.
- View product details.
- Navigate through products using pagination.

###  Authentication
- User registration and login.
- Token-based authentication.
- Secure token storage using Flutter Secure Storage.
- Email verification using OTP.
- Resend OTP functionality.

### Shopping Cart
- Add products to the shopping cart.
- Update product quantities.
- Remove products from the cart.

### Location Selection & Delivery Address
- Select a delivery location using an interactive OpenStreetMap.
- Move and zoom the map to choose the desired location.
- Confirm the selected location using the Choose Location action.
- View the selected location's coordinates.
- Complete the delivery address through a form, including street, city, and other address details.
- Review the delivery address during checkout.

*Note: The selected map coordinates are displayed in the application, while the delivery address information submitted to the backend is collected through the address form.*

### Checkout & Orders
- Complete the checkout process.
- Create and place orders.
- View order details and receipts.

### Payment
- Integrate Paymob payment gateway.
- Complete the payment flow.

### Notifications
- View and manage notifications.

## 🏗️ Architecture
The application follows **Clean Architecture**, separating responsibilities into three main layers:

- **Presentation Layer:** UI components and state management using BLoC.
- **Domain Layer:** Business logic, entities, repository contracts, and use cases.
- **Data Layer:** Data models, remote data sources, and repository implementations.

## 🧰Tech Stack & Packages

- **Flutter & Dart**
- **State Management:** flutter_bloc
- **Networking:** Dio, HTTP
- **Dependency Injection:** GetIt
- **Navigation:** GoRouter
- **Functional Programming:** DartZ
- **Value Equality:** Equatable
- **Responsive UI:** Flutter ScreenUtil
- **Image Loading & Caching:** Cached Network Image
- **Secure Storage:** Flutter Secure Storage
- **Map Integration:** Flutter Map, OpenStreetMap, LatLong2
- **Location Services:** Geolocator
- **Debouncing:**  RxDart
- **Web Content:** WebView Flutter

## 📂 Project Structure

```text
lib/
├── core/
│   ├── constants/
│   ├── di/
│   ├── errors/
│   ├── network/
│   └── ...
│
└── features/
    ├── products/
    ├── categories/
    ├── cart/
    ├── Addresses/
    ├── checkout/
    ├── orders/
    ├── notifications/
    └── ...
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK
- Dart SDK

### Installation

1. Clone the repository:

```bash
git clone YOUR_REPOSITORY_URL
```

2. Navigate to the project directory:

```bash
cd store
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the application:

```bash
flutter run
```

## 📸 Screenshots

Add screenshots of the application below to showcase its main screens and features.

| Home | Products |
|:---:|:---:|
| ![Home](screenshots/home.png) | ![Products](screenshots/products.png) |

| Product Details | Categories |
|:---:|:---:|
| ![Product Details](screenshots/product_details.png) | ![Categories](screenshots/categories.png) |

| Cart | Location Selection |
|:---:|:---:|
| ![Cart](screenshots/cart.png) | ![Location Selection](screenshots/location.png) |

| Checkout | Payment |
|:---:|:---:|
| ![Checkout](screenshots/checkout.png) | ![Payment](screenshots/payment.png) |

| Orders | Notifications |
|:---:|:---:|
| ![Orders](screenshots/orders.png) | ![Notifications](screenshots/notifications.png) |

## 🔮Future Improvements

- Develop an Admin Dashboard.
- Add product management functionality (Create, Update, and Delete products).
- Improve error handling and user-friendly error messages.
- Refactor and further improve the code structure and performance.
- Add products to the wishlist.
