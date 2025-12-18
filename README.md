# La Unión Pupusería y Taquería - Flutter Web App

A complete food truck ordering system with a customer-facing website and an admin portal, built with Flutter Web.

## Features

### **Customer Features**
- **Menu Browsing** – View food items with filters and search
- **Online Ordering** – Add items to cart, customize, and checkout
- **Truck Locator** – Find current and upcoming truck locations
- **Loyalty Program** – Earn points with every purchase
- **Order Tracking** – Real-time order status updates
- **User Profile** – Manage account and view order history

### **Admin Features**
- **Order Management** – View and update order status
- **Menu Management** – Add, edit, or remove menu items
- **Schedule Management** – Update truck locations and hours
- **Analytics Dashboard** – View sales data and insights

## 🛠️ Tech Stack

| Layer             | Technology                          |
|-------------------|--------------------------------------|
| **Frontend**      | Flutter Web                          |
| **State Management** | Riverpod                             |
| **Routing**       | GoRouter                             |
| **Backend**       | Supabase (PostgreSQL + Auth + Storage) |
| **Hosting**       | Railway                              |
| **Payment**       | Stripe / Google Pay / Apple Pay      |

## 📁 Project Structure

```
lib/
├── main.dart
├── app.dart
├── router.dart
├── config/          # Configuration files
├── models/          # Data models
├── services/        # API and service classes
├── providers/       # Riverpod state providers
├── ui/
│   ├── layout/      # Layout components
│   ├── shared/      # Reusable UI components
│   ├── pages/       # Page widgets
│   └── widgets/     # Feature-specific widgets
└── utils/           # Utilities and helpers
```

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK** 3.8.1 or higher
- **Chrome browser** (for web development)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd launionweb
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run -d chrome
   ```

4. **Build for production**
   ```bash
   flutter build web
   ```

## 🔧 Environment Setup

Create a `.env` file in the root directory with the following variables:

```env
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
STRIPE_PUBLISHABLE_KEY=your_stripe_key
GOOGLE_MAPS_API_KEY=your_google_maps_key
```

## 🧑‍💻 Development

### Adding New Pages
1. Create the page in `ui/pages/`
2. Add the route in `router.dart`
3. Create corresponding providers if needed

### Adding New Models
1. Create the model in `models/`
2. Add to providers if state management is required
3. Update services for API integration

## 🎨 Design System

### Colors
| Color            | Hex       | Usage               |
|------------------|-----------|---------------------|
| Spicy Red        | `#E63946` | Primary             |
| Citrus Orange    | `#F77F00` | Secondary           |
| Corn Yellow      | `#FDC500` | Accent              |
| Avocado Green    | `#2A9D8F` | Success             |
| Off-white        | `#F8F8F8` | Background          |
| Charcoal         | `#333333` | Text                |

### Typography
- **Headings**: Poppins (600 weight)
- **Body**: Open Sans (400 weight)
- **Menu Items**: Poppins (500)
- **Prices**: Poppins (600)

### Spacing
8px grid system with increments: 4px, 8px, 16px, 24px, 32px, 48px.

## 🌐 Deployment

### Web Deployment
1. Build the project:
   ```bash
   flutter build web --release
   ```
2. Deploy the contents of `build/web` to your hosting service (Vercel, Netlify, Railway Static, etc.).

### Supabase Setup
1. Create a new Supabase project.
2. Run the SQL schema from `docs/schema.sql`.
3. Set up authentication and storage.
4. Update environment variables accordingly.

## 📄 License

Proprietary – All rights reserved.

