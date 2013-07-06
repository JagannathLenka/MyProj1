# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#=begin
Bay.delete_all
Aisle.delete_all


Aisle.create(aisle_id: "1",customer_aisle_id: "06",zone_id: "zone1",properties1: "drivepath",properties2: "",properties3: "")
Bay.create(bay_id: "1",customer_bay_id: "",aisle_id: "1",properties1: "bay",properties2: "FD04",properties3: "")
Bay.create(bay_id: "2",customer_bay_id: "",aisle_id: "1",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "3",customer_bay_id: "",aisle_id: "1",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "4",customer_bay_id: "",aisle_id: "1",properties1: "bay",properties2: "FD05",properties3: "")

Aisle.create(aisle_id: "2",customer_aisle_id: "07",zone_id: "zone1",properties1: "divider",properties2: "",properties3: "")
Bay.create(bay_id: "5",customer_bay_id: "",aisle_id: "2",properties1: "bay",properties2: "FD07",properties3: "")
Bay.create(bay_id: "6",customer_bay_id: "",aisle_id: "2",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "7",customer_bay_id: "",aisle_id: "2",properties1: "bay",properties2: "FD07",properties3: "")
Bay.create(bay_id: "8",customer_bay_id: "",aisle_id: "2",properties1: "bay",properties2: "FD08",properties3: "")

Aisle.create(aisle_id: "3",customer_aisle_id: "08",zone_id: "zone1",properties1: "drivepath",properties2: "",properties3: "")
Bay.create(bay_id: "9",customer_bay_id: "",aisle_id: "3",properties1: "bay",properties2: "FD09",properties3: "")
Bay.create(bay_id: "10",customer_bay_id: "",aisle_id: "3",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "11",customer_bay_id: "",aisle_id: "3",properties1: "bay",properties2: "FD09",properties3: "")
Bay.create(bay_id: "12",customer_bay_id: "",aisle_id: "3",properties1: "bay",properties2: "FD10",properties3: "")

Aisle.create(aisle_id: "4",customer_aisle_id: "09",zone_id: "zone1",properties1: "divider",properties2: "",properties3: "")
Bay.create(bay_id: "13",customer_bay_id: "",aisle_id: "4",properties1: "bay",properties2: "SP02",properties3: "")
Bay.create(bay_id: "14",customer_bay_id: "",aisle_id: "4",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "15",customer_bay_id: "",aisle_id: "4",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "16",customer_bay_id: "",aisle_id: "4",properties1: "bay",properties2: "SP09",properties3: "")

Aisle.create(aisle_id: "5",customer_aisle_id: "10",zone_id: "zone1",properties1: "drivepath",properties2: "",properties3: "")
Bay.create(bay_id: "17",customer_bay_id: "",aisle_id: "5",properties1: "bay",properties2: "SP28",properties3: "")
Bay.create(bay_id: "18",customer_bay_id: "",aisle_id: "5",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "19",customer_bay_id: "",aisle_id: "5",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "20",customer_bay_id: "",aisle_id: "5",properties1: "bay",properties2: "SP19",properties3: "")

Aisle.create(aisle_id: "6",customer_aisle_id: "11",zone_id: "zone1",properties1: "divider",properties2: "",properties3: "")
Bay.create(bay_id: "21",customer_bay_id: "",aisle_id: "6",properties1: "bay", properties2: "SP16",properties3: "")
Bay.create(bay_id: "22",customer_bay_id: "",aisle_id: "6",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "23",customer_bay_id: "",aisle_id: "6",properties1: "bay",properties2: "SP16",properties3: "")
Bay.create(bay_id: "24",customer_bay_id: "",aisle_id: "6",properties1: "bay",properties2: "SP16",properties3: "")

Aisle.create(aisle_id: "7",customer_aisle_id: "12",zone_id: "zone1",properties1: "drivepath",properties2: "",properties3: "")
Bay.create(bay_id: "25",customer_bay_id: "",aisle_id: "7",properties1: "bay",properties2: "KD20",properties3: "")
Bay.create(bay_id: "26",customer_bay_id: "",aisle_id: "7",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "27",customer_bay_id: "",aisle_id: "7",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "28",customer_bay_id: "",aisle_id: "7",properties1: "bay",properties2: "KD18",properties3: "")

