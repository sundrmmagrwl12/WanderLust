# 🌍 Wanderlust

[![Node.js Version](https://img.shields.io/badge/Node.js-v22.0+-339933?logo=node.js&logoColor=white)](https://nodejs.org/)
[![Express](https://img.shields.io/badge/Express-v5.2-000000?logo=express&logoColor=white)](https://expressjs.com/)
[![MongoDB](https://img.shields.io/badge/MongoDB-Atlas-47A248?logo=mongodb&logoColor=white)](https://www.mongodb.com/)
[![TailwindCSS](https://img.shields.io/badge/TailwindCSS-v3.0-38B2AC?logo=tailwindcss&logoColor=white)](https://tailwindcss.com/)
[![Cloudinary](https://img.shields.io/badge/Cloudinary-Optimized-3448C5?logo=cloudinary&logoColor=white)](https://cloudinary.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Wanderlust is a premium, full-stack travel marketplace that allows users to discover, host, and review unique accommodations worldwide. Designed with a focus on responsiveness, modern aesthetics, and performance optimization, the platform follows the MVC architecture and utilizes cloud-based storage and databases.

---

## 📸 Screenshots & Preview

*Note: Please update these placeholders with your deployed screenshots.*

| 🏠 Homepage | 🔍 Listings Grid |
| :--- | :--- |
| ![Homepage Preview](https://via.placeholder.com/800x450?text=Wanderlust+Home+Page) | ![Listings Preview](https://via.placeholder.com/800x450?text=Wanderlust+Listings+Grid) |

---

## ✨ Features

- **🔒 Secure Authentication**: Full user signup, signin, and signout flows using **Passport.js** with session storage and custom authentication middleware.
- **🏠 Stay Listings (CRUD)**: Authorized hosts can create, read, update, and delete listings. Features automatic price formatting (INR) and dynamic listing status.
- **💬 Guest Reviews**: Interactive review system featuring starability rating fields and strict user ownership verification for deleting reviews.
- **⚡ Performance Optimized Image Pipeline**: Custom Cloudinary integration that automatically resizes, optimizes quality (`q_auto`), and formats (`f_auto` to WebP) user-uploaded photos at the moment of upload—reducing cover sizes by up to 94% to prevent page hangs.
- **🔍 Location Search**: Fast, responsive search filtering stays by title, location, description, or country.
- **🛡️ Robust Security & Validation**: Server-side schemas validation powered by **Joi** paired with authorization layers guarding listing/review mutations.

---

## 🛠️ Technology Stack

| Component | Technologies Used |
| :--- | :--- |
| **Frontend** | HTML5, EJS Layouts, Tailwind CSS, FontAwesome 6, Leaflet (React) |
| **Backend** | Node.js, Express.js |
| **Database** | MongoDB Atlas, Mongoose ODM |
| **Authentication** | Passport.js, Passport Local, Express Session, Connect Flash |
| **Cloud Storage** | Cloudinary, Multer, Multer Storage Cloudinary |
| **Validation** | Joi, ExpressError Utilities |

---

## 🏗️ MVC Architecture

Wanderlust follows the industry-standard **Model-View-Controller (MVC)** software design pattern to isolate application logic, data representations, and user interfaces:

```
Wanderlust/
├── models/         # MongoDB Schemas & business logic (Listing, Review, User)
├── views/          # EJS templates, layouts, and page fragments
├── controller/     # Handler functions managing logic and rendering flow
├── router/         # Express routers map URL endpoints to controllers
├── public/         # Static client assets (CSS, client-side JS, images)
├── utils/          # Global error wrapper and custom middleware
└── app.js          # Main initialization server file
```

---

## 🚀 Getting Started

### Prerequisites

- **Node.js** v22.0 or higher
- **MongoDB** local instance or MongoDB Atlas Connection String
- **Cloudinary** developer credentials

### Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/sundrmmagrwl12/WanderLust.git
   cd Wanderlust
   ```

2. **Install Dependencies**
   ```bash
   npm install
   ```

3. **Configure Environment Variables**
   Create a `.env` file in the root directory:
   ```env
   # Database Configuration
   MONGO_URL=your_mongodb_atlas_connection_string

   # Session Secret
   SECRET=your_express_session_secret

   # Cloudinary Credentials
   CLOUD_NAME=your_cloudinary_cloud_name
   API_KEY=your_cloudinary_api_key
   API_SECRET=your_cloudinary_api_secret
   ```

4. **Initialize / Seed Database**
   *(Optional)* To populate the database with sample listing locations:
   ```bash
   node init/index.js
   ```

5. **Start Development Server**
   ```bash
   npm run dev
   ```
   Open [http://localhost:8080](http://localhost:8080) in your browser.

---

## 🌐 Deployed Hosting

- **Cloud Database**: MongoDB Atlas
- **Cloud Media Storage**: Cloudinary
- **Web Application Host**: Deployed via Render / Vercel
- **Live Site**: [Wanderlust Live Demo](https://github.com/sundrmmagrwl12/WanderLust) *(Update with your live URL)*

---

## 👨‍💻 Author

**Sundram Singhal**
- **Education**: Computer Science & Engineering Student
- **Role**: Aspiring Full-Stack Developer | Passionate about Node.js Backend, Databases, and Optimization
- **GitHub**: [@sundrmmagrwl12](https://github.com/sundrmmagrwl12)
- **LinkedIn**: [Sundram Singhal](https://www.linkedin.com/in/sundram-singhal-b94069252/)

---

## ⭐ Support

If you found this project helpful, please consider giving it a ⭐ on [GitHub](https://github.com/sundrmmagrwl12/WanderLust)!

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.