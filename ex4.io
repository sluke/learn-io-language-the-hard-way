# 先clone对象
Cars := Object clone
Cars := 100
# 直接给对象的slot添加值
SpaceInACar := 4
Drivers := 30
Passengers := 90
CarsNotDriven := Cars-Drivers
CarsDriven := Drivers
CarpoolCapacity := CarsDriven*SpaceInACar
AveragePassengersPerCar := Passengers/CarsDriven

"There are " print .. Cars print .. " cars available." println
"There are only " print .. Drivers print .. " drives available." println
"There will be " print .. CarsNotDriven print .. " empty cars today." println
"We can transport " print .. CarpoolCapacity print .. " people today." println
"We have " print .. Passengers print .. " to carpool today." println
"We need to put about " print .. AveragePassengersPerCar print .. " in each car." println