Aisle.create(aisle_id: "8",customer_aisle_id: "",zone_id: "zone1",properties1: "divider",properties2: "",properties3: "")
Bay.create(bay_id: "29",customer_bay_id: "",aisle_id: "8",properties1: "bay",properties2: "DP10",properties3: "")
Bay.create(bay_id: "30",customer_bay_id: "",aisle_id: "8",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "31",customer_bay_id: "",aisle_id: "8",properties1: "bay",properties2: "DP10",properties3: "")
Bay.create(bay_id: "32",customer_bay_id: "",aisle_id: "8",properties1: "bay",properties2: "DP10",properties3: "")

#=end
Position.delete_all
Level.delete_all


Level.create(bay_id: "1", customerlevel_id: "" , level_id: "A", properties1:"stretch",properties2:"",properties3: "")
Level.create(bay_id: "1", customerlevel_id: "" , level_id: "B", properties1:"stretch",properties2:"",properties3: "")
Level.create(bay_id: "1", customerlevel_id: "" , level_id: "C", properties1:"normal",properties2:"",properties3: "")
Level.create(bay_id: "1", customerlevel_id: "" , level_id: "D", properties1:"normal",properties2:"",properties3: "")
Level.create(bay_id: "1", customerlevel_id: "" , level_id: "E", properties1:"normal",properties2:"",properties3: "")
Level.create(bay_id: "1", customerlevel_id: "" , level_id: "F", properties1:"bend",properties2:"",properties3: "")
Level.create(bay_id: "1", customerlevel_id: "" , level_id: "G", properties1:"bend",properties2:"",properties3: "")

Level.create(bay_id: "bay2", customerlevel_id: "" , level_id: "A", properties1:"stretch",properties2:"",properties3: "")
Level.create(bay_id: "bay2", customerlevel_id: "" , level_id: "B", properties1:"stretch",properties2:"",properties3: "")
Level.create(bay_id: "bay2", customerlevel_id: "" , level_id: "C", properties1:"normal",properties2:"",properties3: "")
Level.create(bay_id: "bay2", customerlevel_id: "" , level_id: "D", properties1:"normal",properties2:"",properties3: "")
Level.create(bay_id: "bay2", customerlevel_id: "" , level_id: "E", properties1:"normal",properties2:"",properties3: "")
Level.create(bay_id: "bay2", customerlevel_id: "" , level_id: "F", properties1:"bend",properties2:"",properties3: "")
Level.create(bay_id: "bay2", customerlevel_id: "" , level_id: "G", properties1:"bend",properties2:"",properties3: "")

Level.create(bay_id: "13", customerlevel_id: "" , level_id: "A", properties1:"stretch",properties2:"",properties3: "")
Level.create(bay_id: "13", customerlevel_id: "" , level_id: "B", properties1:"stretch",properties2:"",properties3: "")
Level.create(bay_id: "13", customerlevel_id: "" , level_id: "C", properties1:"normal",properties2:"",properties3: "")
Level.create(bay_id: "13", customerlevel_id: "" , level_id: "D", properties1:"normal",properties2:"",properties3: "")
Level.create(bay_id: "13", customerlevel_id: "" , level_id: "E", properties1:"normal",properties2:"",properties3: "")
Level.create(bay_id: "13", customerlevel_id: "" , level_id: "F", properties1:"bend",properties2:"",properties3: "")
Level.create(bay_id: "13", customerlevel_id: "" , level_id: "G", properties1:"bend",properties2:"",properties3: "")

