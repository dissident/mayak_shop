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

def seedfile(fname)
  File.open File.join(Rails.root, "public/content/seeds/", fname)
end

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
   name: "Технические особенности",
   product_property_values_attributes: [
     {
       value: "Экологичность",
       description: "Древесина из возобновляемых источников, натуральные составы для обработки и комплектующие с сертифицированных фабрик используются в производстве с минимальным количеством отходов, которые в свою очередь также перерабатываются.",
       image: seedfile('eco.jpg')
     },
     {
       value: "Поляризация",
       description: "Древесина из возобновляемых источников, натуральные составы для обработки и комплектующие с сертифицированных фабрик используются в производстве с минимальным количеством отходов, которые в свою очередь также перерабатываются.",
       image: seedfile('eco.jpg')
     }
   ]
 },
])

VariantOption.create([
  {
    name: "Оправа",
    variant_option_values_attributes: [
      {
        value: "Венге",
        image: seedfile('1375038.jpg')
      },
      {
        value: "Орех",
        image: seedfile('traditional-hardwood-flooring.jpg')
      },
      {
        value: "Ясень",
        image: seedfile('_________________510f4de0dbc86.jpg')
      }
    ]
  },
  {
    name: "Стекло",
    variant_option_values_attributes: [
      {
        value: "черный",
        image: seedfile('images.jpeg')
      },
      {
        value: "коричневый",
        image: seedfile('02.jpg')
      }
    ]
  }
])

Prototype.create([
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
