# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# def time_point_string
#   Time.now.strftime("%H:%M:%S:%L")
# end

# def seedfile(fname)
#   File.open File.join(Rails.root, "public/content/seeds/", fname)
# end

# puts "#{time_point_string}: Start seeding"

# # Use code of file 'db/seeds_more.rb'. This is way to split big seeds.rb file.
# # You can use instance variables (@something) declared in that file.
# require_relative 'seeds_more'

# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
# puts "#{time_point_string}: seed Static Files"
# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --

# sig = StaticFile.new
# sig.file = seedfile "example_pic.jpg"
# sig.save

# puts "#{time_point_string}: Seeding is done!"

ProductProperty.create([
 {
   name: "Страна производитель",
   product_property_values_attributes: [
     {
       value: "Китай"
     },
     {
       value: "Россия"
     },
     {
       value: "США"
     }
   ]
 },
 {
   name: "Бренд",
   product_property_values_attributes: [
     {
       value: "Nike"
     },
     {
       value: "Abibas"
     },
     {
       value: "Краскон"
     }
   ]
 }
])

VariantOption.create([
  {
    name: "Цвет",
    variant_option_values_attributes: [
      {
        value: "Синий"
      },
      {
        value: "Красный"
      }
    ]
  },
  {
    name: "Размер",
    variant_option_values_attributes: [
      {
        value: "XL"
      },
      {
        value: "L"
      }
    ]
  }
])

puts "Seed Prototypes"
prototypes = Prototype.create([
  {
    name: "Футболка",
    product_properties: ProductProperty.all,
    variant_options: VariantOption.all
  },
  {
    name: "Носки",
    product_properties: [ProductProperty.first],
    variant_options: [VariantOption.first]
  }
])

puts "Seed Products"
Product.create!([
  {
    name: "Test product",
    slug: "test1",
    description: "Description of test product",
    prototype_id: prototypes[0].id,
    variants_attributes: [
      {
        sku: "663690",
        width: "500",
      },
      {
        sku: "663691",
        width: "510"
      },
      {
        sku: "663692",
        width: "520"
      }
    ]
  }
])
