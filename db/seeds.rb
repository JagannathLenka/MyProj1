# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Bay.delete_all
Aisle.delete_all


Aisle.create(aisle_id: "aisle1",customer_aisle_id: "",zone_id: "zone1",properties1: "drivepath",properties2: "",properties3: "")
Bay.create(bay_id: "bay1",customer_bay_id: "",aisle_id: "aisle1",properties1: "bay",properties2: "item7",properties3: "")
Bay.create(bay_id: "bay2",customer_bay_id: "",aisle_id: "aisle1",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "bay3",customer_bay_id: "",aisle_id: "aisle1",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "bay4",customer_bay_id: "",aisle_id: "aisle1",properties1: "bay",properties2: "item3",properties3: "")

Aisle.create(aisle_id: "aisle2",customer_aisle_id: "",zone_id: "zone1",properties1: "divider",properties2: "",properties3: "")
Bay.create(bay_id: "bay5",customer_bay_id: "",aisle_id: "aisle2",properties1: "bay",properties2: "item8",properties3: "")
Bay.create(bay_id: "bay6",customer_bay_id: "",aisle_id: "aisle2",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "bay7",customer_bay_id: "",aisle_id: "aisle2",properties1: "bay",properties2: "item7",properties3: "")
Bay.create(bay_id: "bay8",customer_bay_id: "",aisle_id: "aisle2",properties1: "bay",properties2: "item3",properties3: "")

Aisle.create(aisle_id: "aisle3",customer_aisle_id: "",zone_id: "zone1",properties1: "drivepath",properties2: "",properties3: "")
Bay.create(bay_id: "bay9",customer_bay_id: "",aisle_id: "aisle3",properties1: "bay",properties2: "item8",properties3: "")
Bay.create(bay_id: "bay10",customer_bay_id: "",aisle_id: "aisle3",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "bay11",customer_bay_id: "",aisle_id: "aisle3",properties1: "bay",properties2: "item2",properties3: "")
Bay.create(bay_id: "bay12",customer_bay_id: "",aisle_id: "aisle3",properties1: "bay",properties2: "item3",properties3: "")

Aisle.create(aisle_id: "aisle4",customer_aisle_id: "",zone_id: "zone1",properties1: "divider",properties2: "",properties3: "")
Bay.create(bay_id: "bay13",customer_bay_id: "",aisle_id: "aisle4",properties1: "bay",properties2: "item8",properties3: "")
Bay.create(bay_id: "bay14",customer_bay_id: "",aisle_id: "aisle4",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "bay15",customer_bay_id: "",aisle_id: "aisle4",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "bay16",customer_bay_id: "",aisle_id: "aisle4",properties1: "bay",properties2: "item3",properties3: "")

Aisle.create(aisle_id: "aisle5",customer_aisle_id: "",zone_id: "zone1",properties1: "drivepath",properties2: "",properties3: "")
Bay.create(bay_id: "bay17",customer_bay_id: "",aisle_id: "aisle5",properties1: "bay",properties2: "item2",properties3: "")
Bay.create(bay_id: "bay18",customer_bay_id: "",aisle_id: "aisle5",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "bay19",customer_bay_id: "",aisle_id: "aisle5",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "bay20",customer_bay_id: "",aisle_id: "aisle5",properties1: "bay",properties2: "item3",properties3: "")

Aisle.create(aisle_id: "aisle6",customer_aisle_id: "",zone_id: "zone1",properties1: "divider",properties2: "",properties3: "")
Bay.create(bay_id: "bay21",customer_bay_id: "",aisle_id: "aisle6",properties1: "bay",properties2: "item8",properties3: "")
Bay.create(bay_id: "bay22",customer_bay_id: "",aisle_id: "aisle6",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "bay23",customer_bay_id: "",aisle_id: "aisle6",properties1: "bay",properties2: "item9",properties3: "")
Bay.create(bay_id: "bay24",customer_bay_id: "",aisle_id: "aisle6",properties1: "bay",properties2: "item3",properties3: "")

Aisle.create(aisle_id: "aisle7",customer_aisle_id: "",zone_id: "zone1",properties1: "drivepath",properties2: "",properties3: "")
Bay.create(bay_id: "bay25",customer_bay_id: "",aisle_id: "aisle7",properties1: "bay",properties2: "item2",properties3: "")
Bay.create(bay_id: "bay26",customer_bay_id: "",aisle_id: "aisle7",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "bay27",customer_bay_id: "",aisle_id: "aisle7",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "bay28",customer_bay_id: "",aisle_id: "aisle7",properties1: "bay",properties2: "item3",properties3: "")

Aisle.create(aisle_id: "aisle8",customer_aisle_id: "",zone_id: "zone1",properties1: "divider",properties2: "",properties3: "")
Bay.create(bay_id: "bay29",customer_bay_id: "",aisle_id: "aisle8",properties1: "bay",properties2: "item8",properties3: "")
Bay.create(bay_id: "bay30",customer_bay_id: "",aisle_id: "aisle8",properties1: "bay_Empty",properties2: "",properties3: "")
Bay.create(bay_id: "bay31",customer_bay_id: "",aisle_id: "aisle8",properties1: "bay",properties2: "item2",properties3: "")
Bay.create(bay_id: "bay32",customer_bay_id: "",aisle_id: "aisle8",properties1: "bay",properties2: "item3",properties3: "")






