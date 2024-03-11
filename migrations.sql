create table Perfume (
    perfume_id bigint primary key,
    perfume_name varchar(64) not null,
    brand_id bigint not null references Brands(brand_id),
    category_id bigint not null references Categories(category_id),
    bottle_id bigint not null references Bottles(bottle_id),
    price numeric(6,2) not null,
    descriptions text not null,
    updated_at timestamptz,
    created_at timestamptz not null

);

create table Categories (
    category_id bigint primary key,
    Category_name varchar(64) not null,
    updated_at timestamptz,
    created_at timestamptz not null
);

create table Bottles (
    bottle_id bigint primary key,
    bottle_name varchar(64) not null,
    volume smallint not null,
    material varchar(64) not null,
    updated_at timestamptz,
    created_at timestamptz not null
);

create table Brands (
    brand_id bigint primary key,
    brand_name varchar(64) not null,
    updated_at timestamptz,
    created_at timestamptz not null
);

create table Composition (
    composition_id bigint primary key,
    perfume_id bigint not null references Perfume(perfume_id),
    ingredient_id bigint not null references Ingredient(ingredient_id),
    percent tinyint not null,
    updated_at timestamptz,
    created_at timestamptz not null
);

create table Ingredient (
    ingredient_id bigint primary key,
    ingredient_name varchar(64) not null,
    updated_at timestamptz,
    created_at timestamptz not null
);

create table Payment (
    payment_id bigint primary key,
    order_id bigint not null references Orders(order_id),
    payment_date date,
    payment_method varchar(64) not null,
    updated_at timestamptz,
    created_at timestamptz not null
);

create table Orders (
    order_id bigint primary key,
    customer_id bigint not null references Customer(customer_id),
    order_date date,
    total_amount decimal(10,2),
    updated_at timestamptz,
    created_at timestamptz not null
);

create table Delivery (
    delivery_id bigint primary key,
    order_id bigint not null references Orders(order_id),
    delivery_date date,
    address text not null,
    updated_at timestamptz,
    created_at timestamptz not null
);

create table Customer (
    customer_id bigint primary key,
    customer_name varchar(256) not null,
    email varchar(128) not null,
    phone varchar(11) not null,
    updated_at timestamptz,
    created_at timestamptz not null
);

create table Review (
    review_id bigint primary key,
    perfume_id bigint not null references Perfume(perfume_id),
    customer_id bigint not null references Customer(customer_id),
    rating int,
    comment text,
    updated_at timestamptz,
    created_at timestamptz not null
);

create table Supplier (
    supplier_id bigint primary key,
    supplier_name varchar(128) not null,
    contact_person varchar(128) not null,
    phone varchar(11) not null,
    updated_at timestamptz,
    created_at timestamptz not null
);

create table Supply (
    supply_id bigint primary key,
    supplier_id bigint not null references Supplier(supplier_id),
    perfume_id bigint not null references Perfume(perfume_id),
    quantity smallint not null,
    supply_date date,
    updated_at timestamptz,
    created_at timestamptz not null
);

create table Promotion (
    promotion_id bigint primary key,
    promotion_name varchar(128) not null,
    start_date date,
    end_date date,
    updated_at timestamptz,
    created_at timestamptz not null
);

create table PromotionParticipation (
    participation_id bigint primary key,
    perfume_id bigint not null references Perfume(perfume_id),
    promotion_id bigint not null references Promotion(promotion_id),
    updated_at timestamptz,
    created_at timestamptz not null
);

create table Locations (
    location_id bigint primary key,
    location_name varchar(256) not null,
    updated_at timestamptz,
    created_at timestamptz not null
);

create table Shelf (
    shelf_id bigint primary key,
    store_id bigint not null references Store(store_id),
    shelf_number int not null,
    updated_at timestamptz,
    created_at timestamptz not null
);

create table Store (
    store_id bigint primary key,
    perfume_id bigint not null references Perfume(perfume_id),
    store_name varchar(256) not null,
    location_id bigint not null references Locations(location_id),
    updated_at timestamptz,
    created_at timestamptz not null
);

create table Employee (
    employee_id bigint primary key,
    employee_name varchar(128) not null,
    store_id bigint not null references Store(store_id),
    position varchar(128) not null,
    updated_at timestamptz,
    created_at timestamptz not null
);

create table Salary (
    salary_id bigint primary key,
    employee_id bigint not null references Employee(employee_id),
    month date,
    amount decimal(10, 2),
    updated_at timestamptz,
    created_at timestamptz not null
);