Level.create(bay_id: "bay31", customerlevel_id: "" , level_id: "A", properties1:"stretch",properties2:"",properties3: "")
Level.create(bay_id: "bay31", customerlevel_id: "" , level_id: "B", properties1:"stretch",properties2:"",properties3: "")
Level.create(bay_id: "bay31", customerlevel_id: "" , level_id: "C", properties1:"normal",properties2:"",properties3: "")
Level.create(bay_id: "bay31", customerlevel_id: "" , level_id: "D", properties1:"normal",properties2:"",properties3: "")
Level.create(bay_id: "bay31", customerlevel_id: "" , level_id: "E", properties1:"normal",properties2:"",properties3: "")
Level.create(bay_id: "bay31", customerlevel_id: "" , level_id: "F", properties1:"bend",properties2:"",properties3: "")
Level.create(bay_id: "bay31", customerlevel_id: "" , level_id: "G", properties1:"bend",properties2:"",properties3: "")




Position.create(pos_id: "pos1",bay_id: "1",level_id: "A",properties1:"pos",properties2:"Item5",properties3: "")
Position.create(pos_id: "pos2",bay_id: "1",level_id: "A",properties1:"pos",properties2:"item2",properties3: "")
Position.create(pos_id: "pos3",bay_id: "1",level_id: "A",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos4",bay_id: "1",level_id: "A",properties1:"pos",properties2:"item9",properties3: "")
Position.create(pos_id: "pos5",bay_id: "1",level_id: "A",properties1:"pos",properties2:"item4",properties3: "")
Position.create(pos_id: "pos6",bay_id: "1",level_id: "A",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos7",bay_id: "1",level_id: "A",properties1:"pos",properties2:"item3",properties3: "")
Position.create(pos_id: "pos8",bay_id: "1",level_id: "A",properties1:"pos",properties2:"item1",properties3: "")



Position.create(pos_id: "pos9",bay_id: "1",level_id: "B",properties1:"pos",properties2:"item2",properties3: "")
Position.create(pos_id: "pos10",bay_id: "1",level_id: "B",properties1:"pos",properties2:"item3",properties3: "")
Position.create(pos_id: "pos11",bay_id: "1",level_id: "B",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos12",bay_id: "1",level_id: "B",properties1:"pos",properties2:"item7",properties3: "")
Position.create(pos_id: "pos13",bay_id: "1",level_id: "B",properties1:"pos",properties2:"item6",properties3: "")
Position.create(pos_id: "pos14",bay_id: "1",level_id: "B",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos15",bay_id: "1",level_id: "B",properties1:"pos",properties2:"Item4",properties3: "")
Position.create(pos_id: "pos16",bay_id: "1",level_id: "B",properties1:"pos_Empty",properties2:"",properties3: "")

Position.create(pos_id: "pos17",bay_id: "1",level_id: "C",properties1:"pos",properties2:"Item5",properties3: "")
Position.create(pos_id: "pos18",bay_id: "1",level_id: "C",properties1:"pos",properties2:"item2",properties3: "")
Position.create(pos_id: "pos19",bay_id: "1",level_id: "C",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos20",bay_id: "1",level_id: "C",properties1:"pos",properties2:"item9",properties3: "")
Position.create(pos_id: "pos21",bay_id: "1",level_id: "C",properties1:"pos",properties2:"item4",properties3: "")
Position.create(pos_id: "pos22",bay_id: "1",level_id: "C",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos23",bay_id: "1",level_id: "C",properties1:"pos",properties2:"item3",properties3: "")
Position.create(pos_id: "pos24",bay_id: "1",level_id: "C",properties1:"pos",properties2:"item1",properties3: "")

Position.create(pos_id: "pos25",bay_id: "1",level_id: "D",properties1:"pos",properties2:"item2",properties3: "")
Position.create(pos_id: "pos26",bay_id: "1",level_id: "D",properties1:"pos",properties2:"item3",properties3: "")
Position.create(pos_id: "pos27",bay_id: "1",level_id: "D",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos28",bay_id: "1",level_id: "D",properties1:"pos",properties2:"item7",properties3: "")
Position.create(pos_id: "pos29",bay_id: "1",level_id: "D",properties1:"pos",properties2:"item6",properties3: "")
Position.create(pos_id: "pos30",bay_id: "1",level_id: "D",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos31",bay_id: "1",level_id: "D",properties1:"pos",properties2:"Item4",properties3: "")
Position.create(pos_id: "pos32",bay_id: "1",level_id: "D",properties1:"pos_Empty",properties2:"",properties3: "")

Position.create(pos_id: "pos33",bay_id: "1",level_id: "E",properties1:"pos",properties2:"Item5",properties3: "")
Position.create(pos_id: "pos34",bay_id: "1",level_id: "E",properties1:"pos",properties2:"item2",properties3: "")
Position.create(pos_id: "pos35",bay_id: "1",level_id: "E",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos36",bay_id: "1",level_id: "E",properties1:"pos",properties2:"item9",properties3: "")
Position.create(pos_id: "pos37",bay_id: "1",level_id: "E",properties1:"pos",properties2:"item4",properties3: "")
Position.create(pos_id: "pos38",bay_id: "1",level_id: "E",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos39",bay_id: "1",level_id: "E",properties1:"pos",properties2:"item3",properties3: "")
Position.create(pos_id: "pos40",bay_id: "1",level_id: "E",properties1:"pos",properties2:"item1",properties3: "")


Position.create(pos_id:  "pos41" ,bay_id:  "1" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos42" ,bay_id:  "1" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos43" ,bay_id:  "1" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos44" ,bay_id:  "1" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos45" ,bay_id:  "1" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos46" ,bay_id:  "1" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos47" ,bay_id:  "1" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos48" ,bay_id:  "1" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )

Position.create(pos_id:  "pos49" ,bay_id:  "1" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos50" ,bay_id:  "1" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos51" ,bay_id:  "1" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos52" ,bay_id:  "1" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos53" ,bay_id:  "1" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos54" ,bay_id:  "1" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos55" ,bay_id:  "1" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos56" ,bay_id:  "1" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )


Position.create(pos_id:  "pos57" ,bay_id:  "4" ,level_id:  "A" ,properties1:  "pos_Empty" ,properties2:  "" ,properties3:  "" )
Position.create(pos_id:  "pos58" ,bay_id:  "4" ,level_id:  "A" ,properties1:  "pos_Empty" ,properties2:  "" ,properties3:  "" )
Position.create(pos_id:  "pos59" ,bay_id:  "4" ,level_id:  "A" ,properties1:  "pos_Empty" ,properties2: "" ,properties3:  "" )
Position.create(pos_id:  "pos60" ,bay_id:  "4" ,level_id:  "A" ,properties1:  "pos_Empty" ,properties2:  "" ,properties3:  "" )
Position.create(pos_id:  "pos61" ,bay_id:  "4" ,level_id:  "A" ,properties1:  "pos_Empty" ,properties2:  "" ,properties3:  "" )
Position.create(pos_id:  "pos62" ,bay_id:  "4" ,level_id:  "A" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos63" ,bay_id:  "4" ,level_id:  "A" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos64" ,bay_id:  "4" ,level_id:  "A" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )

Position.create(pos_id:  "pos65" ,bay_id:  "4" ,level_id:  "B" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos66" ,bay_id:  "4" ,level_id:  "B" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos67" ,bay_id:  "4" ,level_id:  "B" ,properties1:  "pos_Empty" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos68" ,bay_id:  "4" ,level_id:  "B" ,properties1:  "pos_Empty" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos69" ,bay_id:  "4" ,level_id:  "B" ,properties1:  "pos_Empty" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos70" ,bay_id:  "4" ,level_id:  "B" ,properties1:  "pos_Empty" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos71" ,bay_id:  "4" ,level_id:  "B" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos72" ,bay_id:  "4" ,level_id:  "B" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )

Position.create(pos_id:  "pos73" ,bay_id:  "4" ,level_id:  "C" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos74" ,bay_id:  "4" ,level_id:  "C" ,properties1:  "pos_Empty" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos75" ,bay_id:  "4" ,level_id:  "C" ,properties1:  "pos_Empty" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos76" ,bay_id:  "4" ,level_id:  "C" ,properties1:  "pos_Empty" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos77" ,bay_id:  "4" ,level_id:  "C" ,properties1:  "pos_Empty" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos78" ,bay_id:  "4" ,level_id:  "C" ,properties1:  "pos_Empty" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos79" ,bay_id:  "4" ,level_id:  "C" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos80" ,bay_id:  "4" ,level_id:  "C" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )

Position.create(pos_id:  "pos57" ,bay_id:  "4" ,level_id:  "D" ,properties1:  "pos_Empty" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos58" ,bay_id:  "4" ,level_id:  "D" ,properties1:  "pos_Empty" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos59" ,bay_id:  "4" ,level_id:  "D" ,properties1:  "pos_Empty" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos60" ,bay_id:  "4" ,level_id:  "D" ,properties1:  "pos_Empty" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos61" ,bay_id:  "4" ,level_id:  "D" ,properties1:  "pos_Empty" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos62" ,bay_id:  "4" ,level_id:  "D" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos63" ,bay_id:  "4" ,level_id:  "D" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos64" ,bay_id:  "4" ,level_id:  "D" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )

#13
Position.create(pos_id: "pos1",bay_id: "13",level_id: "A",properties1:"pos",properties2:"Item5",properties3: "")
Position.create(pos_id: "pos2",bay_id: "13",level_id: "A",properties1:"pos",properties2:"item2",properties3: "")
Position.create(pos_id: "pos3",bay_id: "13",level_id: "A",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos4",bay_id: "13",level_id: "A",properties1:"pos",properties2:"item9",properties3: "")
Position.create(pos_id: "pos5",bay_id: "13",level_id: "A",properties1:"pos",properties2:"item4",properties3: "")
Position.create(pos_id: "pos6",bay_id: "13",level_id: "A",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos7",bay_id: "13",level_id: "A",properties1:"pos",properties2:"item3",properties3: "")
Position.create(pos_id: "pos8",bay_id: "13",level_id: "A",properties1:"pos",properties2:"item1",properties3: "")



Position.create(pos_id: "pos9",bay_id: "13",level_id: "B",properties1:"pos",properties2:"item2",properties3: "")
Position.create(pos_id: "pos10",bay_id: "13",level_id: "B",properties1:"pos",properties2:"item3",properties3: "")
Position.create(pos_id: "pos11",bay_id: "13",level_id: "B",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos12",bay_id: "13",level_id: "B",properties1:"pos",properties2:"item7",properties3: "")
Position.create(pos_id: "pos13",bay_id: "13",level_id: "B",properties1:"pos",properties2:"item6",properties3: "")
Position.create(pos_id: "pos14",bay_id: "13",level_id: "B",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos15",bay_id: "13",level_id: "B",properties1:"pos",properties2:"Item4",properties3: "")
Position.create(pos_id: "pos16",bay_id: "13",level_id: "B",properties1:"pos_Empty",properties2:"",properties3: "")

Position.create(pos_id: "pos17",bay_id: "13",level_id: "C",properties1:"pos",properties2:"Item5",properties3: "")
Position.create(pos_id: "pos18",bay_id: "13",level_id: "C",properties1:"pos",properties2:"item2",properties3: "")
Position.create(pos_id: "pos19",bay_id: "13",level_id: "C",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos20",bay_id: "13",level_id: "C",properties1:"pos",properties2:"item9",properties3: "")
Position.create(pos_id: "pos21",bay_id: "13",level_id: "C",properties1:"pos",properties2:"item4",properties3: "")
Position.create(pos_id: "pos22",bay_id: "13",level_id: "C",properties1:"pos",properties2:"",properties3: "")
Position.create(pos_id: "pos23",bay_id: "13",level_id: "C",properties1:"pos",properties2:"item3",properties3: "")
Position.create(pos_id: "pos24",bay_id: "13",level_id: "C",properties1:"pos",properties2:"item1",properties3: "")

Position.create(pos_id: "pos25",bay_id: "13",level_id: "D",properties1:"pos",properties2:"item2",properties3: "")
Position.create(pos_id: "pos26",bay_id: "13",level_id: "D",properties1:"pos",properties2:"item3",properties3: "")
Position.create(pos_id: "pos27",bay_id: "13",level_id: "D",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos28",bay_id: "13",level_id: "D",properties1:"pos",properties2:"item7",properties3: "")
Position.create(pos_id: "pos29",bay_id: "13",level_id: "D",properties1:"pos",properties2:"item6",properties3: "")
Position.create(pos_id: "pos30",bay_id: "13",level_id: "D",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos31",bay_id: "13",level_id: "D",properties1:"pos",properties2:"Item4",properties3: "")
Position.create(pos_id: "pos32",bay_id: "13",level_id: "D",properties1:"pos",properties2:"",properties3: "")

Position.create(pos_id: "pos33",bay_id: "13",level_id: "E",properties1:"pos",properties2:"Item5",properties3: "")
Position.create(pos_id: "pos34",bay_id: "13",level_id: "E",properties1:"pos",properties2:"item2",properties3: "")
Position.create(pos_id: "pos35",bay_id: "13",level_id: "E",properties1:"pos",properties2:"",properties3: "")
Position.create(pos_id: "pos36",bay_id: "13",level_id: "E",properties1:"pos",properties2:"item9",properties3: "")
Position.create(pos_id: "pos37",bay_id: "13",level_id: "E",properties1:"pos",properties2:"item4",properties3: "")
Position.create(pos_id: "pos38",bay_id: "13",level_id: "E",properties1:"pos",properties2:"",properties3: "")
Position.create(pos_id: "pos39",bay_id: "13",level_id: "E",properties1:"pos",properties2:"item3",properties3: "")
Position.create(pos_id: "pos40",bay_id: "13",level_id: "E",properties1:"pos",properties2:"item1",properties3: "")


Position.create(pos_id:  "pos41" ,bay_id:  "13" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos42" ,bay_id:  "13" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos43" ,bay_id:  "13" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos44" ,bay_id:  "13" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos45" ,bay_id:  "13" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos46" ,bay_id:  "13" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos47" ,bay_id:  "13" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos48" ,bay_id:  "13" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )

Position.create(pos_id:  "pos49" ,bay_id:  "13" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos50" ,bay_id:  "13" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos51" ,bay_id:  "13" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos52" ,bay_id:  "13" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos53" ,bay_id:  "13" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos54" ,bay_id:  "13" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos55" ,bay_id:  "13" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos56" ,bay_id:  "13" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )



#bay31

Position.create(pos_id: "pos1",bay_id: "31",level_id: "A",properties1:"pos",properties2:"Item5",properties3: "")
Position.create(pos_id: "pos2",bay_id: "31",level_id: "A",properties1:"pos",properties2:"item2",properties3: "")
Position.create(pos_id: "pos3",bay_id: "31",level_id: "A",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos4",bay_id: "31",level_id: "A",properties1:"pos",properties2:"item9",properties3: "")
Position.create(pos_id: "pos5",bay_id: "31",level_id: "A",properties1:"pos",properties2:"item4",properties3: "")
Position.create(pos_id: "pos6",bay_id: "31",level_id: "A",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos7",bay_id: "31",level_id: "A",properties1:"pos",properties2:"item3",properties3: "")
Position.create(pos_id: "pos8",bay_id: "31",level_id: "A",properties1:"pos",properties2:"item1",properties3: "")

Position.create(pos_id: "pos9",bay_id: "31",level_id: "B",properties1:"pos_Empty",properties2:"item2",properties3: "")
Position.create(pos_id: "pos10",bay_id: "31",level_id: "B",properties1:"pos",properties2:"item3",properties3: "")
Position.create(pos_id: "pos11",bay_id: "31",level_id: "B",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos12",bay_id: "31",level_id: "B",properties1:"pos",properties2:"item7",properties3: "")
Position.create(pos_id: "pos13",bay_id: "31",level_id: "B",properties1:"pos",properties2:"item6",properties3: "")
Position.create(pos_id: "pos14",bay_id: "31",level_id: "B",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos15",bay_id: "31",level_id: "B",properties1:"pos",properties2:"Item4",properties3: "")
Position.create(pos_id: "pos16",bay_id: "31",level_id: "B",properties1:"pos",properties2:"",properties3: "")

Position.create(pos_id: "pos17",bay_id: "31",level_id: "C",properties1:"pos",properties2:"Item5",properties3: "")
Position.create(pos_id: "pos18",bay_id: "31",level_id: "C",properties1:"pos",properties2:"item2",properties3: "")
Position.create(pos_id: "pos19",bay_id: "31",level_id: "C",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos20",bay_id: "31",level_id: "C",properties1:"pos",properties2:"item9",properties3: "")
Position.create(pos_id: "pos21",bay_id: "31",level_id: "C",properties1:"pos",properties2:"item4",properties3: "")
Position.create(pos_id: "pos22",bay_id: "31",level_id: "C",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos23",bay_id: "31",level_id: "C",properties1:"pos",properties2:"item3",properties3: "")
Position.create(pos_id: "pos24",bay_id: "31",level_id: "C",properties1:"pos",properties2:"item1",properties3: "")

Position.create(pos_id: "pos25",bay_id: "31",level_id: "D",properties1:"pos",properties2:"item2",properties3: "")
Position.create(pos_id: "pos26",bay_id: "31",level_id: "D",properties1:"pos_Empty",properties2:"item3",properties3: "")
Position.create(pos_id: "pos27",bay_id: "31",level_id: "D",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos28",bay_id: "31",level_id: "D",properties1:"pos",properties2:"item7",properties3: "")
Position.create(pos_id: "pos29",bay_id: "31",level_id: "D",properties1:"pos",properties2:"item6",properties3: "")
Position.create(pos_id: "pos30",bay_id: "31",level_id: "D",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos31",bay_id: "31",level_id: "D",properties1:"pos",properties2:"Item4",properties3: "")
Position.create(pos_id: "pos32",bay_id: "31",level_id: "D",properties1:"pos_Empty",properties2:"",properties3: "")

Position.create(pos_id: "pos33",bay_id: "31",level_id: "E",properties1:"pos",properties2:"Item5",properties3: "")
Position.create(pos_id: "pos34",bay_id: "31",level_id: "E",properties1:"pos",properties2:"item2",properties3: "")
Position.create(pos_id: "pos35",bay_id: "31",level_id: "E",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos36",bay_id: "31",level_id: "E",properties1:"pos",properties2:"item9",properties3: "")
Position.create(pos_id: "pos37",bay_id: "31",level_id: "E",properties1:"pos",properties2:"item4",properties3: "")
Position.create(pos_id: "pos38",bay_id: "31",level_id: "E",properties1:"pos_Empty",properties2:"",properties3: "")
Position.create(pos_id: "pos39",bay_id: "31",level_id: "E",properties1:"pos",properties2:"item3",properties3: "")
Position.create(pos_id: "pos40",bay_id: "31",level_id: "E",properties1:"pos",properties2:"item1",properties3: "")


Position.create(pos_id:  "pos41" ,bay_id:  "31" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos42" ,bay_id:  "31" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos43" ,bay_id:  "31" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos44" ,bay_id:  "31" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos45" ,bay_id:  "31" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos46" ,bay_id:  "31" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos47" ,bay_id:  "31" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos48" ,bay_id:  "31" ,level_id:  "F" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )

Position.create(pos_id:  "pos49" ,bay_id:  "31" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos50" ,bay_id:  "31" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos51" ,bay_id:  "31" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos52" ,bay_id:  "31" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos53" ,bay_id:  "31" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos54" ,bay_id:  "31" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos55" ,bay_id:  "31" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
Position.create(pos_id:  "pos56" ,bay_id:  "31" ,level_id:  "G" ,properties1:  "pos" ,properties2:  "item2" ,properties3:  "" )
