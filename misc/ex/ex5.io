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

s := ("There are " .. Cars .. " cars available.") println
("There are only " .. Drivers .. " drives available.") println
	