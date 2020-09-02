CREATE TABLE `SQL_1`.`product_t` (
  `product_id` INT NOT NULL,
  `product_description` VARCHAR(50) NULL,
  `product_finish` VARCHAR(20) NULL,
  `standard_price` DECIMAL(6,2) NULL,
  `product_line_id` INT NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT check (`product_finish` in ('Cherry', 'Natural Ash', 'White Ash', 'Red Oak', 'Natural Oak', 'Walnut'))
  );
  
  CREATE TABLE `SQL_1`.`order_t` (
  `order_id` DECIMAL(11,0) NOT NULL,
  `order_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_id` DECIMAL(11,0) NULL,
  PRIMARY KEY (`order_id`),
  INDEX `order_fk_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `order_fk`
    FOREIGN KEY (`customer_id`)
    REFERENCES `SQL_1`.`customer_t` (`CUSTOMER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);