class Product < ActiveRecord::Base

  belongs_to :prototype, inverse_of: :products

  has_and_belongs_to_many :product_property_values

  has_many :variants, inverse_of: :product, dependent: :destroy

  accepts_nested_attributes_for :variants

  validates :name, :slug, presence: true

  def add_fields(properties)
    properties.each do |property|
      self.class.send(:define_method, "#{property.latin_name}") do
        property_id = (property.product_property_values.ids & product_property_values.map{ |p| p.id }).first
        value = nil
        if property_id.present?
          value = ProductPropertyValue.find(property_id)
        end
        value
      end
      self.class.send(:define_method, "#{property.latin_name}=") do |argument|
        unless (argument.to_i == 0)
          property.product_property_values.each do |value|
            product_property_values.delete(value)
          end
          product_property_values << ProductPropertyValue.find(argument.to_i)
        end
      end
    end
  end


end
