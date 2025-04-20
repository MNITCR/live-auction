/*
 Navicat Premium Data Transfer

 Source Server         : LiveAuction
 Source Server Type    : MySQL
 Source Server Version : 80041
 Source Host           : localhost:3306
 Source Schema         : liveauction_db

 Target Server Type    : MySQL
 Target Server Version : 80041
 File Encoding         : 65001

 Date: 20/04/2025 21:06:40
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for api_biddingproduct
-- ----------------------------
DROP TABLE IF EXISTS `api_biddingproduct`;
CREATE TABLE `api_biddingproduct`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `price` decimal(10, 2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` int(0) NOT NULL,
  `product_id` bigint(0) NOT NULL,
  `is_auto_bid` tinyint(1) NOT NULL,
  `is_win` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `api_biddingproduct_user_id_2375ba42_fk_auth_user_id`(`user_id`) USING BTREE,
  INDEX `api_biddingproduct_product_id_b26c9962_fk_api_product_id`(`product_id`) USING BTREE,
  CONSTRAINT `api_biddingproduct_product_id_b26c9962_fk_api_product_id` FOREIGN KEY (`product_id`) REFERENCES `api_product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of api_biddingproduct
-- ----------------------------
INSERT INTO `api_biddingproduct` VALUES (1, 3000.00, '2025-04-20 04:09:32.221039', '2025-04-20 04:09:32.223054', 11, 56, 0, 0);
INSERT INTO `api_biddingproduct` VALUES (2, 1500.00, '2025-04-20 12:46:22.919239', '2025-04-20 12:46:22.920242', 5, 74, 0, 0);

-- ----------------------------
-- Table structure for api_category
-- ----------------------------
DROP TABLE IF EXISTS `api_category`;
CREATE TABLE `api_category`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` int(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `api_category_user_id_4a62861e_fk_auth_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of api_category
-- ----------------------------
INSERT INTO `api_category` VALUES (1, 'Historical', '2025-03-30 09:59:08.183370', '2025-03-31 11:37:50.919976', 7);
INSERT INTO `api_category` VALUES (2, 'Electronics', '2025-03-30 11:03:12.917280', '2025-03-31 11:38:03.847223', 7);
INSERT INTO `api_category` VALUES (3, 'Automobiles', '2025-03-31 11:38:18.933709', '2025-03-31 11:38:18.933709', 7);
INSERT INTO `api_category` VALUES (4, 'Real Estate', '2025-03-31 11:38:41.581686', '2025-03-31 11:38:41.581686', 7);
INSERT INTO `api_category` VALUES (5, 'Art', '2025-03-31 11:38:50.724012', '2025-03-31 11:38:50.724012', 7);
INSERT INTO `api_category` VALUES (6, 'Antiques', '2025-03-31 11:39:03.394402', '2025-03-31 11:39:03.394402', 7);
INSERT INTO `api_category` VALUES (7, 'Jewelry & Watches', '2025-03-31 11:39:17.530607', '2025-03-31 11:39:17.530607', 7);
INSERT INTO `api_category` VALUES (8, 'Books & Media', '2025-03-31 11:40:50.549897', '2025-03-31 11:40:50.549897', 7);

-- ----------------------------
-- Table structure for api_product
-- ----------------------------
DROP TABLE IF EXISTS `api_product`;
CREATE TABLE `api_product`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `slug` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `commission` decimal(10, 2) NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `height` decimal(10, 2) NULL DEFAULT NULL,
  `lengthpic` decimal(10, 2) NULL DEFAULT NULL,
  `width` decimal(10, 2) NULL DEFAULT NULL,
  `mediumused` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `weight` decimal(10, 2) NULL DEFAULT NULL,
  `isverify` tinyint(1) NOT NULL,
  `is_soldout` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `sold_to_id` int(0) NULL DEFAULT NULL,
  `user_id` int(0) NOT NULL,
  `end_date` datetime(6) NULL DEFAULT NULL,
  `start_date` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `slug`(`slug`) USING BTREE,
  INDEX `api_product_sold_to_id_70783a93_fk_auth_user_id`(`sold_to_id`) USING BTREE,
  INDEX `api_product_user_id_b5580e10_fk_auth_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 76 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of api_product
-- ----------------------------
INSERT INTO `api_product` VALUES (1, 'Blown Glass Creations for Every Occasion', 'Blown Glass Creations for Every Occasion', 'Korem ipsum dolor amet, consectetur adipiscing elit. Maece nas in pulvinar neque. Nulla finibus lobortis pulvinar. Donec a consectetur nulla.', 'https://rainbowthemes.net/themes/nuron/wp-content/uploads/2023/09/nuron-art-demo-image-7-768x768.png', '5', 0.00, 5000.00, NULL, NULL, NULL, NULL, NULL, 1, 0, '2025-04-06 09:08:13.000000', '2025-04-06 09:08:13.000000', NULL, 7, NULL, NULL);
INSERT INTO `api_product` VALUES (2, 'Capturing Nature’s Beauty', 'Capturing Nature’s Beauty', 'test', 'https://rainbowthemes.net/themes/nuron/wp-content/uploads/2023/09/nuron-art-demo-image-8-390x532.png', '5', 0.00, 1420.00, NULL, NULL, NULL, NULL, NULL, 1, 0, '2025-04-06 09:08:13.000000', '2025-04-06 09:08:13.000000', NULL, 7, NULL, NULL);
INSERT INTO `api_product` VALUES (3, 'Ceramic Tea Sets with a Twist', 'Ceramic Tea Sets with a Twist', 'test', 'https://rainbowthemes.net/themes/nuron/wp-content/uploads/2023/09/nuron-art-demo-image-1-390x532.png', '5', 0.00, 100.00, NULL, NULL, NULL, NULL, NULL, 1, 0, '2025-04-06 09:08:13.000000', '2025-04-06 09:08:13.000000', NULL, 7, NULL, NULL);
INSERT INTO `api_product` VALUES (4, 'Vintage Motorcycles and Scooters', 'Vintage Motorcycles and Scooters', 'test', 'https://rainbowthemes.net/themes/nuron/wp-content/uploads/2023/09/automotive_product-01-600x600.jpg', '3', 0.00, 50000.00, NULL, NULL, NULL, NULL, NULL, 1, 0, '2025-04-06 09:08:13.000000', '2025-04-06 09:08:13.000000', NULL, 7, NULL, NULL);
INSERT INTO `api_product` VALUES (5, 'Off-Road Adventure Seekers', 'Off-Road Adventure Seekers', 'test', 'https://rainbowthemes.net/themes/nuron/wp-content/uploads/2023/09/automotive_product-02-600x600.jpg', '3', 0.00, 8000.00, NULL, NULL, NULL, NULL, NULL, 1, 0, '2025-04-06 09:08:13.000000', '2025-04-06 09:08:13.000000', NULL, 7, NULL, NULL);
INSERT INTO `api_product` VALUES (6, 'Rare Exotics and Supercars', 'Rare Exotics and Supercars', 'test', 'https://rainbowthemes.net/themes/nuron/wp-content/uploads/2023/09/automotive_product-04-600x600.jpg', '3', 0.00, 80000.00, NULL, NULL, NULL, NULL, NULL, 1, 0, '2025-04-06 09:08:13.000000', '2025-04-06 09:08:13.000000', NULL, 7, NULL, NULL);
INSERT INTO `api_product` VALUES (7, 'Rare Exotics and Supercar', 'Rare Exotics and Supercar', 'test', 'https://rainbowthemes.net/themes/nuron/wp-content/uploads/2023/09/books_demo_product_07-600x600.jpg', '8', 0.00, 800.00, NULL, NULL, NULL, NULL, NULL, 1, 0, '2025-04-06 09:08:13.000000', '2025-04-06 09:08:13.000000', NULL, 7, NULL, NULL);
INSERT INTO `api_product` VALUES (8, 'Epic Fantasy Chronicles', 'Epic Fantasy Chronicles', 'test', 'https://rainbowthemes.net/themes/nuron/wp-content/uploads/2023/09/books_demo_product_02-600x600.jpg', '8', 0.00, 800.00, NULL, NULL, NULL, NULL, NULL, 1, 0, '2025-04-06 09:08:13.000000', '2025-04-06 09:08:13.000000', NULL, 7, NULL, NULL);
INSERT INTO `api_product` VALUES (9, 'Graphic Non-Fiction', 'Graphic Non-Fiction', 'test', 'https://rainbowthemes.net/themes/nuron/wp-content/uploads/2023/09/books_demo_product_09-600x600.jpg', '8', 0.00, 800.00, NULL, NULL, NULL, NULL, NULL, 1, 0, '2025-04-06 09:08:13.000000', '2025-04-06 09:08:13.000000', NULL, 7, NULL, NULL);
INSERT INTO `api_product` VALUES (10, 'Coin Hyundai Sonata', 'Coin Hyundai Sonata', 'test', 'https://rainbowthemes.net/themes/nuron/wp-content/uploads/2023/09/coin-auction-demo-product-10-768x768.jpg', '5', 0.00, 5000.00, NULL, NULL, NULL, NULL, NULL, 1, 0, '2025-04-06 09:08:13.000000', '2025-04-06 09:08:13.000000', NULL, 7, NULL, NULL);
INSERT INTO `api_product` VALUES (11, '2018 Hyundai Sonata', '2018 Hyundai Sonata', 'test', 'https://rainbowthemes.net/themes/nuron/wp-content/uploads/2023/09/coin-auction-demo-product-07-768x768.jpg', '5', 0.00, 5000.00, NULL, NULL, NULL, NULL, NULL, 1, 0, '2025-04-06 09:08:13.000000', '2025-04-06 09:08:13.000000', NULL, 7, NULL, NULL);
INSERT INTO `api_product` VALUES (12, '2018 Hyundai Sonata', '2018 Hyundai Sonatas', 'test', 'https://rainbowthemes.net/themes/nuron/wp-content/uploads/2023/09/lab-product-05-768x768.jpg', '5', 0.00, 5000.00, NULL, NULL, NULL, NULL, NULL, 1, 0, '2025-04-06 09:14:19.000000', '2025-04-06 09:14:19.000000', NULL, 7, NULL, NULL);
INSERT INTO `api_product` VALUES (56, 'Test', 'test', 'testse', 'https://res.cloudinary.com/dfuiwaipz/image/upload/v1744069700/mxvoonjismgtjkip8hgi.png', 'Automobiles', 10.00, 100.00, 0.00, 0.00, 0.00, '', 0.00, 1, 0, '2025-04-07 23:46:01.486758', '2025-04-20 03:09:34.352199', NULL, 5, '2025-04-30 21:48:00.000000', '2025-04-08 21:48:00.000000');
INSERT INTO `api_product` VALUES (72, 'test11', 'test11', 'fsfsd', NULL, 'Automobiles', 20.00, 100.00, 0.00, 0.00, 0.00, '', 0.00, 1, 0, '2025-04-09 16:37:22.945933', '2025-04-20 02:48:43.022715', NULL, 5, '2025-04-17 23:38:00.000000', '2025-04-09 23:38:00.000000');
INSERT INTO `api_product` VALUES (74, 'Teststs', 'teststs', 'fkjskfjklsdf', 'https://res.cloudinary.com/dfuiwaipz/image/upload/v1745065761/q9lcurl6pvkjys8qgoxz.jpg', 'Art', 20.00, 1000.00, 0.00, 0.00, 0.00, '', 0.00, 1, 0, '2025-04-19 12:29:32.265480', '2025-04-19 16:55:27.613268', NULL, 11, '2025-04-30 19:31:00.000000', '2025-04-19 19:30:00.000000');

-- ----------------------------
-- Table structure for api_user
-- ----------------------------
DROP TABLE IF EXISTS `api_user`;
CREATE TABLE `api_user`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `photo` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `commission_balance` decimal(10, 2) NOT NULL,
  `balance` decimal(10, 2) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `contact_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of api_user
-- ----------------------------
INSERT INTO `api_user` VALUES (5, 'M', 'seller@gmail.com', 'pbkdf2_sha256$870000$nOfJhJvyxmT5yAnQw8Vtef$iItX4div1l7Nq08n2KOWiO30TcIin2V7LWzGauFziFE=', 'https://cdn-icons-png.flaticon.com/512/2202/2202112.png', 'seller', 0.00, 0.00, '2025-03-28 17:54:08.704302', '2025-04-20 10:25:59.898215', 1, 0, NULL);
INSERT INTO `api_user` VALUES (6, 'Sok dara', 'buyer@gmail.com', 'pbkdf2_sha256$870000$MHDN2U0nsmLtaeK05yOYjf$HsUwDOxwW3RN846Gvvhua0m4SscFvSyJmzClYQbMCAI=', 'https://res.cloudinary.com/dfuiwaipz/image/upload/v1744853150/qws7avqkytldt3dm8lw4.webp', 'seller', 0.00, 0.00, '2025-03-28 17:54:26.529106', '2025-04-19 12:33:23.622797', 1, 0, '234234234234234');
INSERT INTO `api_user` VALUES (7, 'Mean', 'admin@gmail.com', 'pbkdf2_sha256$870000$eKjKRh2AO7iyic4PcN34PZ$JpFzN1uVfoBZCkZBjZxo/lymntDy/Za5H58GKTEOKqU=', 'https://res.cloudinary.com/dfuiwaipz/image/upload/v1743326804/cvjkavth5nzgv0x1ubnu.jpg', 'admin', 0.00, 0.00, '2025-03-30 02:22:00.237521', '2025-04-19 12:34:14.997771', 1, 0, '234234234234234');
INSERT INTO `api_user` VALUES (11, 'leak', 'leak@gmail.com', 'pbkdf2_sha256$870000$6s6nT8xkQFlGGTNxtPvo6D$fnXq2A3F+eAr5JHvMC74YztM54fOSoaGcFwDlxRa8LE=', 'https://cdn-icons-png.flaticon.com/512/2202/2202112.png', 'seller', 0.00, 0.00, '2025-04-19 12:08:37.256756', '2025-04-20 03:07:28.044132', 1, 0, NULL);

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `group_id` int(0) NOT NULL,
  `permission_id` int(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int(0) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` VALUES (14, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` VALUES (15, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` VALUES (16, 'Can view user', 4, 'view_user');
INSERT INTO `auth_permission` VALUES (17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` VALUES (24, 'Can view session', 6, 'view_session');
INSERT INTO `auth_permission` VALUES (25, 'Can add user', 7, 'add_user');
INSERT INTO `auth_permission` VALUES (26, 'Can change user', 7, 'change_user');
INSERT INTO `auth_permission` VALUES (27, 'Can delete user', 7, 'delete_user');
INSERT INTO `auth_permission` VALUES (28, 'Can view user', 7, 'view_user');
INSERT INTO `auth_permission` VALUES (29, 'Can add category', 8, 'add_category');
INSERT INTO `auth_permission` VALUES (30, 'Can change category', 8, 'change_category');
INSERT INTO `auth_permission` VALUES (31, 'Can delete category', 8, 'delete_category');
INSERT INTO `auth_permission` VALUES (32, 'Can view category', 8, 'view_category');
INSERT INTO `auth_permission` VALUES (33, 'Can add product', 9, 'add_product');
INSERT INTO `auth_permission` VALUES (34, 'Can change product', 9, 'change_product');
INSERT INTO `auth_permission` VALUES (35, 'Can delete product', 9, 'delete_product');
INSERT INTO `auth_permission` VALUES (36, 'Can view product', 9, 'view_product');
INSERT INTO `auth_permission` VALUES (37, 'Can add bidding product', 10, 'add_biddingproduct');
INSERT INTO `auth_permission` VALUES (38, 'Can change bidding product', 10, 'change_biddingproduct');
INSERT INTO `auth_permission` VALUES (39, 'Can delete bidding product', 10, 'delete_biddingproduct');
INSERT INTO `auth_permission` VALUES (40, 'Can view bidding product', 10, 'view_biddingproduct');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `user_id` int(0) NOT NULL,
  `group_id` int(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `user_id` int(0) NOT NULL,
  `permission_id` int(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action_flag` smallint(0) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int(0) NULL DEFAULT NULL,
  `user_id` int(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (10, 'api', 'biddingproduct');
INSERT INTO `django_content_type` VALUES (8, 'api', 'category');
INSERT INTO `django_content_type` VALUES (9, 'api', 'product');
INSERT INTO `django_content_type` VALUES (7, 'api', 'user');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2025-03-28 16:03:30.003213');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2025-03-28 16:03:30.698584');
INSERT INTO `django_migrations` VALUES (3, 'admin', '0001_initial', '2025-03-28 16:03:30.910230');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2025-03-28 16:03:30.917230');
INSERT INTO `django_migrations` VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2025-03-28 16:03:30.926322');
INSERT INTO `django_migrations` VALUES (6, 'api', '0001_initial', '2025-03-28 16:03:31.398931');
INSERT INTO `django_migrations` VALUES (7, 'contenttypes', '0002_remove_content_type_name', '2025-03-28 16:03:31.524932');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0002_alter_permission_name_max_length', '2025-03-28 16:03:31.595963');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0003_alter_user_email_max_length', '2025-03-28 16:03:31.626196');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0004_alter_user_username_opts', '2025-03-28 16:03:31.636191');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0005_alter_user_last_login_null', '2025-03-28 16:03:31.709286');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0006_require_contenttypes_0002', '2025-03-28 16:03:31.713194');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0007_alter_validators_add_error_messages', '2025-03-28 16:03:31.724193');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0008_alter_user_username_max_length', '2025-03-28 16:03:31.854196');
INSERT INTO `django_migrations` VALUES (15, 'auth', '0009_alter_user_last_name_max_length', '2025-03-28 16:03:31.958193');
INSERT INTO `django_migrations` VALUES (16, 'auth', '0010_alter_group_name_max_length', '2025-03-28 16:03:31.979196');
INSERT INTO `django_migrations` VALUES (17, 'auth', '0011_update_proxy_permissions', '2025-03-28 16:03:31.991195');
INSERT INTO `django_migrations` VALUES (18, 'auth', '0012_alter_user_first_name_max_length', '2025-03-28 16:03:32.066698');
INSERT INTO `django_migrations` VALUES (19, 'sessions', '0001_initial', '2025-03-28 16:03:32.103732');
INSERT INTO `django_migrations` VALUES (20, 'api', '0002_alter_user_password', '2025-03-29 11:04:22.936716');
INSERT INTO `django_migrations` VALUES (21, 'api', '0003_user_contact_number', '2025-03-30 07:11:37.728673');
INSERT INTO `django_migrations` VALUES (22, 'api', '0004_alter_product_image', '2025-04-01 08:27:32.660660');
INSERT INTO `django_migrations` VALUES (23, 'api', '0005_product_end_date_product_start_date', '2025-04-07 23:59:45.779780');
INSERT INTO `django_migrations` VALUES (24, 'api', '0006_biddingproduct_is_auto_bid', '2025-04-19 13:28:59.955950');
INSERT INTO `django_migrations` VALUES (25, 'api', '0007_biddingproduct_is_win', '2025-04-20 02:17:05.641185');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('04e38a0rpxnfjij8moe6qmabe5zcw9f6', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u25Ml:RVyC9mDsR3mLU2_8Kgbs1XFNfSMb-7BOqoQjh_38Gi0', '2025-04-22 09:35:35.281991');
INSERT INTO `django_session` VALUES ('0nibsoc2paq3a28thi499uvxrnu56lzf', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1tyoVi:yHLaMpjCNBuc0XmzESQozrHTvF91xfQoF9IJEl4UB30', '2025-04-13 08:59:18.441106');
INSERT INTO `django_session` VALUES ('0p469moklwofn34mippe0a9pfjh8qqoe', '.eJxVjEEOwiAQRe_C2hBohwx16d4zkIEZpGogKe3KeHdt0oVu_3vvv1SgbS1h67KEmdVZOXX63SKlh9Qd8J3qrenU6rrMUe-KPmjX18byvBzu30GhXr71JJCjn5KJLnsZGWgYPFIS6wz4PGZncIgICOwd0sQsFjICWCcWfVLvD-1FN78:1u1DUR:pUjLeEd_rSKp4xJ_CV3yMbo9dbE14BoBqCYyV4rhfdU', '2025-04-20 00:03:55.509832');
INSERT INTO `django_session` VALUES ('0zob6l9agblr4g1fwvlow69onn703vd7', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u2XeW:HfI0Lz8xsBf3ZzQoHkk8iSMVVyf136TRz4Z5jgH6wYo', '2025-04-23 15:47:48.800965');
INSERT INTO `django_session` VALUES ('10xwx2aqg1p4fdne6d9soxixj6xn76yx', '.eJxVjM0OwiAQhN-FsyGyXX7q0bvPQFhYpGogKe3J-O62SQ96nPm-mbfwYV2KXzvPfkriIow4_XYU4pPrDtIj1HuTsdVlnkjuijxol7eW-HU93L-DEnrZ1i5a0pTPERkHtKCyxZExOeRBmS0RJz0OWUFiRqPBZW1QGYQAlBnE5wviyje0:1u0Ia1:pYBi5kS_Ls0sxPe4p8ZckuwA06ZEi1YJ6DX5qMEiLLo', '2025-04-17 11:17:53.709401');
INSERT INTO `django_session` VALUES ('199z0sgqqoplm16guof2q227f9dk8h92', '.eJxVjEEOwiAQRe_C2hBohwx16d4zkIEZpGogKe3KeHdt0oVu_3vvv1SgbS1h67KEmdVZOXX63SKlh9Qd8J3qrenU6rrMUe-KPmjX18byvBzu30GhXr71JJCjn5KJLnsZGWgYPFIS6wz4PGZncIgICOwd0sQsFjICWCcWfVLvD-1FN78:1u1Eog:2y_tz_9fkFI28mo2Tx-sr-tAZ-X5bQs6CMtCHxaBIdw', '2025-04-20 01:28:54.779276');
INSERT INTO `django_session` VALUES ('1zyonc8737hylfownppbg27huwbyghpn', '.eJxVjM0OwiAQhN-FsyGyXX7q0bvPQFhYpGogKe3J-O62SQ96nPm-mbfwYV2KXzvPfkriIow4_XYU4pPrDtIj1HuTsdVlnkjuijxol7eW-HU93L-DEnrZ1i5a0pTPERkHtKCyxZExOeRBmS0RJz0OWUFiRqPBZW1QGYQAlBnE5wviyje0:1u1E67:7vY71Hp1GFpJ0WLlHqjlk1R2KQUC3OMp2T8sa6s-Hn4', '2025-04-20 00:42:51.664075');
INSERT INTO `django_session` VALUES ('2u3o7wjpciwsutuh8k64zivlyhpu0oci', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1tzWvn:FTin6vVMtezUUEPvp4lsiVtZQj1wJXQRucuJxX-HAxQ', '2025-04-15 08:25:11.808468');
INSERT INTO `django_session` VALUES ('2v7gj61qwszrobu68mpqpswpiytwap5a', '.eJxVjM0OwiAQhN-FsyGyXX7q0bvPQFhYpGogKe3J-O62SQ96nPm-mbfwYV2KXzvPfkriIow4_XYU4pPrDtIj1HuTsdVlnkjuijxol7eW-HU93L-DEnrZ1i5a0pTPERkHtKCyxZExOeRBmS0RJz0OWUFiRqPBZW1QGYQAlBnE5wviyje0:1u27E4:r3y3Wo8baq1yAb-MpLz6VjwWQc3gv5R2H0xXpWvsj7o', '2025-04-22 11:34:44.845511');
INSERT INTO `django_session` VALUES ('3sr5ikec04s1ka66k2icdvnjsw96uczg', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1tyisK:COfwFXHE4iqu0gk0Tt6kMasWPjtgQkzpLvr9Z9YJv90', '2025-04-13 02:58:16.067201');
INSERT INTO `django_session` VALUES ('3z8vmgwhkjdeo65kym7mdvzj6eatt5ir', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u24wT:8FhAxH9WT0zgtYfmW6DcP280OCsZhuEfJKyexwYBIlY', '2025-04-22 09:08:25.159532');
INSERT INTO `django_session` VALUES ('45e1duk5qrc2taqpy1821y1alos7an79', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1tzXtQ:1LqcIFeXpD8kQXD6r9JvWbSqvClfZQKJ6VCxuplklf0', '2025-04-15 09:26:48.153218');
INSERT INTO `django_session` VALUES ('48a4osxtd3f9x1v2nt63vk3g9ml77s0a', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1tyiz1:-K7_P-g-5MZn4rB5c-2oa_5_C04AmtZIeuXSdM6SSss', '2025-04-13 03:05:11.588752');
INSERT INTO `django_session` VALUES ('4p72d2skjer91qxzmgzyaxphix6n63mp', '.eJxVjM0OwiAQhN-FsyGyXX7q0bvPQFhYpGogKe3J-O62SQ96nPm-mbfwYV2KXzvPfkriIow4_XYU4pPrDtIj1HuTsdVlnkjuijxol7eW-HU93L-DEnrZ1i5a0pTPERkHtKCyxZExOeRBmS0RJz0OWUFiRqPBZW1QGYQAlBnE5wviyje0:1u66xW:o7bF5oMvYJ74T8o57aG4tx-IFbZkBMM9OC3uwXfrpbY', '2025-05-03 12:06:10.793854');
INSERT INTO `django_session` VALUES ('5i96ofphs5jwtgn78w7mchahgvkpbt49', '.eJxVjMEOwiAQRP-FsyFApYBH734D2V0WqRpISnsy_rtt0oPeJvPezFtEWJcS185znJK4CK3F6bdEoCfXnaQH1HuT1OoyTyh3RR60y1tL_Loe7t9BgV62NY9D9gTKWEomjzaAGsgGpbXyhg2icsZCJkTr2Ft9Tt4RUghbAM9KfL4GgDgu:1u67Ie:LYwr1KHFX8ExDRMxxWOmItpsZA8WTGKcSUyqGsFTHmk', '2025-05-03 12:28:00.606195');
INSERT INTO `django_session` VALUES ('5u57fsjm4rc0n7hevo6tqfhcgs6edlnv', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u2XY5:zI72LFUAVkwHVWIdXt2ZWFh-7WbpQIzwZjIQf9OdQzE', '2025-04-23 15:41:09.407050');
INSERT INTO `django_session` VALUES ('71mfnefri9ix51q63kxrqb7u4n3f3ttb', '.eJxVjEEOwiAQRe_C2hBohwx16d4zkIEZpGogKe3KeHdt0oVu_3vvv1SgbS1h67KEmdVZOXX63SKlh9Qd8J3qrenU6rrMUe-KPmjX18byvBzu30GhXr71JJCjn5KJLnsZGWgYPFIS6wz4PGZncIgICOwd0sQsFjICWCcWfVLvD-1FN78:1u2X41:GbYU0pjVTdHmkpv8APTRKdsdwr6TRPiEkWpz075repg', '2025-04-23 15:10:05.376701');
INSERT INTO `django_session` VALUES ('7dn6xuvq0om2m1f9kqvirjsyb05i2z1m', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1tyoQb:PQoefNQrnA6ilbibYHT8jvSimLy0LE7u0v1fdxEr9Yo', '2025-04-13 08:54:01.108924');
INSERT INTO `django_session` VALUES ('87ygu84f3pdh2agw7viinj9z1b2fkb19', '.eJxVjEEOwiAQRe_C2hBohwx16d4zkIEZpGogKe3KeHdt0oVu_3vvv1SgbS1h67KEmdVZOXX63SKlh9Qd8J3qrenU6rrMUe-KPmjX18byvBzu30GhXr71JJCjn5KJLnsZGWgYPFIS6wz4PGZncIgICOwd0sQsFjICWCcWfVLvD-1FN78:1u2YQD:ndeQaI-FDb-MhXnp3vzQc5RfWl9XCW8Wsu95DGYotvI', '2025-04-23 16:37:05.628945');
INSERT INTO `django_session` VALUES ('89rrht3ix4y4w37vqfsgyx4p7p1a0cmx', '.eJxVjEEOwiAQRe_C2hBohwx16d4zkIEZpGogKe3KeHdt0oVu_3vvv1SgbS1h67KEmdVZOXX63SKlh9Qd8J3qrenU6rrMUe-KPmjX18byvBzu30GhXr71JJCjn5KJLnsZGWgYPFIS6wz4PGZncIgICOwd0sQsFjICWCcWfVLvD-1FN78:1u1w9t:3HaUyrIemmxqcoWsOSxmkubLwpt61MAIVlnLb3-UcOc', '2025-04-21 23:45:41.167484');
INSERT INTO `django_session` VALUES ('8ebm4i8w8k420v7o2zcva0aq19oefhdl', '.eJxVjEEOwiAQRe_C2hBohwx16d4zkIEZpGogKe3KeHdt0oVu_3vvv1SgbS1h67KEmdVZOXX63SKlh9Qd8J3qrenU6rrMUe-KPmjX18byvBzu30GhXr71JJCjn5KJLnsZGWgYPFIS6wz4PGZncIgICOwd0sQsFjICWCcWfVLvD-1FN78:1tyoUA:sEh3v0x5wNeZMQooSjXDJGALUb2hqoK-NVxuHsSWTjk', '2025-04-13 08:57:42.649674');
INSERT INTO `django_session` VALUES ('92rbsb8sunvl6p4pqt2jfremlenrfzuo', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1tyirS:S_gdlRYwImFaUJkiDV5nni-ZmLRxXFqOMdJqvzW8Xzw', '2025-04-13 02:57:22.500295');
INSERT INTO `django_session` VALUES ('9a9g9yi3d28qy8e8cs2l8oovpkkzj7nf', '.eJxVjMEOwiAQRP-FsyFApYBH734D2V0WqRpISnsy_rtt0oPeJvPezFtEWJcS185znJK4CK3F6bdEoCfXnaQH1HuT1OoyTyh3RR60y1tL_Loe7t9BgV62NY9D9gTKWEomjzaAGsgGpbXyhg2icsZCJkTr2Ft9Tt4RUghbAM9KfL4GgDgu:1u6L1k:xY52zL0S-lSIfrm1jDS0UE5p-RNozuNNdKaVQQfsD4c', '2025-05-04 03:07:28.066547');
INSERT INTO `django_session` VALUES ('aewtibhmhyy2n4uix5z3l8wn4wwzums9', '.eJxVjM0OwiAQhN-FsyGyXX7q0bvPQFhYpGogKe3J-O62SQ96nPm-mbfwYV2KXzvPfkriIow4_XYU4pPrDtIj1HuTsdVlnkjuijxol7eW-HU93L-DEnrZ1i5a0pTPERkHtKCyxZExOeRBmS0RJz0OWUFiRqPBZW1QGYQAlBnE5wviyje0:1u1EpJ:_ePr5xfR4ksrI7BymBlAm5BE_JnYaFWzCd_mJadwMFQ', '2025-04-20 01:29:33.449795');
INSERT INTO `django_session` VALUES ('akkmw7m8nldhomi54ecvtdnr12nnf0jm', '.eJxVjMEOwiAQRP-FsyFApYBH734D2V0WqRpISnsy_rtt0oPeJvPezFtEWJcS185znJK4CK3F6bdEoCfXnaQH1HuT1OoyTyh3RR60y1tL_Loe7t9BgV62NY9D9gTKWEomjzaAGsgGpbXyhg2icsZCJkTr2Ft9Tt4RUghbAM9KfL4GgDgu:1u6703:cFk-SxXVS22F1Ey9yAPVhYYmYZ-crEkO9jBiSKrILBo', '2025-05-03 12:08:47.293526');
INSERT INTO `django_session` VALUES ('avs24xa4i2xt5ualxwi3qy9deggl5guq', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u67LE:zwBeuMAE6Mj2b6uyq9P1TPw7OnZFB8TDI1PdziuB8Fg', '2025-05-03 12:30:40.225164');
INSERT INTO `django_session` VALUES ('bhsgcfa0fk7auz0ukmkse6g95lt4r7ch', '.eJxVjM0OwiAQhN-FsyGyXX7q0bvPQFhYpGogKe3J-O62SQ96nPm-mbfwYV2KXzvPfkriIow4_XYU4pPrDtIj1HuTsdVlnkjuijxol7eW-HU93L-DEnrZ1i5a0pTPERkHtKCyxZExOeRBmS0RJz0OWUFiRqPBZW1QGYQAlBnE5wviyje0:1u1ELr:auPfSNSJYUILcz7m7iBAuYhBbkmrFLmvKHgxR3Wmmk4', '2025-04-20 00:59:07.460980');
INSERT INTO `django_session` VALUES ('c6rav2plbqgohgm6t4prdqzxhxvjkksd', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1tzIqA:FRFLAk1X3VB6pTTvUEG5p7WFwvjs5rJcqX4155aGFgY', '2025-04-14 17:22:26.640099');
INSERT INTO `django_session` VALUES ('cnj11hfg63m5wfu3o82tjz64gof78udf', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u27CK:zomOoWMJYAq1wZDFQkeue__Nwl6kFhVEUOFO0eIehZg', '2025-04-22 11:32:56.099498');
INSERT INTO `django_session` VALUES ('dznzugo5vco3hf0xbltaykdm7tl40pfq', '.eJxVjM0OwiAQhN-FsyGyXX7q0bvPQFhYpGogKe3J-O62SQ96nPm-mbfwYV2KXzvPfkriIow4_XYU4pPrDtIj1HuTsdVlnkjuijxol7eW-HU93L-DEnrZ1i5a0pTPERkHtKCyxZExOeRBmS0RJz0OWUFiRqPBZW1QGYQAlBnE5wviyje0:1u5IvO:aiI_4HJqjqA5utBMnb_lfXmHpip_YHofN4JjvMzy8zQ', '2025-05-01 06:40:38.064521');
INSERT INTO `django_session` VALUES ('e0bryfgukn4vvyk2ojrqjp9ikc6fu9v8', '.eJxVjM0OwiAQhN-FsyGyXX7q0bvPQFhYpGogKe3J-O62SQ96nPm-mbfwYV2KXzvPfkriIow4_XYU4pPrDtIj1HuTsdVlnkjuijxol7eW-HU93L-DEnrZ1i5a0pTPERkHtKCyxZExOeRBmS0RJz0OWUFiRqPBZW1QGYQAlBnE5wviyje0:1u25Oh:wCTCCIgoFBXFNd6B4f8gNGcbj4U-tcx6ePCqsAe1DA4', '2025-04-22 09:37:35.834439');
INSERT INTO `django_session` VALUES ('eeysl7kptwan599w6i3r3v9wqgqq3x8n', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1tyiuf:eMcVbuMUHVeL-_eWZl6DDHzWE8n2rlqhtZEikD4qayE', '2025-04-13 03:00:41.577817');
INSERT INTO `django_session` VALUES ('ef5a0qv6z8ouvjee5llxirhilhif5ljr', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u1DS7:FvtRlQ-cErvhzHHmF3d51lhfO490pIy-x1MvU0ahxOE', '2025-04-20 00:01:31.413263');
INSERT INTO `django_session` VALUES ('f8wqrcq392x8arorb8to6h4rojl6w0b5', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1tyj5I:m4oBQPjQsqLmKeuVLrRoWyfZSddhMgGG1VwPv8j1j4E', '2025-04-13 03:11:40.292466');
INSERT INTO `django_session` VALUES ('fkha697mjs7sbfxd0j4ln6lamg6bg66i', '.eJxVjEEOwiAQRe_C2hBohwx16d4zkIEZpGogKe3KeHdt0oVu_3vvv1SgbS1h67KEmdVZOXX63SKlh9Qd8J3qrenU6rrMUe-KPmjX18byvBzu30GhXr71JJCjn5KJLnsZGWgYPFIS6wz4PGZncIgICOwd0sQsFjICWCcWfVLvD-1FN78:1tySZS:VAoLQ25RaiwqH9iULbc2HaCwOxNrjmhJ4NLi5ffYfWc', '2025-04-12 09:33:42.523537');
INSERT INTO `django_session` VALUES ('fnxwx57hlsp792axjlp6v034kk798xir', '.eJxVjEEOwiAQRe_C2hBohwx16d4zkIEZpGogKe3KeHdt0oVu_3vvv1SgbS1h67KEmdVZOXX63SKlh9Qd8J3qrenU6rrMUe-KPmjX18byvBzu30GhXr71JJCjn5KJLnsZGWgYPFIS6wz4PGZncIgICOwd0sQsFjICWCcWfVLvD-1FN78:1u0IZR:uJXziqtz7SOq4IDazcwi6t5qAldkr630TKUE67XyftI', '2025-04-17 11:17:17.685536');
INSERT INTO `django_session` VALUES ('fozm0o15hcstv4w21cgbtx6bnzioncer', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1tyjmP:ag7yoHot2mFFrFlm892WYc8JbTOjiP2rzuxVb9EGpWU', '2025-04-13 03:56:13.357677');
INSERT INTO `django_session` VALUES ('fzq0j1gen8qw692zax9g45tgdh3bfqde', '.eJxVjEEOwiAQRe_C2hBohwx16d4zkIEZpGogKe3KeHdt0oVu_3vvv1SgbS1h67KEmdVZOXX63SKlh9Qd8J3qrenU6rrMUe-KPmjX18byvBzu30GhXr71JJCjn5KJLnsZGWgYPFIS6wz4PGZncIgICOwd0sQsFjICWCcWfVLvD-1FN78:1u1E5Z:Ba8GK3ukaIS401NEJtBemuzFJRS_uScauaLpiWoWdes', '2025-04-20 00:42:17.806855');
INSERT INTO `django_session` VALUES ('fzt28ur0zih6x6btj9rym9le1u30bh1s', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u2YQq:x5pZ2btsuhCS9sRBrh1ADEbYcyBMGG1w2MZcbN9lmgM', '2025-04-23 16:37:44.478744');
INSERT INTO `django_session` VALUES ('gcdnqloxqfr0h4hjpv559sdial34ymm0', '.eJxVjEEOwiAQRe_C2hBohwx16d4zkIEZpGogKe3KeHdt0oVu_3vvv1SgbS1h67KEmdVZOXX63SKlh9Qd8J3qrenU6rrMUe-KPmjX18byvBzu30GhXr71JJCjn5KJLnsZGWgYPFIS6wz4PGZncIgICOwd0sQsFjICWCcWfVLvD-1FN78:1u6Rs7:h5DvpSRPzgUC3EEbHYJScRewtuAcDhg0zZm4xtHvYHI', '2025-05-04 10:25:59.960152');
INSERT INTO `django_session` VALUES ('gmfn55f0vmpldayg16rdqcvr8f78zpfn', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u1Dav:R4oQ1FgGRupMOFW73EOwqsFozpS9XreglB7z-5LLqF4', '2025-04-20 00:10:37.659333');
INSERT INTO `django_session` VALUES ('gxheegcwivh7enzzui11ftx02u4ich4p', '.eJxVjM0OwiAQhN-FsyGyXX7q0bvPQFhYpGogKe3J-O62SQ96nPm-mbfwYV2KXzvPfkriIow4_XYU4pPrDtIj1HuTsdVlnkjuijxol7eW-HU93L-DEnrZ1i5a0pTPERkHtKCyxZExOeRBmS0RJz0OWUFiRqPBZW1QGYQAlBnE5wviyje0:1u67Nr:5KAmL9yCtCI8y8jMV5-3peB4Gum5qxw70jHJIgZ06f8', '2025-05-03 12:33:23.626792');
INSERT INTO `django_session` VALUES ('h68qlm5azdd6aty2pjd45hjs1xiamc92', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u5HnW:VG-jZ0IqHFrTLDVyW4KYbc4JTrxTJPjc4Ivw7RW1RA0', '2025-05-01 05:28:26.313412');
INSERT INTO `django_session` VALUES ('hksjbfw5q3a9oy4v779fpc9ulwd70g2d', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1tyjTa:LnA7O5EGxgIMejgevaqXCSYcrfoJC2rHwrXhjpCO1AM', '2025-04-13 03:36:46.073052');
INSERT INTO `django_session` VALUES ('hp6c4hps0iv09h41baeznt5mscx7nj2g', '.eJxVjEEOwiAQRe_C2hBohwx16d4zkIEZpGogKe3KeHdt0oVu_3vvv1SgbS1h67KEmdVZOXX63SKlh9Qd8J3qrenU6rrMUe-KPmjX18byvBzu30GhXr71JJCjn5KJLnsZGWgYPFIS6wz4PGZncIgICOwd0sQsFjICWCcWfVLvD-1FN78:1u1Ddf:EUksbJJW_H_8Tbj4GXbK8wMS4SjVixgQhd90GX-XMB4', '2025-04-20 00:13:27.398759');
INSERT INTO `django_session` VALUES ('ivcxzdjhlcqaeobklzbutgxh9fef7jjs', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u24Z1:AD9airzCRh4YX35epO_uESTHE9JFdwEKQ5INhDHxnbA', '2025-04-22 08:44:11.465470');
INSERT INTO `django_session` VALUES ('ivgfgybevc2fcfxs2b09r44t82reg6s9', '.eJxVjM0OwiAQhN-FsyGyXX7q0bvPQFhYpGogKe3J-O62SQ96nPm-mbfwYV2KXzvPfkriIow4_XYU4pPrDtIj1HuTsdVlnkjuijxol7eW-HU93L-DEnrZ1i5a0pTPERkHtKCyxZExOeRBmS0RJz0OWUFiRqPBZW1QGYQAlBnE5wviyje0:1u5Hj6:n0Src4jTsJeyYcauA4CwM0VxtdEOgNmWUD1FGkfm-bE', '2025-05-01 05:23:52.171490');
INSERT INTO `django_session` VALUES ('ixhrn49ouwu83cwsenvti2t2ek9goodt', '.eJxVjM0OwiAQhN-FsyGyXX7q0bvPQFhYpGogKe3J-O62SQ96nPm-mbfwYV2KXzvPfkriIow4_XYU4pPrDtIj1HuTsdVlnkjuijxol7eW-HU93L-DEnrZ1i5a0pTPERkHtKCyxZExOeRBmS0RJz0OWUFiRqPBZW1QGYQAlBnE5wviyje0:1u1H4f:FwF3tRr7tCCQbhnLrh3mEJm_KSpFEc0dhW-PESeq1mg', '2025-04-20 03:53:33.716165');
INSERT INTO `django_session` VALUES ('j8zylrvq4dl0ou8tnik3q1dxbbhz0cnf', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1tzyM2:rfA3G8vtPv4yo8KsjkKwCebahh522B20RkxkO2w7Ou8', '2025-04-16 13:42:06.003438');
INSERT INTO `django_session` VALUES ('jc67sn6pftn93abfo6ksb8u06hi3jpkj', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u671N:k582_7cv4YK6TvJFofHozuZy0M_iYtciAnLH3RNKDss', '2025-05-03 12:10:09.796078');
INSERT INTO `django_session` VALUES ('jovfclnkt5km1irin4otnjzerc41ogyo', '.eJxVjEEOwiAQRe_C2hBohwx16d4zkIEZpGogKe3KeHdt0oVu_3vvv1SgbS1h67KEmdVZOXX63SKlh9Qd8J3qrenU6rrMUe-KPmjX18byvBzu30GhXr71JJCjn5KJLnsZGWgYPFIS6wz4PGZncIgICOwd0sQsFjICWCcWfVLvD-1FN78:1tzXkq:xA-FLO0R6LOOlN-qirMWw6bfzFyTYkKkrYmoCLLoy1A', '2025-04-15 09:17:56.866654');
INSERT INTO `django_session` VALUES ('jy0ksxrbnynjb9b1lc9ojvkp7lcpcqfj', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1tyj1V:pwabnjdIplqeOcfCvsRYVVoVB2iONjnJZZlfGJmOvVQ', '2025-04-13 03:07:45.938172');
INSERT INTO `django_session` VALUES ('k0n4jpy1ch9an7af4uq82mhdwvyqp7v6', '.eJxVjEEOwiAQRe_C2hBohwx16d4zkIEZpGogKe3KeHdt0oVu_3vvv1SgbS1h67KEmdVZOXX63SKlh9Qd8J3qrenU6rrMUe-KPmjX18byvBzu30GhXr71JJCjn5KJLnsZGWgYPFIS6wz4PGZncIgICOwd0sQsFjICWCcWfVLvD-1FN78:1u67Mk:yCohvibKFWMJ7jMNLqzJNr5uSYKpXxIz8puKgMLQpVE', '2025-05-03 12:32:14.903055');
INSERT INTO `django_session` VALUES ('k5yzu83bkh1ht4di6unlwaxj2dj3kie4', '.eJxVjM0OwiAQhN-FsyGyXX7q0bvPQFhYpGogKe3J-O62SQ96nPm-mbfwYV2KXzvPfkriIow4_XYU4pPrDtIj1HuTsdVlnkjuijxol7eW-HU93L-DEnrZ1i5a0pTPERkHtKCyxZExOeRBmS0RJz0OWUFiRqPBZW1QGYQAlBnE5wviyje0:1u257c:24EgmbA8iXZRztQMDmm0nt6jbOETIbePLwNoff8lbYs', '2025-04-22 09:19:56.503527');
INSERT INTO `django_session` VALUES ('kap13gziy9htkotlgpxqlo1w4qz40lte', '.eJxVjM0OwiAQhN-FsyGyXX7q0bvPQFhYpGogKe3J-O62SQ96nPm-mbfwYV2KXzvPfkriIow4_XYU4pPrDtIj1HuTsdVlnkjuijxol7eW-HU93L-DEnrZ1i5a0pTPERkHtKCyxZExOeRBmS0RJz0OWUFiRqPBZW1QGYQAlBnE5wviyje0:1u5EPR:C7yqqfsPdUJxt0k9V7W1QkImFWG_JcQhPqHzMxBlYzc', '2025-05-01 01:51:21.722808');
INSERT INTO `django_session` VALUES ('ki0sq853vai5u9toz4j1zvlyxsvu4g6n', '.eJxVjM0OwiAQhN-FsyGyXX7q0bvPQFhYpGogKe3J-O62SQ96nPm-mbfwYV2KXzvPfkriIow4_XYU4pPrDtIj1HuTsdVlnkjuijxol7eW-HU93L-DEnrZ1i5a0pTPERkHtKCyxZExOeRBmS0RJz0OWUFiRqPBZW1QGYQAlBnE5wviyje0:1u25Oh:wCTCCIgoFBXFNd6B4f8gNGcbj4U-tcx6ePCqsAe1DA4', '2025-04-22 09:37:35.629812');
INSERT INTO `django_session` VALUES ('m7hk4tmniuudoz6zuf8zymto0kbejs68', '.eJxVjM0OwiAQhN-FsyGyXX7q0bvPQFhYpGogKe3J-O62SQ96nPm-mbfwYV2KXzvPfkriIow4_XYU4pPrDtIj1HuTsdVlnkjuijxol7eW-HU93L-DEnrZ1i5a0pTPERkHtKCyxZExOeRBmS0RJz0OWUFiRqPBZW1QGYQAlBnE5wviyje0:1tzRKC:0bImZK4MBACLtNvV0xQGxQ-DGrWmX7vyPEBh7wYDde0', '2025-04-15 02:26:00.943362');
INSERT INTO `django_session` VALUES ('naw9ggkzz1iwiys55pjunhwy8vknv09b', '.eJxVjEEOwiAQRe_C2hBohwx16d4zkIEZpGogKe3KeHdt0oVu_3vvv1SgbS1h67KEmdVZOXX63SKlh9Qd8J3qrenU6rrMUe-KPmjX18byvBzu30GhXr71JJCjn5KJLnsZGWgYPFIS6wz4PGZncIgICOwd0sQsFjICWCcWfVLvD-1FN78:1u66vM:1nPWN912cSzF0f_5UiUf--TMEIkFhNydTjH_TYHajfM', '2025-05-03 12:03:56.136394');
INSERT INTO `django_session` VALUES ('ne5way1g2qos5wnwv8g8ynmbwo7stwrt', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1tzDGx:eX9roXRG7dtGW6MFkm-6y8wDo9T4w8MXx_zZkvGHr7o', '2025-04-14 11:25:43.510141');
INSERT INTO `django_session` VALUES ('njz8leakouiudg6vch3ckej2sdacsbf0', '.eJxVjEEOwiAQRe_C2hBohwx16d4zkIEZpGogKe3KeHdt0oVu_3vvv1SgbS1h67KEmdVZOXX63SKlh9Qd8J3qrenU6rrMUe-KPmjX18byvBzu30GhXr71JJCjn5KJLnsZGWgYPFIS6wz4PGZncIgICOwd0sQsFjICWCcWfVLvD-1FN78:1u27Io:N8BFRX_fCN6ber48jYkNq6O-ALLNNNSbuKniYbW0zmQ', '2025-04-22 11:39:38.813156');
INSERT INTO `django_session` VALUES ('nmek6m9cqvau4h1tnwfkfqyntcuxcucl', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u1EyJ:REbcJy93N8l9EzEcnTsWpZYWwpARk2cYUjbXkjuR9-o', '2025-04-20 01:38:51.656307');
INSERT INTO `django_session` VALUES ('o9v54zg94ml25rz75ut21o0dcg5sadu3', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1tyooh:TVy2yEeLwxQCk4Jif-RyzHr91008NWMmmUWpRKZbysI', '2025-04-13 09:18:55.952075');
INSERT INTO `django_session` VALUES ('oi5fpslhicuvmr5vi5g0dkbg50mtz5rl', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u0IbP:eQi4qOe20aazDfRfItN3IMM38Dn9aHSf8fLj3MkJp8U', '2025-04-17 11:19:19.689597');
INSERT INTO `django_session` VALUES ('p46rqgfwnmx3wgidljpg6qxo6wmnsn4c', '.eJxVjM0OwiAQhN-FsyGyXX7q0bvPQFhYpGogKe3J-O62SQ96nPm-mbfwYV2KXzvPfkriIow4_XYU4pPrDtIj1HuTsdVlnkjuijxol7eW-HU93L-DEnrZ1i5a0pTPERkHtKCyxZExOeRBmS0RJz0OWUFiRqPBZW1QGYQAlBnE5wviyje0:1u1Dj1:xo2MNrXT5r1KVn1IiA_dBvvJm8l-Hah-cQ765jkWfHs', '2025-04-20 00:18:59.888496');
INSERT INTO `django_session` VALUES ('pqz6ie264je5zs142iy3iom1m8s84aap', '.eJxVjM0OwiAQhN-FsyGyXX7q0bvPQFhYpGogKe3J-O62SQ96nPm-mbfwYV2KXzvPfkriIow4_XYU4pPrDtIj1HuTsdVlnkjuijxol7eW-HU93L-DEnrZ1i5a0pTPERkHtKCyxZExOeRBmS0RJz0OWUFiRqPBZW1QGYQAlBnE5wviyje0:1u2l4k:Yd4YdZQnppigU97ry72eLA2Op0hNcRc1nEgimCNhSGI', '2025-04-24 06:07:46.595200');
INSERT INTO `django_session` VALUES ('qo6jhi575ekgcszndba900081q6al9j5', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u2Wkk:AUO-qo2WctKCuJXvqfGbKj1h-3ah03fBy_OZ9UZCLck', '2025-04-23 14:50:10.556560');
INSERT INTO `django_session` VALUES ('qtrhrqob6561gu41aofv2m2lmktukxs3', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u5I2H:7UVC3_BeBWMpfJi3ZSh_EJ-wSfE3VQfN174deUZ3NTA', '2025-05-01 05:43:41.371690');
INSERT INTO `django_session` VALUES ('qyf5falytb9osqj4uhknuxwsao19cpa0', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u1KBc:mh3umnKkV1Pay_BayldXGCrjaWTi1VdVmrJtR2JHJhM', '2025-04-20 07:12:56.640748');
INSERT INTO `django_session` VALUES ('r4r9houmddcaro2x8a7fcxdtwhppjo1o', '.eJxVjEEOwiAQRe_C2hBohwx16d4zkIEZpGogKe3KeHdt0oVu_3vvv1SgbS1h67KEmdVZOXX63SKlh9Qd8J3qrenU6rrMUe-KPmjX18byvBzu30GhXr71JJCjn5KJLnsZGWgYPFIS6wz4PGZncIgICOwd0sQsFjICWCcWfVLvD-1FN78:1u5I19:xN6rnXdQ9-mkNQhV767gh7rW0KNPhXwWFm50BrgdhHo', '2025-05-01 05:42:31.233553');
INSERT INTO `django_session` VALUES ('r7lotzjylbuybkkiukeza34m3w5h5vcs', '.eJxVjDsOwjAQRO_iGlla_Kek5wzWrr3GAWRLcVIh7k4ipYBminlv5i0irkuN6-A5TllcRBCn344wPbntID-w3btMvS3zRHJX5EGHvPXMr-vh_h1UHHVbp6ICOTbFbhGYrAtWc_CKOKvgLFE5awOAPmWEAsYbsOhBa4eMnMXnC_ijOFk:1tyjSf:fVc0kGvoo7hf5t4StLB2ifvv02XGsZjtfIAR44EntDE', '2025-04-13 03:35:49.603663');
INSERT INTO `django_session` VALUES ('s4cdmad2ubvz00rq37lzbxx13pty0gqa', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u0Ei7:tJUx7Gdig2BXGiFjlunAyN1pFZyj-SKbKLRjRqBNQHM', '2025-04-17 07:09:59.226427');
INSERT INTO `django_session` VALUES ('sgxbxsvlvyds6pib7v26pju8wpx36klh', '.eJxVjM0OwiAQhN-FsyGyXX7q0bvPQFhYpGogKe3J-O62SQ96nPm-mbfwYV2KXzvPfkriIow4_XYU4pPrDtIj1HuTsdVlnkjuijxol7eW-HU93L-DEnrZ1i5a0pTPERkHtKCyxZExOeRBmS0RJz0OWUFiRqPBZW1QGYQAlBnE5wviyje0:1u0Iak:VtCj7Z_yVFA1FVdjDsZnGufhchLOufG_MmvGbYzT0bY', '2025-04-17 11:18:38.416076');
INSERT INTO `django_session` VALUES ('tmbogg8li8k5mut7qf4e60rsvqd97kkf', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u1Det:3dWHV-XVaKXJohMpX2Gr4qZFOEal7xr3EITQbzFRHjc', '2025-04-20 00:14:43.167847');
INSERT INTO `django_session` VALUES ('udr3eysq7p2fkh274krh777myitznl88', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u67Oh:bFJDjenyKxTF6nudL32YTYJhX4Lv95f_g3lFPgSdgmM', '2025-05-03 12:34:15.002773');
INSERT INTO `django_session` VALUES ('v13dmuce2zmasj3jc80lngphfhhjkj6x', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u14Mu:c_oJA4MK4hpbiFRO52EOXqSZPIWEK-sIOQeKDCRXN5w', '2025-04-19 14:19:32.429444');
INSERT INTO `django_session` VALUES ('vk4w4arn778d7p56c1k7609o9w7mjmsg', '.eJxVjM0OwiAQhN-FsyGyXX7q0bvPQFhYpGogKe3J-O62SQ96nPm-mbfwYV2KXzvPfkriIow4_XYU4pPrDtIj1HuTsdVlnkjuijxol7eW-HU93L-DEnrZ1i5a0pTPERkHtKCyxZExOeRBmS0RJz0OWUFiRqPBZW1QGYQAlBnE5wviyje0:1u5HqO:vCHPiMd2tcF2rKrju3GpdZi5CKNyRDQdBVNT2dYCWpc', '2025-05-01 05:31:24.718364');
INSERT INTO `django_session` VALUES ('vrx5ziap7sffwmlcqyc3774h2ay2v4pu', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1tyjfR:6rNUAfec9ZcQA7IFO3dfBJys9eMpHF9asPMAWtjlm-s', '2025-04-13 03:49:01.172771');
INSERT INTO `django_session` VALUES ('vy0jmoea3fvsoxcukxgnwsfncm8tk5oz', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u27Se:RzV0hMUk4PruXMT2d6SOztB0tkwLSxNsYX6hC9klQV8', '2025-04-22 11:49:48.892697');
INSERT INTO `django_session` VALUES ('w02k4wp77aykmpmut1x5yhin53mux4k1', '.eJxVjEEOwiAQRe_C2hBohwx16d4zkIEZpGogKe3KeHdt0oVu_3vvv1SgbS1h67KEmdVZOXX63SKlh9Qd8J3qrenU6rrMUe-KPmjX18byvBzu30GhXr71JJCjn5KJLnsZGWgYPFIS6wz4PGZncIgICOwd0sQsFjICWCcWfVLvD-1FN78:1tzRKi:dsyBrFPNxuczks4bIZre8iN9mAU03HPXlLag1ML0VrQ', '2025-04-15 02:26:32.024599');
INSERT INTO `django_session` VALUES ('wa56cgzccpwx34hv1i3imq02pcxw8k1c', '.eJxVjM0OwiAQhN-FsyGyXX7q0bvPQFhYpGogKe3J-O62SQ96nPm-mbfwYV2KXzvPfkriIow4_XYU4pPrDtIj1HuTsdVlnkjuijxol7eW-HU93L-DEnrZ1i5a0pTPERkHtKCyxZExOeRBmS0RJz0OWUFiRqPBZW1QGYQAlBnE5wviyje0:1u66v8:S9R6Sodvz7U36SdSH6vIjNSDPAc8zF9Zi4PD1DchIPc', '2025-05-03 12:03:42.685650');
INSERT INTO `django_session` VALUES ('wlfz70gvnxhjm34xj54xkntw8nfuri9a', '.eJxVjEEOwiAQRe_C2hBohwx16d4zkIEZpGogKe3KeHdt0oVu_3vvv1SgbS1h67KEmdVZOXX63SKlh9Qd8J3qrenU6rrMUe-KPmjX18byvBzu30GhXr71JJCjn5KJLnsZGWgYPFIS6wz4PGZncIgICOwd0sQsFjICWCcWfVLvD-1FN78:1u2jdu:K1V0AR_7vHRk5n5Rh4KuOsML8qypYOSwG_oHgMLCDrQ', '2025-04-24 04:35:58.484419');
INSERT INTO `django_session` VALUES ('wwn2drmxe4obau6ifshckgjb1nelnha9', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1tyj41:bnzKbjViSXdrj-RCnrJk-1pkTJ31m_sh-fjTPngDKGQ', '2025-04-13 03:10:21.528378');
INSERT INTO `django_session` VALUES ('xlqt4h537dal2ho0gks74w0hgouhhs5d', '.eJxVjEEOwiAQRe_C2hBohwx16d4zkIEZpGogKe3KeHdt0oVu_3vvv1SgbS1h67KEmdVZOXX63SKlh9Qd8J3qrenU6rrMUe-KPmjX18byvBzu30GhXr71JJCjn5KJLnsZGWgYPFIS6wz4PGZncIgICOwd0sQsFjICWCcWfVLvD-1FN78:1u1DGo:jgIzKEn_qoVnkZ95sRQflUVX-D6SBIcsD-IXA_4iSv4', '2025-04-19 23:49:50.394274');
INSERT INTO `django_session` VALUES ('xv6bsisrl36hh8jt9bf0aotq48wj3jqv', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u67I7:ZxfBw4Fs_2_KXTCLV0D8hnNnfxrxtOhxtIxE8e9uzlM', '2025-05-03 12:27:27.365714');
INSERT INTO `django_session` VALUES ('y7217rhhazkzzbhokehtldxh5va6dlui', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u2jA1:Cs0vBvZn1wrq4X0d7PulhCWEyReQQWgt2EXJofmq9jg', '2025-04-24 04:05:05.144534');
INSERT INTO `django_session` VALUES ('yqmxniwa9044432exijzax6191lx5ijk', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u5EQp:c8Xlo7f6K_46OiYzTKFjY7d71YrY5rDHBzHrZMoS--E', '2025-05-01 01:52:47.261375');
INSERT INTO `django_session` VALUES ('z60wn3ojjafjifpm979tgy5wabw6v4kw', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1tyiu9:qbac4W1PgpDxrv7mCAiwIib1HErod5hWfbWvM0WRVog', '2025-04-13 03:00:09.072138');
INSERT INTO `django_session` VALUES ('z83iym6csr1hw57875cys4tbyrls9acw', '.eJxVjEEOwiAQRe_C2hBohwx16d4zkIEZpGogKe3KeHdt0oVu_3vvv1SgbS1h67KEmdVZOXX63SKlh9Qd8J3qrenU6rrMUe-KPmjX18byvBzu30GhXr71JJCjn5KJLnsZGWgYPFIS6wz4PGZncIgICOwd0sQsFjICWCcWfVLvD-1FN78:1u24sx:7dXk80qTlhqxswu_WQt33GmNTxnv6l-sqOKrjlrPWsY', '2025-04-22 09:04:47.630967');
INSERT INTO `django_session` VALUES ('zbxjwnulownxjusebh9rwggnep4ru359', '.eJxVjDsOwjAQBe_iGln-xY4p6TmDtetd4wBypDipEHeHSCmgfTPzXiLBtta0dV7SROIsgjj9bgj5wW0HdId2m2We27pMKHdFHrTL60z8vBzu30GFXr-1MnaMaJm1NblQiMqxA11iNHbQFhUVZgSNYLyh4h1b79QYgwl5IOXE-wPgADee:1u1wAv:Wzt_UW--y0-YgmjWqmb1L9nsrQOSk0TYM7q7_azB5PQ', '2025-04-21 23:46:45.343805');

SET FOREIGN_KEY_CHECKS = 1;
