SELECT `pet_table`.`id`,`race`.`racenick` 
FROM `pet_test`.`pet_table` 
JOIN `pet_test`.`race` 
ON `pet_table`.`race`=`race`.`id` 
WHERE `pet_table`.`id`=2;